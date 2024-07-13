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
import copy

params = ["ATM mean", "ATM median", "ATM min", "ATM max", "ATP mean", "ATP median", "ATP min", "ATP max",
        "APD90M mean", "APD90M median", "APD90M min", "APD90M max", "APD90P mean", "APD90P median", "APD90P min", "APD90P max",    
        "CVM mean", "CVM median", "CVM min", "CVM max", "CVP mean", "CVP median", "CVP min", "CVP max",
        "RTGM mean", "RTGM median", "RTGM min", "RTGM max", "RTGP mean", "RTGP median", "RTGP min", "RTGP max"]
    
def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resPath',  type=str, required=True, help='path to data')
    parser.add_argument('--myResPath',type=str, required=True, help='path to data')
    parser.add_argument('--meshPath', type=str, required=True)
    parser.add_argument('--nDigits',  type=int, default=5)
    parser.add_argument('--soluName', type=str, default='tissue_solution')
    parser.add_argument('--timeStart',type=int, default=2000)
    parser.add_argument('--timeEnd',  type=int, default=3000)
    parser.add_argument('--dt',       type=float, default=1.)
    parser.add_argument('--apd',      type=int, default=90)
    parser.add_argument('--maxMem',   type=float, default=5, help="Allowed RAM consumption in critical computations in GB")
    parser.add_argument('--nCores',   type=int, default=1)
    parser.add_argument('--spaceUnit',type=str, default="mm")
    parser.add_argument('--maxDist',  type=float, help='distance radius', nargs='+')
    parser.add_argument('--maxCV',    type=float, help='max CV in cm/s', default=300)
    parser.add_argument('--resExcel', type=str, required=True, help='Excel for saving results')
    args = parser.parse_args()

    mesh = meshio.read(args.meshPath)
    latPath = os.path.join(args.resPath, "lat.ens")
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

    if patch_flag: 
        idxpatch = mesh.point_sets["patch_nodes"]
        # if "unatt_nodes" in mesh.point_sets.keys():
        #     idxpatch = np.append(idxpatch, mesh.point_sets["unatt_nodes"])
    # if not os.path.isdir(args.myResPath): os.mkdir(args.myResPath)
    # del mesh
    # ATs------------------------------------------------------------------------
    copyfile(latPath, os.path.join(args.resPath, "latOri.ens"))

    with open(latPath, "r") as f:
        data = f.readlines()
    lats = np.array(data[4:]).astype(float)
    lats = lats - np.nanmin(lats)

    with open(latPath, "w") as f:
        f.write("Ensight Model Post Process\n")
        f.write("part\n")
        f.write(" 1\n")
        f.write("coordinates\n")
        for i in tqdm(range(lats.shape[0])):
            f.write("{0:f}\n".format(lats[i]))

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
    totNodes = lats.shape[0]
    reqMem = (totNodes * (args.timeEnd - args.timeStart) * 4) / 1e9
    print("Required Memory: {} GB".format(reqMem))

    if reqMem > args.maxMem:
        apds = np.zeros(totNodes)
        nNodes = (args.maxMem * 1e9) / ((args.timeEnd - args.timeStart) * 4)
        for i in tqdm(range(np.arange(0, totNodes, nNodes).shape[0])):
            nodeStart = int(i*nNodes)
            nodeEnd   = int((i+1)*nNodes)
            if nodeEnd > totNodes: nodeEnd = totNodes
            apds[nodeStart:nodeEnd] = calcAPDXFromEns(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)

    else:
        apds = calcAPDXFromEns(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)

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


    # CVs ---------------------------------------------------------------------------------------------
    mesh = meshio.read(args.meshPath)
    points = mesh.points

    if points.shape[1]==2:
        points = np.concatenate((points, np.zeros((points.shape[0],1))), axis=1)
    cells = mesh.cells
    ats = lats

    #Myo --------------------------------------------------------------------
    print("LOCAL CV HEALTHY MYO with maxDist {0}".format(args.maxDist[0]))
    start = time.time()
    if args.nCores != 1:
        xyzuvw = getLocalGradsVanillaMeshPerNodePool(points[idxmyo], ats[idxmyo], args.maxDist[0], args.maxMem, "time", args.nCores)
    else:
        xyzuvw = getLocalGradsVanillaMeshPerNode(points[idxmyo], ats[idxmyo], args.maxDist[0], "time")
    print("Cv computed in {} s".format(time.time() - start))
    CVvectors = xyzuvw[:,-3:]
    CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
    CVversors = np.empty((CVmagnitudes.shape[0],3)); CVversors[:] = np.nan
    np.divide(CVvectors, np.expand_dims(CVmagnitudes, axis=1), out=CVversors, where=np.expand_dims(CVmagnitudes, axis=1) != 0.)

    # Add units and get rid of CVs which are too high and stimulated
    if args.spaceUnit == "mm": CVmagnitudes = CVmagnitudes * 100
    elif args.spaceUnit == "cm": CVmagnitudes = CVmagnitudes * 1000
    else: raise ValueError("Wrong space unit")
    idxs2Nan = np.where(CVmagnitudes>args.maxCV)
    # if "stim_nodes" in mesh.point_sets.keys(): 
    #     idxs2Nan = np.append(idxs2Nan, mesh.point_sets["stim_nodes"])
    CVmagnitudes[idxs2Nan] = np.nan
    CVversors[idxs2Nan,:] = np.nan
    CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

    res["CVM mean"] = np.nanmean(CVmagnitudes)
    res["CVM median"] = np.nanmedian(CVmagnitudes)
    res["CVM min"] = np.nanmin(CVmagnitudes)
    res["CVM max"] = np.nanmax(CVmagnitudes)
    
    print("CVM mean:   {0:f}".format(np.nanmean(CVmagnitudes)))
    print("CVM median: {0:f}".format(np.nanmedian(CVmagnitudes)))
    print("CVM min:    {0:f}".format(np.nanmin(CVmagnitudes)))
    print("CVM max:    {0:f}".format(np.nanmax(CVmagnitudes)))
    
    CVmagnitudesMyo   = copy.deepcopy(CVmagnitudes)
    CVversorsMyo      = copy.deepcopy(CVversors)
    
    #Patch --------------------------------------------------------------------
    if patch_flag:
        print("LOCAL CV HEALTHY PATCH with maxDist {0}".format(args.maxDist[1]))
        start = time.time()
        if args.nCores != 1:
            xyzuvw = getLocalGradsVanillaMeshPerNodePool(points[idxpatch], ats[idxpatch], args.maxDist[1], args.maxMem, "time", args.nCores)
        else:
            xyzuvw = getLocalGradsVanillaMeshPerNode(points[idxpatch], ats[idxpatch], args.maxDist[1], "time")
        print("Cv computed in {} s".format(time.time() - start))
        CVvectors = xyzuvw[:,-3:]
        CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
        CVversors = np.empty((CVmagnitudes.shape[0],3)); CVversors[:] = np.nan
        np.divide(CVvectors, np.expand_dims(CVmagnitudes, axis=1), out=CVversors, where=np.expand_dims(CVmagnitudes, axis=1) != 0.)

        # Add units and get rid of CVs which are too high and stimulated
        if args.spaceUnit == "mm": CVmagnitudes = CVmagnitudes * 100
        elif args.spaceUnit == "cm": CVmagnitudes = CVmagnitudes * 1000
        else: raise ValueError("Wrong space unit")
        idxs2Nan = np.where(CVmagnitudes>args.maxCV)
        # if "stim_nodes" in mesh.point_sets.keys(): 
        #     idxs2Nan = np.append(idxs2Nan, mesh.point_sets["stim_nodes"])
        CVmagnitudes[idxs2Nan] = np.nan
        CVversors[idxs2Nan,:] = np.nan
        CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors
        
        res["CVP mean"] = np.nanmean(CVmagnitudes)
        res["CVP median"] = np.nanmedian(CVmagnitudes)
        res["CVP min"] = np.nanmin(CVmagnitudes)
        res["CVP max"] = np.nanmax(CVmagnitudes)

        print("CVP mean:   {0:f}".format(np.nanmean(CVmagnitudes)))
        print("CVP median: {0:f}".format(np.nanmedian(CVmagnitudes)))
        print("CVP min:    {0:f}".format(np.nanmin(CVmagnitudes)))
        print("CVP max:    {0:f}".format(np.nanmax(CVmagnitudes)))
        
        CVmagnitudesPatch = copy.deepcopy(CVmagnitudes)
        CVversorsPatch    = copy.deepcopy(CVversors)
    

    #  Put all together
    CVmagnitudes           = np.empty(points.shape[0]);     CVmagnitudes[:] = np.nan
    CVversors              = np.empty((points.shape[0],3)); CVversors[:]    = np.nan
    CVmagnitudes[idxmyo]   = CVmagnitudesMyo
    CVversors[idxmyo]      = CVversorsMyo
    
    if patch_flag:
        CVmagnitudes[idxpatch] = CVmagnitudesPatch
        CVversors[idxpatch]    = CVversorsPatch

    # RTs--------------------------------------------------------------------
    rts = apds
    
    # MYO--------------------------------------------------------------------
    print("LOCAL RT GRADS HEALTHY MYO")
    start = time.time()
    if args.nCores != 1:
        xyzuvw = getLocalGradsVanillaMeshPerNodePool(points[idxmyo], rts[idxmyo], args.maxDist[0], args.maxMem, "space", args.nCores)
    else:
        xyzuvw = getLocalGradsVanillaMeshPerNode(points[idxmyo], rts[idxmyo], args.maxDist[0], "space")
    print("RT grads computed in {} s".format(time.time() - start))
    
    RTVvectors = xyzuvw[:,-3:]
    RTgradients = np.linalg.norm(RTVvectors, axis=1)
    if "stim_nodes" in mesh.point_sets.keys(): 
        idxs2Nan = mesh.point_sets["stim_nodes"]
        RTgradients[idxs2Nan] = np.nan

    res["RTGM mean"]   = np.nanmean(RTgradients)
    res["RTGM median"] = np.nanmedian(RTgradients)
    res["RTGM min"]    = np.nanmin(RTgradients)
    res["RTGM max"]    = np.nanmax(RTgradients)
    print("RTGM mean:   {0:f}".format(np.nanmean(RTgradients)))
    print("RTGM median: {0:f}".format(np.nanmedian(RTgradients)))
    print("RTGM min:    {0:f}".format(np.nanmin(RTgradients)))
    print("RTGM max:    {0:f}".format(np.nanmax(RTgradients)))
    RTgradientsMyo     = copy.deepcopy(RTgradients)
    
    #Patch--------------------------------------------------------------------
    if patch_flag:
        print("LOCAL RT GRADS PATCH")
        start = time.time()
        if args.nCores != 1:
            xyzuvw = getLocalGradsVanillaMeshPerNodePool(points[idxpatch], rts[idxpatch], args.maxDist[1], args.maxMem, "space", args.nCores)
        else:
            xyzuvw = getLocalGradsVanillaMeshPerNode(points[idxpatch], rts[idxpatch], args.maxDist[1], "space")
        print("RT grads computed in {} s".format(time.time() - start))
        
        RTVvectors = xyzuvw[:,-3:]
        RTgradients = np.linalg.norm(RTVvectors, axis=1)
        if "stim_nodes" in mesh.point_sets.keys(): 
            idxs2Nan = mesh.point_sets["stim_nodes"]
            RTgradients[idxs2Nan] = np.nan

        res["RTGP mean"] = np.nanmean(RTgradients)
        res["RTGP median"] = np.nanmedian(RTgradients)
        res["RTGP min"] = np.nanmin(RTgradients)
        res["RTGP max"] = np.nanmax(RTgradients)
        print("RTGP mean:   {0:f}".format(np.nanmean(RTgradients)))
        print("RTGP median: {0:f}".format(np.nanmedian(RTgradients)))
        print("RTGP min:    {0:f}".format(np.nanmin(RTgradients)))
        print("RTGP max:    {0:f}".format(np.nanmax(RTgradients)))
        
        RTgradientsPatch = copy.deepcopy(RTgradients)

    # Put all together 
    RTgradients      = np.empty(points.shape[0]); RTgradients[:] = np.nan
    RTgradients[idxmyo]   = RTgradientsMyo
    if patch_flag:
        RTgradients[idxpatch] = RTgradientsPatch

    #Save--------------------------------------------------------------------
    point_data = {}
    point_data["ATs_(ms)"] = lats
    point_data["APD{}_(ms)".format(args.apd)] = apds
    point_data["CVMag_(cm/s)"] = CVmagnitudes
    point_data["CVversors"] = CVversors
    point_data["RTs_(ms)"] = rts
    point_data["RTgrad_[ms/mm]"] = RTgradients

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
    
    indexs = ["_".join(args.resPath.split("/")[-3:])]
    stats  = np.ones(len(params)) * np.nan
    for i, param in enumerate(params):
        try:
            stats[i] = res[params[i]]
        except KeyError:
            pass
    df = pd.DataFrame([stats], index=indexs, columns=params)
    if not os.path.exists(args.resExcel):
        df.to_excel(args.resExcel, sheet_name='sheet1')
    else:
        with pd.ExcelWriter(args.resExcel, engine="openpyxl", mode='a',if_sheet_exists="overlay") as writer:
            startrow = writer.sheets['sheet1'].max_row
            df.to_excel(writer, sheet_name='sheet1', startrow=startrow, header=False)

if __name__ == '__main__':
    main()