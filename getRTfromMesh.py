# This computes the repolarization time for a ventricular mesh that has ATs and APDX calculated
# the initiation is the time of the earliest upstroke (this should be comparable/equivalent 
# with the onset of QRS) and the finish is the 90 percent of repolarization, so basically we sum
# the ATs with their APDX
# Paper Yue et al "Determination of Human Ventricular Repolarization by Noncontact Mapping Validation With Monophasic Action Potential Recordings"

import os
import numpy as np
import argparse 
import time
from shutil import copyfile
from utils import calculateBoxPlotParams, plotHistAndBoxPlotSeaBorn

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--animationPrefix',type=str, required=True)
parser.add_argument('--apdType',type=int, required=True)
args = parser.parse_args()

#ATs
with open(os.path.join(args.dataPath, "lat.ens"), "r") as f:
    data = f.readlines()
lats = np.array(data[4:]).astype(float)
# lats = lats[~np.isnan(lats)]; values = lats

#APDXs
with open(os.path.join(args.dataPath, "apd{}.ens".format(args.apdType)), "r") as f:
    data = f.readlines()
apds = np.array(data[4:]).astype(float)
# apds = apds[~np.isnan(apds)]

RTs = lats + apds

# Save
with open(os.path.join(args.dataPath, "rt.ens"), 'w') as f:
    f.write("Ensight Model Post Process\n")
    f.write("part\n")
    f.write(" 1\n")
    f.write("coordinates\n")

    for i in range(RTs.shape[0]):
        f.write("{0:f}\n".format(RTs[i]))

#Adjust .case for seeing new data
with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'r') as f:
    data = f.readlines()

copyfile (os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), os.path.join(args.dataPath, "{}Ori.case".format(args.animationPrefix)))
scalarNewData = "scalar per node: RT rt.ens\n"
for i in range(len(data)):
    if "TIME" in data[i]:
        newdata = data[:i-1]
        newdata.append(scalarNewData)
        newdata.extend(data[i-1:])

with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'w') as f:
    for i in range(len(newdata)):
        f.write(newdata[i])

values = RTs
values = values[~np.isnan(values)]
boxplotData = calculateBoxPlotParams(values)
print("Useful Data: mean-std {0:.2f} +/- {1:.2f}; min {2:.2f}; max {3:.2f}".format(np.mean(values), np.std(values), np.min(values), np.max(values)))
print("\t median {0}, lowQuart {1}, upQuart {2}, lowWhisker {3}, upWhisker {4}".format(boxplotData[0], boxplotData[1], boxplotData[2], boxplotData[3], boxplotData[4]))

plotHistAndBoxPlotSeaBorn(values, "RT (ms)", os.path.join(args.dataPath.split("tissue")[0], "RT_metrics.png"))

# Calculation to compare with Opthof et al, Dispersion in ventricular repolarization in the human, canine and porcine heart
rtThreshold = ((np.max(values) - np.min(values)) * 0.71) + np.min(values)
rtTissuePercent = ( (values <= rtThreshold).nonzero()[0].shape[0] / values.shape[0] ) * 100
print("Percent of tissue repolarized at 71% of repolarization time : {0:.2f} %".format(rtTissuePercent))

rtTissue50Percent = np.median(values)
rtTissue50Percent = rtTissue50Percent - np.min(values)
rtPercent = (rtTissue50Percent / (np.max(values) - np.min(values))) * 100
print("Percent of repolarization time at 50% of tissue repolarized : {0:.2f} %".format(rtPercent))