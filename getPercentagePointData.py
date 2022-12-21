import os
import numpy as np
import argparse
import meshio

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--varName',type=str, required=True)
parser.add_argument('--threshold',type=float,  required=True)
args = parser.parse_args()


mesh = meshio.read(args.dataPath)
data = mesh.point_data[args.varName]
subdata = (data>args.threshold).nonzero()[0].shape[0]
print("Percentage of {} above {} is {}".format(args.varName, args.threshold, (subdata/mesh.points.shape[0]) * 100))