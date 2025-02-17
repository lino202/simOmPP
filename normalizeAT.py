import argparse
import numpy as np
import meshio

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--meshPath',type=str, required=True, help='path to data')
parser.add_argument('--pointDataName',type=str, required=True)
args = parser.parse_args()

mesh = meshio.read(args.meshPath)
mesh.point_data[args.pointDataName] = mesh.point_data[args.pointDataName] - np.nanmin(mesh.point_data[args.pointDataName])
mesh.write(args.meshPath)

    


