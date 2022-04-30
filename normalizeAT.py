import os  
from shutil import copyfile
import argparse
from tqdm import tqdm
import numpy as np

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--latPath',type=str, required=True, help='path to data')
args = parser.parse_args()

path = args.latPath.split("lat.ens")[0]
copyfile(args.latPath, os.path.join(path, "latOri.ens"))

with open(args.latPath, "r") as f:
    data = f.readlines()

lats = np.array(data[4:]).astype(int)
lats = lats - np.nanmin(lats)

with open(args.latPath, "w") as f:
    f.write("Ensight Model Post Process\n")
    f.write("part\n")
    f.write(" 1\n")
    f.write("coordinates\n")

    for i in tqdm(range(lats.shape[0])):
        f.write("{0:d}\n".format(lats[i]))

print("max AT is : {0:d}".format(np.nanmax(lats)) )


    


