import os  
import argparse
import numpy as np
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath1',type=str, required=True, help='path to data')
parser.add_argument('--dataPath2',type=str, required=True, help='path to data')
parser.add_argument('--nameData1',type=str, required=True)
parser.add_argument('--nameData2',type=str, required=True)
parser.add_argument('--histSteps',type=int, required=True)
parser.add_argument('--outPath',type=str, required=True)
args = parser.parse_args()

with open(args.dataPath1, "r") as f:
    data = f.readlines()
data1 = np.array(data[4:]).astype(int)
data1 = data1[~np.isnan(data1)]

with open(args.dataPath2, "r") as f:
    data = f.readlines()
data2 = np.array(data[4:]).astype(int)
data2 = data2[~np.isnan(data2)]

dataMin = np.min(np.array([np.min(data1), np.min(data2)]))
dataMax = np.max(np.array([np.max(data1), np.max(data2)]))
bins = np.linspace(dataMin, dataMax, args.histSteps)
fig, ax = plt.subplots()
ax.hist(data1, bins, alpha=0.5, label=args.nameData1)
ax.hist(data2, bins, alpha=0.5, label=args.nameData2)
ax.set_ylabel("Frequency")
ax.set_xlabel("AT [ms]")
ax.legend(loc='upper right')
plt.savefig(os.path.join(args.outPath,'endo_intramyo_comparison_hists.png'))
plt.show()

data = [data1, data2]
fig, ax = plt.subplots()
ax.boxplot(data, labels=[args.nameData1, args.nameData2])
ax.set_ylabel("AT [ms]")
plt.savefig(os.path.join(args.outPath,'endo_intramyo_comparison_boxs.png'))
plt.show()
