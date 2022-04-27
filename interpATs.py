import os  
import argparse
import numpy as np
import meshio
from scipy.interpolate import RBFInterpolator, griddata

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath1',type=str, required=True, help='path to data')
parser.add_argument('--dataPath2',type=str, required=True, help='path to data')
parser.add_argument('--interpType', type=str, required=True, help='nearest or rbf')
parser.add_argument('--outPath',type=str, required=True)
args = parser.parse_args()

mesh1 = meshio.read(args.dataPath1)
mesh2 = meshio.read(args.dataPath2)

points1 = mesh1.points
points2 = mesh2.points
values = mesh1.point_data["LAT"]

if args.interpType == "nearest":
    ats2 = griddata(points1, values, points2, method='nearest')
elif args.interpType == "rbf":
    ats2 = RBFInterpolator(points1, values, neighbors=100)(points2)

mesh2.point_data["LAT"] = ats2 - np.min(ats2)
mesh2.write(args.outPath.split(".")[0] + "_{}.vtk".format(args.interpType) )
