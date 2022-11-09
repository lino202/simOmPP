import os  
import argparse
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns 
import meshio
import pandas as pd
import pickle

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}

plt.rc('font', **font)
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPaths',type=str, required=True, nargs='+', help='path to different files')
parser.add_argument('--dataNames',type=str, required=True, nargs='+', help='data names')
parser.add_argument('--palette',type=str, required=True, nargs='+', help='colors in boxplot')
parser.add_argument('--variableName',type=str, required=True, help='data name')
parser.add_argument('--save', action='store_true')
parser.add_argument('--outPath', type=str, required=True, help='path to the folder for saving images, if 0 images are plotted and not saved')
args = parser.parse_args()

# Parse
data = {}
for i, dataPath in enumerate(args.dataPaths):
        if ".vtk" in dataPath and args.variableName == "CV (cm/s)":
                data[args.dataNames[i]] = list(meshio.read(dataPath).point_data["CVMag"])

        else:
                with open(dataPath, "rb") as fp:
                        data[args.dataNames[i]] = list(pickle.load(fp))


df = pd.concat(map(pd.Series, data.values()), keys=data.keys(), axis=1)
# tmp = np.empty(cvHe.shape)
# tmp[:] = np.nan
# tmp[np.where(cvMiApex != np.nan)] = cvMiApex
# cvMiApex = tmp
# df = pd.DataFrame.from_dict(data)

plt.figure()
sns.boxplot(data=df, palette=args.palette)
# plt.xlabel(args.variableName)
plt.ylabel(args.variableName)
plt.savefig(args.outPath) if args.save else plt.show(block=True)