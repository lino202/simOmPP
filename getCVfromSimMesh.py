import os  
import argparse
import numpy as np
import meshio
from utilsCV import getLocalGradsVanillaMeshPerNodePool, getLocalGradsVanillaMeshPerNode
import pandas as pd
import time

params = ["CVM mean", "CVM median", "CVM min", "CVM max", "CVP mean", "CVP median", "CVP min", "CVP max", "CVBZ mean", "CVBZ median", "CVBZ min", "CVBZ max",]

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
    parser.add_argument('--meshPath', type=str, required=True)
    parser.add_argument('--stimLabel',type=str, default="stim_nodes")
    parser.add_argument('--maxMem',   type=float, default=5, help="Allowed RAM consumption in critical computations in GB")
    parser.add_argument('--nCores',   type=int, default=1)
    parser.add_argument('--spaceUnit',type=str, default="mm")
    parser.add_argument('--maxDist',  type=float, help='distance radius', default=0.5)
    parser.add_argument('--maxCV',    type=float, help='max CV in cm/s', default=300)
    parser.add_argument('--resExcel', type=str, required=True, help='Excel for saving results')
    args = parser.parse_args()


    mesh = meshio.read(args.meshPath)
    points = mesh.points
    ats = mesh.point_data["ATs_(ms)"]
    ats = ats - np.nanmin(ats)
    res = {}

    # If I have layers it means I have the MI and maybe the patch otherwise I just have myo HE nodes
    if "layers" in mesh.point_data.keys():
        layers   = mesh.point_data['layers']
        idxmyo   = np.where((layers==layers_endo_flag) | (layers==layers_mid_flag) | (layers==layers_epi_flag))[0]
        idxpatch = np.where(layers==layers_patch_flag)[0]
        idxbz    = np.where(layers==layers_bz_flag)[0]
        idxscar  = np.where(layers==layers_scar_flag)[0]

        if idxpatch.size:
            patch_flag = 1
        else:
            patch_flag = 0
        
        if idxbz.size:
            bz_flag = 1
        else:
            bz_flag = 0

        if idxscar.size:
            scar_flag = 1
        else:
            scar_flag = 0

    else:  
        idxmyo = np.arange(mesh.points.shape[0])
        patch_flag = 0
        bz_flag = 0
        scar_flag = 0


    print("Calculating CVs-----------------------------------------------------")
    start = time.time()
    if args.nCores != 1:
        xyzuvw = getLocalGradsVanillaMeshPerNodePool(points, ats, args.maxDist, args.maxMem, "time", args.nCores)
    else:
        xyzuvw = getLocalGradsVanillaMeshPerNode(points, ats, args.maxDist, "time")
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
    if args.stimLabel in mesh.point_data.keys(): 
        idxs2Nan = np.append(idxs2Nan, mesh.point_data[args.stimLabel])
    CVmagnitudes[idxs2Nan] = np.nan
    CVversors[idxs2Nan,:] = np.nan
    CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

    res["CVM mean"] = np.nanmean(CVmagnitudes[idxmyo])
    res["CVM median"] = np.nanmedian(CVmagnitudes[idxmyo])
    res["CVM min"] = np.nanmin(CVmagnitudes[idxmyo])
    res["CVM max"] = np.nanmax(CVmagnitudes[idxmyo])
    if patch_flag:
        res["CVP mean"] = np.nanmean(CVmagnitudes[idxpatch])
        res["CVP median"] = np.nanmedian(CVmagnitudes[idxpatch])
        res["CVP min"] = np.nanmin(CVmagnitudes[idxpatch])
        res["CVP max"] = np.nanmax(CVmagnitudes[idxpatch])
    if bz_flag:
        res["CVBZ mean"] = np.nanmean(CVmagnitudes[idxbz])
        res["CVBZ median"] = np.nanmedian(CVmagnitudes[idxbz])
        res["CVBZ min"] = np.nanmin(CVmagnitudes[idxbz])
        res["CVBZ max"] = np.nanmax(CVmagnitudes[idxbz])

    print("CVM mean:   {0:f}".format(np.nanmean(CVmagnitudes[idxmyo])))
    print("CVM median: {0:f}".format(np.nanmedian(CVmagnitudes[idxmyo])))
    print("CVM min:    {0:f}".format(np.nanmin(CVmagnitudes[idxmyo])))
    print("CVM max:    {0:f}".format(np.nanmax(CVmagnitudes[idxmyo])))
    if patch_flag:
        print("CVP mean:   {0:f}".format(np.nanmean(CVmagnitudes[idxpatch])))
        print("CVP median: {0:f}".format(np.nanmedian(CVmagnitudes[idxpatch])))
        print("CVP min:    {0:f}".format(np.nanmin(CVmagnitudes[idxpatch])))
        print("CVP max:    {0:f}".format(np.nanmax(CVmagnitudes[idxpatch])))
    if bz_flag:
        print("CVBZ mean:   {0:f}".format(np.nanmean(CVmagnitudes[idxbz])))
        print("CVBZ median: {0:f}".format(np.nanmedian(CVmagnitudes[idxbz])))
        print("CVBZ min:    {0:f}".format(np.nanmin(CVmagnitudes[idxbz])))
        print("CVBZ max:    {0:f}".format(np.nanmax(CVmagnitudes[idxbz])))
    
    #Save--------------------------------------------------------------------

    mesh.point_data["CVMag_(cm/s)_epi"] = CVmagnitudes
    mesh.point_data["CVversors_epi"] = CVversors

    # Delete scar nodes from results
    if scar_flag:
        for key in mesh.point_data.keys():
            mesh.point_data[key][idxscar] = np.nan

    mesh.write(args.meshPath)
    
    indexs = ["_".join(args.meshPath.split("/")[-3:])]
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