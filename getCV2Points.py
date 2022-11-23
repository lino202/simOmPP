import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import scipy.io
from utils import meanFilter, cleanMap, keepBigIsland, plotHistAndBoxPlotSeaBorn
from utilsCV import twoPointsCV
import copy
from roipoly import RoiPoly

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}

plt.rc('font', **font)
np.seterr(divide='raise', invalid='raise')
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data, AT should be in ms')
parser.add_argument('--atMapName',type=str, required=True, help='name of AT map from Matlab')
parser.add_argument('--cleanProcess',type=int, required=True, help='Select the cleaning proccessed, they are really similar. 0 for not cleaning')
parser.add_argument('--blockDown',type=int, required=True, help='Cut bottom boundary for AT values, 0 = not cutting')
parser.add_argument('--blockUp',type=int, required=True, help='Cut upper boundary for AT values, 0 = not cutting')
parser.add_argument('--pixRes',type=float, required=True, help='pixel resolution in cm')
parser.add_argument('--outPath', type=str, required=True, help='path to the folder for saving images, if 0, images are plotted and not saved')
parser.add_argument('--outType', type=str, required=True, help='png or pdf')
args = parser.parse_args()

#LOAD and CLEAN -------------------------------------------------------------------
actMap = scipy.io.loadmat(args.filePath)[args.atMapName]
plt.figure(); plt.imshow(actMap) 
plt.title("Initial AT map")
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
plt.title("AT map after cleanning")
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
    plotHistAndBoxPlotSeaBorn(lats, "AT (ms)", path=os.path.join(args.outPath, "atmap_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(lats, "AT (ms)")

fig = plt.figure(); ax = fig.add_subplot(111)
plt.imshow(clearImg, vmin=np.nanmin(clearImg), vmax=np.nanmax(clearImg), cmap='Blues'); plt.axis('off')
plt.title("Final AT map")
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(np.nanmin(clearImg),np.nanmax(clearImg),4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20); cbar.ax.facecolor = 'r'; cbar.set_label('AT (ms)', fontsize=20)
plt.savefig(os.path.join(args.outPath, "atmap.{}".format(args.outType))) if args.outPath != "0" else plt.show(block=True)

# CV-----------------------------------------------
coords = []
def onclick(event):
    global ix, iy
    ix, iy = event.xdata, event.ydata
    print('x = {}, y = {}'.format(ix, iy))

    global coords
    coords.append((ix, iy))
    if len(coords) == 2:
        # fig.canvas.mpl_disconnect(cid)
        global clearImg
        coords = np.round(coords).astype(int)
        cv = twoPointsCV(coords, clearImg) * 1000 * args.pixRes
        print("The CV is {} cm/s".format(cv[0][0]))
        coords = []


fig = plt.figure(); ax = fig.add_subplot(111)
cid = fig.canvas.mpl_connect('button_press_event', onclick)
plt.imshow(clearImg, vmin=np.nanmin(clearImg), vmax=np.nanmax(clearImg), cmap='Blues'); plt.axis('off')
plt.title("Select two points for CV calculation")
cbar = plt.colorbar(ax=[ax], ticks=np.round(np.linspace(np.nanmin(clearImg),np.nanmax(clearImg),4)), location="right", pad=0.02, shrink=0.9)
cbar.ax.tick_params(labelsize=20); cbar.ax.facecolor = 'r'; cbar.set_label('AT (ms)', fontsize=20)
plt.show()
