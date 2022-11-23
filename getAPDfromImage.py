import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import time
import scipy.io
from utils import meanFilter, cleanMap, keepBigIsland, calculateBoxPlotParams
import copy
from scipy.ndimage import generic_filter

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data')
parser.add_argument('--cleanProcess',type=int, required=True)
parser.add_argument('--blockDown',type=int, required=True)
parser.add_argument('--blockUp',type=int, required=True)
parser.add_argument('--apdtype',type=int, required=True)
parser.add_argument('--blockPlot',action='store_true')
parser.add_argument('--outType', type=str, required=True)
args = parser.parse_args()

#LOAD
apdMap = scipy.io.loadmat(args.filePath)['apmap']
plt.figure()
plt.imshow(apdMap, cmap='jet')
plt.show(block=args.blockPlot)

#CLEAN
if args.cleanProcess==0:
    newapdMap = copy.deepcopy(apdMap)
elif args.cleanProcess==1:
    newapdMap = cleanMap(apdMap.astype('uint8'))
elif args.cleanProcess==2:
    newapdMap = meanFilter(apdMap)
else: raise ValueError("Wrong cleanProcess")

plt.figure()
plt.imshow(newapdMap, cmap='jet')
plt.show(block=args.blockPlot)

#KEEP BIGGEST ISLAND
_, clearImg, imgMin, imgMax = keepBigIsland(newapdMap, show=True)

#PREPARE FOR PLOT AND DELETE OUTLIERS
clearImg = clearImg.astype(float)
clearImg[clearImg==0] = np.nan


# Block in case there are outliers
if args.blockDown != 0:
    clearImg[clearImg<args.blockDown] = np.nan
if args.blockUp != 0:
    clearImg[clearImg>args.blockUp] = np.nan


# imgLatRange = np.nanmax(clearImg) - np.nanmin(clearImg)


apds = clearImg[~np.isnan(clearImg)]
print("There are {} different apds: {}\n".format(len(np.unique(apds)), np.unique(apds)))
boxplotData = calculateBoxPlotParams(apds)
print("Useful Data: mean-std {0:.2f} +/- {1:.2f}".format(np.mean(apds), np.std(apds)))
print("\t median {0}, lowQuart {1}, upQuart {2}, lowWhisker {3}, upWhisker {4}".format(boxplotData[0], boxplotData[1], boxplotData[2], boxplotData[3], boxplotData[4]))

fig, axs = plt.subplots(1,2)
plt.subplots_adjust(wspace=0.4)
axs[0].hist(apds)
axs[1].boxplot(apds)
axs[0].set_ylabel("Frequencies")
axs[0].set_xlabel("APD{} (ms)".format(args.apdtype))
axs[1].set_xlabel("Samples")
axs[1].set_ylabel("APD{} (ms)".format(args.apdtype))
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'apd{}map_metrics.{}'.format(args.apdtype, args.outType)))
plt.show(block=args.blockPlot)


#PLOT
fig = plt.figure()
ax = fig.add_subplot(111)
plt.imshow(clearImg, vmin=np.round(np.nanmin(clearImg)), vmax=np.round(np.nanmax(clearImg)), cmap='Blues')
plt.axis('off')
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace( np.nanmin(clearImg),np.nanmax(clearImg),4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20)
cbar.ax.facecolor = 'r'
cbar.set_label('APD{} (ms)'.format(args.apdtype), fontsize=20)
plt.savefig(os.path.join(("/").join(args.filePath.split("/")[:-1]),'apd{}map.{}'.format(args.apdtype, args.outType)))
plt.show(block=args.blockPlot)

