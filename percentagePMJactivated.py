import argparse
import numpy as np
import meshio


def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--meshPath',  type=str, required=True, help='path to data')
    parser.add_argument('--pmjActivatedDelay',  type=int, help='Delay in ms between pmj and previous endbranch node activation time', default=1)
    args = parser.parse_args()

    mesh  = meshio.read(args.meshPath)
    ats   = mesh.point_data['ATs_(ms)']
    cells = mesh.cells_dict['line']
    idxs, count = np.unique(cells.flatten(), return_counts=True)
    idxs_pmj = idxs[count==1]
    idxs_pmj = idxs_pmj[1:] # without av node
    
    idxs_cells = np.isin(cells, idxs_pmj).nonzero()[0]
    pmj_edges = cells[idxs_cells,:]

    pmj_edges_ats = ats[pmj_edges]
    activated_pmjs = np.count_nonzero(np.where(np.abs(np.diff(pmj_edges_ats, axis=1)) < args.pmjActivatedDelay)[0]) # does not count nans, perfect!
    print("The amount of activated pmjs are {:d}/{:d} -> so percentage of {:f}".format(activated_pmjs, idxs_pmj.shape[0], activated_pmjs/idxs_pmj.shape[0] * 100))
    


if __name__ == '__main__':
    main()