import os
import numpy as np
import argparse
import matplotlib.pyplot as plt 
import time
from tqdm import tqdm
from shutil import copyfile
import random

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--solutionPrefix',type=str, required=True)
parser.add_argument('--animationPrefix',type=str, required=True)
parser.add_argument('--timeStart',type=int, required=True)
parser.add_argument('--timeEnd',type=int, required=True)
parser.add_argument('--apd',type=int, required=True)
args = parser.parse_args()

print("Reading .ens solutions")
nDigits = len(str(args.timeEnd))
for i in tqdm(range(args.timeStart, args.timeEnd)):
    with open(os.path.join(args.dataPath, '{}{}.ens'.format(args.solutionPrefix, str(i).zfill(nDigits)))) as f:
        data = f.readlines()

    tmp = np.array(data[4:]).astype(float)
    if i == args.timeStart: v = np.zeros((tmp.shape[0], args.timeEnd - args.timeStart))
    v[:, i-args.timeStart] = tmp

#Plot some curves
fig, ax = plt.subplots()
for i in range(10):
    plotIdx = random.randint(0,v.shape[0])
    ax.plot(v[plotIdx,:], label=plotIdx)
ax.legend()
ax.set_title("10 Vm signals")
plt.show()

diff = np.diff(v, axis=1)
upstrokeIdxs = np.argmax(diff, axis=1)

peakIdxs = np.argmax(v, axis=1)
peaks    = np.max(v, axis=1)
baselinelvls = np.array([np.min(v[i,peakIdxs[i]:]) for i in range(v.shape[0])])

Voi = baselinelvls + (1 - (args.apd/100)) * (peaks - baselinelvls)
tin = np.ones(v.shape[0]) * np.nan
for i in tqdm(range(v.shape[0])):
    try:
        tin[i] = (v[i,peakIdxs[i]:]<Voi[i]).nonzero()[0][0] 
    except IndexError:
        pass

tin = tin + peakIdxs
# APD = np.ones(v.shape[0]) * np.nan
# if (tin[~np.isnan(tin)] >= upstrokeIdxs[~np.isnan(tin)]).all():
#     APD[~np.isnan(tin)] = tin[~np.isnan(tin)] - upstrokeIdxs[~np.isnan(tin)] 
# else: 
#     raise ValueError("Max derivate time greater than x repolarization")
    
APD = tin - upstrokeIdxs
APD[APD<0] = np.nan
with open(os.path.join(args.dataPath, "apd{}.ens".format(args.apd)), 'w') as f:
    f.write("Ensight Model Post Process\n")
    f.write("part\n")
    f.write(" 1\n")
    f.write("coordinates\n")

    for i in range(APD.shape[0]):
        f.write("{0:f}\n".format(APD[i]))

#Adjust .case for seeing new apd data
with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'r') as f:
    data = f.readlines()

copyfile (os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), os.path.join(args.dataPath, "{}Ori.case".format(args.animationPrefix)))
scalarNewData = "scalar per node: APD{0} apd{1}.ens\n".format(args.apd, args.apd)
for i in range(len(data)):
    if "TIME" in data[i]:
        newdata = data[:i-1]
        newdata.append(scalarNewData)
        newdata.extend(data[i-1:])

with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'w') as f:
    for i in range(len(newdata)):
        f.write(newdata[i])
