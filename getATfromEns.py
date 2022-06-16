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
parser.add_argument('--method',type=str, required=True)
parser.add_argument('--timeStart',type=int, required=True)
parser.add_argument('--timeEnd',type=int, required=True)
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

ATs = np.ones(v.shape[0]) * np.nan
if args.method == "upstroke":
    diff = np.diff(v, axis=1)
    upstrokeIdxs = np.argmax(diff, axis=1)   # ATs
    ATs = upstrokeIdxs
elif  args.method == "zero-cross":
    for i in tqdm(range(v.shape[0])):
        try:
            ATs[i] = np.where(np.diff(np.sign(v[i])))[0][0]
        except IndexError: pass
else: raise ValueError("Wrong method")

with open(os.path.join(args.dataPath, "lat.ens"), 'w') as f:
    f.write("Ensight Model Post Process\n")
    f.write("part\n")
    f.write(" 1\n")
    f.write("coordinates\n")

    for i in range(ATs.shape[0]):
        f.write("{0:f}\n".format(ATs[i]))

#Adjust .case for seeing new apd data
with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'r') as f:
    data = f.readlines()

copyfile (os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), os.path.join(args.dataPath, "{}Ori.case".format(args.animationPrefix)))
scalarNewData = "scalar per node: LAT lat.ens\n"
for i in range(len(data)):
    if "TIME" in data[i]:
        newdata = data[:i-1]
        newdata.append(scalarNewData)
        newdata.extend(data[i-1:])

with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'w') as f:
    for i in range(len(newdata)):
        f.write(newdata[i])
