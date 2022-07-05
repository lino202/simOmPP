import os
import meshio
import numpy as np
import argparse
from scipy.spatial.distance import cdist
from tqdm import tqdm
from utils import calculateBoxPlotParams, isMemberIdxsRowWise, getLocalCvVanillaMesh, getLocalCvBaylyMesh, plotHistAndBoxPlotSeaBorn

np.seterr(divide='raise', invalid='raise')
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--resultsMesh',type=str, required=True)
parser.add_argument('--cleanMesh',type=str)
parser.add_argument('--spaceUnit',type=str, required=True)
parser.add_argument('--alreadyClean',action='store_true')
parser.add_argument('--maxDist', type=float, required=True, help='distance of Bayly paper in px')
parser.add_argument('--maxCV', type=float, required=True, help='max CV in cm/s')
parser.add_argument('--calcMethod', type=str, required=True, help='bayly or vanilla')
parser.add_argument('--outPath', type=str, required=True, help='path to the folder for saving images, if 0 images are plotted and not saved')
parser.add_argument('--outType', type=str, required=True, help='png or pdf')
args = parser.parse_args()

resultsMesh = meshio.read(os.path.join(args.dataPath, args.resultsMesh))
if not args.alreadyClean:
    cleanMesh = meshio.read(os.path.join(args.dataPath, args.cleanMesh))
    points = cleanMesh.points
    cells = cleanMesh.cells
    idxs = isMemberIdxsRowWise(points, resultsMesh.points)
    ats = resultsMesh.point_data["LAT"][idxs]
else:
    points = resultsMesh.points
    cells = resultsMesh.cells
    ats = resultsMesh.point_data["LAT"]


# CV-----------------------------------------------
print("Starting calculation of the local CVs with method {}".format(args.calcMethod))
if args.calcMethod == "bayly": xyzuvw = getLocalCvBaylyMesh(points, ats, args.maxDist)
elif args.calcMethod == "vanilla": xyzuvw = getLocalCvVanillaMesh(points, ats, args.maxDist)
else: raise ValueError("Wrong calculation method")

CVvectors = xyzuvw[:,-3:]
CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
CVversors = CVvectors / np.expand_dims(CVmagnitudes, axis=1)

# Add units and get rid of CVs which are too long
if args.spaceUnit == "mm": CVmagnitudes = CVmagnitudes * 100
elif args.spaceUnit == "cm": CVmagnitudes = CVmagnitudes * 1000
else: raise ValueError("Wrong space unit")

idxs2Nan = np.where(CVmagnitudes>args.maxCV)
CVmagnitudes[idxs2Nan] = np.nan
CVversors[idxs2Nan,:] = np.nan
CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

print("The mean CV magnitude is {}  cm/s".format(np.nanmean(CVmagnitudes)))
print("The median CV magnitude is {}  cm/s".format(np.nanmedian(CVmagnitudes)))
totDir = np.nanmean(CVversors, axis=0)
totDir = totDir / np.linalg.norm(totDir)
print("The mean CV direction versor is {} ".format(totDir))
print("The mean CVxyz vector is {} ".format(np.nanmean(CVvectors, axis=0)))
print("The meanAbs CVxyz vector is {} ".format(np.nanmean(np.abs(CVvectors), axis=0)))

array = CVvectors[:,0][~np.isnan(CVvectors[:,0])]
if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(array, "CVx [cm/s]", path=os.path.join(args.outPath, "cvx_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(array, "CVx [cm/s]")

array = CVvectors[:,1][~np.isnan(CVvectors[:,1])]
if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(array, "CVy [cm/s]", path=os.path.join(args.outPath, "cvy_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(array, "CVy [cm/s]")

array = CVvectors[:,2][~np.isnan(CVvectors[:,2])]
if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(array, "CVz [cm/s]", path=os.path.join(args.outPath, "cvz_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(array, "CVz [cm/s]")

if args.outPath != "0":
    plotHistAndBoxPlotSeaBorn(CVmagnitudes[~np.isnan(CVmagnitudes)], "CV Mag [cm/s]", path=os.path.join(args.outPath, "cvmag_metrics.{}".format(args.outType)))
else:
    plotHistAndBoxPlotSeaBorn(CVmagnitudes[~np.isnan(CVmagnitudes)], "CV Mag [cm/s]")


#Save
ats = ats - np.nanmin(ats)
point_data = {"ATs": ats, "CVMag": CVmagnitudes, "CVversors": CVversors}
meshOut = meshio.Mesh(points, cells, point_data=point_data)
if args.outPath != "0":
    meshOut.write(os.path.join(args.outPath, "{}_cv.vtk".format(args.resultsMesh.split("/")[-1].split(".")[0])))
