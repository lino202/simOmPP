import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import scipy.io
from utilsCVCML import vector_to_rgb, getLocalCV, plotHistAndBoxPlot

np.seterr(divide='raise', invalid='raise')
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data including .mat with actmap in ms')
parser.add_argument('--pixRes',type=float, required=True, help='pixel resolution in cm')
parser.add_argument('--baylyDist', type=float, required=True, help='distance of Bayly paper in px')
parser.add_argument('--baylyMaxCV', type=float, required=True, help='max CV in cm/s, this supplant the time window in the paper')
parser.add_argument('--scaleVectors', type=int, required=True, help='scale of the vectors in quiver plot, usually 100 is ok but it depends on the magnitude of the CV')
parser.add_argument('--outPath', type=str, required=True, help='path to the folder for saving images, if 0 images are plotted and not saved')
parser.add_argument('--outType', type=str, required=True, help='png or pdf')
args = parser.parse_args()

# LOAD---------------------------------------
actMap = scipy.io.loadmat(args.filePath)['actmap']
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(actMap)
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.linspace(np.nanmin(actMap),np.nanmax(actMap),6), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
cbar.set_label('AT [ms]', fontsize=20)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "atmap.{}".format(args.outType)))
else:
    plt.show(block=True)

# AT------------------------------------------
lats = actMap[~np.isnan(actMap)]
print("There are {} different lats: {}".format(len(np.unique(lats)), np.unique(lats)))
print("The Range of the LAT is: {:.2f}".format(np.max(lats) - np.min(lats)))
if args.outPath != "0":
    plotHistAndBoxPlot(lats, "AT [ms]", path=os.path.join(args.outPath, "atmap_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlot(lats, "AT [ms]")


# CV-----------------------------------------------
print("Starting calculation of th CVs-----------------")
xyuv = getLocalCV(actMap, args.baylyDist)

CVvectors = np.zeros(xyuv[:,-2:].shape)
CVvectors[:,0] = xyuv[:,3]
CVvectors[:,1] = -1*xyuv[:,2]
positions = np.array(xyuv[:,:2]-1).astype(int)
CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
CVversors = CVvectors / np.expand_dims(CVmagnitudes, axis=1)

# Add units and get rid of CVs which are too long
CVmagnitudes = CVmagnitudes * args.pixRes * 1000                # Only valid for conversion to cm/s if ATs are in ms and pixRes in cm
idxs2Nan = np.where(CVmagnitudes>args.baylyMaxCV)
CVmagnitudes[idxs2Nan] = np.nan
CVversors[idxs2Nan,:] = np.nan
CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

CVMagImg = np.zeros(actMap.shape)
CVMagImg[positions[:,0], positions[:,1]] = CVmagnitudes
CVDirsImg = np.zeros((actMap.shape[0], actMap.shape[1], 2))
CVDirsImg[positions[:,0], positions[:,1], 0] = CVversors[:,0]
CVDirsImg[positions[:,0], positions[:,1], 1] = CVversors[:,1]

totMag = np.nanmean(CVmagnitudes)
totDir = np.nanmean(CVversors, axis=0)
totDir = totDir / np.linalg.norm(totDir)
print("The CV magnitude is {}  cm/s".format(totMag))
print("The CV direction versor is {} ".format(totDir))
totDir = np.nanmean(CVvectors, axis=0)
totDir = totDir / np.linalg.norm(totDir)
print("The CV direction vector is {} ".format(totDir))

# CV PLOTS ---------------------------------------------
# CV Magnitude
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(CVMagImg, vmin=np.nanmin(CVMagImg), vmax=np.nanmax(CVMagImg))
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.linspace(np.nanmin(CVMagImg),np.nanmax(CVMagImg),4), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
cbar.set_label('CV Magnitude [cm/s]', fontsize=20)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvMag.{}".format(args.outType)))
else:
    plt.show(block=True)

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
q = ax.quiver(X, Y, U, V, color=c)
ax.set_ylim(ax.get_ylim()[1], ax.get_ylim()[0])
plt.axis('off')
ax.set_title('Versors mapped by colors')
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvDirs.{}".format(args.outType)))
else:
    plt.show(block=True)

# CV vectors
fig = plt.figure(figsize=(15, 15), dpi=100)
ax = fig.add_subplot(111)
Q = plt.quiver(positions[:,1], np.abs(positions[:,0]-actMap.shape[0]), CVvectors[:,0], CVvectors[:,1], CVmagnitudes, pivot='mid', angles='xy', scale_units='xy', scale=args.scaleVectors)
plt.scatter(positions[:,1], positions[:,0], color='k', s=0.01)
cbar = plt.colorbar(Q, ticks=np.linspace(np.nanmin(CVmagnitudes), np.nanmax(CVmagnitudes),6), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
plt.axis('off')
cbar.set_label('CV vectors [cm/s]', fontsize=20)
if args.outPath != "0":
    plt.savefig(os.path.join(args.outPath, "cvVectors.{}".format(args.outType)))
else:
    plt.show(block=True)