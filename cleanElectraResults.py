import os
import numpy as np
import argparse

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--animationPrefix',type=str, default="tissue_animation")
parser.add_argument('--solutionPrefix',type=str, default="tissue_solution")
parser.add_argument('--nDigits',type=int, default=4)
parser.add_argument('--timeStart',type=float, required=True)
parser.add_argument('--timeEnd',type=float, required=True)
args = parser.parse_args()

#Adjust .case for seeing new apd data
with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'r') as f:
    data = f.readlines()

caseTimeIdx = data.index("TIME\n")
dt = float(data[caseTimeIdx+5].split(' ')[3])
nSteps = np.array(data[caseTimeIdx+2].split(':')[-1].split('\n')[0]).astype(int)
caseVariableIdx = data.index("VARIABLE\n")
ensNames = data[caseVariableIdx+1].split(':')[-1].split('\n')[0].split(" ")[2].split("*")[0]

samples = np.arange(args.timeStart / dt, args.timeEnd / dt + 1)
times = np.arange(args.timeStart, args.timeEnd + dt, dt)
newdata = data[:caseTimeIdx+5]
newdata[caseTimeIdx+1] = 'time set: 1\n'
newdata[caseTimeIdx+2] = 'number of steps: {0:d}\n'.format(samples.shape[0])
newdata[caseTimeIdx+3] = 'filename start number: {0:d}\n'.format(int(samples[0]))

timeWriteStep = 10
for idx in range(0,samples.shape[0],timeWriteStep):
    currentTimes = list(times[idx:idx+timeWriteStep])
    currentTimes = [str(x) for x in currentTimes]

    tmp = "time values: " if idx == 0 else "\t\t\t"
    for itime in currentTimes:
        tmp += itime + " "
    tmp += "\n"

    newdata.append(tmp)


print("Removing .ens solutions")
nFiles = int(data[caseTimeIdx+2].split("\n")[0].split(" ")[-1])
allSamples = np.arange(0, nFiles)
samples2Delete = allSamples[~np.isin(allSamples, samples)]
for sample in samples2Delete:
    tmpName = os.path.join(args.dataPath, "{0}{1}.ens".format(args.solutionPrefix, str(sample).zfill(args.nDigits)))
    print(tmpName)
    os.remove(tmpName)
    

with open(os.path.join(args.dataPath, "{}.case".format(args.animationPrefix)), 'w') as f:
    f.writelines(newdata)
