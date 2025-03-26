import time
import argparse
import numpy as np
import subprocess
import re

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--resultsFolderPath',  type=str, required=True, nargs='+', help='path to data')
    parser.add_argument('--paraviewScriptPath',type=str, required=True, help='path to data')
    parser.add_argument('--prefixOfFolders',type=str, help='Prefix used in all folders and in the paraview script', default='stimAHA')
    args = parser.parse_args()


    pattern = rf"_{args.prefixOfFolders}\d+_"

    for folderPath in args.resultsFolderPath:
        start = time.time()
        stimAHA = re.search(pattern, folderPath).group()

        # First we open the script and change the folder inside of it
        with open(args.paraviewScriptPath, 'r') as f:
            data = f.readlines()

        for i, line in enumerate(data):
            if re.search(pattern, line):
                data[i] = re.sub(pattern, stimAHA, line)

        with open(args.paraviewScriptPath, 'w') as f:
            f.writelines(data)

        # Then execute
        # pvpython is not parallel and painfully slow but it uses less resources
        # pvbatch is faster as it is parallel but it uses more resources, pvbatch is generally the option to go
        subprocess.run(["C:\\Program Files\\ParaView 5.11.1\\bin\\pvbatch.exe", args.paraviewScriptPath])  # Blocks until finished
        print(f"Video for {folderPath} finished in {time.time()-start} seconds")





    

if __name__ == '__main__':
    main()