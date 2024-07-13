import os  
import argparse
from tqdm import tqdm
import numpy as np
import meshio
from utilsCV import getLocalGradsVanillaMeshPerNodePool, getLocalGradsVanillaMeshPerNode, getLocalGradsVanillaMeshPerNodeCS
from utils import calcATFromEnsBinary, calcAPDXFromEnsBinary, calcATFromEns, calcAPDXFromEns
import pandas as pd
import time
import copy

params = ["ATM mean", "ATM median", "ATM min", "ATM max", "ATP mean", "ATP median", "ATP min", "ATP max", "ATBZ mean", "ATBZ median", "ATBZ min", "ATBZ max",
        "APD90M mean", "APD90M median", "APD90M min", "APD90M max", "APD90P mean", "APD90P median", "APD90P min", "APD90P max", "APD90BZ mean", "APD90BZ median", "APD90BZ min", "APD90BZ max",  
        "CVM mean", "CVM median", "CVM min", "CVM max", "CVP mean", "CVP median", "CVP min", "CVP max", "CVBZ mean", "CVBZ median", "CVBZ min", "CVBZ max",
        "RTGM mean", "RTGM median", "RTGM min", "RTGM max", "RTGP mean", "RTGP median", "RTGP min", "RTGP max", "RTGBZ mean", "RTGBZ median", "RTGBZ min", "RTGBZ max"]

layers_myo_flag = 1
layers_endo_flag = 3
layers_mid_flag  = 4
layers_epi_flag  = 5
layers_bz_flag   = 7
layers_scar_flag = 8
layers_patch_flag = 9
    
def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resPath',  type=str, required=True, help='path to data')
    parser.add_argument('--myResPath',type=str, required=True, help='path to data')
    parser.add_argument('--meshPath', type=str, required=True)
    parser.add_argument('--stimLabel',type=str, default="stim_nodes")
    parser.add_argument('--soluName', type=str, default='tissue_solution')
    parser.add_argument('--ensType',  type=str, default="binary", help="Ensight solution: binary or ascii")
    parser.add_argument('--nDigits',  type=int, default=5)
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

    # Get mesh, myo , patch and other idxs as well as required memory for partially computation of things to avoid memory overload
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

    if "bz_nodes" in mesh.point_sets.keys():
        if mesh.point_sets["bz_nodes"].size!=0:
            bz_flag = 1 
        else:
            bz_flag = 0 
    else: 
        bz_flag = 0
    if bz_flag: idxbz = mesh.point_sets["bz_nodes"]

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
            
            if args.ensType == "binary":
                ats[nodeStart:nodeEnd] = calcATFromEnsBinary(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
            elif args.ensType == "ascii":
                ats[nodeStart:nodeEnd] = calcATFromEns(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
            else:
                raise ValueError("Wrong ensType")
    else:
        if args.ensType == "binary":
            ats = calcATFromEnsBinary(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
        elif args.ensType == "ascii":
            ats = calcATFromEns(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
        else:
            raise ValueError("Wrong ensType")
        
    ats_absolute = copy.deepcopy(ats)
    ats = ats - np.nanmin(ats)

    res["ATM mean"] = np.nanmean(ats[idxmyo])
    res["ATM median"] = np.nanmedian(ats[idxmyo])
    res["ATM min"] = np.nanmin(ats[idxmyo])
    res["ATM max"] = np.nanmax(ats[idxmyo])
    if patch_flag:
        res["ATP mean"] = np.nanmean(ats[idxpatch])
        res["ATP median"] = np.nanmedian(ats[idxpatch])
        res["ATP min"] = np.nanmin(ats[idxpatch])
        res["ATP max"] = np.nanmax(ats[idxpatch])
    if bz_flag:
        res["ATBZ mean"]   = np.nanmean(ats[idxbz])
        res["ATBZ median"] = np.nanmedian(ats[idxbz])
        res["ATBZ min"]    = np.nanmin(ats[idxbz])
        res["ATBZ max"]    = np.nanmax(ats[idxbz])

    print("ATM mean:   {0:f}".format(np.nanmean(ats[idxmyo])))
    print("ATM median: {0:f}".format(np.nanmedian(ats[idxmyo])))
    print("ATM min:    {0:f}".format(np.nanmin(ats[idxmyo])))
    print("ATM max:    {0:f}".format(np.nanmax(ats[idxmyo])))
    if patch_flag:
        print("ATP mean:   {0:f}".format(np.nanmean(ats[idxpatch])))
        print("ATP median: {0:f}".format(np.nanmedian(ats[idxpatch])))
        print("ATP min:    {0:f}".format(np.nanmin(ats[idxpatch])))
        print("ATP max:    {0:f}".format(np.nanmax(ats[idxpatch])))
    if bz_flag:
        print("ATBZ mean:   {0:f}".format(np.nanmean(ats[idxbz])))
        print("ATBZ median: {0:f}".format(np.nanmedian(ats[idxbz])))
        print("ATBZ min:    {0:f}".format(np.nanmin(ats[idxbz])))
        print("ATBZ max:    {0:f}".format(np.nanmax(ats[idxbz])))

    #APD90 ----------------------------------------------------------------------------
    print("Calculating APD-----------------------------------------------")
    # Here happens the most memory burden, check memory consumption and make it in parts if neccesary
    # Take into account this is the reqMem for storing v but diff has almost the same store size
    # So memMax should be set to approximately one third of your RAM, for 32GB -> 10GB

    if reqMem > args.maxMem:
        apds = np.zeros(totNodes)
        for i in tqdm(range(np.arange(0, totNodes, maxNodesPerSection).shape[0])):
            nodeStart = i*maxNodesPerSection
            nodeEnd   = (i+1)*maxNodesPerSection
            if nodeEnd > totNodes: nodeEnd = totNodes

            if args.ensType == "binary":
                apds[nodeStart:nodeEnd] = calcAPDXFromEnsBinary(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)
            elif args.ensType == "ascii":
                apds[nodeStart:nodeEnd] = calcAPDXFromEns(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)
            else:
                raise ValueError("Wrong ensType")

            
    else:
        if args.ensType == "binary":
            apds = calcAPDXFromEnsBinary(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)
        elif args.ensType == "ascii":
            apds = calcAPDXFromEns(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)
        else:
            raise ValueError("Wrong ensType")
        
    res["APD90M mean"] = np.nanmean(apds[idxmyo])
    res["APD90M median"] = np.nanmedian(apds[idxmyo])
    res["APD90M min"] = np.nanmin(apds[idxmyo])
    res["APD90M max"] = np.nanmax(apds[idxmyo])
    if patch_flag:
        res["APD90P mean"] = np.nanmean(apds[idxpatch])
        res["APD90P median"] = np.nanmedian(apds[idxpatch])
        res["APD90P min"] = np.nanmin(apds[idxpatch])
        res["APD90P max"] = np.nanmax(apds[idxpatch])
    if bz_flag:
        res["APD90BZ mean"] = np.nanmean(apds[idxbz])
        res["APD90BZ median"] = np.nanmedian(apds[idxbz])
        res["APD90BZ min"] = np.nanmin(apds[idxbz])
        res["APD90BZ max"] = np.nanmax(apds[idxbz])

    print("APD90M mean:   {0:f}".format(np.nanmean(apds[idxmyo])))
    print("APD90M median: {0:f}".format(np.nanmedian(apds[idxmyo])))
    print("APD90M min:    {0:f}".format(np.nanmin(apds[idxmyo])))
    print("APD90M max:    {0:f}".format(np.nanmax(apds[idxmyo])))
    if patch_flag:
        print("APD90P mean:   {0:f}".format(np.nanmean(apds[idxpatch])))
        print("APD90P median: {0:f}".format(np.nanmedian(apds[idxpatch])))
        print("APD90P min:    {0:f}".format(np.nanmin(apds[idxpatch])))
        print("APD90P max:    {0:f}".format(np.nanmax(apds[idxpatch])))
    if bz_flag:
        print("APD90BZ mean:   {0:f}".format(np.nanmean(apds[idxbz])))
        print("APD90BZ median: {0:f}".format(np.nanmedian(apds[idxbz])))
        print("APD90BZ min:    {0:f}".format(np.nanmin(apds[idxbz])))
        print("APD90BZ max:    {0:f}".format(np.nanmax(apds[idxbz])))


    # CVs --------------------------------------------------------------------
    print("Calculating CVs-----------------------------------------------------")
    points = mesh.points
    if points.shape[1]==2:
        points = np.concatenate((points, np.zeros((points.shape[0],1))), axis=1)

    #Myo --------------------------------------------------------------------
    print("LOCAL CV MYO or CS with maxDist {0}".format(args.maxDist[0]))
    start = time.time()

    # We call idx_completemyo to idxmyo for the case of no bz and working with cs
    idx_completemyo = idxmyo
    if 'cs' in args.soluName:
        xyzuvw = getLocalGradsVanillaMeshPerNodeCS(points, ats, mesh.cells_dict['line'] , "time")
    else:
        # Here if we have bz_nodes we add them to idxmyo as usually they have the same mesh length
        if bz_flag:
            idx_completemyo = np.append(idxmyo, idxbz)
        
        if args.nCores != 1:
            xyzuvw = getLocalGradsVanillaMeshPerNodePool(points[idx_completemyo], ats[idx_completemyo], args.maxDist[0], args.maxMem, "time", args.nCores)
        else:
            xyzuvw = getLocalGradsVanillaMeshPerNode(points[idx_completemyo], ats[idx_completemyo], args.maxDist[0], "time")

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
    if args.stimLabel in mesh.point_sets.keys(): 
        idxs2NanStim = np.where(idx_completemyo==mesh.point_sets[args.stimLabel])[0]
        idxs2Nan = np.append(idxs2Nan, idxs2NanStim)
    CVmagnitudes[idxs2Nan] = np.nan
    CVversors[idxs2Nan,:] = np.nan
    CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

    res["CVM mean"] = np.nanmean(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])
    res["CVM median"] = np.nanmedian(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])
    res["CVM min"] = np.nanmin(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])
    res["CVM max"] = np.nanmax(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])
    if bz_flag:
        res["CVBZ mean"] = np.nanmean(CVmagnitudes[np.isin(idx_completemyo,idxbz)])
        res["CVBZ median"] = np.nanmedian(CVmagnitudes[np.isin(idx_completemyo,idxbz)])
        res["CVBZ min"] = np.nanmin(CVmagnitudes[np.isin(idx_completemyo,idxbz)])
        res["CVBZ max"] = np.nanmax(CVmagnitudes[np.isin(idx_completemyo,idxbz)])

    print("CVM mean:   {0:f}".format(np.nanmean(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])))
    print("CVM median: {0:f}".format(np.nanmedian(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])))
    print("CVM min:    {0:f}".format(np.nanmin(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])))
    print("CVM max:    {0:f}".format(np.nanmax(CVmagnitudes[np.isin(idx_completemyo,idxmyo)])))

    if bz_flag:
        print("CVBZ mean:   {0:f}".format(np.nanmean(CVmagnitudes[np.isin(idx_completemyo,idxbz)])))
        print("CVBZ median: {0:f}".format(np.nanmedian(CVmagnitudes[np.isin(idx_completemyo,idxbz)])))
        print("CVBZ min:    {0:f}".format(np.nanmin(CVmagnitudes[np.isin(idx_completemyo,idxbz)])))
        print("CVBZ max:    {0:f}".format(np.nanmax(CVmagnitudes[np.isin(idx_completemyo,idxbz)])))

    CVmagnitudesMyo   = copy.deepcopy(CVmagnitudes)
    CVversorsMyo      = copy.deepcopy(CVversors)

    #EHT --------------------------------------------------------------------
    if patch_flag:
        print("LOCAL CV EHT with maxDist {0}".format(args.maxDist[1]))
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
        if args.stimLabel in mesh.point_sets.keys(): 
            idxs2NanStim = np.where(idxpatch==mesh.point_sets[args.stimLabel])[0]
            idxs2Nan = np.append(idxs2Nan, idxs2NanStim)
        CVmagnitudes[idxs2Nan] = np.nan
        CVversors[idxs2Nan,:] = np.nan
        CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

        res["CVP mean"]   = np.nanmean(CVmagnitudes)
        res["CVP median"] = np.nanmedian(CVmagnitudes)
        res["CVP min"]    = np.nanmin(CVmagnitudes)
        res["CVP max"]    = np.nanmax(CVmagnitudes)

        print("CVP mean:   {0:f}".format(np.nanmean(CVmagnitudes)))
        print("CVP median: {0:f}".format(np.nanmedian(CVmagnitudes)))
        print("CVP min:    {0:f}".format(np.nanmin(CVmagnitudes)))
        print("CVP max:    {0:f}".format(np.nanmax(CVmagnitudes)))

        CVmagnitudesPatch = copy.deepcopy(CVmagnitudes)
        CVversorsPatch    = copy.deepcopy(CVversors)

    #  Put all together
    CVmagnitudes           = np.empty(points.shape[0]);     CVmagnitudes[:] = np.nan
    CVversors              = np.empty((points.shape[0],3)); CVversors[:]    = np.nan
    CVmagnitudes[idx_completemyo]   = CVmagnitudesMyo
    CVversors[idx_completemyo]      = CVversorsMyo
    
    if patch_flag:
        CVmagnitudes[idxpatch] = CVmagnitudesPatch
        CVversors[idxpatch]    = CVversorsPatch

    # RTs--------------------------------------------------------------------
    rts = ats + apds
    print("Calculating RTGs--------------------------------------------------")
    
    # MYO--------------------------------------------------------------------
    print("LOCAL RT GRADS MYO with maxDist {0}".format(args.maxDist[0]))
    start = time.time()
    if 'cs' in args.soluName:
        xyzuvw = getLocalGradsVanillaMeshPerNodeCS(points, rts, mesh.cells_dict['line'] , "space")
    else:
        if args.nCores != 1:
            xyzuvw = getLocalGradsVanillaMeshPerNodePool(points[idx_completemyo], rts[idx_completemyo], args.maxDist[0], args.maxMem, "space", args.nCores)
        else:
            xyzuvw = getLocalGradsVanillaMeshPerNode(points[idx_completemyo], rts[idx_completemyo], args.maxDist[0], "space")
    print("RT grads computed in {} s".format(time.time() - start))
    
    RTVvectors = xyzuvw[:,-3:]
    RTgradients = np.linalg.norm(RTVvectors, axis=1)
    if args.stimLabel in mesh.point_sets.keys(): 
        idxs2Nan = idx_completemyo==mesh.point_sets[args.stimLabel]
        RTgradients[idxs2Nan] = np.nan

    res["RTGM mean"] = np.nanmean(RTgradients[np.isin(idx_completemyo,idxmyo)])
    res["RTGM median"] = np.nanmedian(RTgradients[np.isin(idx_completemyo,idxmyo)])
    res["RTGM min"] = np.nanmin(RTgradients[np.isin(idx_completemyo,idxmyo)])
    res["RTGM max"] = np.nanmax(RTgradients[np.isin(idx_completemyo,idxmyo)])
    if bz_flag:
        res["RTGBZ mean"] = np.nanmean(RTgradients[np.isin(idx_completemyo,idxbz)])
        res["RTGBZ median"] = np.nanmedian(RTgradients[np.isin(idx_completemyo,idxbz)])
        res["RTGBZ min"] = np.nanmin(RTgradients[np.isin(idx_completemyo,idxbz)])
        res["RTGBZ max"] = np.nanmax(RTgradients[np.isin(idx_completemyo,idxbz)])

    print("RTGM mean:   {0:f}".format(np.nanmean(RTgradients[np.isin(idx_completemyo,idxmyo)])))
    print("RTGM median: {0:f}".format(np.nanmedian(RTgradients[np.isin(idx_completemyo,idxmyo)])))
    print("RTGM min:    {0:f}".format(np.nanmin(RTgradients[np.isin(idx_completemyo,idxmyo)])))
    print("RTGM max:    {0:f}".format(np.nanmax(RTgradients[np.isin(idx_completemyo,idxmyo)])))
    if bz_flag:
        print("RTGBZ mean:   {0:f}".format(np.nanmean(RTgradients[np.isin(idx_completemyo,idxbz)])))
        print("RTGBZ median: {0:f}".format(np.nanmedian(RTgradients[np.isin(idx_completemyo,idxbz)])))
        print("RTGBZ min:    {0:f}".format(np.nanmin(RTgradients[np.isin(idx_completemyo,idxbz)])))
        print("RTGBZ max:    {0:f}".format(np.nanmax(RTgradients[np.isin(idx_completemyo,idxbz)])))

    RTgradientsMyo     = copy.deepcopy(RTgradients)


    # EHT--------------------------------------------------------------------
    if patch_flag:
        print("LOCAL RT GRADS EHT with maxDist {0}".format(args.maxDist[1]))
        start = time.time()
        if args.nCores != 1:
            xyzuvw = getLocalGradsVanillaMeshPerNodePool(points[idxpatch], rts[idxpatch], args.maxDist[1], args.maxMem, "space", args.nCores)
        else:
            xyzuvw = getLocalGradsVanillaMeshPerNode(points[idxpatch], rts[idxpatch], args.maxDist[1], "space")
        print("RT grads computed in {} s".format(time.time() - start))
        
        RTVvectors = xyzuvw[:,-3:]
        RTgradients = np.linalg.norm(RTVvectors, axis=1)
        if args.stimLabel in mesh.point_sets.keys(): 
            idxs2Nan = idxpatch==mesh.point_sets[args.stimLabel]
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
    RTgradients[idx_completemyo]   = RTgradientsMyo
    if patch_flag:
        RTgradients[idxpatch] = RTgradientsPatch

    #Save--------------------------------------------------------------------
    point_data = {}
    point_data["ATs_(ms)"] = ats
    point_data["ATs_absolute_(ms)"] = ats_absolute
    point_data["APD{}_(ms)".format(args.apd)] = apds
    point_data["CVMag_(cm/s)"] = CVmagnitudes
    point_data["CVversors"] = CVversors
    point_data["RTs_(ms)"] = rts
    point_data["RTgrad_[ms/mm]"] = RTgradients

    # Delete scar nodes from results all results
    if "scar_nodes" in mesh.point_sets.keys():
        idxscar = mesh.point_sets["scar_nodes"]
        for key in point_data.keys():
            point_data[key][idxscar] = np.nan

    # Get some reference for the node types
    tmp = np.zeros(mesh.points.shape[0])
    if "endo_nodes" in mesh.point_sets.keys():
        tmp[mesh.point_sets["endo_nodes"]] = layers_endo_flag
        tmp[mesh.point_sets["mid_nodes"]]  = layers_mid_flag
        tmp[mesh.point_sets["epi_nodes"]]  = layers_epi_flag
    elif "myo_nodes" in mesh.point_sets.keys():
        tmp[idxmyo] = layers_myo_flag
    if patch_flag:
        tmp[idxpatch] = layers_patch_flag
    if bz_flag:
        tmp[idxbz] = layers_bz_flag
    if "scar_nodes" in mesh.point_sets.keys():
        tmp[mesh.point_sets["scar_nodes"]] = layers_scar_flag
    point_data["layers"] = tmp

    meshOut = meshio.Mesh(mesh.points, mesh.cells, point_data=point_data)
    resFolder = "/".join(args.myResPath.split('/')[:-1])
    if not os.path.exists(resFolder): os.mkdir(resFolder)
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
    startTime = time.time()
    main()
    print("Total time was {0:.2f}".format(time.time()-startTime))