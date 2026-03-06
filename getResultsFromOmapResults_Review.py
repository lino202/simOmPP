'''Here we get the ATs, CVs and APDs for experiments videos of optical mapping already filtered in omap
ATs is obtained from omap and APD is re computed here for OM_filtered. We also give three results complete and divide (MI and healthy)
the divide is only present when we say we are in a MI case

oneCycleSamples  = (the period in ms in opmap)/exposure (generally exposure 2ms for Madrid)
startFrame and endFrame must be taken when doing the Omap analysis
'''

# The paper 3 was analyzed with this script, so for this reason we copy the file and add the caculation of the standard deviation
# for measuring the disperson beat-to-beat of APD.


import os
import argparse
import scipy.io
import matplotlib.pyplot as plt
import numpy as np
from roipoly import RoiPoly
from utils import plotHistAndBoxPlotSeaBorn, plotColorbar, cleanMap, meanFilter, keepBigIsland, calculateBoxPlotParams, vector_to_rgb
import copy
from utilsCV import getLocalCvBayly, getLocalCvVanilla
import pickle
import pandas as pd

np.seterr(all='raise')

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--folderPath',type=str, required=True, help='path to data')
parser.add_argument('--videoNumber',type=str, required=True)
parser.add_argument('--infarction',action='store_true')
parser.add_argument('--roisName',type=str, required=True)

# CV
parser.add_argument('--shouldNotHaveAllPoints', action='store_true', help="If false CV in a point is only computed if it has all the points in its sourroundings defined, according to maxdist")
parser.add_argument('--cleanProcess',type=int, required=True, help='Select the cleaning proccessed, they are really similar. 0 for not cleaning')
parser.add_argument('--blockDown',type=int, required=True, help='Cut bottom boundary for AT values, 0 = not cutting')
parser.add_argument('--blockUp',type=int, required=True, help='Cut upper boundary for AT values, 0 = not cutting')
parser.add_argument('--pixRes',type=float, required=True, help='pixel resolution in cm')
parser.add_argument('--maxDist', type=float, required=True, help='max distance of pxs from the pixel in which the CV computation is happening in order to be used in the calculation, in px')
parser.add_argument('--maxCV', type=float, required=True, help='max CV in cm/s')
parser.add_argument('--cvCalcMethod', type=str, required=True, help='bayly or vanilla')
parser.add_argument('--scaleVectors', type=float, required=True, help='scale of the vectors in quiver plot, usually 100 is ok but it depends on the magnitude of the CV')

# APD
parser.add_argument('--startFrame',type=int, required=True)
parser.add_argument('--endFrame',type=int, required=True)
parser.add_argument('--oneCycleSamples',type=int, required=True)
parser.add_argument('--reverse',action='store_true')
parser.add_argument('--apdtype',type=int, required=True)
parser.add_argument('--fps',type=float, required=True)

parser.add_argument('--stimFreq',type=int, required=True)
parser.add_argument('--stimType',type=str, required=True)
parser.add_argument('--faceView',type=str, required=True)
parser.add_argument('--pigNumber',type=str, required=True)
args = parser.parse_args()

samplePath = os.path.join(args.folderPath, str(args.videoNumber))
videoPath = os.path.join(samplePath, "FileTag{}_video_filtered.mat".format(str(args.videoNumber.split('_')[0]).zfill(3))) # already filtered from omap
atmapPath = os.path.join(samplePath, "actmap_withstd_FileTag{}_video.mat".format(str(args.videoNumber.split('_')[0]).zfill(3)))
video = scipy.io.loadmat(videoPath)['wholav_images']
atmap = scipy.io.loadmat(atmapPath)['map']
atmap_std = scipy.io.loadmat(atmapPath)['stdmap']

outPath = os.path.join(samplePath, "myresults")
if not os.path.exists(outPath): os.makedirs(outPath)
secondaryOutFolder = os.path.join(outPath, "secondary_results")
roisFolder         = os.path.join(args.folderPath, args.roisName)
if not os.path.exists(secondaryOutFolder): os.makedirs(secondaryOutFolder)
if not os.path.exists(roisFolder): os.makedirs(roisFolder)
resExcelPath = os.path.join(outPath, "results.xlsx")
dataFramePath = os.path.join(args.folderPath, "dataFrame.pickle")

plt.figure()
plt.plot(np.arange(0,video.shape[2]),video[int(video.shape[0]/2),int(video.shape[1]/2),:])
plt.savefig(os.path.join(secondaryOutFolder, "see_reversed_or_not.png"))

#Cropping Space--------------------------------------------------------------------
if len(os.listdir(roisFolder))<1:
    img0 = atmap
    plt.figure(); plt.imshow(img0); plt.title("Select Area, Nans here are nans already in ATs inside the ROI from omap, 0s are pixels outside the ROI in omap") 
    my_roi = RoiPoly(color='r') # draw new ROI in red color
    try:
        mask_overall = my_roi.get_mask(img0)
    except IndexError:
        mask_overall = (img0>0).astype(int)
    with open(os.path.join(roisFolder,'overall_mask.pkl'), 'wb') as file: pickle.dump(mask_overall, file) 

    # Now select infarcted area over the already cropped
    if args.infarction: 
        img0 = img0 * mask_overall.astype(int)
        plt.figure(); plt.imshow(img0); plt.title("Select MI") 
        my_roi = RoiPoly(color='r') # draw new ROI in red color
        try:
            mask_mi = my_roi.get_mask(img0)
        except IndexError:
            mask_mi = (img0>0).astype(int)
        mask_mi      = mask_mi.astype(int) * mask_overall.astype(int)
        mask_healthy = (mask_mi.astype(int) + mask_overall.astype(int)).astype(int)
        mask_healthy[mask_healthy!=1] = 0
        with open(os.path.join(roisFolder,'mi_mask.pkl'), 'wb') as file: pickle.dump(mask_mi, file) 
        with open(os.path.join(roisFolder,'healthy_mask.pkl'), 'wb') as file: pickle.dump(mask_healthy, file) 

else:
    with open(os.path.join(roisFolder,'overall_mask.pkl'), 'rb') as file: mask_overall = pickle.load(file) 
    if args.infarction: 
        with open(os.path.join(roisFolder,'mi_mask.pkl'), 'rb') as file: mask_mi = pickle.load(file) 
        with open(os.path.join(roisFolder,'healthy_mask.pkl'), 'rb') as file: mask_healthy = pickle.load(file) 

# Get the Data 
videos = {}
atmaps = {}
atmaps_stds = {}
minV = np.min(video)
maxV = np.max(video)
videoNorm = (video - minV) / (maxV - minV)
if args.reverse:
    videoNorm = np.abs(videoNorm - 1)
v_overall = np.zeros(videoNorm.shape)
for i in range(v_overall.shape[2]):
    v_overall[:,:,i] = videoNorm[:,:,i] * mask_overall.astype(int)
videos['overall'] = v_overall
atmaps['overall'] = atmap * mask_overall.astype(int)
atmaps_stds['overall'] = atmap_std * mask_overall.astype(int)
if args.infarction: 
    v_mi      = np.zeros(videoNorm.shape)
    v_healthy = np.zeros(videoNorm.shape)
    for i in range(video.shape[2]):
        v_mi[:,:,i] = videoNorm[:,:,i] * mask_mi.astype(int)
        v_healthy[:,:,i] = videoNorm[:,:,i] * mask_healthy.astype(int)
    videos['mi']      = v_mi
    videos['healthy'] = v_healthy
    atmaps['mi']      = atmap * mask_mi.astype(int)
    atmaps['healthy'] = atmap * mask_healthy.astype(int)
    atmaps_stds['mi']      = atmap_std * mask_mi.astype(int)
    atmaps_stds['healthy'] = atmap_std * mask_healthy.astype(int)
    
if args.infarction:
    fig, axs = plt.subplots(1,3)
    axs[0].imshow(v_overall[:,:,0])
    axs[1].imshow(v_healthy[:,:,0])
    axs[2].imshow(v_mi[:,:,0])
else:
    fig, axs = plt.subplots(1)
    axs.imshow(v_overall[:,:,0])
plt.savefig(os.path.join(secondaryOutFolder, "firstFrameVideoWithMask.png"))


# Compute ---------------------------------------------------------------
nameMap = ['Myo', 'MI', 'HE']
for i, key in enumerate(videos.keys()):

    i_atmap = atmaps[key]
    i_atmap_stds = atmaps_stds[key]
    i_video = videos[key]
    res = {}
    #ATs --------------------------------------------------------------------
    #CLEAN
    if args.cleanProcess==0:
        i_atmap = copy.deepcopy(i_atmap)
    elif args.cleanProcess==1:
        i_atmap = cleanMap(i_atmap.astype('uint8'))
    elif args.cleanProcess==2:
        i_atmap = meanFilter(i_atmap)
    else: raise ValueError("Wrong cleanProcess")

    #KEEP BIGGEST ISLAND
    i_atmap = i_atmap.astype(float)
    i_atmap[i_atmap==0] = np.nan
    _, i_atmap, imgMin, imgMax = keepBigIsland(i_atmap, show=False)

    #PREPARE FOR PLOT AND DELETE OUTLIERS
    i_atmap = i_atmap.astype(float)
    i_atmap[i_atmap==0] = np.nan

    i_atmap = i_atmap - np.nanmin(i_atmap)      # With Nans
    i_ats = i_atmap[~np.isnan(i_atmap)]         # Without Nans

    # Block in case there are outliers
    if args.blockDown != 0:
        i_atmap[i_atmap<args.blockDown] = np.nan
    if args.blockUp != 0:
        i_atmap[i_atmap>args.blockUp] = np.nan

    i_atmap = i_atmap - np.nanmin(i_atmap)      # With Nans
    i_ats = i_atmap[~np.isnan(i_atmap)]         # Without Nans

    i_atmap_stds[i_atmap_stds==0] = np.nan
    i_ats_stds = i_atmap_stds[~np.isnan(i_atmap_stds)]         # Without Nans

    plotHistAndBoxPlotSeaBorn(i_ats, "AT (ms)", path=os.path.join(secondaryOutFolder, "outliers4Block.png"))

    boxplotData = calculateBoxPlotParams(i_ats)
    res["AT_{} mean".format(nameMap[i])]   = np.mean(i_ats)
    res["AT_{} std".format(nameMap[i])]    = np.std(i_ats)
    res["AT_{} median".format(nameMap[i])] = np.median(i_ats)
    res["AT_{} min".format(nameMap[i])]    = np.min(i_ats)
    res["AT_{} max".format(nameMap[i])]    = np.max(i_ats)
    res["AT_{} lowQuart".format(nameMap[i])]   = boxplotData[1]
    res["AT_{} upQuart".format(nameMap[i])]    = boxplotData[2]
    res["AT_{} lowWhisker".format(nameMap[i])] = boxplotData[3]
    res["AT_{} upWhisker".format(nameMap[i])]  = boxplotData[4]

    boxplotData = calculateBoxPlotParams(i_ats_stds)
    res["STD AT_{} mean".format(nameMap[i])]   = np.mean(i_ats_stds)
    res["STD AT_{} std".format(nameMap[i])]    = np.std(i_ats_stds)
    res["STD AT_{} median".format(nameMap[i])] = np.median(i_ats_stds)
    res["STD AT_{} min".format(nameMap[i])]    = np.min(i_ats_stds)
    res["STD AT_{} max".format(nameMap[i])]    = np.max(i_ats_stds)
    res["STD AT_{} lowQuart".format(nameMap[i])]   = boxplotData[1]
    res["STD AT_{} upQuart".format(nameMap[i])]    = boxplotData[2]
    res["STD AT_{} lowWhisker".format(nameMap[i])] = boxplotData[3]
    res["STD AT_{} upWhisker".format(nameMap[i])]  = boxplotData[4]

    # Nice Plot of ATs (map and statistics)
    plotHistAndBoxPlotSeaBorn(i_ats, "AT (ms)", path=os.path.join(outPath, '{}_at_stats.png'.format(nameMap[i])))
    plotColorbar(i_atmap, 'AT (ms)', os.path.join(outPath, '{}_at_map.png'.format(nameMap[i])))
    
    plotHistAndBoxPlotSeaBorn(i_ats_stds, "STD AT (ms)", path=os.path.join(outPath, '{}_at_std_stats.pdf'.format(nameMap[i])))
    plotColorbar(i_atmap_stds, 'STD AT (ms)', os.path.join(outPath, '{}_at_std_map.pdf'.format(nameMap[i])))

    #Compute APD--------------------------------------------------------------------
    # periods = np.arange(args.startFrame+args.oneCycleSamples, args.endFrame-args.oneCycleSamples, args.oneCycleSamples) # as in omap we not use the first and last AP
    periods = np.arange(args.startFrame, args.endFrame+args.oneCycleSamples, args.oneCycleSamples)
    print(periods)
    i_p_apds    = np.ones((i_video.shape[0], i_video.shape[1], periods.shape[0]-1)) * np.nan
    for p in range(periods.shape[0]-1):
        
        i_p_video = i_video[:,:,periods[p]:periods[p+1]]

        diff = np.diff(i_p_video, axis=2)
        upstrokeIdxs = np.argmax(diff, axis=2)

        peakIdxs = np.argmax(i_p_video, axis=2)
        peaks    = np.max(i_p_video, axis=2)
        baselinelvls = np.zeros((i_p_video.shape[0],i_p_video.shape[1]))
        for j in range(i_p_video.shape[0]):
            for k in range(i_p_video.shape[1]):
                baselinelvls[j,k] = np.min(i_p_video[j,k,peakIdxs[j,k]:])

        Voi = baselinelvls + (1 - (args.apdtype/100)) * (peaks - baselinelvls)
        tin = np.ones((i_p_video.shape[0],i_p_video.shape[1])) * np.nan
        for j in range(i_p_video.shape[0]):
            for k in range(i_p_video.shape[1]):
                try:
                    tin[j,k] = (i_p_video[j,k,peakIdxs[j,k]:]<Voi[j,k]).nonzero()[0][0] 
                except IndexError:
                    pass
        tin = tin + peakIdxs
        
        i_p_apds[:,:,p] = tin - upstrokeIdxs
        i_p_apds[:,:,p][i_p_apds[:,:,p]<0] = np.nan

    # Get median per pixel as the final APD value
    i_apdImg = np.nanmedian(i_p_apds, axis=2)
    i_apdImg = (i_apdImg / args.fps) * 1000          # Make ms and with Nans 
    i_apds = i_apdImg[~np.isnan(i_apdImg)]         # Without Nans

    i_apdStdImg = np.nanstd(i_p_apds, axis=2)
    i_apdStdImg = (i_apdStdImg / args.fps) * 1000          # Make ms and with Nans 
    i_apd_stds = i_apdStdImg[~np.isnan(i_apdStdImg)]         # Without Nans
    
    boxplotData = calculateBoxPlotParams(i_apds)
    res["APD{}_{} mean".format(args.apdtype, nameMap[i])]       = np.mean(i_apds)
    res["APD{}_{} std".format(args.apdtype, nameMap[i])]        = np.std(i_apds)
    res["APD{}_{} median".format(args.apdtype, nameMap[i])]     = np.median(i_apds)
    res["APD{}_{} min".format(args.apdtype, nameMap[i])]        = np.min(i_apds)
    res["APD{}_{} max".format(args.apdtype, nameMap[i])]        = np.max(i_apds)
    res["APD{}_{} lowQuart".format(args.apdtype, nameMap[i])]   = boxplotData[1]
    res["APD{}_{} upQuart".format(args.apdtype, nameMap[i])]    = boxplotData[2]
    res["APD{}_{} lowWhisker".format(args.apdtype, nameMap[i])] = boxplotData[3]
    res["APD{}_{} upWhisker".format(args.apdtype, nameMap[i])]  = boxplotData[4]

    boxplotData = calculateBoxPlotParams(i_apd_stds)
    res["STD APD{}_{} mean".format(args.apdtype, nameMap[i])]       = np.mean(i_apd_stds)
    res["STD APD{}_{} std".format(args.apdtype, nameMap[i])]        = np.std(i_apd_stds)
    res["STD APD{}_{} median".format(args.apdtype, nameMap[i])]     = np.median(i_apd_stds)
    res["STD APD{}_{} min".format(args.apdtype, nameMap[i])]        = np.min(i_apd_stds)
    res["STD APD{}_{} max".format(args.apdtype, nameMap[i])]        = np.max(i_apd_stds)
    res["STD APD{}_{} lowQuart".format(args.apdtype, nameMap[i])]   = boxplotData[1]
    res["STD APD{}_{} upQuart".format(args.apdtype, nameMap[i])]    = boxplotData[2]
    res["STD APD{}_{} lowWhisker".format(args.apdtype, nameMap[i])] = boxplotData[3]
    res["STD APD{}_{} upWhisker".format(args.apdtype, nameMap[i])]  = boxplotData[4]

    apdName = '$APD_{'+ str(args.apdtype) +'} (ms)$'
    stdApdName = 'STD '+'$APD_{'+ str(args.apdtype) +'} (ms)$'

    # Nice Plot (map and statistics)
    plotHistAndBoxPlotSeaBorn(i_apds, apdName, path=os.path.join(outPath, '{}_apd_stats.png'.format(nameMap[i])))
    plotColorbar(i_apdImg, apdName, os.path.join(outPath, '{}_apd_map.png'.format(nameMap[i])))

    plotHistAndBoxPlotSeaBorn(i_apd_stds, stdApdName, path=os.path.join(outPath, '{}_apd_std_stats.pdf'.format(nameMap[i])))
    plotColorbar(i_apdStdImg, stdApdName, os.path.join(outPath, '{}_apd_std_map.pdf'.format(nameMap[i])))


    # SAVE ALL, maybe to post-process in another way again
    # with open(os.path.join(outPath,'{}_ats.pkl'.format(nameMap[i])), 'wb') as file: pickle.dump(i_atmap, file) 
    # with open(os.path.join(outPath,'{}_apds.pkl'.format(nameMap[i])), 'wb') as file: pickle.dump(i_apdImg, file) 
    
    indexs = ["_".join(outPath.split("/")[-3:]) + '_' + nameMap[i]]
    # stats  = np.ones(len(res.keys())) * np.nan
    # for j, key in enumerate(res.keys()):
    #     try:
    #         stats[j] = res[key]
    #     except KeyError:
    #         pass

    res2 = {"Stim Freq": args.stimFreq, "Stim Type": args.stimType, "Face View": args.faceView, "Pig": args.pigNumber, "Tissue": nameMap[i]}
    new_data = {**res2, **res}
    df = pd.DataFrame(new_data, index=indexs)
    if not os.path.exists(resExcelPath):
        df.to_excel(resExcelPath, sheet_name='sheet1')
    else:
        with pd.ExcelWriter(resExcelPath, engine="openpyxl", mode='a',if_sheet_exists="overlay") as writer:
            startrow = writer.sheets['sheet1'].max_row
            df.to_excel(writer, sheet_name='sheet1', startrow=startrow, header=False)