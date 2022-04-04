import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import time
import scipy.io
from utils import meanFilter, cleanMap, keepBigIsland
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

lats = clearImg[~np.isnan(clearImg)]
print("There are {} different lats: {}\n".format(len(np.unique(lats)), np.unique(lats)))
print("The Range of the LAT in this continuos mass is: {:.2f}".format(imgLatRange))

fig, axs = plt.subplots(1,2)
axs[0].hist(lats)
axs[1].boxplot(lats)
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'atmap_metrics.png'))
plt.show(block=args.blockPlot)


#PLOT
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(clearImg, vmin=0, vmax=imgLatRange, cmap='Blues')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(0,imgLatRange,4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
cbar.set_label('AT [ms]', fontsize=20)
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'atmap.png'))
plt.show(block=args.blockPlot)



#CALCULATE CV FROM IMAGE
idxs = np.logical_not(np.isnan(clearImg)).nonzero()
dirs = np.array([[-1,1], [0,1], [1,1], [-1,0], [1,0], [-1,-1], [0,-1], [1,-1]])
dirsVersors = dirs/np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
dists = np.linalg.norm(dirs,axis=1) * args.pixRes

cvMag = np.zeros(idxs[0].shape[0])
cvDirs = np.zeros((idxs[0].shape[0],2))

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
    
    if np.isnan(pixCVs).all():
        cvMag[i] = np.nan
        cvDirs[i,:] = np.nan
    else:
        #Direction 
        #Velocity sign changes direction!! so pixCVs must not be absolute value
        #but in the following line the magnitude is absolute in order to make the mean!
        pixCVvectors = dirsVersors * np.expand_dims(pixCVs, axis=1)
        resVector = np.nanmean(pixCVvectors, axis=0)  #np.nansum(pixCVvectors, axis=0) np.nanmean(pixCVvectors, axis=0)
        if np.linalg.norm(resVector) != 0.0:
            cvMag[i] = np.linalg.norm(resVector)
            cvDirs[i,:] = resVector / np.linalg.norm(resVector)
        else:
            cvMag[i] = np.nan
            cvDirs[i,:] = np.nan

totMag = np.nanmean(cvMag) * 100
totDir = np.nanmean(cvDirs, axis=0)
totDir = totDir / np.linalg.norm(totDir)
print("The CV magnitude is {}  cm/s".format(totMag))
print("The CV direction is {} [x,y = 0,0 bottom left of the screen]  ".format(totDir))

#DRAW IMAGE WITH ARROW va a ser bueno plottear cada versor en la imagen
# pointA = np.array([np.min(idxs[0]), np.min(idxs[1])])
# pointB = np.array([np.max(idxs[0]), np.max(idxs[1])])
# arrowVect = pointA-pointB
# arrowMag = 10

# fig = plt.figure()
# ax = fig.add_subplot(111)
# plt.imshow(clearImg, vmin=0, vmax=imgLatRange, cmap='Blues')
# plt.axis('off')

# x = pointA[1]
# y = clearImg.shape[0] - pointA[0]
# dx = pointA[1]+ arrowMag * totDir[0]
# dy = clearImg.shape[0] - pointA[0] + arrowMag * totDir[1]
# plt.arrow( x, y, dx, dy)

# cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(0,imgLatRange,4)), location="right", pad=0.02, shrink=0.9)
# cbar.ax.tick_params(labelsize=20)
# cbar.ax.facecolor = 'r'
# cbar.set_label('AT[ms]', fontsize=20)
# plt.show()