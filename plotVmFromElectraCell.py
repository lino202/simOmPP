import os  
import argparse
import numpy as np
import matplotlib.pyplot as plt
from utils import calcAPDXFromV
import h5py

def main():

    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--filePaths',  type=str, nargs='+', required=True, help='path to data')
    parser.add_argument('--starts',     type=int, nargs='+', required=True, help='')
    parser.add_argument('--ends',       type=int, nargs='+', required=True, help='')
    parser.add_argument('--names',      type=str, nargs='+', required=True, help='')
    parser.add_argument('--dt',         type=float, nargs='+', required=True, help='')
    parser.add_argument('--apdType',    type=int, required=True, help='')
    parser.add_argument('--outPath',    type=str, required=True, help='')
    args = parser.parse_args()

    cases = {}
    for i, filePath in enumerate(args.filePaths):
        cases[filePath] = {}
        if '.mat' in filePath:   # ElectraCell results can be saved in .mat format
            with h5py.File(filePath, "r") as f:
                vm = np.asarray(f['V'])   # f['time'] can be also obtained
                vm = np.squeeze(vm)
                vms = vm[int(args.starts[i]/args.dt[i]):int(args.ends[i]/args.dt[i])]
        elif '.txt' in filePath:  # ElectraCell results can be saved in .txt format
            with open(filePath, 'r') as file:
                data = np.loadtxt(file)
                vms = data[int(args.starts[i]/args.dt[i]):int(args.ends[i]/args.dt[i]), 1]
        elif '.dat' in filePath: # OpenCARP results can be saved in .dat format
            with open(filePath, 'r') as file:
                data = np.loadtxt(file)
                vms = data[int(args.starts[i]/args.dt[i]):int(args.ends[i]/args.dt[i]), -1]   # opencarp results must be save every 1 ms and the Vm is the last column
        else:
            raise ValueError("Unsupported file format: {}".format(filePath))
        

        time = np.arange(args.starts[i]/args.dt[i], args.ends[i]/args.dt[i], 1)
        time = (time - args.starts[i]/args.dt[i]) * args.dt[i]

        # Calculate APDX
        apd = calcAPDXFromV(vms[:, np.newaxis].T, args.dt[i], args.apdType)[0]
        print("APD{0} of {1} is {2:.2f} ms".format(args.apdType, args.names[i], apd))
        args.names[i] = "{0}, APD{1}: {2:.2f}".format(args.names[i], args.apdType, apd)
        
        # Save Vm and time for plotting
        cases[filePath] = {"vms": vms, "time": time, "apd": apd}


    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 10}
    plt.rc('font', **font)
    plt.figure()
    for i, key in enumerate(cases.keys()):
        plt.plot(cases[key]["time"], cases[key]["vms"], label=args.names[i])
    plt.legend(loc="upper right")
    plt.ylabel("Vm (mV)")
    plt.xlabel("time (ms)")
    # plt.show()
    plt.savefig(args.outPath, dpi=400)


if __name__ == '__main__':
    main()