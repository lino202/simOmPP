
import meshio
import numpy as np 
import argparse
import os
from tqdm import tqdm
# import h5py
import hdf5storage

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--meshPath' ,        type=str, required=True, help='path to mesh for obtaining the geometry (TODO read .geo)')
parser.add_argument('--transMatrix',      type=str, help='path to transformation matrix in .txt file got from meshlab maybe (ICP alignment)')
parser.add_argument('--saveAlignedPath',  type=str, help='save a vtk file for seeing the aligned mesh, give the file path')
parser.add_argument('--addVs'    ,        action='store_true', help='select if you want ot save Vs or not in H')
parser.add_argument('--resPath'  ,        type=str, help='path to electra ensight results')
parser.add_argument('--timeStart',        type=str, help='complete time in the ens file to start with')
parser.add_argument('--timeEnd'  ,        type=str, help='complete time in the ens file to end with')
parser.add_argument('--outPath'  ,        type=str, required=True, help='path of output with matlab extension')
args = parser.parse_args()

#Get Geometry
mesh   = meshio.read(args.meshPath)
points = mesh.points
cells  = mesh.cells_dict["tetra"]
H = { "xyz": points, "tri": cells+1, "celltype": 10}

#Transform mesh
if args.transMatrix != None:
    transMatrix = np.loadtxt(args.transMatrix)
    H["xyz"] = np.matmul(np.concatenate((points, np.ones((points.shape[0],1))), axis=1) , transMatrix.T)[:,:3]
    if hasattr(args, 'saveAlignedPath'):
        meshAligned = meshio.Mesh(H["xyz"], mesh.cells)
        meshAligned.write(args.saveAlignedPath)

#Get Results
if args.addVs:
    timeStart = int(args.timeStart)
    timeEnd = int(args.timeEnd)
    nDigits = len(args.timeStart)
    v = np.zeros((points.shape[0], timeEnd-timeStart+1))
    # TODO read binary ensight file now since Electra 0.6.0
    for i in tqdm(range(timeStart, timeEnd+1)):
        raise ValueError("TODO read binary ensight file now since Electra 0.6.0")
        with open(os.path.join(args.resPath, 'tissue_solution{}.ens'.format(str(i).zfill(nDigits))), "r") as f:
            data = f.readlines()
        v[:, i-timeStart] = np.array(data[4:]).astype(float)

    H["v"] = v
    
# with h5py.File(args.outPath, 'w') as f:

#     f.create_dataset("xyz", data=H["xyz"])
#     f.create_dataset("tri", data=H["tri"])
#     f.create_dataset("celltype", data=H["celltype"])

#     if args.addVs:
#         f.create_dataset("v", data=H["v"])

# It seems matlab altered the h5 format with some specific metadata so we are using the following package
# for writing the data
# https://github.com/frejanordsiek/hdf5storage
hdf5storage.savemat( args.outPath, {'H': H}, format=7.3, matlab_compatible=True, compress=False )
