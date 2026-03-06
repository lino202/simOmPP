import argparse
import numpy as np
import meshio
from scipy.spatial import KDTree
import pandas as pd
import os
from tqdm import tqdm

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--csMeshPath',       type=str, required=True, help='path to data')
    parser.add_argument('--tissueMeshPath',   type=str, required=True, help='path to data with AHA')
    parser.add_argument('--pmjRatio',         type=float, help='Ratio of pmj', default=1)
    parser.add_argument('--segAHA',           type=int, help='Segment AHA', default=1)
    args = parser.parse_args()

    cs_mesh  = meshio.read(args.csMeshPath)
    cs_cells = cs_mesh.cells_dict['line']

    tissue_mesh  = meshio.read(args.tissueMeshPath)
    aha_points = np.where(tissue_mesh.point_data['stim_nodes_aha{}'.format(args.segAHA)] == 1)[0]

    # Get cs pmj activation percentage ----------------------------------

    idxs, count = np.unique(cs_cells.flatten(), return_counts=True)
    idxs_pmj = idxs[count==1]
    idxs_pmj = idxs_pmj[1:] # without av node
    
    # Get cs pmj-tissue activation percentage ----------------------------------
    tree = KDTree(tissue_mesh.points)
    idxs_tissue_pmjs = tree.query_ball_point(cs_mesh.points[idxs_pmj,:], args.pmjRatio)

    for i in tqdm(range(idxs_pmj.shape[0])):
        if len(idxs_tissue_pmjs[i]) != 0:

            isthereidx = np.isin(idxs_tissue_pmjs[i], aha_points)
            if np.any(isthereidx): # if any of the tissue points connected to the pmj is in the AHA segment, then this pmj is on the AHA segment. We can also check how many of the connected tissue points are in the AHA segment, but for now we just check if there is at least one connection to the AHA segment.
                print("PMJ {} is connected to AHA segment {}, the tissue idx is {}".format(idxs_pmj[i], args.segAHA, np.array(idxs_tissue_pmjs[i])[isthereidx])) 





if __name__ == '__main__':
    main()