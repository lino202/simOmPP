import os
from platform import node
import meshio
import numpy as np
import argparse
from utils import isMemberIdxsRowWise
from scipy.spatial.distance import cdist

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--cleanMesh',type=str, required=True, help='path to data')
parser.add_argument('--resultsMesh',type=str, required=True, help='path to data')
args = parser.parse_args()



cleanMesh = meshio.read(os.path.join(args.dataPath, args.cleanMesh))
resultsMesh = meshio.read(os.path.join(args.dataPath, args.resultsMesh))

points = cleanMesh.points
cells = cleanMesh.cells_dict["triangle"]
idxsMap = isMemberIdxsRowWise(cleanMesh.points, resultsMesh.points)
ats = resultsMesh.point_data["LAT"][idxsMap]
#  Check
meshOut = meshio.Mesh(points, cleanMesh.cells, point_data={'at' : ats})
meshOut.write(os.path.join(args.dataPath, "AV.vtk"))

# Analize per point
cvMag = np.zeros(ats.shape)
cvDirs = np.zeros((ats.shape[0],3))
for i in range(points.shape[0]):
    #Get connections
    nodeConns = np.unique(cells[(cells == i).nonzero()[0]])        #nodes connected
    nodeConns = np.delete(nodeConns, nodeConns==i)
    
    #Calculate mean magnitude and direction
    #Magnitude
    dists = np.transpose(cdist(points[nodeConns,:], points[[i],:]))
    times = np.abs(np.expand_dims(ats[nodeConns] - ats[i], axis=0))
    initNans = np.empty(dists.shape)
    initNans[:] = np.nan
    nodeCVs = np.divide(dists, times, out=initNans, where=times != 0.)
    
    if np.isnan(nodeCVs).all():
        cvMag[i] = np.nan
        cvDirs[i,:] = np.nan
    else:
        #Direction
        dirs = points[nodeConns,:] - points[[i],:]
        dirs = dirs / np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
        dir = np.nanmean(dirs * np.transpose(nodeCVs), axis=0)
        
        cvMag[i] = np.nanmean(nodeCVs)
        cvDirs[i,:] = dir / np.linalg.norm(dir)


totMag = np.nanmean(cvMag) * 100
totDir = np.nanmean(cvDirs, axis=0)
print("The CV magnitude is {} cm/s\n".format(totMag))
print("The CV direction is {} \n".format(totDir))