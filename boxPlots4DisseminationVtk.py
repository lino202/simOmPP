import os  
import argparse
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns 
import meshio
import pandas as pd
import pickle

font = {'family' : "Times New Roman",
        'weight' : 'bold',
        'size'   : 20}
plt.rc('font', **font)

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPaths',type=str, required=True, nargs='+', help='path to different files')
# parser.add_argument('--palette',type=str, required=True, nargs='+', help='colors in boxplot')
parser.add_argument('--variableName',type=str, required=True, help='data name')
parser.add_argument('--dataNames',type=str, required=True, nargs='+', help='data names')
parser.add_argument('--nodeset',type=str, required=True, help='node set')
parser.add_argument('--ylabel',type=str, required=True)
parser.add_argument('--xlabel',type=str, required=True)
parser.add_argument('--huelabel',type=str, required=True)
parser.add_argument('--threshold',type=float, nargs='+')
parser.add_argument('--outPath', type=str, help='path to the folder for saving images, if 0 images are plotted and not saved')
args = parser.parse_args()

# Parse
data = {}

for i, dataPath in enumerate(args.dataPaths):
        if ".vtk" in dataPath:
                mesh = meshio.read(dataPath)
                idxs = (mesh.point_data[args.nodeset]==1.).nonzero()[0]
                data[args.dataNames[i]] = mesh.point_data[args.variableName][idxs]
        else:
                raise ValueError("Input datapath must be a .vtk file")

mymap = {"10": 0, "50": 1, "90": 2}
values = np.array([])
valuesEHTc = np.array([])
valuesAttach = np.array([])
for key in data.keys():
        EHTc         = int(key.split("_")[0])
        try: 
                attach       = int(key.split("_")[1])
        except:
                attach = key.split("_")[1]

        # if min(args.threshold) != 0 and args.threshold != None:
        #         valueThres = (data[key]>=args.threshold[mymap[str(EHTc)]]).nonzero()[0]
        #         valueThres = len(valueThres) / data[key].shape[0] * 100
        #         valueThres = np.array([valueThres])
        #         EHTc       = np.array([EHTc])
        #         attach     = np.array([attach])
        #         values = np.concatenate((values, valueThres)) if values.size else valueThres
        #         valuesEHTc   = np.concatenate((valuesEHTc, EHTc)) if valuesEHTc.size else EHTc
        #         valuesAttach = np.concatenate((valuesAttach, attach)) if valuesAttach.size else attach
        # elif min(args.threshold) == 0:
                # valueThres = np.max(data[key])
        # valueThres = np.percentile(data[key], 70)
        # valueThres = np.array([valueThres])
        # EHTc       = np.array([EHTc])
        # attach     = np.array([attach])
        # values = np.concatenate((values, valueThres)) if values.size else valueThres
        # valuesEHTc   = np.concatenate((valuesEHTc, EHTc)) if valuesEHTc.size else EHTc
        # valuesAttach = np.concatenate((valuesAttach, attach)) if valuesAttach.size else attach
        # else:       
        EHTcArr      = np.ones(data[key].shape[0]) * EHTc
        try:
                attachArr    = np.ones(data[key].shape[0]) * attach
        except:
                attachArr = [attach] * data[key].shape[0]
                attachArr = np.array(attachArr)
        valuesEHTc   = np.concatenate((valuesEHTc, EHTcArr)) if valuesEHTc.size else EHTcArr
        valuesAttach = np.concatenate((valuesAttach, attachArr)) if valuesAttach.size else attachArr  
        values = np.concatenate((values, data[key])) if values.size else data[key]

try:
        data4DF = {args.variableName: values, args.xlabel: valuesEHTc.astype(int), args.huelabel: valuesAttach.astype(int)}   
except:
        data4DF = {args.variableName: values, args.xlabel: valuesEHTc.astype(int), args.huelabel: valuesAttach}   

# df = pd.concat(map(pd.Series, data.values()), keys=data.keys(), axis=1)
df = pd.DataFrame(data4DF)

# plt.figure(figsize=(19, 10), dpi=80)
# sns.boxplot(data=df, palette=args.palette)
# plt.xlabel(args.xlabel, fontweight='bold')
# plt.ylabel(args.ylabel, fontweight='bold')
# plt.savefig(args.outPath) if args.outPath else plt.show(block=True)

plt.rcParams.update({'mathtext.default':  'regular' })
sns.set_context("paper", font_scale=3., rc={"lines.linewidth": 1.5})
plt.figure(figsize=(12,9))
if args.threshold:
        sns.barplot(data=df, x=args.xlabel, y=args.variableName, hue=args.huelabel, palette="deep")
else:
        # sns.boxplot(data=df, x="Relative EHT conductivity (%)", y=args.variableName, hue="Attachment (%)", palette="deep")
        sns.violinplot(data=df, x=args.xlabel, y=args.variableName, hue=args.huelabel, palette="deep", scale="width")
plt.ylabel(args.ylabel, fontsize=45)
plt.xlabel(args.xlabel, fontsize=45)
plt.savefig(args.outPath) if args.outPath else plt.show(block=True)