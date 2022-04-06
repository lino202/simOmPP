import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import time
import scipy.io
from utils import meanFilter, cleanMap, keepBigIsland, calculateBoxPlotParams, vector_to_rgb
import copy
from scipy.ndimage import generic_filter

np.seterr(divide='raise', invalid='raise')

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data')
parser.add_argument('--pixRes',type=float, required=True)
parser.add_argument('--cleanProcess',type=int, required=True)
parser.add_argument('--blockDown',type=int, required=True)
parser.add_argument('--blockUp',type=int, required=True)
parser.add_argument('--blockPlot',action='store_true')
parser.add_argument('--outType', type=str, required=True)
args = parser.parse_args()

#LOAD
actMap = scipy.io.loadmat(args.filePath)['map']
plt.figure()
plt.imshow(actMap)
plt.show(block=args.blockPlot)

actMap = np.nan_to_num(actMap) 

#CLEAN
if args.cleanProcess==0:
    newActMap = copy.deepcopy(actMap)
elif args.cleanProcess==1:
    newActMap = cleanMap(actMap.astype('uint8'))
elif args.cleanProcess==2:
    newActMap = meanFilter(actMap)
else: raise ValueError("Wrong cleanProcess")

plt.figure()
plt.imshow(newActMap)
plt.show(block=args.blockPlot)

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

fig, axs = plt.subplots(1,2)
plt.subplots_adjust(wspace=0.4)
axs[0].hist(lats)
axs[1].boxplot(lats)
axs[0].set_ylabel("Frequencies")
axs[0].set_xlabel("AT [ms]")
axs[1].set_xlabel("Samples")
axs[1].set_ylabel("AT [ms]")
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'atmap_metrics.{}'.format(args.outType)))
plt.show(block=args.blockPlot)

fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(clearImg, vmin=0, vmax=imgLatRange, cmap='Blues')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(0,imgLatRange,4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
cbar.set_label('AT [ms]', fontsize=20)
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'atmap.{}'.format(args.outType)))
plt.show(block=args.blockPlot)



#CALCULATE CV FROM IMAGE
idxs = np.logical_not(np.isnan(clearImg)).nonzero()
dirs = np.array([[-1,1], [0,1], [1,1], [-1,0], [1,0], [-1,-1], [0,-1], [1,-1]])
dirsVersors = dirs/np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
dists = np.linalg.norm(dirs,axis=1) * args.pixRes

cvMagImg = np.zeros(clearImg.shape)
cvDirImg = np.zeros((clearImg.shape[0],clearImg.shape[1],2))
cvMagImg[:] = np.nan
cvDirImg[:] = np.nan
for i in range(idxs[0].shape[0]):
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
            cvMagImg[x,y] = np.linalg.norm(resVector)
            cvDirImg[x,y,:] = resVector / np.linalg.norm(resVector)

cvMagImg = cvMagImg * 100

#PLOTS
totMag = np.nanmean(cvMagImg)
totDir = np.nanmean(cvDirImg, axis=(0,1))
totDir = totDir / np.linalg.norm(totDir)
print("The CV magnitude is {}  cm/s".format(totMag))
print("The CV direction is {} [x,y = 0,0 bottom left of the screen]  ".format(totDir))


fig = plt.figure()
ax = fig.add_subplot(111)
minTmp = np.nanmin(cvMagImg)
maxTmp = np.nanmax(cvMagImg)
plt.imshow(cvMagImg, vmin=minTmp, vmax=maxTmp, cmap='Blues')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(minTmp,maxTmp,4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
cbar.set_label('CV Magnitude [cm/s]', fontsize=20)
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'cvMag.{}'.format(args.outType)))
plt.show(block=args.blockPlot)

cvMagVector = cvMagImg.flatten()
cvMagVector = cvMagVector[~np.isnan(cvMagVector)]
boxplotData = calculateBoxPlotParams(cvMagVector)
print("Useful Data: mean-std {0:.2f} +/- {1:.2f}".format(np.mean(cvMagVector), np.std(cvMagVector)))
print("\t median {0}, lowQuart {1}, upQuart {2}, lowWhisker {3}, upWhisker {4}".format(boxplotData[0], boxplotData[1], boxplotData[2], boxplotData[3], boxplotData[4]))

fig, axs = plt.subplots(1,2)
plt.subplots_adjust(wspace=0.4)
axs[0].hist(cvMagVector)
axs[1].boxplot(cvMagVector)
axs[0].set_ylabel("Frequencies")
axs[0].set_xlabel("CV [cm/s]")
axs[1].set_xlabel("Samples")
axs[1].set_ylabel("CV [cm/s]")
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'cv_mag_metrics.{}'.format(args.outType)))
plt.show(block=args.blockPlot)

X = np.arange(0, clearImg.shape[0], 1)
Y = np.arange(0, clearImg.shape[1], 1)
U = cvDirImg[:,:,0]
V = cvDirImg[:,:,1]

angles = np.arctan2(V, U)
lengths = np.sqrt(np.square(U) + np.square(V))
max_abs = np.ones(angles.shape)*np.nanmax(lengths)
c = np.array(list(map(vector_to_rgb, angles.flatten(), lengths.flatten(), max_abs.flatten())))
fig, ax = plt.subplots()
q = ax.quiver(X, Y, U, V, color=c)
ax.set_ylim(ax.get_ylim()[1], ax.get_ylim()[0])
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'cv_Dirs.{}'.format(args.outType)))
plt.show(block=args.blockPlot)

