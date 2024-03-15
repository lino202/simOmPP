import os  
import argparse
import numpy as np
import matplotlib.pyplot as plt



def main():

    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--filePaths',  type=str, nargs='+', required=True, help='path to data')
    parser.add_argument('--starts',     type=int, nargs='+', required=True, help='')
    parser.add_argument('--ends',       type=int, nargs='+', required=True, help='')
    parser.add_argument('--names',      type=str, nargs='+', required=True, help='')
    parser.add_argument('--dt',         type=float, required=True, help='')
    parser.add_argument('--outPath',    type=str, required=True, help='')
    args = parser.parse_args()

    vms = np.zeros((int((args.ends[0] - args.starts[0] ) / args.dt), len(args.filePaths)))
    for i, filePath in enumerate(args.filePaths):
        with open(filePath, 'r') as file:
            data = np.loadtxt(file)
            vms[:,i] = data[int(args.starts[i]/args.dt):int(args.ends[i]/args.dt), 1]
    

    time = np.arange(args.starts[0]/args.dt, args.ends[0]/args.dt, 1)
    time = time * args.dt


    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}
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