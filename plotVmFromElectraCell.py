import os  
import argparse
import numpy as np
import matplotlib.pyplot as plt


def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--filePath',  type=str, required=True, help='path to data')
    args = parser.parse_args()

    with open(args.filePath, 'r') as file:
        data = np.loadtxt(file)
    
    plt.figure()
    plt.plot(data[:,0], data[:,1])
    plt.ylabel("Vm (mV)")
    plt.xlabel("time (ms)")
    plt.show()


if __name__ == '__main__':
    main()