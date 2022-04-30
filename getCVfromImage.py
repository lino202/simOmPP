import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import scipy.io
from utils import meanFilter, cleanMap, keepBigIsland, vector_to_rgb
from CVCML.utilsCVCML import getLocalCV, plotHistAndBoxPlot
import copy
from tqdm import tqdm

np.seterr(divide='raise', invalid='raise')
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data')
parser.add_argument('--pixRes',type=float, required=True)
parser.add_argument('--cleanProcess',type=int, required=True)
parser.add_argument('--blockDown',type=int, required=True)
parser.add_argument('--blockUp',type=int, required=True)
parser.add_argument('--outType', type=str, required=True)
parser.add_argument('--outPath', type=str, required=True)
args = parser.parse_args()

#LOAD
actMap = scipy.io.loadmat(args.filePath)['actmap'].astype(float)
actMap[0,:] = np.nan; actMap[-1,:] = np.nan; actMap[:,0] = np.nan; actMap[:,-1] = np.nan

plt.figure(); plt.imshow(actMap); plt.show(block=False) if args.outPath != "0" else plt.show(block=True)
actMap = np.nan_to_num(actMap) 

#CLEAN
if args.cleanProcess==0:   newActMap = copy.deepcopy(actMap)
elif args.cleanProcess==1: newActMap = cleanMap(actMap.astype('uint8'))
elif args.cleanProcess==2: newActMap = meanFilter(actMap)
else: raise ValueError("Wrong cleanProcess")
plt.figure(); plt.imshow(newActMap)
plt.show(block=False) if args.outPath != "0" else plt.show(block=True)

#KEEP BIGGEST ISLAND
_, clearImg, imgMin, imgMax = keepBigIsland(newActMap, show=True)

#PREPARE FOR PLOT AND DELETE OUTLIERS
clearImg = clearImg.astype(float)
clearImg[clearImg==0] = np.nan
clearImg = np.round(clearImg-imgMin)

# Block in case there are outliers
if args.blockDown != 0:
    clearImg[clearImg<args.blockDown] = np.nan
if args.blockUp != 0:
    clearImg[clearImg>args.blockUp] = np.nan

clearImg = clearImg - np.nanmin(clearImg)
imgLatRange = np.nanmax(clearImg)

#PLOT AT
lats = clearImg[~np.isnan(clearImg)]
print("There are {} different lats: {}\n".format(len(np.unique(lats)), np.unique(lats)))
print("The Range of the LAT in this continuos mass is: {:.2f}".format(imgLatRange))
if args.outPath != "0":
    plotHistAndBoxPlot(lats, "AT [ms]", path=os.path.join(args.outPath, "atmap_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlot(lats, "AT [ms]")

fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(clearImg, vmin=np.nanmin(clearImg), vmax=np.nanmax(clearImg), cmap='Blues'); plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(0,imgLatRange,4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20); cbar.ax.facecolor = 'r'; cbar.set_label('AT [ms]', fontsize=20)
plt.savefig(os.path.join(args.outPath, "atmap.{}".format(args.outType))) if args.outPath != "0" else plt.show(block=True)

#CALCULATE CV FROM IMAGE
idxs = np.logical_not(np.isnan(clearImg)).nonzero()
dirs = np.array([[-1,1], [0,1], [1,1], [-1,0], [1,0], [-1,-1], [0,-1], [1,-1]])
dirsVersors = dirs/np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
dists = np.linalg.norm(dirs,axis=1)

CVMagImg = np.zeros(clearImg.shape)
CVDirImg = np.zeros((clearImg.shape[0],clearImg.shape[1],2))
CVMagImg[:] = np.nan
CVDirImg[:] = np.nan
for i in tqdm(range(idxs[0].shape[0])):
    x = idxs[0][i]
    y = idxs[1][i]
    kernely = np.array([y-1, y, y+1, y-1, y+1, y-1, y, y+1])
    kernelx = np.array([x-1, x-1, x-1, x, x, x+1, x+1, x+1])
    
    times = clearImg[kernelx, kernely]
    times = times - clearImg[x,y]
    pixCVs = np.empty(dists.shape)
    pixCVs[:] = np.nan
    np.divide(dists, times, out=pixCVs, where=times != 0.)
    
    if not np.isnan(pixCVs).all():
        #Direction 
        #Velocity sign changes direction!! so pixCVs must not be absolute value
        pixCVvectors = dirsVersors * np.expand_dims(pixCVs, axis=1)
        resVector = np.nanmean(pixCVvectors, axis=0)  
        if np.linalg.norm(resVector) != 0.0:
            #Here I not consider sources and sinks of velocities as I wanted to do consider only the trevalling of 
            # the vector field 
            CVMagImg[x,y] = np.linalg.norm(resVector)
            CVDirImg[x,y,:] = resVector / np.linalg.norm(resVector)

CVMagImg = CVMagImg * args.pixRes * 1000 
CVmagnitudes = CVMagImg.flatten()

#PLOTS
totMag = np.nanmean(CVMagImg)
totDir = np.nanmean(CVDirImg, axis=(0,1))
totDir = totDir / np.linalg.norm(totDir)
print("The CV magnitude is {}  cm/s".format(totMag))
print("The CV direction is {} [x,y = 0,0 bottom left of the screen]  ".format(totDir))


fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(CVMagImg, vmin=np.nanmin(CVMagImg), vmax=np.nanmax(CVMagImg)); plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.linspace(np.nanmin(CVMagImg),np.nanmax(CVMagImg),4), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20); cbar.ax.facecolor = 'r'; cbar.set_label('CV Magnitude [cm/s]', fontsize=20)
plt.savefig(os.path.join(args.outPath, "cvMag.{}".format(args.outType))) if args.outPath != "0" else plt.show(block=True)
if args.outPath != "0":
    plotHistAndBoxPlot(CVmagnitudes[~np.isnan(CVmagnitudes)], "CV Mag [cm/s]", path=os.path.join(args.outPath, "cvmag_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlot(CVmagnitudes[~np.isnan(CVmagnitudes)], "CV Mag [cm/s]")

X = np.arange(0, actMap.shape[0], 1)
Y = np.arange(0, actMap.shape[1], 1)
U = CVDirImg[:,:,0]
V = CVDirImg[:,:,1]
angles = np.arctan2(V, U)
lengths = np.sqrt(np.square(U) + np.square(V))
max_abs = np.ones(angles.shape)*np.nanmax(lengths)
c = np.array(list(map(vector_to_rgb, angles.flatten(), lengths.flatten(), max_abs.flatten())))
fig, ax = plt.subplots()
q = ax.quiver(X, Y, U, V, color=c)
ax.set_ylim(ax.get_ylim()[1], ax.get_ylim()[0]); plt.axis('off'); ax.set_title('Versors mapped by colors')
plt.savefig(os.path.join(args.outPath, "cvDirs.{}".format(args.outType))) if args.outPath != "0" else plt.show(block=True)