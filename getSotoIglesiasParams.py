# This computes the histrograms for the LV endo and XV epi and IVD and LVTD params
# for the paper Soto-Iglesias et al "Quantitative Analysis of Electro-Anatomical
# Maps: Application to an Experimental Model of Left Bundle Branch Block/Cardiac Resynchronization Therapy"
import os
import numpy as np
import argparse 
import seaborn as sns 
import pandas as pd
import meshio
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',type=str, required=True, help='path to data')
parser.add_argument('--nbins',type=int, required=False, help='number of bins')
parser.add_argument('--save', action='store_true')
args = parser.parse_args()

lvEndo = meshio.read(os.path.join(args.dataPath, "lv_endoMeshio.xmf"))
lvEpi = meshio.read(os.path.join(args.dataPath, "lv_epiMeshio.xmf"))
rvEpi = meshio.read(os.path.join(args.dataPath, "rv_epiMeshio.xmf"))

data = {"lvEndoATs": lvEndo.point_data["LAT"], "lvEpiATs": lvEpi.point_data["LAT"], "rvEpiATs": rvEpi.point_data["LAT"]}

print ("LVTD {0:.2f} (ms)".format(np.nanmin(data["lvEpiATs"]) - np.nanmin(data["lvEndoATs"])))
print ("IVD {0:.2f} (ms)".format(np.nanmin(data["lvEpiATs"]) - np.nanmin(data["rvEpiATs"])))

# plt.figure()
sns.histplot(data=data["lvEndoATs"], color="skyblue", label="LV endo", bins=args.nbins if args.nbins else "auto")
sns.histplot(data=data["rvEpiATs"], color="red", label="RV epi", bins=args.nbins if args.nbins else "auto")
sns.histplot(data=data["lvEpiATs"], color="green", label="LV epi", bins=args.nbins if args.nbins else "auto")
plt.xlabel("AT (ms)")
plt.ylabel("Frequencies")
plt.legend() 
plt.savefig(os.path.join(args.dataPath, "sotoIglesiasHists.png")) if args.save else plt.show(block=True)