import os  
import argparse
import numpy as np
import meshio
import pandas as pd
import time

params = ["ATM mean", "ATM median", "ATM min", "ATM max", "ATP mean", "ATP median", "ATP min", "ATP max",
        "APD90M mean", "APD90M median", "APD90M min", "APD90M max", "APD90P mean", "APD90P median", "APD90P min", "APD90P max",    
        "CVM mean", "CVM median", "CVM min", "CVM max", "CVP mean", "CVP median", "CVP min", "CVP max",
        "RTGM mean", "RTGM median", "RTGM min", "RTGM max", "RTGP mean", "RTGP median", "RTGP min", "RTGP max"]
    
def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--meshPath', type=str, required=True)
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

    

    # ATs------------------------------------------------------------------------
    print("Calculating AT-----------------------------------------------------")
    ats = mesh.point_data["ATs_(ms)"]
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

    print("ATM mean:   {0:f}".format(np.nanmean(ats[idxmyo])))
    print("ATM median: {0:f}".format(np.nanmedian(ats[idxmyo])))
    print("ATM min:    {0:f}".format(np.nanmin(ats[idxmyo])))
    print("ATM max:    {0:f}".format(np.nanmax(ats[idxmyo])))
    if patch_flag:
        print("ATP mean:   {0:f}".format(np.nanmean(ats[idxpatch])))
        print("ATP median: {0:f}".format(np.nanmedian(ats[idxpatch])))
        print("ATP min:    {0:f}".format(np.nanmin(ats[idxpatch])))
        print("ATP max:    {0:f}".format(np.nanmax(ats[idxpatch])))

    #APD90 ----------------------------------------------------------------------------
    print("Calculating APD-----------------------------------------------")
    apds = mesh.point_data["APD90_(ms)"]

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
    print("Calculating CV-----------------------------------------------")
    cvs = mesh.point_data["CVMag_(cm/s)"]

    res["CVM mean"] = np.nanmean(cvs[idxmyo])
    res["CVM median"] = np.nanmedian(cvs[idxmyo])
    res["CVM min"] = np.nanmin(cvs[idxmyo])
    res["CVM max"] = np.nanmax(cvs[idxmyo])
    if patch_flag:
        res["CVP mean"] = np.nanmean(cvs[idxpatch])
        res["CVP median"] = np.nanmedian(cvs[idxpatch])
        res["CVP min"] = np.nanmin(cvs[idxpatch])
        res["CVP max"] = np.nanmax(cvs[idxpatch])

    print("CVM mean:   {0:f}".format(np.nanmean(cvs[idxmyo])))
    print("CVM median: {0:f}".format(np.nanmedian(cvs[idxmyo])))
    print("CVM min:    {0:f}".format(np.nanmin(cvs[idxmyo])))
    print("CVM max:    {0:f}".format(np.nanmax(cvs[idxmyo])))
    if patch_flag:
        print("CVP mean:   {0:f}".format(np.nanmean(cvs[idxpatch])))
        print("CVP median: {0:f}".format(np.nanmedian(cvs[idxpatch])))
        print("CVP min:    {0:f}".format(np.nanmin(cvs[idxpatch])))
        print("CVP max:    {0:f}".format(np.nanmax(cvs[idxpatch])))

    # RTs--------------------------------------------------------------------
    print("Calculating RTG-----------------------------------------------")
    rtgs = mesh.point_data["RTgrad_[ms/mm]"]

    res["RTGM mean"] = np.nanmean(rtgs[idxmyo])
    res["RTGM median"] = np.nanmedian(rtgs[idxmyo])
    res["RTGM min"] = np.nanmin(rtgs[idxmyo])
    res["RTGM max"] = np.nanmax(rtgs[idxmyo])
    if patch_flag:
        res["RTGP mean"] = np.nanmean(rtgs[idxpatch])
        res["RTGP median"] = np.nanmedian(rtgs[idxpatch])
        res["RTGP min"] = np.nanmin(rtgs[idxpatch])
        res["RTGP max"] = np.nanmax(rtgs[idxpatch])

    print("RTGM mean:   {0:f}".format(np.nanmean(rtgs[idxmyo])))
    print("RTGM median: {0:f}".format(np.nanmedian(rtgs[idxmyo])))
    print("RTGM min:    {0:f}".format(np.nanmin(rtgs[idxmyo])))
    print("RTGM max:    {0:f}".format(np.nanmax(rtgs[idxmyo])))
    if patch_flag:
        print("RTGP mean:   {0:f}".format(np.nanmean(rtgs[idxpatch])))
        print("RTGP median: {0:f}".format(np.nanmedian(rtgs[idxpatch])))
        print("RTGP min:    {0:f}".format(np.nanmin(rtgs[idxpatch])))
        print("RTGP max:    {0:f}".format(np.nanmax(rtgs[idxpatch])))

    #Save--------------------------------------------------------------------
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