import os
import meshio
import numpy as np
import argparse
from tqdm import tqdm
from utils import calculateBoxPlotParams, isMemberIdxsRowWise
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--resultsMesh',type=str, required=True)
parser.add_argument('--cleanMesh',type=str, required=True)
parser.add_argument('--apdtype',type=int, required=True)
args = parser.parse_args()

cleanMesh = meshio.read(os.path.join(args.dataPath, args.cleanMesh))
resultsMesh = meshio.read(os.path.join(args.dataPath, args.resultsMesh))
points = cleanMesh.points
cells = cleanMesh.cells_dict["triangle"]
idxs = isMemberIdxsRowWise(points, resultsMesh.points)
apds = resultsMesh.point_data["APD{}".format(args.apdtype)][idxs]

apds = apds[~np.isnan(apds)]
boxplotData = calculateBoxPlotParams(apds)
print("Useful Data: mean-std {0:.2f} +/- {1:.2f}".format(np.mean(apds), np.std(apds)))
print("\t median {0}, lowQuart {1}, upQuart {2}, lowWhisker {3}, upWhisker {4}".format(boxplotData[0], boxplotData[1], boxplotData[2], boxplotData[3], boxplotData[4]))

fig, axs = plt.subplots(1,2)
plt.subplots_adjust(wspace=0.4)
axs[0].hist(apds)
axs[1].boxplot(apds)
axs[0].set_ylabel("Frequencies")
axs[0].set_xlabel("APD{} [ms]".format(args.apdtype))
axs[1].set_xlabel("Samples")
axs[1].set_ylabel("APD{} [ms]".format(args.apdtype))
plt.savefig(os.path.join(args.dataPath,'APD{}_metrics.png'.format(args.apdtype)))
plt.show()