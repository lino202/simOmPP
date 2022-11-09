import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import scipy.io
from utils import meanFilter, cleanMap, keepBigIsland, vector_to_rgb
from utils import getLocalCvBayly, getLocalCvVanilla, plotHistAndBoxPlot
import copy
from roipoly import RoiPoly
import pickle

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}

plt.rc('font', **font)
np.seterr(divide='raise', invalid='raise')
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data, AT should be in ms')
parser.add_argument('--shouldNotHaveAllPoints', action='store_true', help="If false CV in a point is only computed if it has all the points in its sourroundings defined, according to maxdist")
parser.add_argument('--atMapName',type=str, required=True, help='name of AT map from Matlab')
parser.add_argument('--cleanProcess',type=int, required=True, help='Select the cleaning proccessed, they are really similar. 0 for not cleaning')
parser.add_argument('--blockDown',type=int, required=True, help='Cut bottom boundary for AT values, 0 = not cutting')
parser.add_argument('--blockUp',type=int, required=True, help='Cut upper boundary for AT values, 0 = not cutting')
parser.add_argument('--pixRes',type=float, required=True, help='pixel resolution in cm')
parser.add_argument('--maxDist', type=float, required=True, help='max distance of pxs from the pixel in which the CV computation is happening in order to be used in the calculation, in px')
parser.add_argument('--maxCV', type=float, required=True, help='max CV in cm/s')
parser.add_argument('--calcMethod', type=str, required=True, help='bayly or vanilla')
parser.add_argument('--scaleVectors', type=float, required=True, help='scale of the vectors in quiver plot, usually 100 is ok but it depends on the magnitude of the CV')
parser.add_argument('--outPath', type=str, required=True, help='path to the folder for saving images, if 0 images are plotted and not saved')
parser.add_argument('--outType', type=str, required=True, help='png or pdf')
args = parser.parse_args()

#LOAD and CLEAN -------------------------------------------------------------------
actMap = scipy.io.loadmat(args.filePath)[args.atMapName]
plt.figure(); plt.imshow(actMap) 
my_roi = RoiPoly(color='r') # draw new ROI in red color
plt.show(block=False) if args.outPath != "0" else plt.show(block=True)
actMap = np.nan_to_num(actMap) 

try:
    mask = my_roi.get_mask(actMap)
    actMap = actMap * mask.astype(int)
except IndexError:
    pass


if args.cleanProcess==0: newActMap = copy.deepcopy(actMap)
elif args.cleanProcess==1: newActMap = cleanMap(actMap.astype('uint8'))
elif args.cleanProcess==2: newActMap = meanFilter(actMap)
else: raise ValueError("Wrong cleanProcess")
plt.figure(); plt.imshow(newActMap)
plt.show(block=False) if args.outPath != "0" else plt.show(block=True)

#KEEP BIGGEST ISLAND---------------------------------------------------
_, clearImg, imgMin, imgMax = keepBigIsland(newActMap, show=False if args.outPath != "0" else True)



#PREPARE FOR PLOT AND DELETE OUTLIERS-------------------------------------------
clearImg = clearImg.astype(float)
clearImg[clearImg==0] = np.nan
# clearImg = np.round(clearImg-imgMin)
clearImg = clearImg-imgMin

# Block in case there are outliers
if args.blockDown != 0: clearImg[clearImg<args.blockDown] = np.nan
if args.blockUp != 0: clearImg[clearImg>args.blockUp] = np.nan
clearImg = clearImg - np.nanmin(clearImg)
imgLatRange = np.nanmax(clearImg)

#PLOT AT---------------------------------------------------------------
lats = clearImg[~np.isnan(clearImg)]
if args.outPath != "0":
    plotHistAndBoxPlot(lats, "AT [ms]", path=os.path.join(args.outPath, "atmap_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlot(lats, "AT [ms]")

fig = plt.figure(); ax = fig.add_subplot(111)
plt.imshow(clearImg, vmin=np.nanmin(clearImg), vmax=np.nanmax(clearImg), cmap='Blues'); plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(np.nanmin(clearImg),np.nanmax(clearImg),4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20); cbar.ax.facecolor = 'r'; cbar.set_label('AT [ms]', fontsize=20)
plt.savefig(os.path.join(args.outPath, "atmap.{}".format(args.outType))) if args.outPath != "0" else plt.show(block=True)

# CV-----------------------------------------------
print("Starting calculation of the local CVs with method {}".format(args.calcMethod))
if args.calcMethod == "bayly": x_y_vx_vy = getLocalCvBayly(clearImg, args.maxDist, args.shouldNotHaveAllPoints)
elif args.calcMethod == "vanilla": x_y_vx_vy = getLocalCvVanilla(clearImg, args.maxDist, args.maxCV / (args.pixRes * 1000), args.shouldNotHaveAllPoints)
else: raise ValueError("Wrong calculation method")

CVvectors = x_y_vx_vy[:,-2:]
positions = x_y_vx_vy[:,:2].astype(int)
CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
CVversors = CVvectors / np.expand_dims(CVmagnitudes, axis=1)

# Add units and get rid of CVs which are too long
CVmagnitudes = CVmagnitudes * args.pixRes * 1000               # Only valid for conversion to cm/s if ATs are in ms and pixRes in cm
idxs2Nan = np.where(CVmagnitudes>args.maxCV)
CVmagnitudes[idxs2Nan] = np.nan
CVversors[idxs2Nan,:] = np.nan
CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

CVMagImg = np.zeros(actMap.shape)
CVMagImg[positions[:,0], positions[:,1]] = CVmagnitudes
CVMagImg[CVMagImg==0] = np.nan
CVDirsImg = np.zeros((actMap.shape[0], actMap.shape[1], 2))
CVDirsImg[positions[:,0], positions[:,1], 0] = CVversors[:,0]
CVDirsImg[positions[:,0], positions[:,1], 1] = CVversors[:,1]

totMag = np.nanmean(CVmagnitudes)
totDir = np.nanmean(CVversors, axis=0)
# totDir = totDir / np.linalg.norm(totDir) #values near zero apear to have a direction when normalize
print("The mean CV magnitude is {}  cm/s".format(totMag))
print("The median CV magnitude is {}  cm/s".format(np.nanmedian(CVmagnitudes)))
print("The mean of CV direction versors is {} ".format(totDir))
totDir = np.nanmean(CVvectors, axis=0)
print("The mean CVxy vector is {} ".format(totDir))
totDir = np.nanmean(np.abs(CVvectors), axis=0)
print("The meanAbs CVxy vector is {} ".format(totDir))

array = CVvectors[:,0][~np.isnan(CVvectors[:,0])]
if args.outPath != "0":
    plotHistAndBoxPlot(array, "CVx [cm/s]", path=os.path.join(args.outPath, "cvx_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlot(array, "CVx [cm/s]")

array = CVvectors[:,1][~np.isnan(CVvectors[:,1])]
if args.outPath != "0":
    plotHistAndBoxPlot(array, "CVy [cm/s]", path=os.path.join(args.outPath, "cvy_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlot(array, "CVy [cm/s]")

# CV PLOTS ---------------------------------------------
# CV Magnitude
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
q = ax.quiver(X, Y, U, -V, color=c, pivot='mid', angles='xy', scale_units='xy', scale=args.scaleVectors)
ax.set_ylim(ax.get_ylim()[1], ax.get_ylim()[0]); plt.axis('off'); ax.set_title('Versors mapped by colors')
plt.savefig(os.path.join(args.outPath, "cvDirs.{}".format(args.outType))) if args.outPath != "0" else plt.show(block=True)

# CV vectors
# fig = plt.figure(figsize=(8, 8), dpi=100)
# ax = fig.add_subplot(111)
# Q = plt.quiver(positions[:,1], np.abs(positions[:,0]-actMap.shape[0]), CVvectors[:,0], CVvectors[:,1], CVmagnitudes, pivot='mid', angles='xy', scale_units='xy', scale=args.scaleVectors)
# # plt.scatter(positions[:,1], positions[:,0], color='k', s=0.01)
# cbar = plt.colorbar(Q, ticks=np.linspace(np.nanmin(CVmagnitudes), np.nanmax(CVmagnitudes),6), location="right", pad=0.02, shrink=0.9)
# cbar.ax.tick_params(labelsize=20); cbar.ax.facecolor = 'r'; plt.axis('off')
# cbar.set_label('CV vectors [cm/s]', fontsize=20)
# plt.savefig(os.path.join(args.outPath, "cvVectors.{}".format(args.outType))) if args.outPath != "0" else plt.show(block=True)

if args.outPath != "0":
    with open(os.path.join(args.outPath, "cvMags"), "wb") as fp:
        pickle.dump(CVmagnitudes, fp)