import os  
import argparse
import numpy as np
import meshio
import matplotlib.pyplot as plt
import sys
import random
sys.path.append(os.path.join('/'.join(sys.path[0].split("/")[:-1])))
# from utilsCV import getLocalGradsVanillaMeshPerNodePool, getLocalGradsVanillaMeshPerNode
from utils import calcATFromVs, calcAPDXFromV
from carputils.carpio.igb import IGBFile
import pandas as pd
import time

def main():
    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resPath',  type=str, required=True, help='path to data')
    parser.add_argument('--myResPath',type=str, required=True, help='path to data')
    parser.add_argument('--meshPath', type=str, required=True)
    # parser.add_argument('--nDigits',  type=int, default=5)
    parser.add_argument('--timeStart',type=int, default=2000)
    parser.add_argument('--timeEnd',  type=int, default=3000)
    parser.add_argument('--dt',       type=float, default=1.)
    parser.add_argument('--apd',      type=int, default=90)
    # parser.add_argument('--maxMem',   type=float, default=5, help="Allowed RAM consumption in critical computations in GB")
    # parser.add_argument('--usePool',  action='store_true')
    parser.add_argument('--spaceUnit',type=str, default="mm")
    # parser.add_argument('--maxDist',  type=float, help='distance radius', default=0.5)
    # parser.add_argument('--maxCV',    type=float, help='max CV in cm/s', default=300)
    parser.add_argument('--resExcel', type=str, required=True, help='Excel for saving results')
    args = parser.parse_args()

    mesh = meshio.read(args.meshPath)
    res = {}
    
    if "endo_nodes" in mesh.point_sets.keys():
        idxmyo = np.append(mesh.point_sets["endo_nodes"], mesh.point_sets["mid_nodes"])
        idxmyo = np.append(idxmyo, mesh.point_sets["epi_nodes"])
    elif "myo_nodes" in mesh.point_sets.keys():
        idxmyo = mesh.point_sets["myo_nodes"]
    else:  
        idxmyo = np.arange(mesh.points.shape[0])

    if "patch_nodes" in mesh.point_sets.keys():
        if mesh.point_sets["patch_nodes"].size!=0:
            patch_flag = 1 
        else:
            patch_flag = 0 
    else: 
        patch_flag = 0

    if patch_flag: idxpatch = mesh.point_sets["patch_nodes"]
    # if not os.path.isdir(args.myResPath): os.mkdir(args.myResPath)
    # del mesh
    # Vs------------------------------------------------------------------------
    print("Reading Vs")
    with IGBFile(os.path.join(args.resPath, "vm.igb")) as f:
        header = f.header()
        data   = f.data()
    v = data.reshape(header['t'], -1).T
    v = v[:,args.timeStart:args.timeEnd]
    
    # Plot some curves
    fig, ax = plt.subplots()
    for i in range(10):
        plotIdx = random.randint(0,v.shape[0])
        ax.plot(v[plotIdx,:], label=plotIdx)
    ax.legend()
    ax.set_title("10 Vm signals")
    plt.savefig(os.path.join(args.resPath,"Vs.png"))
    
    # ATs------------------------------------------------------------------------
    print("Calculating AT")
    lats = calcATFromVs(v, args.dt)   
    lats = lats - np.nanmin(lats)

    res["ATM mean"] = np.nanmean(lats[idxmyo])
    res["ATM median"] = np.nanmedian(lats[idxmyo])
    res["ATM min"] = np.nanmin(lats[idxmyo])
    res["ATM max"] = np.nanmax(lats[idxmyo])
    if patch_flag:
        res["ATP mean"] = np.nanmean(lats[idxpatch])
        res["ATP median"] = np.nanmedian(lats[idxpatch])
        res["ATP min"] = np.nanmin(lats[idxpatch])
        res["ATP max"] = np.nanmax(lats[idxpatch])

    print("ATM mean:   {0:f}".format(np.nanmean(lats[idxmyo])))
    print("ATM median: {0:f}".format(np.nanmedian(lats[idxmyo])))
    print("ATM min:    {0:f}".format(np.nanmin(lats[idxmyo])))
    print("ATM max:    {0:f}".format(np.nanmax(lats[idxmyo])))
    if patch_flag:
        print("ATP mean:   {0:f}".format(np.nanmean(lats[idxpatch])))
        print("ATP median: {0:f}".format(np.nanmedian(lats[idxpatch])))
        print("ATP min:    {0:f}".format(np.nanmin(lats[idxpatch])))
        print("ATP max:    {0:f}".format(np.nanmax(lats[idxpatch])))

    #APD90 ----------------------------------------------------------------------------
    print("Calculating APD")
    #Here happens the most memory burden, check memory consumption and make it in parts if neccesary
    #Take into account this is the reqMem for storing v but diff has almost the same store size
    #So memMax should be set to approximately one third of your RAM, for 32GB -> 10GB
    # totNodes = lats.shape[0]
    # reqMem = (totNodes * (args.timeEnd - args.timeStart) * 4) / 1e9
    # print("Required Memory: {} GB".format(reqMem))

    # if reqMem > args.maxMem:
    #     apds = np.zeros(totNodes)
    #     nNodes = (args.maxMem * 1e9) / ((args.timeEnd - args.timeStart) * 4)
    #     for i in tqdm(range(np.arange(0, totNodes, nNodes).shape[0])):
    #         nodeStart = int(i*nNodes)
    #         nodeEnd   = int((i+1)*nNodes)
    #         if nodeEnd > totNodes: nodeEnd = totNodes
    #         apds[nodeStart:nodeEnd] = calcAPDXFromEns(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits)
    # else:
    apds = calcAPDXFromV(v, args.dt, args.apd)

    res["APD90M mean"] = np.nanmean(apds[idxmyo])
    res["APD90M median"] = np.nanmedian(apds[idxmyo])
    res["APD90M min"] = np.nanmin(apds[idxmyo])
    res["APD90M max"] = np.nanmax(apds[idxmyo])
    if patch_flag:
        res["APD90P mean"] = np.nanmean(apds[idxpatch])
        res["APD90P median"] = np.nanmedian(apds[idxpatch])
        res["APD90P min"] = np.nanmin(apds[idxpatch])
        res["APD90P max"] = np.nanmax(apds[idxpatch])

    print("APD90M mean:   {0:f}".format(np.nanmean(apds[idxmyo])))
    print("APD90M median: {0:f}".format(np.nanmedian(apds[idxmyo])))
    print("APD90M min:    {0:f}".format(np.nanmin(apds[idxmyo])))
    print("APD90M max:    {0:f}".format(np.nanmax(apds[idxmyo])))
    if patch_flag:
        print("APD90P mean:   {0:f}".format(np.nanmean(apds[idxpatch])))
        print("APD90P median: {0:f}".format(np.nanmedian(apds[idxpatch])))
        print("APD90P min:    {0:f}".format(np.nanmin(apds[idxpatch])))
        print("APD90P max:    {0:f}".format(np.nanmax(apds[idxpatch])))


    # CVs --------------------------------------------------------------------
    # mesh = meshio.read(args.meshPath)
    points = mesh.points

    # if points.shape[1]==2:
    #     points = np.concatenate((points, np.zeros((points.shape[0],1))), axis=1)
    # cells = mesh.cells
    # ats = lats

    # print("Starting calculation of the local CVs with vanilla method")
    # start = time.time()
    # if args.usePool:
    #     xyzuvw = getLocalGradsVanillaMeshPerNodePool(points, ats, args.maxDist, args.maxMem, "time")
    # else:
    #     xyzuvw = getLocalGradsVanillaMeshPerNode(points, ats, args.maxDist, "time")
    # print("Cv computed in {} s".format(time.time() - start))
    # CVvectors = xyzuvw[:,-3:]
    # CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
    # CVversors = np.empty((CVmagnitudes.shape[0],3)); CVversors[:] = np.nan
    # np.divide(CVvectors, np.expand_dims(CVmagnitudes, axis=1), out=CVversors, where=np.expand_dims(CVmagnitudes, axis=1) != 0.)

    # # Add units and get rid of CVs which are too high and stimulated
    # if args.spaceUnit == "mm": CVmagnitudes = CVmagnitudes * 100
    # elif args.spaceUnit == "cm": CVmagnitudes = CVmagnitudes * 1000
    # else: raise ValueError("Wrong space unit")
    # idxs2Nan = np.where(CVmagnitudes>args.maxCV)
    # if "stim_nodes" in mesh.point_sets.keys(): 
    #     idxs2Nan = np.append(idxs2Nan, mesh.point_sets["stim_nodes"])
    # CVmagnitudes[idxs2Nan] = np.nan
    # CVversors[idxs2Nan,:] = np.nan
    # CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

    # res["CVM mean"] = np.nanmean(CVmagnitudes[idxmyo])
    # res["CVM median"] = np.nanmedian(CVmagnitudes[idxmyo])
    # res["CVM min"] = np.nanmin(CVmagnitudes[idxmyo])
    # res["CVM max"] = np.nanmax(CVmagnitudes[idxmyo])
    # if patch_flag:
    #     res["CVP mean"] = np.nanmean(CVmagnitudes[idxpatch])
    #     res["CVP median"] = np.nanmedian(CVmagnitudes[idxpatch])
    #     res["CVP min"] = np.nanmin(CVmagnitudes[idxpatch])
    #     res["CVP max"] = np.nanmax(CVmagnitudes[idxpatch])

    # print("CVM mean:   {0:f}".format(np.nanmean(CVmagnitudes[idxmyo])))
    # print("CVM median: {0:f}".format(np.nanmedian(CVmagnitudes[idxmyo])))
    # print("CVM min:    {0:f}".format(np.nanmin(CVmagnitudes[idxmyo])))
    # print("CVM max:    {0:f}".format(np.nanmax(CVmagnitudes[idxmyo])))
    # if patch_flag:
    #     print("CVP mean:   {0:f}".format(np.nanmean(CVmagnitudes[idxpatch])))
    #     print("CVP median: {0:f}".format(np.nanmedian(CVmagnitudes[idxpatch])))
    #     print("CVP min:    {0:f}".format(np.nanmin(CVmagnitudes[idxpatch])))
    #     print("CVP max:    {0:f}".format(np.nanmax(CVmagnitudes[idxpatch])))

    # # RTs--------------------------------------------------------------------
    # rts = lats + apds
    # print("Starting calculation of the local RT gradients with vanilla method")
    # start = time.time()
    # if args.usePool:
    #     xyzuvw = getLocalGradsVanillaMeshPerNodePool(points, rts, args.maxDist, args.maxMem, "space")
    # else:
    #     xyzuvw = getLocalGradsVanillaMeshPerNode(points, rts, args.maxDist, "space")
    # print("RT grads computed in {} s".format(time.time() - start))
    
    # RTVvectors = xyzuvw[:,-3:]
    # RTgradients = np.linalg.norm(RTVvectors, axis=1)
    # # RTgradients = 1 / RTVmagnitudes
    # if "stim_nodes" in mesh.point_sets.keys(): 
    #     idxs2Nan = mesh.point_sets["stim_nodes"]
    #     RTgradients[idxs2Nan] = np.nan

    # res["RTGM mean"] = np.nanmean(RTgradients[idxmyo])
    # res["RTGM median"] = np.nanmedian(RTgradients[idxmyo])
    # res["RTGM min"] = np.nanmin(RTgradients[idxmyo])
    # res["RTGM max"] = np.nanmax(RTgradients[idxmyo])
    # if patch_flag:
    #     res["RTGP mean"] = np.nanmean(RTgradients[idxpatch])
    #     res["RTGP median"] = np.nanmedian(RTgradients[idxpatch])
    #     res["RTGP min"] = np.nanmin(RTgradients[idxpatch])
    #     res["RTGP max"] = np.nanmax(RTgradients[idxpatch])

    # print("RTGM mean:   {0:f}".format(np.nanmean(RTgradients[idxmyo])))
    # print("RTGM median: {0:f}".format(np.nanmedian(RTgradients[idxmyo])))
    # print("RTGM min:    {0:f}".format(np.nanmin(RTgradients[idxmyo])))
    # print("RTGM max:    {0:f}".format(np.nanmax(RTgradients[idxmyo])))
    # if patch_flag:
    #     print("RTGP mean:   {0:f}".format(np.nanmean(RTgradients[idxpatch])))
    #     print("RTGP median: {0:f}".format(np.nanmedian(RTgradients[idxpatch])))
    #     print("RTGP min:    {0:f}".format(np.nanmin(RTgradients[idxpatch])))
    #     print("RTGP max:    {0:f}".format(np.nanmax(RTgradients[idxpatch])))

    # #Save--------------------------------------------------------------------
    point_data = {}
    point_data["ATs_(ms)"] = lats
    point_data["APD{}_(ms)".format(args.apd)] = apds
    # point_data["CVMag_(cm/s)"] = CVmagnitudes
    # point_data["CVversors"] = CVversors
    # point_data["RTs_(ms)"] = rts
    # point_data["RTgrad_[ms/mm]"] = RTgradients

    # Delete scar nodes from results
    if "scar_nodes" in mesh.point_sets.keys():
        idxscar = mesh.point_sets["scar_nodes"]
        for key in point_data.keys():
            point_data[key][idxscar] = np.nan

    myo_nodes = np.zeros(points.shape[0])
    myo_nodes[idxmyo] = 1
    point_data["myo_nodes"] = myo_nodes

    if patch_flag:
        patch_nodes = np.zeros(points.shape[0])
        patch_nodes[idxpatch] = 1
        point_data["patch_nodes"] = patch_nodes

    meshOut = meshio.Mesh(mesh.points, mesh.cells, point_data=point_data)
    meshOut.write(args.myResPath)

    df = pd.read_excel(args.resExcel)
    res["Id"] = "_".join(args.resPath.split("/")[-3:])
    new_row = pd.Series(res)
    df2 = pd.concat([df, new_row.to_frame().T], ignore_index=True)
    df2.to_excel(args.resExcel)


if __name__ == '__main__':
    main()