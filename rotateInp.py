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

nsets = {}
nsets["stim_nodes"] = np.where( (points[:,1]<=0.5) & (points[:,0]<=0.5))[0]
nsets["block1"] = np.where((points[:,1]>0.5) & (points[:,0]>0.5))[0]
# nsets["block2"] = np.where((points[:,1]<=1.2) & (points[:,0]>=0.6))[0]
nsets["myo_nodes"] = np.arange(0,points.shape[0])
block = np.array([nsets["block1"]]).flatten()
nsets["myo_nodes"] = np.delete(nsets["myo_nodes"], block)

point_data = {}
for key in nsets.keys():
    tmp = np.zeros((points.shape[0]))
    tmp[nsets[key]] = 1
    point_data[key] = tmp

angleRad = np.deg2rad(args.angle)
R = np.array([[np.cos(angleRad), -np.sin(angleRad)],[np.sin(angleRad), np.cos(angleRad)]])
rotPoints = np.matmul(points, R)

meshOut = meshio.Mesh(rotPoints, mesh.cells, point_sets=nsets)
meshOut.write("{}.inp".format(args.outPath))

meshOut = meshio.Mesh(rotPoints, mesh.cells, point_data=point_data)
meshOut.write("{}.vtk".format(args.outPath))

objPoints = np.zeros((rotPoints.shape[0],3))
objPoints[:,:2] = rotPoints
meshOut = meshio.Mesh(objPoints, mesh.cells)
meshOut.write("{}.obj".format(args.outPath))