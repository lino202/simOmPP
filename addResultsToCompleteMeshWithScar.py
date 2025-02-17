"""This code is used to add results to a mesh with scar, putting as nans the values in the scar"""


import argparse
import numpy as np
import meshio
from scipy.spatial import KDTree

def main():

    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resultsMesh',   type=str, required=True, help='Mesh that does not have the scar but has the results')
    parser.add_argument('--completeMesh',  type=str, required=True, help='Mesh that has scar')
    parser.add_argument('--outMesh',       type=str, required=True, help='Output mesh')
    args = parser.parse_args()

    resultsMesh = meshio.read(args.resultsMesh)
    completeMesh = meshio.read(args.completeMesh)

    tree = KDTree(completeMesh.points)
    idxs = tree.query(resultsMesh.points)[1]

    point_data = {}

    for key, values in resultsMesh.point_data.items():
        if values.ndim == 1:
            tmp = np.ones(completeMesh.points.shape[0]) * np.nan
        elif values.ndim == 2:
            tmp = np.ones(completeMesh.points.shape) * np.nan
        tmp[idxs] = values
        point_data[key] = tmp

    point_data["layers"] = completeMesh.point_data["layers"]

    meshOut = meshio.Mesh(completeMesh.points, completeMesh.cells, point_data=point_data)
    meshOut.write(args.outMesh)
   

if __name__ == '__main__':
    main()