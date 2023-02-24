
import meshio
import numpy as np 
import argparse
import os
from tqdm import tqdm
import hdf5storage

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--resPath',type=str, required=True, help='path to electra ensight results')
parser.add_argument('--meshPath',type=str, required=True, help='path to mesh for obtaining the geometry (TODO read .geo)')
parser.add_argument('--timeStart',type=str, required=True, help='complete time in the ens file to start with')
parser.add_argument('--timeEnd',type=str, required=True, help='complete time in the ens ens end file')
parser.add_argument('--outPath',type=str, required=True, help='path of output with matlab extension')
args = parser.parse_args()

#Get Geometry
mesh = meshio.read(args.meshPath)
points = mesh.points
cells = mesh.cells_dict["tetra"]

#Get Results
timeStart = int(args.timeStart)
timeEnd = int(args.timeEnd)
nDigits = len(args.timeStart)
v = np.zeros((points.shape[0], timeEnd-timeStart+1))
for i in tqdm(range(timeStart, timeEnd+1)):
    with open(os.path.join(args.resPath, 'tissue_solution{}.ens'.format(str(i).zfill(nDigits))), "r") as f:
        data = f.readlines()
    v[:, i-timeStart] = np.array(data[4:]).astype(float)

from scipy.io import savemat

H = { "xyz": points, "tri": cells+1, "celltype": 10, "v": v}
hdf5storage.savemat( args.outPath, {'H': H}, format=7.3, matlab_compatible=True, compress=False )
# savemat(args.outPath, {'H': H})