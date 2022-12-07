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
parser.add_argument('--animationPrefix',type=str, default="tissue_animation")
parser.add_argument('--timeStart',type=float, required=True)
parser.add_argument('--timeEnd',type=float, required=True)
args = parser.parse_args()


#Adjust .case for seeing new apd data
with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'r') as f:
    data = f.readlines()

caseTimeIdx = data.index("TIME\n")
dt = np.array(data[caseTimeIdx+1].split(':')[-1].split('\n')[0]).astype(float)
nSteps = np.array(data[caseTimeIdx+2].split(':')[-1].split('\n')[0]).astype(int)
caseVariableIdx = data.index("VARIABLE\n")
ensNames = data[caseVariableIdx+1].split(':')[-1].split('\n')[0].split(" ")[2].split("*")[0]

times = np.arange(args.timeStart * 1/dt, args.timeEnd * 1/dt + 1).astype(int) # paraview has problems with this being decimals maybe read ensight manual              
newdata = data[:caseTimeIdx+5]
newdata[caseTimeIdx+1] = 'time set: 1\n'
newdata[caseTimeIdx+2] = 'number of steps: {0:d}\n'.format(times.shape[0])
newdata[caseTimeIdx+3] = 'filename start number: {0:d}\n'.format(times[0])

timeWriteStep = 10
for idx in range(0,times.shape[0],timeWriteStep):
    if idx == 0:
        tmp = "time values: " + str(times[idx:idx+timeWriteStep]).split("[")[1].split("]")[0] + "\n"
        newdata.append(tmp)
    else:
        tmp = "             " + str(times[idx:idx+timeWriteStep]).split("[")[1].split("]")[0] + "\n"
        newdata.append(tmp)

print("Removing .ens solutions")
filesInfoString = newdata[caseTimeIdx-3]
files2DeletePrefix = filesInfoString.split('*')[0].split(" ")[-1]
nFiles = int(data[caseTimeIdx+2].split("\n")[0].split(" ")[-1])
allTimes = np.arange(0, nFiles)
nAsterisks = newdata[caseTimeIdx-3].count('*')
times2Delete = allTimes[~np.isin(allTimes, times)]
for time in times2Delete:
    os.remove(os.path.join(args.dataPath, "{0}{1}.ens".format(files2DeletePrefix, str(time).zfill(nAsterisks))))
    # print(os.path.join(args.dataPath, "{0}{1}.ens".format(files2DeletePrefix, str(time).zfill(nAsterisks))))

with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'w') as f:
    f.writelines(newdata)
