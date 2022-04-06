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
parser.add_argument('--timeStart',type=int, required=True)
parser.add_argument('--timeEnd',type=int, required=True)
parser.add_argument('--apd',type=int, required=True)
args = parser.parse_args()

print("Reading .ens solutions")
for i in tqdm(range(args.timeStart, args.timeEnd)):
    with open(os.path.join(args.dataPath, 'tissue_solution{}.ens'.format(str(i).zfill(4)))) as f:
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
tin = np.array([(v[i,peakIdxs[i]:]<Voi[i]).nonzero()[0][0] for i in range(v.shape[0])])
tin = tin + peakIdxs

if (tin >= upstrokeIdxs).all():
    APD = tin - upstrokeIdxs 
else: 
    raise ValueError("Max derivate time greater than x repolarization")
    
with open(os.path.join(args.dataPath, "apd{}.ens".format(args.apd)), 'w') as f:
    f.write("Ensight Model Post Process\n")
    f.write("part\n")
    f.write(" 1\n")
    f.write("coordinates\n")

    for i in range(APD.shape[0]):
        f.write("{0:d}\n".format(APD[i]))

#Adjust .case for seeing new apd data
with open(os.path.join(args.dataPath, "tissue_animation.case"), 'r') as f:
    data = f.readlines()

copyfile (os.path.join(args.dataPath, "tissue_animation.case"), os.path.join(args.dataPath, "tissue_animationOri.case"))
scalarNewData = "scalar per node: APD{0} apd{1}.ens\n".format(args.apd, args.apd)
for i in range(len(data)):
    if "TIME" in data[i]:
        newdata = data[:i-1]
        newdata.append(scalarNewData)
        newdata.extend(data[i-1:])

with open(os.path.join(args.dataPath, "tissue_animation.case"), 'w') as f:
    for i in range(len(newdata)):
        f.write(newdata[i])
