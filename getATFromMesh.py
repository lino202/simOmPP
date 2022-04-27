import os  
import argparse
from tqdm import tqdm
import numpy as np
from utils import calculateBoxPlotParams
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--resPath',type=str, required=True, help='path to data')
args = parser.parse_args()

with open(os.path.join(args.dataPath, "lat.ens"), "r") as f:
    data = f.readlines()

lats = np.array(data[4:]).astype(int)
lats = lats[~np.isnan(lats)]
boxplotData = calculateBoxPlotParams(lats)
print("Useful Data: mean-std {0:.2f} +/- {1:.2f}".format(np.mean(lats), np.std(lats)))
print("\t median {0}, lowQuart {1}, upQuart {2}, lowWhisker {3}, upWhisker {4}".format(boxplotData[0], boxplotData[1], boxplotData[2], boxplotData[3], boxplotData[4]))

fig, axs = plt.subplots(1,2)
plt.subplots_adjust(wspace=0.4)
axs[0].hist(lats)
axs[1].boxplot(lats)
axs[0].set_ylabel("Frequencies")
axs[0].set_xlabel("AT [ms]")
axs[1].set_xlabel("Samples")
axs[1].set_ylabel("AT [ms]")
plt.savefig(os.path.join(args.resPath,'AT_metrics.png'))
plt.show()
