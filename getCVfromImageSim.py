import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import scipy.io
from utils import vector_to_rgb, getLocalCvVanilla, getLocalCvBayly, plotHistAndBoxPlotSeaBorn

np.seterr(divide='raise', invalid='raise')
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data')
parser.add_argument('--shouldNotHaveAllPoints', action='store_true', help="If false CV in a point is only computed if it has all the points in its sourroundings defined, according to maxdist")
parser.add_argument('--pixRes',type=float, required=True, help='pixel resolution in cm')
parser.add_argument('--maxDist', type=float, required=True, help='max distance of pxs from the pixel in which the CV computation is happening in order to be used in the calculation, in px')
parser.add_argument('--maxCV', type=float, required=True, help='max CV in cm/s')
parser.add_argument('--calcMethod', type=str, required=True, help='bayly or vanilla')
parser.add_argument('--scaleVectors', type=float, required=True, help='scale of the vectors in quiver plot, usually 100 is ok but it depends on the magnitude of the CV')
parser.add_argument('--outPath', type=str, required=True, help='path to the folder for saving images, if 0 images are plotted and not saved')
parser.add_argument('--outType', type=str, required=True, help='png or pdf')
args = parser.parse_args()

# LOAD---------------------------------------
actMap = scipy.io.loadmat(args.filePath)['actmap']
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(actMap, cmap='viridis')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.linspace(np.nanmin(actMap),np.nanmax(actMap),6), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
cbar.set_label('AT (ms)', fontsize=20)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "atmap.{}".format(args.outType)))
else:
    plt.show(block=True)

# AT------------------------------------------
lats = actMap[~np.isnan(actMap)]
if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(lats, "AT (ms)", path=os.path.join(args.outPath, "atmap_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(lats, "AT (ms)")


# CV-----------------------------------------------
print("Starting calculation of the local CVs with method {}".format(args.calcMethod))
if args.calcMethod == "bayly": x_y_vx_vy = getLocalCvBayly(actMap, args.maxDist, args.shouldNotHaveAllPoints)
elif args.calcMethod == "vanilla": x_y_vx_vy = getLocalCvVanilla(actMap, args.maxDist, args.shouldNotHaveAllPoints)
else: raise ValueError("Wrong calculation method")


CVvectors = x_y_vx_vy[:,-2:]
positions = x_y_vx_vy[:,:2].astype(int)
CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
CVversors = CVvectors / np.expand_dims(CVmagnitudes, axis=1)

# Add units and get rid of CVs which are too long
CVmagnitudes = CVmagnitudes * args.pixRes * 1000                # Only valid for conversion to cm/s if ATs are in ms and pixRes in cm
idxs2Nan = np.where(CVmagnitudes>args.maxCV)
CVmagnitudes[idxs2Nan] = np.nan
CVversors[idxs2Nan,:] = np.nan
CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors



CVMagImg = np.zeros(actMap.shape)
CVMagImg[positions[:,0], positions[:,1]] = CVmagnitudes

CVxMagImg = np.zeros(actMap.shape)
CVxMagImg[positions[:,0], positions[:,1]] = CVvectors[:,0]
CVyMagImg = np.zeros(actMap.shape)
CVyMagImg[positions[:,0], positions[:,1]] = CVvectors[:,1]

#Save to .mat
if args.outPath != "0":
    cvMat = np.array([CVxMagImg, CVyMagImg])
    scipy.io.savemat(os.path.join(args.outPath, "CVxy.mat"), {"CVxy" : cvMat})

CVDirsImg = np.zeros((actMap.shape[0], actMap.shape[1], 2))
CVDirsImg[positions[:,0], positions[:,1], 0] = CVversors[:,0]
CVDirsImg[positions[:,0], positions[:,1], 1] = CVversors[:,1]


totDir = np.nanmean(CVversors, axis=0)
totDir = totDir / np.linalg.norm(totDir)
print("The mean CV magnitude is {}  cm/s".format(np.nanmean(CVmagnitudes)))
print("The median CV magnitude is {}  cm/s".format(np.nanmedian(CVmagnitudes)))
print("The mean CV direction versor is {} ".format(totDir))
totDir = np.nanmean(CVvectors, axis=0)
print("The mean CVxy vector is {} ".format(totDir))
totDir = np.nanmean(np.abs(CVvectors), axis=0)
print("The meanAbs CVxy vector is {} ".format(totDir))
totDir = np.nanmax(CVvectors, axis=0)
print("CVmax is {}".format(totDir))
totDir = np.nanmin(CVvectors, axis=0)
print("CVmin is {}".format(totDir))
totDir = np.nanmax(np.abs(CVvectors), axis=0)
print("CVmaxAbs is {}".format(totDir))
totDir = np.nanmin(np.abs(CVvectors), axis=0)
print("CVminAbs is {}".format(totDir))

array = CVvectors[:,0][~np.isnan(CVvectors[:,0])]
if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(array, "CVx (cm/s)", path=os.path.join(args.outPath, "cvx_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(array, "CVx (cm/s)")

array = CVvectors[:,1][~np.isnan(CVvectors[:,1])]
if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(array, "CVy (cm/s)", path=os.path.join(args.outPath, "cvy_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(array, "CVy (cm/s)")

# CV PLOTS ---------------------------------------------
# CV Magnitude
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(CVMagImg, vmin=np.nanmin(CVMagImg), vmax=np.nanmax(CVMagImg), cmap='viridis')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.linspace(np.nanmin(CVMagImg),np.nanmax(CVMagImg),4), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=15)
cbar.ax.facecolor = 'r'
cbar.set_label('CV Magnitude (cm/s)', fontsize=15)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvMag.{}".format(args.outType)))
else:
    plt.show(block=True)

if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(CVmagnitudes[~np.isnan(CVmagnitudes)], "CV Mag (cm/s)", path=os.path.join(args.outPath, "cvmag_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(CVmagnitudes[~np.isnan(CVmagnitudes)], "CV Mag (cm/s)")

# CV versors directions
X = np.arange(0, actMap.shape[0], 1)
Y = np.arange(0, actMap.shape[1], 1)
U = CVDirsImg[:,:,0]
V = CVDirsImg[:,:,1]
angles = np.arctan2(V, U)
lengths = np.sqrt(np.square(U) + np.square(V))
max_abs = np.ones(angles.shape)*np.nanmax(lengths)
c = np.array(list(map(vector_to_rgb, angles.flatten(), lengths.flatten(), max_abs.flatten())))
fig, ax = plt.subplots()
q = ax.quiver(X, Y, U, V, color=c)
ax.set_ylim(ax.get_ylim()[1], ax.get_ylim()[0])
plt.axis('off')
ax.set_title('Versors mapped by colors')
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvDirs.{}".format(args.outType)))
else:
    plt.show(block=True)

# CV vectors
fig = plt.figure()
ax = fig.add_subplot(111)
Q = plt.quiver(positions[:,1], np.abs(positions[:,0]-actMap.shape[0]), CVvectors[:,0], CVvectors[:,1], CVmagnitudes, pivot='mid', angles='xy', scale_units='xy', scale=args.scaleVectors, cmap='viridis')
plt.scatter(positions[:,1], positions[:,0], color='k', s=0.01)
cbar = plt.colorbar(Q, ticks=np.linspace(np.nanmin(CVmagnitudes), np.nanmax(CVmagnitudes),6), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=15)
cbar.ax.facecolor = 'r'
plt.axis('off')
cbar.set_label('CV vectors (cm/s)', fontsize=15)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvVectors.{}".format(args.outType)))
else:
    plt.show(block=True)


# CVx and CVy

plotMin = np.nanmin(np.array([CVxMagImg,CVyMagImg]).flatten())
plotMax = np.nanmax(np.array([CVxMagImg,CVyMagImg]).flatten())

fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(CVxMagImg, vmin=plotMin, vmax=plotMax, cmap='viridis')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.linspace(plotMin, plotMax, 4), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=15)
cbar.ax.facecolor = 'r'
cbar.set_label('CVx Magnitude (cm/s)', fontsize=15)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvxMag.{}".format(args.outType)))
else:
    plt.show(block=True)


fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(CVyMagImg, vmin=plotMin, vmax=plotMax, cmap='viridis')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.linspace(plotMin, plotMax, 4), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=15)
cbar.ax.facecolor = 'r'
cbar.set_label('CVy Magnitude (cm/s)', fontsize=15)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvyMag.{}".format(args.outType)))
else:
    plt.show(block=True)