import os  
import argparse
from tqdm import tqdm
import numpy as np
import meshio
from utils import calcATFromEnsBinary
import time


    
def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resPath',  type=str, required=True, help='path to data')
    parser.add_argument('--meshPath',type=str, required=True, help='path to data')
    parser.add_argument('--soluName', type=str, default='tissue_solution')
    parser.add_argument('--nDigits',  type=int, default=5)
    parser.add_argument('--timeStart',type=int, default=2000)
    parser.add_argument('--timeEnd',  type=int, default=3000)
    parser.add_argument('--maxMem',   type=float, default=5, help="Allowed RAM consumption in critical computations in GB")
    parser.add_argument('--dt',       type=float, default=1.)
    args = parser.parse_args()

    # Get mesh, myo , patch and other idxs as well as required memory for partially computation of things to avoid memory overload
    mesh = meshio.read(args.meshPath)
    

    # We compute the memory reqs for the Vs most memory-wise heavy variable
    # but more memory can be consumed! even if this reqMem is lower than the one we set
    totNodes = mesh.points.shape[0]
    nTimeSteps = (args.timeEnd / args.dt) - (args.timeStart / args.dt) + 1
    reqMem = (totNodes * nTimeSteps * 4) / 1e9
    print("Required Memory for reading and handling potentials is: {} GB".format(reqMem))
    maxNodesPerSection = int((args.maxMem * 1e9) / (nTimeSteps * 4))
    # del mesh

    # ATs------------------------------------------------------------------------
    print("Calculating AT-----------------------------------------------------")
    if reqMem > args.maxMem:
        ats = np.zeros(totNodes)
        for i in tqdm(range(np.arange(0, totNodes, maxNodesPerSection).shape[0])):
            nodeStart = int(i*maxNodesPerSection)
            nodeEnd   = int((i+1)*maxNodesPerSection)
            if nodeEnd > totNodes: nodeEnd = totNodes
            ats[nodeStart:nodeEnd] = calcATFromEnsBinary(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
    else:
        ats = calcATFromEnsBinary(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
    
    mesh.point_data['ATs_absolute_(ms)'] = ats
    mesh.write(args.meshPath)

if __name__ == '__main__':
    startTime = time.time()
    main()
    print("Total time was {0:.2f}".format(time.time()-startTime))