'''Here we get the ATs, CVs and APDs for experiments videos of optical mapping already filtered in omap
'''

import os
import argparse
import scipy
import matplotlib.pyplot as plt
import numpy as np
from roipoly import RoiPoly
from utils import plotHistAndBoxPlotSeaBorn, plotColorbar, cleanMap, meanFilter, keepBigIsland, calculateBoxPlotParams, vector_to_rgb
import copy
from utilsCV import getLocalCvBayly, getLocalCvVanilla
import pickle
import pandas as pd

font = {'family' : "Times New Roman",
    'weight' : 'normal',
    'size'   : 20}

parser = argparse.ArgumentParser(description="Options")
# Input data
parser.add_argument('--folderPath',type=str, required=True, help='Path to the folder where all videos for one sample/experiment are saved')
parser.add_argument('--videoName',type=str, required=True, help='Name of the folder containing 1 video')
parser.add_argument('--fileName',type=str, required=True, help='Name of the filtered file, needs to be .mat')
parser.add_argument('--matVarName',type=str, required=True, help='Name of the variable save in matlab/Omap')
parser.add_argument('--getSubRegions',action='store_true', help='Sub divide the domain by subregionsNames')
parser.add_argument('--subregionNames',type=str, nargs='+')
parser.add_argument('--roisName',type=str, required=True)

# General
parser.add_argument('--exposure',type=float, required=True, help="This is the temporal sampling frequency")
parser.add_argument('--reverse',action='store_true')
parser.add_argument('--startTime',type=int, required=True, help="Start time in ms from which we cut the signal for analysis")
parser.add_argument('--endTime',type=int, required=True, help="End time in ms from which we cut the signal for analysis")
parser.add_argument('--before',type=int, required=True, help="Before chunck to take in ms")
parser.add_argument('--after',type=int, required=True, help="After chunck to take in ms")
parser.add_argument('--nBeats',type=int, required=True, help="After chunck to take in ms")

# AT
parser.add_argument('--cleanProcess',type=int, required=True, help='Select the cleaning proccessed, they are really similar. 0 for not cleaning')
parser.add_argument('--blockDown',type=int, required=True, help='Cut bottom boundary for AT values, 0 = not cutting')
parser.add_argument('--blockUp',type=int, required=True, help='Cut upper boundary for AT values, 0 = not cutting')

# CV
parser.add_argument('--shouldNotHaveAllPoints', action='store_true', help="If false CV in a point is only computed if it has all the points in its sourroundings defined, according to maxdist")
parser.add_argument('--pixRes',type=float, required=True, help='pixel resolution in cm')
parser.add_argument('--maxDist', type=float, required=True, help='max distance of pxs from the pixel in which the CV computation is happening in order to be used in the calculation, in px')
parser.add_argument('--maxCV', type=float, required=True, help='max CV in cm/s')
parser.add_argument('--cvCalcMethod', type=str, required=True, help='bayly or vanilla')
parser.add_argument('--scaleVectors', type=float, required=True, help='scale of the vectors in quiver plot, usually 100 is ok but it depends on the magnitude of the CV')

# APD
parser.add_argument('--apdtype',type=int, required=True)

# Variables regarding stimulation
parser.add_argument('--stimCL',type=int, required=True)
parser.add_argument('--stimType',type=str, required=True)
parser.add_argument('--sampleType',type=str, required=True)
parser.add_argument('--sampleName',type=str, required=True)
args = parser.parse_args()

videoPath  = os.path.join(args.folderPath, args.videoName, "{}.mat".format(args.fileName)) # already filtered from omap
video      = scipy.io.loadmat(videoPath)[args.matVarName]

# Estimation of original roi
mask_original = np.zeros(video.shape[:-1])
mask_original[np.where(video[:,:,0]!=0)] = 1

#  We create the folders for results and the rois
outPath = os.path.join(args.folderPath, args.videoName, "myresults")
if not os.path.exists(outPath): os.makedirs(outPath)
secondaryOutFolder = os.path.join(outPath, "secondary_results")
roisFolder         = os.path.join(args.folderPath, args.roisName)
if not os.path.exists(secondaryOutFolder): os.makedirs(secondaryOutFolder)
if not os.path.exists(roisFolder): os.makedirs(roisFolder)
resExcelPath = os.path.join(args.folderPath, "results.xlsx")

plt.figure()
plt.plot(np.arange(0,video.shape[2]),video[int(video.shape[0]/2),int(video.shape[1]/2),:]), plt.title("Middle pixel signal")
plt.savefig(os.path.join(secondaryOutFolder, "see_reversed_or_not.png"))
plt.close()

#Cropping Space-------------------------------------------------------------------- 
if len(os.listdir(roisFolder))<1:
    img0 = copy.deepcopy(video[:,:,0])
    plt.figure(); plt.imshow(img0); plt.title("Select Area, 0s are pixels outside the ROI in omap") 
    my_roi = RoiPoly(color='r') # draw new ROI in red color
    try:
        mask_overall = my_roi.get_mask(img0)
    except IndexError:
        mask_overall = (img0>0).astype(int)
    with open(os.path.join(roisFolder,'mask.pkl'), 'wb') as file: pickle.dump(mask_overall, file) 

    # Check if we need to divide in subregions
    if args.getSubRegions: 
        masks = []
        tmp_mask_overall = copy.deepcopy(mask_overall)
        for m in range(len(args.subregionNames)):
            img0 = img0 * tmp_mask_overall.astype(int)
            plt.figure(); plt.imshow(img0); plt.title("Select {} mask, ALWAYS DRAW IN THE INNER REGION!".format(args.subregionNames[m])) 
            my_roi = RoiPoly(color='r') # draw new ROI in red color
            try:
                mask = my_roi.get_mask(img0)
            except IndexError:
                mask = (img0>0).astype(int)
            
            masks.append(mask.astype(int) * tmp_mask_overall.astype(int))
            tmp_mask_overall = (tmp_mask_overall.astype(int) - mask.astype(int)).astype(int)
            with open(os.path.join(roisFolder,'{}_mask.pkl'.format(args.subregionNames[m])), 'wb') as file: pickle.dump(mask, file) 

else:
    with open(os.path.join(roisFolder,'mask.pkl'), 'rb') as file: mask_overall = pickle.load(file) 
    if args.getSubRegions:
        masks = [] 
        for m in range(len(args.subregionNames)):
            with open(os.path.join(roisFolder,'{}_mask.pkl'.format(args.subregionNames[m])), 'rb') as file: masks.append(pickle.load(file))


# Get the video data for processing -------------------------------------------------------------------------------
video = video[:,:,int(np.floor(args.startTime/args.exposure)):int(np.ceil(args.endTime/args.exposure))]
minV = np.min(video)
maxV = np.max(video)
videoNorm = (video - minV) / (maxV - minV)
if args.reverse:
    videoNorm = np.abs(videoNorm - 1)
del video
 
video = np.zeros(videoNorm.shape)
for i in range(video.shape[2]):
    video[:,:,i] = videoNorm[:,:,i] * mask_overall.astype(int)


# We define list cases that should be overall + subregions or just overall
cases = ['overall']
tmp = [mask_overall]
if args.getSubRegions:
    cases.extend(args.subregionNames)
    tmp.extend(masks)
masks = tmp

plt.figure()
all_masks = [mask_original]
all_masks.extend(masks)
all_masks = np.array(all_masks)
all_masks = np.sum(all_masks, axis=0)
plt.imshow(all_masks, interpolation='none')
plt.savefig(os.path.join(secondaryOutFolder, "masks.png"))
plt.close()

# Compute ---------------------------------------------------------------
# We compute these params in overall for getting the maps and in case there are subregions, these maps
# are separated by region
before_samples = int(np.floor(args.before/args.exposure))
after_samples  = int(np.ceil(args.after/args.exposure))
video_beats    = np.ones([video.shape[0], video.shape[1], args.nBeats, before_samples+after_samples]) * np.nan
b_before_dict = {}

# Crop the APs ---------------------------------------------------------------
for i in range(video.shape[0]):
    for j in range(video.shape[1]):
        if mask_overall[i,j]==1:
            #  Pixel in Roi get beats
            pixel_signal = video[i,j,:]
            pixel_signal = scipy.ndimage.gaussian_filter1d(pixel_signal, sigma=(args.stimCL*0.2)/args.exposure)
            locs, _      = scipy.signal.find_peaks(pixel_signal, distance=(before_samples+after_samples)/2, height=np.mean(pixel_signal))

            # We delete the pixel with less peaks than the beats, this is useful when it is too tricky to set 
            # startTime, endTime, before and after, but pay attention there are a few and not the entire map
            if locs.size > args.nBeats: 
                print("Pixel {},{} has MORE peaks than the selected {} nBeats".format(i,j,args.nBeats))
                mask_overall[i,j] = 0
                continue
                # raise ValueError("Pixel {},{} has MORE peaks than the selected {} nBeats".format(i,j,args.nBeats))
            if locs.size < args.nBeats: 
                print("Pixel {},{} has LESS peaks than the selected {} nBeats".format(i,j,args.nBeats))
                mask_overall[i,j] = 0
                continue
            
            b_before_dict["pix_{}_{}".format(i,j)] = locs-before_samples

            for l, loc in enumerate(locs):
                # It could be that we end up with out of range indixes so:
                in_l_before  = loc-before_samples
                out_l_before = 0

                in_l_after   = loc+after_samples
                out_l_after  = before_samples+after_samples

                if in_l_before<0: 
                    in_l_before = 0
                    out_l_before = np.abs(loc-before_samples)
                if in_l_after>pixel_signal.size: 
                    in_l_after = pixel_signal.size
                    out_l_after = pixel_signal.size - (loc+after_samples)
                    
                current_ap = np.zeros(before_samples+after_samples)
                current_ap[out_l_before:out_l_after] = video[i,j,in_l_before:in_l_after]
                current_ap[:out_l_before] = video[i,j,in_l_before]
                current_ap[out_l_after:] = video[i,j,in_l_after-1]
                video_beats[i,j,l,:] = current_ap


# AT computation -------------------------------------------------------------------------------
print("Computing AT")
# We need to take into accoun the border of the signal, specially the left limit
b_befores = np.array(list(b_before_dict.values()))
at_array = np.ones([video.shape[0], video.shape[1], args.nBeats]) * np.nan
for b in range(args.nBeats):
    neg_time_ref = False
    if min(b_befores[:,b])<0:
        # We went out the left-limit of the array so the at ref for the first beat is in the negative idxs
        neg_time_ref = True
    b_time_ref = np.abs(min(b_befores[:,b]))

    # We cut the signal in half to get correctly the upstroke (not seems necessary)
    b_video = video_beats[:,:,b,:]
    # peakIdxs = np.argmax(b_video, axis=2)
    # b_video_before = copy.deepcopy(b_video)
    # for i in range(video.shape[0]):
    #     for j in range(video.shape[1]):
    #         if mask_overall[i,j]==1: 
    #             b_video_before[i,j,peakIdxs[i,j]:] = np.nan
    
    diff = np.diff(b_video, axis=2)
    upstrokeIdxs = np.argmax(diff, axis=2)     # Out of the Roi the argmax gives 0 for the first nan but does not matter as we only change the nans in at_array within the mask

    for i in range(video.shape[0]):
        for j in range(video.shape[1]):
            if mask_overall[i,j]==1:
                
                pix_b_in_l_before = b_before_dict["pix_{}_{}".format(i,j)][b]
                if pix_b_in_l_before<=0:
                    # pix_b_in_l_before will never be negative if b_time_ref was positive before taking the absolute
                    at_array[i,j,b] = b_time_ref+upstrokeIdxs[i,j]
                else:
                    # here we are not going out the left limit of the array, but if we are in the first beat
                    #  maybe the time_ref is negative so
                    if neg_time_ref:
                        at_array[i,j,b] = b_time_ref+pix_b_in_l_before+upstrokeIdxs[i,j]
                    else:
                        at_array[i,j,b] = pix_b_in_l_before+upstrokeIdxs[i,j]

at_map = np.median(at_array, axis=2)
at_map = (at_map - np.nanmin(at_map)) * args.exposure

# # Clean
# if args.cleanProcess==0:
#     pass
# elif args.cleanProcess==1:
#     at_map = cleanMap(at_map.astype('uint8'))
# elif args.cleanProcess==2:
#     at_map = meanFilter(at_map)
# else: raise ValueError("Wrong cleanProcess")

# #Keep Biggest Island
# _, at_map, imgMin, imgMax = keepBigIsland(at_map.astype(float), show=False)
# at_map = at_map - np.nanmin(at_map)      # With Nans

# # Block in case there are outliers
# if args.blockDown != 0:
#     at_map[at_map<args.blockDown] = np.nan
# if args.blockUp != 0:
#     at_map[at_map>args.blockUp] = np.nan
# at_map = at_map - np.nanmin(at_map)      # With Nans

# Save info
# # Here we save the final AT map and nBeats APs for 10 pixel spanning the whole range of activation for analysing the AP cropping
# plotColorbar(at_map, 'AT (ms)', os.path.join(outPath, 'overall_AT.png'))
# plotHistAndBoxPlotSeaBorn(at_map[~np.isnan(at_map)], 'AT (ms)', path=os.path.join(outPath, "overall_AT_stats.png"))

at_uniques = np.unique(at_map)
at_uniques = at_uniques[~np.isnan(at_uniques)]
idxs = np.arange(0,at_uniques.size,int(np.ceil(at_uniques.size/5)))
idxs = np.concatenate([idxs, np.array([at_uniques.size-1])])
at_uniques = at_uniques[idxs]
n_cols = 3
n_rows = int(np.ceil(at_uniques.size/n_cols))
fig, axs = plt.subplots(n_rows,n_cols, figsize=(12,9))
beat_labels = []
for b in range(args.nBeats):
    beat_labels.append('b_{}'.format(b))

z = 0
for m, at in enumerate(at_uniques): 
    m_idxs = np.where(at_map == at)
    i = m_idxs[0][0]
    j = m_idxs[1][0]

    if (m % n_cols==0) and (m!=0): z+=1
    axs[z,m-(n_cols*z)].plot(video_beats[i,j,:,:].T, label=beat_labels)
    axs[z,m-(n_cols*z)].set_title("AT {} ms, pix {},{}".format(at_uniques[m], i, j), fontsize=10)
    # axs[z,m-(n_cols*z)].legend(bbox_to_anchor=(1.04, 1), loc="upper right", prop={'size': 10})
fig.legend(beat_labels)
plt.savefig(os.path.join(secondaryOutFolder, "beats_vs_AT.png"), dpi=500)
plt.close()


# APD computation -------------------------------------------------------------------------------
print("Computing APD")
apd_array = np.ones([video.shape[0], video.shape[1], args.nBeats]) * np.nan
for b in range(args.nBeats):

    # We cut the signal in half to get correctly the upstroke and the repolarization (seems no neccesary)
    b_video = video_beats[:,:,b,:]
    peakIdxs = np.argmax(b_video, axis=2)
    # b_video_before = copy.deepcopy(b_video)
    # b_video_before[:,:,peakIdxs:] = np.nan
    # b_video_after = copy.deepcopy(b_video)
    # b_video_after[:,:,:peakIdxs] = np.nan

    # Get upstroke
    diff = np.diff(b_video, axis=2)
    upstrokeIdxs = np.argmax(diff, axis=2)

    peaks    = np.max(b_video, axis=2)
    baselinelvls = np.ones((b_video.shape[0],b_video.shape[1])) * np.nan
    for i in range(b_video.shape[0]):
        for j in range(b_video.shape[1]):
            if mask_overall[i,j]==1:
                baselinelvls[i,j] = np.min(b_video[i,j,peakIdxs[i,j]:])

    Voi = baselinelvls + (1 - (args.apdtype/100)) * (peaks - baselinelvls)
    tin = np.ones((b_video.shape[0],b_video.shape[1])) * np.nan
    for i in range(b_video.shape[0]):
        for j in range(b_video.shape[1]):
            if mask_overall[i,j]==1:
                try:
                    tin[i,j] = (b_video[i,j,peakIdxs[i,j]:]<Voi[i,j]).nonzero()[0][0] 
                except IndexError:
                    pass
    tin = tin + peakIdxs
    
    apd_array[:,:,b] = tin - upstrokeIdxs
    apd_array[:,:,b][apd_array[:,:,b]<0] = np.nan

# Get median per pixel as the final APD/AT value
apd_map = np.median(apd_array, axis=2) * args.exposure # Make ms and with Nans    

# Save info
# # Here we save the final AT map and nBeats APs for 10 pixel spanning the whole range of activation for analysing the AP cropping
# plotColorbar(apd_map, 'APD{} (ms)'.format(args.apdtype), os.path.join(outPath, 'overall_APD.png'))
# plotHistAndBoxPlotSeaBorn(apd_map[~np.isnan(apd_map)], 'APD{} (ms)'.format(args.apdtype), path=os.path.join(outPath, "overall_APD_stats.png"))

apd_uniques = np.unique(apd_map)
apd_uniques = apd_uniques[~np.isnan(apd_uniques)]
idxs = np.arange(0,apd_uniques.size,int(np.ceil(apd_uniques.size/5)))
idxs = np.concatenate([idxs, np.array([apd_uniques.size-1])])
apd_uniques = apd_uniques[idxs]
n_cols = 3
n_rows = int(np.ceil(apd_uniques.size/n_cols))
fig, axs = plt.subplots(n_rows,n_cols, figsize=(12,9))
beat_labels = []
for b in range(args.nBeats):
    beat_labels.append('b_{}'.format(b))

z = 0
for m, apd in enumerate(apd_uniques): 
    m_idxs = np.where(apd_map == apd)
    i = m_idxs[0][0]
    j = m_idxs[1][0]

    if (m % n_cols==0) and (m!=0): z+=1
    axs[z,m-(n_cols*z)].plot(video_beats[i,j,:,:].T, label=beat_labels)
    axs[z,m-(n_cols*z)].set_title("APD{} {} ms, pix {},{}".format(args.apdtype, apd_uniques[m], i, j), fontsize=10)
    # axs[z,m-(n_cols*z)].legend(bbox_to_anchor=(1.04, 1), loc="upper right", prop={'size': 10})
fig.legend(beat_labels)
plt.savefig(os.path.join(secondaryOutFolder, "beats_vs_APD.png"), dpi=500)
plt.close()


# CV computation -------------------------------------------------------------------------------

print("Computing CV with method {}".format(args.cvCalcMethod))
if args.cvCalcMethod == "bayly": x_y_vx_vy = getLocalCvBayly(at_map, args.maxDist, args.shouldNotHaveAllPoints)
elif args.cvCalcMethod == "vanilla": x_y_vx_vy = getLocalCvVanilla(at_map, args.maxDist, args.maxCV / (args.pixRes * 1000), args.shouldNotHaveAllPoints)
else: raise ValueError("Wrong calculation method")

CVvectors = x_y_vx_vy[:,-2:]
positions = x_y_vx_vy[:,:2].astype(int)
CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
CVversors = CVvectors / np.expand_dims(CVmagnitudes, axis=1)

# Add units and get rid of CVs which are too long
CVmagnitudes = CVmagnitudes * args.pixRes * 1000               # Only valid for conversion to cm/s if ATs are in ms and pixRes in cm/px
idxs2Nan = np.where(CVmagnitudes>args.maxCV)
CVmagnitudes[idxs2Nan] = np.nan
CVversors[idxs2Nan,:] = np.nan
CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

# Results
cv_map = np.zeros(at_map.shape)
cv_map[positions[:,0], positions[:,1]] = CVmagnitudes
cv_map[cv_map==0] = np.nan
cv_dirs_map = np.zeros((at_map.shape[0], at_map.shape[1], 2))
cv_dirs_map[positions[:,0], positions[:,1], 0] = CVversors[:,0]
cv_dirs_map[positions[:,0], positions[:,1], 1] = CVversors[:,1]

# # Save plots
# # Magnitude
# plotColorbar(cv_map, 'CV (cm/s)', os.path.join(outPath, "overall_CV.png"))
# plotHistAndBoxPlotSeaBorn(cv_map[~np.isnan(cv_map)], "CV (cm/s)", path=os.path.join(outPath, "overall_CV_stats.png"))

# # Versors
# plt.rc('font', **font)
# X = np.arange(0, at_map.shape[0], 1)
# Y = np.arange(0, at_map.shape[1], 1)
# U = cv_dirs_map[:,:,0]
# V = cv_dirs_map[:,:,1]
# angles = np.arctan2(V, U)
# lengths = np.sqrt(np.square(U) + np.square(V))
# max_abs = np.ones(angles.shape)*np.nanmax(lengths)
# c = np.array(list(map(vector_to_rgb, angles.flatten(), lengths.flatten(), max_abs.flatten())))
# fig, ax = plt.subplots()
# q = ax.quiver(X, Y, U, -V, color=c, pivot='mid', angles='xy', scale_units='xy', scale=args.scaleVectors)
# ax.set_ylim(ax.get_ylim()[1], ax.get_ylim()[0]); plt.axis('off'); ax.set_title('Versors')
# plt.savefig(os.path.join(outPath, "overall_CV_versors.png"), dpi=500)
# plt.close()


# Get data for regions and save----------------------------------------------------------------------------------
for i, i_mask in enumerate(masks):

    res = {}
    i_mask = i_mask.astype(float)
    i_mask[i_mask==0] = np.nan

    # AT
    i_at_map = at_map * i_mask
    i_at_map = i_at_map - np.nanmin(i_at_map)      # With Nans
    i_ats = i_at_map[~np.isnan(i_at_map)]         # Without Nans

    boxplotData = calculateBoxPlotParams(i_ats)
    res["AT mean"]   = np.mean(i_ats)
    res["AT std"]    = np.std(i_ats)
    res["AT median"] = np.median(i_ats)
    res["AT min"]    = np.min(i_ats)
    res["AT max"]    = np.max(i_ats)
    res["AT lowQuart"]   = boxplotData[1]
    res["AT upQuart"]    = boxplotData[2]
    res["AT lowWhisker"] = boxplotData[3]
    res["AT upWhisker"]  = boxplotData[4]

    # Nice Plot of ATs (map and statistics)
    plotHistAndBoxPlotSeaBorn(i_ats, "AT (ms)", path=os.path.join(outPath, '{}_AT_stats.png'.format(cases[i])))
    plotColorbar(i_at_map, 'AT (ms)', os.path.join(outPath, '{}_AT.png'.format(cases[i])))
    
    # APD
    i_apd_map = apd_map * i_mask
    i_apds = i_apd_map[~np.isnan(i_apd_map)]         # Without Nans

    boxplotData = calculateBoxPlotParams(i_apds)
    res["APD{} mean".format(args.apdtype)]       = np.mean(i_apds)
    res["APD{} std".format(args.apdtype)]        = np.std(i_apds)
    res["APD{} median".format(args.apdtype)]     = np.median(i_apds)
    res["APD{} min".format(args.apdtype)]        = np.min(i_apds) if i_apds.size != 0 else np.nan
    res["APD{} max".format(args.apdtype)]        = np.max(i_apds) if i_apds.size != 0 else np.nan
    res["APD{} lowQuart".format(args.apdtype)]   = boxplotData[1]
    res["APD{} upQuart".format(args.apdtype)]    = boxplotData[2]
    res["APD{} lowWhisker".format(args.apdtype)] = boxplotData[3]
    res["APD{} upWhisker".format(args.apdtype)]  = boxplotData[4]

    # Nice Plot (map and statistics)
    apdName = '$APD_{'+ str(args.apdtype) +'} (ms)$'
    plotHistAndBoxPlotSeaBorn(i_apds, apdName, path=os.path.join(outPath, '{}_APD_stats.png'.format(cases[i])))
    plotColorbar(i_apd_map, apdName, os.path.join(outPath, '{}_APD_map.png'.format(cases[i])))
    
    # CV
    i_cv_map  = cv_map * i_mask
    i_cv_dirs = cv_dirs_map * np.concatenate([i_mask[:,:,np.newaxis],i_mask[:,:,np.newaxis]], axis=2)
    i_cvs = i_cv_map[~np.isnan(i_cv_map)]        #Without Nans

    boxplotData = calculateBoxPlotParams(i_cvs)
    res["CVmag mean"]       = np.mean(i_cvs)
    res["CVmag std"]        = np.std(i_cvs)
    res["CVmag median"]     = np.median(i_cvs)
    res["CVmag min"]        = np.min(i_cvs)
    res["CVmag max"]        = np.max(i_cvs)
    res["CVmag lowQuart"]   = boxplotData[1]
    res["CVmag upQuart"]    = boxplotData[2]
    res["CVmag lowWhisker"] = boxplotData[3]
    res["CVmag upWhisker"]  = boxplotData[4]
    # res["CVdir mean"]       = np.nanmean(CVversors, axis=0)
    # res["CVvec mean"]       = np.nanmean(CVvectors, axis=0)
    # res["CVvec meanAbs"]    = np.nanmean(np.abs(CVvectors), axis=0)

    # PLOTS 
    # Magnitude
    plotColorbar(i_cv_map, 'CV (cm/s)', os.path.join(outPath, "{}_CV.png".format(cases[i])))
    plotHistAndBoxPlotSeaBorn(i_cvs, "CV (cm/s)", path=os.path.join(outPath, "{}_CV_stats.png".format(cases[i])))

    plt.rc('font', **font)
    X = np.arange(0, i_at_map.shape[0], 1)
    Y = np.arange(0, i_at_map.shape[1], 1)
    U = i_cv_dirs[:,:,0]
    V = i_cv_dirs[:,:,1]
    angles = np.arctan2(V, U)
    lengths = np.sqrt(np.square(U) + np.square(V))
    max_abs = np.ones(angles.shape)*np.nanmax(lengths)
    c = np.array(list(map(vector_to_rgb, angles.flatten(), lengths.flatten(), max_abs.flatten())))
    fig, ax = plt.subplots()
    q = ax.quiver(X, Y, U, -V, color=c, pivot='mid', angles='xy', scale_units='xy', scale=args.scaleVectors)
    ax.set_ylim(ax.get_ylim()[1], ax.get_ylim()[0]); plt.axis('off'); ax.set_title('Versors')
    plt.savefig(os.path.join(outPath, "{}_CV_versors.png".format(cases[i])), dpi=500)
    plt.close()

    # SAVE ALL, maybe to post-process in another way again -----------------------------------------------------------------
    res_pickle = {"at_map": i_at_map, "apd_map": i_apd_map, "cv_map": i_cv_map, "cv_dirs": i_cv_dirs} 
    with open(os.path.join(outPath,'{}_results.pkl'.format(cases[i])), 'wb') as file: pickle.dump(res_pickle, file) 
    
    indexs = ["_".join(outPath.split("/")[-3:]) + '_' + cases[i]]

    res2 = {"Stim CL": args.stimCL, "Stim Type": args.stimType, "Sample Type": args.sampleType, "Sample Name": args.sampleName, "Tissue": cases[i]}
    new_data = {**res2, **res}
    df = pd.DataFrame(new_data, index=indexs)
    if not os.path.exists(resExcelPath):
        df.to_excel(resExcelPath, sheet_name='sheet1')
    else:
        with pd.ExcelWriter(resExcelPath, engine="openpyxl", mode='a',if_sheet_exists="overlay") as writer:
            startrow = writer.sheets['sheet1'].max_row
            df.to_excel(writer, sheet_name='sheet1', startrow=startrow, header=False)

