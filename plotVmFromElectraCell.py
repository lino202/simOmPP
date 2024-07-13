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
    parser.add_argument('--dt',         type=float, required=True, help='')
    parser.add_argument('--apdType',    type=int, required=True, help='')
    parser.add_argument('--outPath',    type=str, required=True, help='')
    args = parser.parse_args()

    vms = np.zeros((int((args.ends[0] - args.starts[0] ) / args.dt), len(args.filePaths)))
    for i, filePath in enumerate(args.filePaths):
        # with open(filePath, 'r') as file:
        #     data = np.loadtxt(file)
        #     vms[:,i] = data[int(args.starts[i]/args.dt):int(args.ends[i]/args.dt), 1]
        with h5py.File(filePath, "r") as f:
            vm = np.asarray(f['V'])   # f['time'] can be also obtained
            vm = np.squeeze(vm)
            vms[:,i] = vm[int(args.starts[i]/args.dt):int(args.ends[i]/args.dt)]

    time = np.arange(args.starts[0]/args.dt, args.ends[0]/args.dt, 1)
    time = (time - args.starts[0]/args.dt) * args.dt

    apds = calcAPDXFromV(vms.T, args.dt, args.apdType)
    for i in range(vms.shape[1]):
        args.names[i] = "{0}, APD{1} {2:.2f}".format(args.names[i], args.apdType, apds[i])
        print(args.names[i])

    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 10}
    plt.rc('font', **font)
    plt.figure()
    for i in range(vms.shape[1]):
        plt.plot(time, vms[:,i], label=args.names[i])
    plt.legend(loc="upper right")
    plt.ylabel("Vm (mV)")
    plt.xlabel("time (ms)")
    # plt.show()
    plt.savefig(args.outPath, dpi=400)


if __name__ == '__main__':
    main()