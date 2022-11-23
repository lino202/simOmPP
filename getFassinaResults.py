import os  
from shutil import copyfile
import argparse
from tqdm import tqdm
import numpy as np
import meshio
import matplotlib.pyplot as plt
import random
from utils import getLocalCvVanillaMesh
import pandas as pd

np.seterr(divide='raise', invalid='raise')
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--mainPath',type=str, required=True, help='path to data')
parser.add_argument('--meshPath',type=str, default="F:/Simulations/electra_sims/Biovad/Paper/fassina_05_thick/tissue.inp")
# parser.add_argument('--id',type=str, required=True, help='path to data')
parser.add_argument('--timeStart',type=int, default=2000)
parser.add_argument('--timeEnd',type=int, default=3000)
parser.add_argument('--apd',type=int, default=90)
parser.add_argument('--spaceUnit',type=str, default="mm")
parser.add_argument('--maxDist', type=float, help='distance radio', default=0.5)
parser.add_argument('--maxCV', type=float, help='max CV in cm/s', default=300)
parser.add_argument('--resExcel', type=str, help='max CV in cm/s', default="F:/Simulations/electra_sims/Biovad/Paper/fassina_05_thick/results.xlsx")
args = parser.parse_args()

mesh = meshio.read(args.meshPath)
myResPath = os.path.join(args.mainPath, "myResults")
resPath = os.path.join(args.mainPath, "results")
latPath = os.path.join(resPath, "lat.ens")
res = {}
idxmyo = np.append(mesh.point_sets["endo_nodes"], mesh.point_sets["mid_nodes"])
idxmyo = np.append(idxmyo, mesh.point_sets["epi_nodes"])
idxpatch = mesh.point_sets["patch_nodes"]
if not os.path.isdir(myResPath): os.mkdir(myResPath)

# ATs------------------------------------------------------------------------
copyfile(latPath, os.path.join(resPath, "latOri.ens"))

with open(latPath, "r") as f:
    data = f.readlines()
lats = np.array(data[4:]).astype(float)
lats = lats - np.nanmin(lats)

with open(latPath, "w") as f:
    f.write("Ensight Model Post Process\n")
    f.write("part\n")
    f.write(" 1\n")
    f.write("coordinates\n")
    for i in tqdm(range(lats.shape[0])):
        f.write("{0:f}\n".format(lats[i]))

res["ATM mean"] = np.nanmean(lats[idxmyo])
res["ATM median"] = np.nanmedian(lats[idxmyo])
res["ATM min"] = np.nanmin(lats[idxmyo])
res["ATM max"] = np.nanmax(lats[idxmyo])
res["ATP mean"] = np.nanmean(lats[idxpatch])
res["ATP median"] = np.nanmedian(lats[idxpatch])
res["ATP min"] = np.nanmin(lats[idxpatch])
res["ATP max"] = np.nanmax(lats[idxpatch])
# print("selected idx AT is : {0:f}".format(lats[args.idxAT]) )
# print("Mean AT Myo {0:f}".format(np.nanmean(lats[idxmyo])))
# print("Median AT Myo {0:f}".format(np.nanmedian(lats[idxmyo])))
# print("Min AT Myo {0:f}".format(np.nanmin(lats[idxmyo])))
# print("Max AT Myo {0:f}".format(np.nanmax(lats[idxmyo])))
# print("Mean AT Patch {0:f}".format(np.nanmean(lats[idxpatch])))
# print("Median AT Patch {0:f}".format(np.nanmedian(lats[idxpatch])))
# print("Min AT Patch {0:f}".format(np.nanmin(lats[idxpatch])))
# print("Max AT Patch {0:f}".format(np.nanmax(lats[idxpatch])))

#APD90 ----------------------------------------------------------------------------
print("Calculating APD")
nDigits = len(str(args.timeEnd))
for i in tqdm(range(args.timeStart, args.timeEnd)):
    with open(os.path.join(resPath, 'tissue_solution{}.ens'.format(str(i).zfill(nDigits)))) as f:
        data = f.readlines()
    tmp = np.array(data[4:]).astype(float)
    if i == args.timeStart: v = np.zeros((tmp.shape[0], args.timeEnd - args.timeStart))
    v[:, i-args.timeStart] = tmp

#Plot some curves
# fig, ax = plt.subplots()
# for i in range(10):
#     plotIdx = random.randint(0,v.shape[0])
#     ax.plot(v[plotIdx,:], label=plotIdx)
# ax.legend()
# ax.set_title("10 Vm signals")
# plt.show()

diff = np.diff(v, axis=1)
upstrokeIdxs = np.argmax(diff, axis=1)
peakIdxs = np.argmax(v, axis=1)
peaks    = np.max(v, axis=1)
baselinelvls = np.array([np.min(v[i,peakIdxs[i]:]) for i in range(v.shape[0])])

Voi = baselinelvls + (1 - (args.apd/100)) * (peaks - baselinelvls)
tin = np.ones(v.shape[0]) * np.nan
for i in tqdm(range(v.shape[0])):
    try:
        tin[i] = (v[i,peakIdxs[i]:]<Voi[i]).nonzero()[0][0] 
    except IndexError:
        pass

tin = tin + peakIdxs 
apds = tin - upstrokeIdxs
apds[apds<0] = np.nan

res["APD90M mean"] = np.nanmean(apds[idxmyo])
res["APD90M median"] = np.nanmedian(apds[idxmyo])
res["APD90M min"] = np.nanmin(apds[idxmyo])
res["APD90M max"] = np.nanmax(apds[idxmyo])
res["APD90P mean"] = np.nanmean(apds[idxpatch])
res["APD90P median"] = np.nanmedian(apds[idxpatch])
res["APD90P min"] = np.nanmin(apds[idxpatch])
res["APD90P max"] = np.nanmax(apds[idxpatch])

# CVs --------------------------------------------------------------------
points = mesh.points
cells = mesh.cells
ats = lats

print("Starting calculation of the local CVs with vanilla method")
xyzuvw = getLocalCvVanillaMesh(points, ats, args.maxDist)

CVvectors = xyzuvw[:,-3:]
CVmagnitudes = np.linalg.norm(CVvectors, axis=1)
CVversors = CVvectors / np.expand_dims(CVmagnitudes, axis=1)

# Add units and get rid of CVs which are too high and stimulated
if args.spaceUnit == "mm": CVmagnitudes = CVmagnitudes * 100
elif args.spaceUnit == "cm": CVmagnitudes = CVmagnitudes * 1000
else: raise ValueError("Wrong space unit")
idxs2Nan = np.where(CVmagnitudes>args.maxCV)
idxs2Nan = np.append(idxs2Nan, mesh.point_sets["stim_nodes"])
CVmagnitudes[idxs2Nan] = np.nan
CVversors[idxs2Nan,:] = np.nan
CVvectors = np.expand_dims(CVmagnitudes, axis=1) * CVversors

res["CVM mean"] = np.nanmean(CVmagnitudes[idxmyo])
res["CVM median"] = np.nanmedian(CVmagnitudes[idxmyo])
res["CVM min"] = np.nanmin(CVmagnitudes[idxmyo])
res["CVM max"] = np.nanmax(CVmagnitudes[idxmyo])
res["CVP mean"] = np.nanmean(CVmagnitudes[idxpatch])
res["CVP median"] = np.nanmedian(CVmagnitudes[idxpatch])
res["CVP min"] = np.nanmin(CVmagnitudes[idxpatch])
res["CVP max"] = np.nanmax(CVmagnitudes[idxpatch])

# print("Mean CVmag {0:f}".format(np.nanmean(CVmagnitudes[idxpatch])))
# print("Median CVmag {0:f}".format(np.nanmedian(CVmagnitudes[idxpatch])))
# print("Min CVmag {0:f}".format(np.nanmin(CVmagnitudes[idxpatch])))
# print("Max CVmag {0:f}".format(np.nanmax(CVmagnitudes[idxpatch])))

# RTs--------------------------------------------------------------------
rts = lats + apds

print("Starting calculation of the local RT gradients with vanilla method")
xyzuvw = getLocalCvVanillaMesh(points, rts, args.maxDist)
RTVvectors = xyzuvw[:,-3:]
RTVmagnitudes = np.linalg.norm(RTVvectors, axis=1)
RTgradients = 1 / RTVmagnitudes

res["RTGM mean"] = np.nanmean(RTgradients[idxmyo])
res["RTGM median"] = np.nanmedian(RTgradients[idxmyo])
res["RTGM min"] = np.nanmin(RTgradients[idxmyo])
res["RTGM max"] = np.nanmax(RTgradients[idxmyo])
res["RTGP mean"] = np.nanmean(RTgradients[idxpatch])
res["RTGP median"] = np.nanmedian(RTgradients[idxpatch])
res["RTGP min"] = np.nanmin(RTgradients[idxpatch])
res["RTGP max"] = np.nanmax(RTgradients[idxpatch])

# print("Mean RTgrad {0:f}".format(np.nanmean(RTgradients[idxpatch])))
# print("Median RTgrad {0:f}".format(np.nanmedian(RTgradients[idxpatch])))
# print("Min RTgrad {0:f}".format(np.nanmin(RTgradients[idxpatch])))
# print("Max RTgrad {0:f}".format(np.nanmax(RTgradients[idxpatch])))
#Save--------------------------------------------------------------------
point_data = {"ATs_[ms]": lats, "APD{}_[ms]".format(args.apd): apds, "CVMag_[cm/s]": CVmagnitudes, "CVversors": CVversors, "RTs_[ms]": rts}
point_data["RTgrad_[ms/mm]"] = RTgradients
myo_nodes = np.zeros(points.shape[0])
myo_nodes[idxmyo] = 1
patch_nodes = np.zeros(points.shape[0])
patch_nodes[idxpatch] = 1
point_data["myo_nodes"] = myo_nodes
point_data["patch_nodes"] = patch_nodes
meshOut = meshio.Mesh(mesh.points, mesh.cells, point_data=point_data)
meshOut.write(os.path.join(myResPath, "myresults.vtk"))

df = pd.read_excel(args.resExcel)
res["Id"] = "_".join(args.mainPath.split("/")[-2:])
new_row = pd.Series(res)
df2 = pd.concat([df, new_row.to_frame().T], ignore_index=True)
df2.to_excel(args.resExcel)