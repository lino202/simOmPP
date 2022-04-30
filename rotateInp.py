import meshio 
import os 
import numpy as np
import argparse
from scipy.spatial.transform import Rotation as R


parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data')
parser.add_argument('--angle',type=float, required=True)
parser.add_argument('--outPath', type=str, required=True, help='path to the folder for saving')
args = parser.parse_args()

mesh = meshio.read(args.filePath)
points = mesh.points
nsets = mesh.point_sets

point_data={}
for key in nsets.keys():
    tmp = np.zeros(points.shape[0])
    tmp[nsets[key]] = 1
    point_data[key] = list(tmp)

angleRad = np.deg2rad(args.angle)
R = np.array([[np.cos(angleRad), -np.sin(angleRad)],[np.sin(angleRad), np.cos(angleRad)]])
rotPoints = np.matmul(points, R)

meshOut = meshio.Mesh(rotPoints, mesh.cells, point_sets=nsets)
meshOut.write("{}.inp".format(args.outPath))

meshOut = meshio.Mesh(rotPoints, mesh.cells, point_data=point_data)
meshOut.write("{}.vtk".format(args.outPath))
