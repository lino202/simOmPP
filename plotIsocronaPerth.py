import argparse
import numpy as np
import pickle
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter
import scipy.io
import copy
from utils import cleanMap, meanFilter, keepBigIsland
import hdf5storage

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--dataPath',         type=str, required=True, help='path to data')
    parser.add_argument('--backgroundPath',   type=str, required=True, help='path to data')
    parser.add_argument('--cleanProcess',type=int, required=True, help='Select the cleaning proccessed, they are really similar. 0 for not cleaning')
    parser.add_argument('--blockDown',type=int, required=True, help='Cut bottom boundary for AT values, 0 = not cutting')
    parser.add_argument('--blockUp',type=int, required=True, help='Cut upper boundary for AT values, 0 = not cutting')
    parser.add_argument('--outPath',          type=str, required=True, help='path to data')
    args = parser.parse_args()

    with open(args.dataPath, 'rb') as f:
        atmap = pickle.load(f)['at_map']

    try:
        back_image = scipy.io.loadmat(args.backgroundPath)['A'][:,:,0]
    except NotImplementedError:
        back_image = hdf5storage.loadmat(args.backgroundPath, variable_names=['A'])['A'][:,:,0]        
    back_image = (back_image-np.min(back_image))/(np.max(back_image) - np.min(back_image))

    #CLEAN
    if args.cleanProcess==0:
        atmap = copy.deepcopy(atmap)
    elif args.cleanProcess==1:
        atmap = cleanMap(atmap)
    elif args.cleanProcess==2:
        atmap = meanFilter(atmap)
    else: raise ValueError("Wrong cleanProcess")

    #KEEP BIGGEST ISLAND
    atmap = atmap.astype(float)
    atmap[atmap==0] = np.nan
    _, atmap, imgMin, imgMax = keepBigIsland(atmap, show=False)

    #PREPARE FOR PLOT AND DELETE OUTLIERS
    atmap = atmap.astype(float)
    atmap[atmap==0] = np.nan

    atmap = atmap - np.nanmin(atmap)      # With Nans
    i_ats = atmap[~np.isnan(atmap)]         # Without Nans

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
    plt.imshow(atmap, vmin=np.nanmin(atmap), vmax=np.nanmax(atmap), cmap='viridis', alpha=0.7)
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