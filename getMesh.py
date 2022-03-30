
import meshio
import numpy as np 
import argparse
import os

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--fileName',type=str, required=True, help='path to data')
args = parser.parse_args()

mesh = meshio.read(os.path.join(args.dataPath, args.fileName))
meshOut = meshio.Mesh(mesh.points, mesh.cells)


meshOut.write(os.path.join(args.dataPath, "{}.obj".format(args.fileName.split(".")[0])))