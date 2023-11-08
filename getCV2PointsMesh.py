import numpy as np
import argparse
import meshio


parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--meshPath',type=str, required=True, help='path to data, AT should be in ms')
parser.add_argument('--atName',type=str, required=True, help='name of AT map from Matlab')
parser.add_argument('--initPoints', type=int, nargs='+', required=True)
parser.add_argument('--finalPoints', type=int, nargs='+', required=True)
args = parser.parse_args()


mesh = meshio.read(args.meshPath)
ats = mesh.point_data[args.atName]

dists = mesh.points[args.initPoints] - mesh.points[args.finalPoints]
dists = np.linalg.norm(dists, axis=1)
ats = ats[args.finalPoints] - ats[args.initPoints]


print("Mean CV in cm/s : {}".format(np.nanmean(dists/ats * 100)))


