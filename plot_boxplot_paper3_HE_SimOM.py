
import argparse
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns 
import meshio
import pandas as pd
import pickle

font = {'family' : "Times New Roman",
        # 'weight' : 'bold',
        'size'   : 10}
plt.rc('font', **font)

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPaths',type=str, required=True, nargs='+', help='path to different files')
# parser.add_argument('--palette',type=str, required=True, nargs='+', help='colors in boxplot')
parser.add_argument('--variableName',type=str, required=True, help='data name')
parser.add_argument('--dataNames',type=str, required=True, nargs='+', help='data names')
parser.add_argument('--ylabel',type=str, required=True)
parser.add_argument('--xlabel',type=str, required=True)
parser.add_argument('--huelabel',type=str, required=True)
parser.add_argument('--outPath', type=str, help='path to the folder for saving images, if 0 images are plotted and not saved')
args = parser.parse_args()

# Parse
data = {}

for i, dataPath in enumerate(args.dataPaths):
        if ".vtk" in dataPath:
                mesh = meshio.read(dataPath)
                data[args.dataNames[i]] = mesh.point_data[args.variableName]    # This already should be the magnitude in case of results.vtk
                if "AT" in args.variableName:
                        data[args.dataNames[i]] = data[args.dataNames[i]] - np.min(data[args.dataNames[i]])
        elif ".pkl" in dataPath:
                with open(dataPath, 'rb') as f:
                        tmp = pickle.load(f)
                        if "ats" in dataPath:
                                tmp = tmp.flatten()
                                tmp = tmp[~np.isnan(tmp)]
                                tmp = tmp - np.min(tmp)
                        elif "apd" in dataPath:
                                tmp = tmp.flatten()
                                tmp = tmp[~np.isnan(tmp)]
                        elif "cvs" in dataPath:
                                tmp = np.linalg.norm(tmp, axis=1)
                        else:
                                raise ValueError("Wrong data naming?")
                        data[args.dataNames[i]] = tmp                # here we convert to magnitudes as we receive the vectors or and image shape with 2 dims
        else:
                raise ValueError("Input datapath must be a .vtk or .pkl file")


values = np.array([])
cases = np.array([])
views = np.array([])

for key in data.keys():
        case = key.split("_")[0]
        view = key.split("_")[1]
        sub_cases = np.array([case] * data[key].shape[0])
        sub_views = np.array([view] * data[key].shape[0])

        cases   = np.concatenate((cases,  sub_cases)) if cases.size else sub_cases
        values  = np.concatenate((values, data[key])) if values.size else data[key]  
        views   = np.concatenate((views,  sub_views)) if views.size else sub_views



data4DF = {args.variableName: values, args.xlabel: cases, args.huelabel: views}   


df = pd.DataFrame(data4DF)

plt.rcParams.update({'mathtext.default':  'regular' })
# sns.set_context("paper")
plt.figure(figsize=(9 * 0.393701, 6 * 0.393701))

# sns.boxplot(data=df, palette="deep")
# sns.boxplot(data=df, x=args.xlabel, y=args.variableName, hue=args.huelabel, palette="deep")
sns.violinplot(data=df, x=args.xlabel, y=args.variableName, hue=args.huelabel, palette="deep", scale="width")
plt.ylabel(args.ylabel, fontsize=10)
plt.xlabel(args.xlabel, fontsize=10)

plt.tight_layout()
# plt.show()
plt.savefig(args.outPath) if args.outPath else plt.show(block=True)