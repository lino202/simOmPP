import os
import meshio
import numpy as np
import argparse
from scipy.spatial.distance import cdist
from tqdm import tqdm
from utils import calculateBoxPlotParams, isMemberIdxsRowWise
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--resultsMesh',type=str, required=True)
parser.add_argument('--cleanMesh',type=str, required=True)
args = parser.parse_args()

cleanMesh = meshio.read(os.path.join(args.dataPath, args.cleanMesh))
resultsMesh = meshio.read(os.path.join(args.dataPath, args.resultsMesh))
points = cleanMesh.points
cells = cleanMesh.cells_dict["triangle"]
idxs = isMemberIdxsRowWise(points, resultsMesh.points)
ats = resultsMesh.point_data["LAT"][idxs]

# Analize per point
cvMag = np.zeros(ats.shape)
cvDirs = np.zeros((ats.shape[0],3))
for i in tqdm(range(points.shape[0])):
    #Get connections
    nodeConns = np.unique(cells[(cells == i).nonzero()[0]])        #nodes connected
    nodeConns = np.delete(nodeConns, nodeConns==i)
    
    #Calculate mean magnitude and direction
    #Magnitude
    dists = np.transpose(cdist(points[nodeConns,:], points[[i],:]))
    times = np.expand_dims(ats[nodeConns] - ats[i], axis=0)
    nodeCVs = np.empty(dists.shape)
    nodeCVs[:] = np.nan
    np.divide(dists, times, out=nodeCVs, where=times != 0.)
    
    if np.isnan(nodeCVs).all():
        cvMag[i] = np.nan
        cvDirs[i,:] = np.nan
    else:
        #Direction: All vectors go out from central node and times vector defines the final sign to be entering the node or going out from it
        dirs = points[nodeConns,:] - points[[i],:]  
        dirsVersors = dirs / np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
        cvVectors = dirsVersors * np.transpose(nodeCVs)
        resVector = np.nanmean(cvVectors, axis=0)
        if np.linalg.norm(resVector) != 0.0:
            cvMag[i] = np.linalg.norm(resVector)
            cvDirs[i,:] = resVector / np.linalg.norm(resVector)
        else:
            cvMag[i] = np.nan
            cvDirs[i,:] = np.nan
        

totDir = np.nanmean(cvDirs, axis=0)
totDir = totDir / np.linalg.norm(totDir)
print("The CV direction is {} \n".format(totDir))

cvMag = cvMag * 100
cvMag = cvMag[~np.isnan(cvMag)]
boxplotData = calculateBoxPlotParams(cvMag)
print("Useful Data: mean-std {0:.2f} +/- {1:.2f}".format(np.mean(cvMag), np.std(cvMag)))
print("\t median {0}, lowQuart {1}, upQuart {2}, lowWhisker {3}, upWhisker {4}".format(boxplotData[0], boxplotData[1], boxplotData[2], boxplotData[3], boxplotData[4]))

fig, axs = plt.subplots(1,2)
plt.subplots_adjust(wspace=0.4)
axs[0].hist(cvMag)
axs[1].boxplot(cvMag)
axs[0].set_ylabel("Frequencies")
axs[0].set_xlabel("CV [cm/s]")
axs[1].set_xlabel("Samples")
axs[1].set_ylabel("CV [cm/s]")
plt.savefig(os.path.join(args.dataPath,'CVmag_metrics.png'))
plt.show()