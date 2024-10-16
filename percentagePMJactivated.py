import argparse
import numpy as np
import meshio
from scipy.spatial import KDTree
import pandas as pd
import os
from tqdm import tqdm

params = ["CS ends", "CS ends activated", "CS ends unconnected", "CS-Tissue mean connections", "CS-Tissue pmj activated"]


def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--csMeshPath',       type=str, required=True, help='path to data')
    parser.add_argument('--tissueMeshPath',   type=str, required=True, help='path to data')
    parser.add_argument('--pmjRatio',         type=float, help='Ratio of pmj', default=1)
    parser.add_argument('--activationDelay',  type=float, help='Delay in ms between pmj and previous endbranch node activation time', default=1.5)
    parser.add_argument('--resExcel', type=str, required=True, help='Excel for saving results')
    args = parser.parse_args()

    cs_mesh  = meshio.read(args.csMeshPath)
    cs_ats   = cs_mesh.point_data['ATs_absolute_(ms)']
    cs_cells = cs_mesh.cells_dict['line']

    tissue_mesh  = meshio.read(args.tissueMeshPath)
    tissue_ats   = tissue_mesh.point_data['ATs_absolute_(ms)']
    tissue_cells = tissue_mesh.cells_dict['tetra'] 

    res = {}
    # Get cs pmj activation percentage ----------------------------------

    idxs, count = np.unique(cs_cells.flatten(), return_counts=True)
    idxs_pmj = idxs[count==1]
    idxs_pmj = idxs_pmj[1:] # without av node
    
    idxs_cells = np.isin(cs_cells, idxs_pmj).nonzero()[0]
    pmj_edges = cs_cells[idxs_cells,:]

    pmj_edges_ats = cs_ats[pmj_edges]
    activated_pmjs = np.diff(pmj_edges_ats, axis=1) # should have positive value and less than threshold if it is activated correctly
    activated_pmjs = np.where((activated_pmjs <= args.activationDelay) & (activated_pmjs>=0))[0] # does not count nans, perfect!
    print("The total amount of pmjs is {:d}".format(idxs_pmj.shape[0]))
    print("The amount of activated cs-pmjs are {:d}".format(activated_pmjs.shape[0]))

    res["CS ends"] = idxs_pmj.shape[0]
    res["CS ends activated"] = activated_pmjs.shape[0]
    
    # Get cs pmj-tissue activation percentage ----------------------------------
    tree = KDTree(tissue_mesh.points)
    idxs_tissue_pmjs = tree.query_ball_point(cs_mesh.points[idxs_pmj,:], args.pmjRatio)

    n_pmjs_activated = 0
    pmjs_activated_percentage = np.ones(idxs_pmj.shape[0]) * np.nan
    n_pmjs_tissue_connections = np.ones(idxs_pmj.shape[0]) * np.nan

    for i in tqdm(range(idxs_pmj.shape[0])):
        if len(idxs_tissue_pmjs[i]) != 0:
            activated_tissue_nodes = tissue_ats[idxs_tissue_pmjs[i]] - cs_ats[pmj_edges[i,0]]
            activated_tissue_nodes = np.where((activated_tissue_nodes <= args.activationDelay) & (activated_tissue_nodes>=0))[0]
                             

            n_pmjs_tissue_connections[i] = len(idxs_tissue_pmjs[i])
            pmjs_activated_percentage[i] = activated_tissue_nodes.shape[0] / len(idxs_tissue_pmjs[i]) * 100
            if activated_tissue_nodes.shape[0]  > 0:
                n_pmjs_activated += 1; 

    
    print("The amount of cs-pmjs unconnected with tissue are {:d}".format(np.count_nonzero(np.isnan(pmjs_activated_percentage))))
    print("From the cs-pmjs connected with tissue the mean number of connected nodes {:.2f}".format(np.nanmean(n_pmjs_tissue_connections)))
    print("The amount of activated cs-tissue pmjs are {:d}".format(n_pmjs_activated))

    res["CS ends unconnected"]        = np.count_nonzero(np.isnan(pmjs_activated_percentage))
    res["CS-Tissue mean connections"] = np.nanmean(n_pmjs_tissue_connections)
    res["CS-Tissue pmj activated"]    = n_pmjs_activated

    # Save ------------------------------------------------

    indexs = ["_".join(args.csMeshPath.split("/")[-3:-1])]
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