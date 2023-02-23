import os  
import argparse
import nrrd
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
from matplotlib.ticker import FormatStrFormatter
from scipy.io import savemat
import seaborn as sns
import pandas as pd
from PIL import Image
import openpyxl

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}
plt.rc('font', **font)

def plotHistAndBoxPlotSeaBorn(array, arrayName, binsNum = "auto", path=None):
    
    sns.set(style="ticks")
    f, (ax_box, ax_hist) = plt.subplots(2, sharex=True, gridspec_kw={"height_ratios": (.15, .85)})
    sns.boxplot(x=array, ax=ax_box)
    sns.histplot(x=array, ax=ax_hist, bins=binsNum, kde=True)
    ax_box.set(yticks=[])
    ax_hist.set_ylabel("Frequencies")
    ax_hist.set_xlabel(arrayName)
    ax_hist.ticklabel_format(useOffset=False)
    ax_hist.xaxis.set_major_formatter(FormatStrFormatter('%.2f'))
    sns.despine(ax=ax_hist)
    sns.despine(ax=ax_box, left=True)
    plt.savefig(path) if path else plt.show(block=True)

def plotVarMap(varMap, varName, resFile, save):
    plt.figure()
    ax = plt.subplot()
    im = ax.imshow(varMap, vmin=np.nanmin(varMap), vmax=np.nanmax(varMap), cmap='jet')
    divider = make_axes_locatable(ax)
    cax = divider.append_axes("right", size="5%", pad=0.05)
    cbar = plt.colorbar(im, cax=cax, ticks=np.round(np.linspace(np.nanmin(varMap),np.nanmax(varMap),10)))
    cbar.set_label(varName)
    plt.savefig(resFile) if resFile and save else plt.show(block=True)
    
    
def getStatistics(data):
    mean = np.mean(data)
    mymin = np.min(data)
    mymax = np.max(data)
    median = np.median(data)
    upQuart = np.percentile(data, 75)
    lowQuart = np.percentile(data, 25)
    iqr = upQuart - lowQuart
    upWhisker = data[data<=upQuart+1.5*iqr].max()
    lowWhisker = data[data>=lowQuart-1.5*iqr].min()
    return mean, mymin, mymax, median, lowQuart, upQuart, lowWhisker, upWhisker

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--variableMap',type=str, required=True, help='path to csv map')
parser.add_argument('--meshMask',type=str, required=True, help='should be png or nrrd')
parser.add_argument('--tissueMask',type=str, required=True, help='should be png')
parser.add_argument('--resPath',type=str, required=True, help='results path')
parser.add_argument('--label',type=str, required=True, help='label for figures')
parser.add_argument('--resExcel',type=str)
parser.add_argument('--save',action='store_true')
args = parser.parse_args()

#Load and reconstruct apds from .csv
if "csv" in args.variableMap:
    if "map" in args.variableMap:   
        varMap = np.genfromtxt(args.variableMap, delimiter=',')
    elif "list" in args.variableMap:
        varValues = np.genfromtxt(args.variableMap, delimiter=',')
        imgPixs = int(np.round(np.sqrt((varValues.shape[0]-1))))
        varMap = varValues.reshape(imgPixs,-1)
        varMap = np.fliplr(np.rot90(varMap, k=1, axes=(1,0)))
        
    else:
        raise ValueError("Variable Map needs to have map or list in the name")
elif "fig" in args.variableMap:
    raise ValueError("Implemented for .fig files")
else:
    raise ValueError("Wrong type of file")

#Load the mesh and tissue masks
if "png" in args.tissueMask:
    tissueMask = np.array(Image.open(args.tissueMask)).astype(int)
else:
    raise ValueError("Wrong type of file")

if "nrrd" in args.meshMask:
    meshMask, meshMaskHeader = nrrd.read(args.meshMask)
    meshMask = meshMask[:,:,0]
    meshMask = np.fliplr(np.rot90(meshMask, k=1, axes=(1,0)))
elif "png" in args.meshMask:
    meshMask = np.array(Image.open(args.meshMask))
else:
    raise ValueError("Wrong type of file")

#Plot three files
fig, axs = plt.subplots(1,3)
axs[0].imshow(varMap, vmin=np.nanmin(varMap), vmax=np.nanmax(varMap), cmap='jet')
axs[1].imshow(meshMask)
axs[2].imshow(tissueMask)
if not args.save: plt.show()

#Plot hist and boxplot for mesh, inner tissue and complete, maybe with the colormap and maps
varTissue = varMap * tissueMask
varMesh = varTissue * meshMask
varInner = -1 * varTissue * (meshMask - 1)
varTissue[varTissue<=0] = np.nan
varMesh[varMesh<=0] = np.nan
varInner[varInner<=0] = np.nan

#ACTUAL SAVE

resFile = os.path.join(args.resPath, "{}_tissue_map.png".format(args.label))
plotVarMap(varTissue, args.label,resFile, args.save)
resFile = os.path.join(args.resPath, "{}_tissue_histbox.png".format(args.label))
plotHistAndBoxPlotSeaBorn(varTissue[~np.isnan(varTissue)], args.label, path=resFile if args.save else None)
statsTissue = getStatistics(varTissue[~np.isnan(varTissue)])

resFile = os.path.join(args.resPath, "{}_mesh_map.png".format(args.label))
plotVarMap(varMesh, args.label, resFile, args.save)
resFile = os.path.join(args.resPath, "{}_mesh.png".format(args.label))
plotHistAndBoxPlotSeaBorn(varMesh[~np.isnan(varMesh)], args.label, path=resFile if args.save else None)
statsMesh = getStatistics(varMesh[~np.isnan(varMesh)])

resFile = os.path.join(args.resPath, "{}_inner_map.png".format(args.label))
plotVarMap(varInner, args.label, resFile, args.save)
resFile = os.path.join(args.resPath, "{}_inner.png".format(args.label))
plotHistAndBoxPlotSeaBorn(varInner[~np.isnan(varInner)], args.label, path=resFile if args.save else None)
statsInner = getStatistics(varInner[~np.isnan(varInner)])

if args.save:
    name = args.variableMap.split("/")[-1].split(".")[0]
    data = {}
    data["varTissue"] = varTissue
    data["varMesh"] = varMesh
    data["varInner"] = varInner
    savemat(os.path.join(args.resPath,"var_results.mat"), data)
    
    indexs = ['tissue', 'mesh', 'inner']
    indexs = ["{}_{}".format(name, index) for index in indexs] 
    columns = ['mean', 'min', 'max', 'median', 'lowQuart', 'upQuart', 'lowWhisker', 'upWhisker']
    df = pd.DataFrame([statsTissue, statsMesh, statsInner],
                  index=indexs, columns=columns)
    
    if not os.path.exists(args.resExcel):
        df.to_excel(args.resExcel, sheet_name='sheet1')
    else:
        with pd.ExcelWriter(args.resExcel, engine="openpyxl", mode='a',if_sheet_exists="overlay") as writer:
            startrow = writer.sheets['sheet1'].max_row
            df.to_excel(writer, sheet_name='sheet1', startrow=startrow, header=False)

    
    