import os
import meshio
import numpy as np
import argparse
from tqdm import tqdm
from utils import calculateBoxPlotParams, isMemberIdxsRowWise, plotHistAndBoxPlotSeaBorn

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath', type=str, required=True, help='path to data')
parser.add_argument('--resultsMesh', type=str, required=True)
parser.add_argument('--cleanMesh', type=str)
parser.add_argument('--parameterType', type=str, required=True)
parser.add_argument('--layerType', type=str, required=True)
parser.add_argument('--alreadyClean', action='store_true')
parser.add_argument('--save', action='store_true')
parser.add_argument('--outType', type=str)
args = parser.parse_args()

resultsMesh = meshio.read(os.path.join(args.dataPath, args.resultsMesh))

if not args.alreadyClean:
    cleanMesh = meshio.read(os.path.join(args.dataPath, args.cleanMesh))
    points = cleanMesh.points
    idxs = isMemberIdxsRowWise(points, resultsMesh.points)
    values = resultsMesh.point_data[args.parameterType][idxs]
else:
    values = resultsMesh.point_data[args.parameterType]

values = values[~np.isnan(values)]
boxplotData = calculateBoxPlotParams(values)
print("Useful Data: mean-std {0:.2f} +/- {1:.2f}; min {2:.2f}; max {3:.2f}".format(np.mean(values), np.std(values), np.min(values), np.max(values)))
print("\t median {0}, lowQuart {1}, upQuart {2}, lowWhisker {3}, upWhisker {4}".format(boxplotData[0], boxplotData[1], boxplotData[2], boxplotData[3], boxplotData[4]))

if args.save:
    plotHistAndBoxPlotSeaBorn(values, "{} (ms)".format(args.parameterType), os.path.join(args.dataPath, "{}_{}_metrics.{}".format(args.parameterType, args.layerType, args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(values, "{} (ms)".format(args.parameterType))