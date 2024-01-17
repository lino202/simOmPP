import os  
import argparse
import numpy as np
import meshio

    
def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--latPath',  type=str, required=True, help='path to data')
    parser.add_argument('--outPath',type=str, required=True, help='path to data')
    parser.add_argument('--meshPath', type=str, required=True)
    parser.add_argument('--timeStart',type=int, default=2000)
    parser.add_argument('--timeEnd',  type=int, default=3000)
    parser.add_argument('--dt',       type=float, default=1.)

    args = parser.parse_args()

    mesh = meshio.read(args.meshPath)
    latPath = os.path.join(args.latPath, "lat.ens")
    
    with open(latPath, "r") as f:
        data = f.readlines()
    lats = np.array(data[4:]).astype(float)
    lats = lats - np.nanmin(lats)


    #Save--------------------------------------------------------------------
    mesh.point_data["ATs_(ms)"] = lats
    mesh.write(args.outPath)

if __name__ == '__main__':
    main()