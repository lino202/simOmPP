
import meshio
import numpy as np 
import argparse
import os
from tqdm import tqdm
import hdf5storage

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--resPath'  , type=str, required=True, help='path to electra ensight results')
parser.add_argument('--meshPath' , type=str, required=True, help='path to mesh for obtaining the geometry (TODO read .geo)')
parser.add_argument('--addVs'    , action='store_true', help='select if you want ot save Vs or not in H')
parser.add_argument('--timeStart', type=str, help='complete time in the ens file to start with')
parser.add_argument('--timeEnd'  , type=str, help='complete time in the ens file to end with')
parser.add_argument('--outPath'  , type=str, required=True, help='path of output with matlab extension')
args = parser.parse_args()

#Get Geometry
mesh = meshio.read(args.meshPath)
points = mesh.points
cells = mesh.cells_dict["tetra"]
H = { "xyz": points, "tri": cells+1, "celltype": 10}

#Get Results
if args.addVs:
    timeStart = int(args.timeStart)
    timeEnd = int(args.timeEnd)
    nDigits = len(args.timeStart)
    v = np.zeros((points.shape[0], timeEnd-timeStart+1))
    for i in tqdm(range(timeStart, timeEnd+1)):
        with open(os.path.join(args.resPath, 'tissue_solution{}.ens'.format(str(i).zfill(nDigits))), "r") as f:
            data = f.readlines()
        v[:, i-timeStart] = np.array(data[4:]).astype(float)

    H["v"] = v
    
hdf5storage.savemat( args.outPath, {'H': H}, format=7.3, matlab_compatible=True, compress=False )
# savemat(args.outPath, {'H': H})