import argparse
import numpy as np
import pickle
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter
import scipy.io
import copy
from utils import cleanMap, meanFilter, keepBigIsland

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--dataPath',         type=str, required=True, help='path to data')
    parser.add_argument('--backgroundPath',   type=str, required=True, help='path to data')
    parser.add_argument('--blockDown',type=int, required=True, help='Cut bottom boundary for AT values, 0 = not cutting')
    parser.add_argument('--blockUp',type=int, required=True, help='Cut upper boundary for AT values, 0 = not cutting')
    parser.add_argument('--outPath',          type=str, required=True, help='path to data')
    args = parser.parse_args()

    with open(args.dataPath, 'rb') as f:
        atmap = pickle.load(f)

    back_image = scipy.io.loadmat(args.backgroundPath)['A'][:,:,0]
    back_image = (back_image-np.min(back_image))/(np.max(back_image) - np.min(back_image))

    #PREPARE FOR PLOT AND DELETE OUTLIERS
    #KEEP BIGGEST ISLAND
    # _, atmap, imgMin, imgMax = keepBigIsland(atmap, show=True) # we need to sum 1 and pass nans to 0s then we reconvert the atmap

    #PREPARE FOR PLOT AND DELETE OUTLIER
    atmap = atmap - np.nanmin(atmap)      # With Nans

    # Block in case there are outliers
    if args.blockDown != 0:
        atmap[atmap<args.blockDown] = np.nan
    if args.blockUp != 0:
        atmap[atmap>args.blockUp] = np.nan

    atmap = atmap - np.nanmin(atmap)      # With Nans

    # Nice Plot of ATs 
    font = {'family' : "Times New Roman",
    'weight' : 'normal',
    'size'   : 20}

    plt.rc('font', **font)
    plt.rcParams.update({'mathtext.default':  'regular' })

    fig = plt.figure()
    ax = fig.add_subplot(111)
    plt.imshow(back_image, cmap='gray')
    plt.imshow(atmap, vmin=np.nanmin(atmap), vmax=np.nanmax(atmap), cmap='viridis', alpha=0.8)
    plt.axis('off')
    cbar = plt.colorbar(ax=[ax], ticks=np.linspace(np.nanmin(atmap),np.nanmax(atmap),4), location="right", pad=0.02, shrink=0.9)
    # cbar.ax.tick_params(labelsize=fontsize)
    cbar.ax.facecolor = 'r'
    cbar.set_label('AT (ms)') #fontfamily=fontFamily, fontsize=fontsize
    cbar.ax.ticklabel_format(useOffset=False)
    cbar.ax.yaxis.set_major_formatter(FormatStrFormatter('%.1f'))
    plt.savefig(args.outPath, dpi=500)
    plt.close()

if __name__ == '__main__':
    main()