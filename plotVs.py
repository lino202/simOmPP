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

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resPath',  type=str, required=True, help='path to data')
    parser.add_argument('--meshPath', type=str, required=True)
    parser.add_argument('--nDigits',  type=int)
    parser.add_argument('--timeStart',type=int)
    parser.add_argument('--timeEnd',  type=int)
    parser.add_argument('--dt',       type=float, default=1.)
    parser.add_argument('--nodeList', type=int, nargs='+')
    args = parser.parse_args()

    mesh = meshio.read(args.meshPath)
    latPath = os.path.join(args.resPath, "lat.ens")

    with open(latPath, "r") as f:
        data = f.readlines()
    lats = np.array(data[4:]).astype(float)
    lats = lats - np.nanmin(lats)

    # if args.nodeList:
    nodeList = np.array(args.nodeList)
    # else:
    nodeVsIdxs = np.arange(mesh.points.shape[0])

    v = np.zeros((nodeVsIdxs.shape[0], args.timeEnd - args.timeStart))
    for i in tqdm(range(args.timeStart, args.timeEnd)):
        fileName = os.path.join(args.resPath, 'tissue_solution{}.ens'.format(str(i).zfill(args.nDigits)))
        df = pd.read_csv(fileName, usecols=[0], skiprows=3, dtype=np.float64)
        v[:, i-args.timeStart] = df["coordinates"][nodeVsIdxs].to_numpy()

    for i in range(v.shape[0]):
        if not np.isnan(lats[i]):
            latIdx = int(np.round((lats[i]/args.dt)))
            tmp = v[i,latIdx:]
            v [i,:] = np.pad(tmp, (0,latIdx), 'edge')

    time = np.arange(args.timeStart*args.dt, args.timeEnd*args.dt, args.dt)
    plt.figure()
    for i in nodeList:
        plt.plot(time, v[i,:], label=str(i))
    plt.legend(loc="upper right")
    plt.show()


    

if __name__ == '__main__':
    main()