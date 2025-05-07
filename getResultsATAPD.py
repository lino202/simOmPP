import os  
import argparse
from tqdm import tqdm
import numpy as np
import meshio
from utilsCV import getLocalGradsVanillaMeshPerNodePool, getLocalGradsVanillaMeshPerNode, getLocalGradsVanillaMeshPerNodeCS
from utils import calcATFromEnsBinary, calcAPDXFromEnsBinary
import pandas as pd
import time
import copy

params = ["ATM mean", "ATM median", "ATM min", "ATM max", "ATP mean", "ATP median", "ATP min", "ATP max", "ATBZ mean", "ATBZ median", "ATBZ min", "ATBZ max",
        "APD90M mean", "APD90M median", "APD90M min", "APD90M max", "APD90P mean", "APD90P median", "APD90P min", "APD90P max", "APD90BZ mean", "APD90BZ median", "APD90BZ min", "APD90BZ max"]

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
    parser.add_argument('--nDigits',  type=int, default=5)
    parser.add_argument('--timeStart',type=int, default=2000)
    parser.add_argument('--timeEnd',  type=int, default=3000)
    parser.add_argument('--dt',       type=float, default=1.)
    parser.add_argument('--apd',      type=int, default=90)
    parser.add_argument('--maxMem',   type=float, default=5, help="Allowed RAM consumption in critical computations in GB")
    parser.add_argument('--nCores',   type=int, default=1)
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
            ats[nodeStart:nodeEnd] = calcATFromEnsBinary(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
    else:
        ats = calcATFromEnsBinary(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.resPath, args.nDigits, args.soluName)
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
            apds[nodeStart:nodeEnd] = calcAPDXFromEnsBinary(nodeStart, nodeEnd, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)

    else:
        apds = calcAPDXFromEnsBinary(0, totNodes, args.timeStart, args.timeEnd, args.dt, args.apd, args.resPath, args.nDigits, args.soluName)

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

    #Save--------------------------------------------------------------------
    point_data = {}
    point_data["ATs_(ms)"] = ats
    point_data["ATs_absolute_(ms)"] = ats_absolute
    point_data["APD{}_(ms)".format(args.apd)] = apds

    # Delete scar nodes from results
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