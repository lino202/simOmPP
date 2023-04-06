import os  
from shutil import copyfile
import argparse
from tqdm import tqdm
import numpy as np
import meshio
import matplotlib.pyplot as plt
import random
from utilsCV import getLocalGradsVanillaMeshPerNodePool, getLocalGradsVanillaMeshPerNode
from utils import calcAPDXFromEns
import pandas as pd
import time

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}
plt.rc('font', **font)

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resPath',  type=str, nargs='+', required=True, help='path to data')
    parser.add_argument('--labels',   type=str, nargs='+', required=True)
    parser.add_argument('--meshPath', type=str, required=True)
    parser.add_argument('--nDigits',  type=int)
    parser.add_argument('--timeStart',type=int)
    parser.add_argument('--timeEnd',  type=int)
    parser.add_argument('--dt',       type=float, default=1.)
    parser.add_argument('--node',     type=int)
    args = parser.parse_args()

    mesh = meshio.read(args.meshPath)
    
    nodeLats = []
    for resPath in args.resPath:
        latPath = os.path.join(resPath, "lat.ens")

        with open(latPath, "r") as f:
            data = f.readlines()
        lats = np.array(data[4:]).astype(float)
        lats = lats - np.nanmin(lats)
        nodeLats = lats[args.node]

    nodeVs = np.zeros((len(args.resPath), args.timeEnd - args.timeStart))
    for j, resPath in enumerate(args.resPath):
        for i in tqdm(range(args.timeStart, args.timeEnd)):
            fileName = os.path.join(resPath, 'tissue_solution{}.ens'.format(str(i).zfill(args.nDigits)))
            df = pd.read_csv(fileName, usecols=[0], skiprows=3, dtype=np.float64)
            nodeVs[j, i-args.timeStart] = df["coordinates"][args.node]

    for i in range(nodeVs.shape[0]):
        if not np.isnan(lats[i]):
            latIdx = int(np.round((lats[i]/args.dt)))
            tmp = nodeVs[i,latIdx:]
            nodeVs[i,:] = np.pad(tmp, (0,latIdx), 'edge')

    time = np.arange(args.timeStart*args.dt, args.timeEnd*args.dt, args.dt)
    plt.figure()
    for i in range(nodeVs.shape[0]):
        plt.plot(time, nodeVs[i,:], label=args.labels[i])
    plt.legend(loc="upper right")
    plt.ylabel("Vm (mV)")
    plt.xlabel("time (ms)")
    plt.show()


if __name__ == '__main__':
    main()