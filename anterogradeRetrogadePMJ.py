import argparse
import numpy as np
import meshio
from scipy.spatial import KDTree
import pandas as pd
import os
from tqdm import tqdm
import copy


def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--csMeshPath',       type=str, required=True, help='path to data')
    parser.add_argument('--tissueMeshPath',   type=str, required=True, help='path to data')
    parser.add_argument('--pmjRatio',         type=float, help='Ratio of pmj', default=1)
    args = parser.parse_args()

    cs_mesh  = meshio.read(args.csMeshPath)
    cs_ats   = cs_mesh.point_data['ATs_absolute_(ms)'] if 'ATs_absolute_(ms)' in cs_mesh.point_data else np.zeros(cs_mesh.points.shape[0]) # if no ats, all zeros and all pmjs activated!!
    cs_cells = cs_mesh.cells_dict['line']

    tissue_mesh  = meshio.read(args.tissueMeshPath)
    tissue_ats   = tissue_mesh.point_data['ATs_absolute_(ms)'] if 'ATs_absolute_(ms)' in tissue_mesh.point_data else np.zeros(tissue_mesh.points.shape[0])
    tissue_cells = tissue_mesh.cells_dict['tetra'] 

    # Get cs pmj activation percentage ----------------------------------
    idxs, count = np.unique(cs_cells.flatten(), return_counts=True)
    idxs_pmj = idxs[count==1]
    idxs_pmj = idxs_pmj[1:] # without av node
    
    idxs_cells = np.isin(cs_cells, idxs_pmj).nonzero()[0]
    pmj_edges = cs_cells[idxs_cells,:]
    
    # Get cs pmj-tissue activation percentage ----------------------------------
    tree = KDTree(tissue_mesh.points)
    idxs_tissue_pmjs = tree.query_ball_point(cs_mesh.points[idxs_pmj,:], args.pmjRatio)

    delays = np.ones(idxs_pmj.shape[0]) * np.nan
    anterograde_delays = []
    retrograde_delays = []
    for i in tqdm(range(idxs_pmj.shape[0])):
        if len(idxs_tissue_pmjs[i]) != 0:
            delays[i] = np.nanmean(tissue_ats[idxs_tissue_pmjs[i]] - cs_ats[pmj_edges[i,1]])
            
            if delays[i] >= 0:
                anterograde_delays.append(delays[i])
            else:
                retrograde_delays.append(delays[i])
    
    delays1 = copy.deepcopy(delays)
    print("The mean anterograde delay (myo nodes connected to CS endpoint) is {:.2f} ms from {:} pmjs".format(np.nanmean(anterograde_delays), len(anterograde_delays)))
    print("The mean retrograde delay (myo nodes connected to CS endpoint) is {:.2f} ms from {:} pmjs".format(np.nanmean(retrograde_delays), len(retrograde_delays)))

    # Here we get the last Y point and compare to the activation of the endpoint of the last branch of the pmj 
    # this is a more realistic measure of the delay as the conductivity gradient is applied on the segments of the endbranch-------------------------------------
    idxs_centre_Y_point = idxs[count==3]
    Y_idxs = np.ones(idxs_pmj.shape[0]) * np.nan

    delays = np.ones(idxs_pmj.shape[0]) * np.nan
    anterograde_delays = []
    retrograde_delays = []
    for i in tqdm(range(idxs_pmj.shape[0])):
        if len(idxs_tissue_pmjs[i]) != 0:
            current_idx = pmj_edges[i,0]
            last_segment_idx = pmj_edges[i,:]
            while current_idx not in idxs_centre_Y_point:
                posible_idxs = cs_cells[np.isin(cs_cells, current_idx).nonzero()[0],:] # get the next node in the branch
                current_idx = posible_idxs.flatten()[np.logical_not(np.isin(posible_idxs.flatten(), last_segment_idx)).nonzero()[0][0]] # get the next node in the branch that is not the previous one
                last_segment_idx = posible_idxs[0,:] # update the last segment idx


            Y_idxs[i] = current_idx
            delays[i] = np.nanmean(tissue_ats[idxs_tissue_pmjs[i]] - cs_ats[current_idx])
            
            if delays[i] >= 0:
                anterograde_delays.append(delays[i])
            else:
                retrograde_delays.append(delays[i])
    
    print("The mean anterograde delay (myo nodes connected to Y CS endbranch) is {:.2f} ms from {:} pmjs".format(np.nanmean(anterograde_delays), len(anterograde_delays)))
    print("The mean retrograde delay (myo nodes connected to Y CS endbranch) is {:.2f} ms from {:} pmjs".format(np.nanmean(retrograde_delays), len(retrograde_delays)))

    


if __name__ == '__main__':
    main()