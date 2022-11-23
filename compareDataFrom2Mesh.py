import os  
import argparse
import numpy as np
import matplotlib.pyplot as plt
# csfont = {'fontname':'Times New Roman'}
# plt.rcParams["font.family"] = "Times New Roman"

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 13}

plt.rc('font', **font)

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath1',type=str, required=True, help='path to data')
parser.add_argument('--dataPath2',type=str, required=True, help='path to data')
parser.add_argument('--nameData1',type=str, required=True)
parser.add_argument('--nameData2',type=str, required=True)
parser.add_argument('--histSteps',type=int, required=True)
parser.add_argument('--outPath',type=str, required=True)
parser.add_argument('--outType',type=str, required=True)
parser.add_argument('--outName',type=str, required=True)
args = parser.parse_args()

with open(args.dataPath1, "r") as f:
    data = f.readlines()
data1 = np.array(data[4:]).astype(float)
data1 = data1[~np.isnan(data1)]

with open(args.dataPath2, "r") as f:
    data = f.readlines()
data2 = np.array(data[4:]).astype(float)
data2 = data2[~np.isnan(data2)]

dataMin = np.min(np.array([np.min(data1), np.min(data2)]))
dataMax = np.max(np.array([np.max(data1), np.max(data2)]))
bins = np.linspace(dataMin, dataMax, args.histSteps)
fig, ax = plt.subplots()
ax.hist(data1, bins, alpha=0.5, label=args.nameData1, color = (0.2039,0.2039, 0.2039), ec = (0.2039,0.2039, 0.2039))
ax.hist(data2, bins, alpha=0.5, label=args.nameData2, color = (0.3334,0.6667, 1.0), ec = (0.3334,0.6667, 1.0))
ax.set_ylabel("Frequency")
ax.set_xlabel("AT (ms)")
ax.legend(loc='upper right')
plt.xlim([0, 100])
plt.ylim([0, 15000])
# ax.axis("off")
plt.savefig(os.path.join(args.outPath,'{}_hists.{}'.format(args.outName, args.outType)), transparent=False)
plt.show()

data = [data1, data2]
fig, ax = plt.subplots()
ax.boxplot(data, labels=[args.nameData1, args.nameData2])
ax.set_ylabel("AT (ms)")
plt.savefig(os.path.join(args.outPath,'{}_boxs.{}'.format(args.outName, args.outType)), transparent=True)
plt.show()
