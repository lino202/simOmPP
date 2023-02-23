import os 
import numpy as np
import matplotlib.pyplot as plt
import scipy.io
import argparse

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}
plt.rc('font', **font)



parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--inDatFile',type=str, required=True, help='path to data')
args = parser.parse_args()

v = np.loadtxt(args.inDatFile)[1:,-1]


fig, axes = plt.subplots(1, 1, sharex=False, sharey=False)
axes.plot(v)
axes.set_title("Last AP of 10s with BCL=1000ms")
axes.set_ylabel("V (mV)")
# axes.set_xlabel("t (ms)")
# axes.legend(["Gaur, pig", "O'hara, human (epi)"])
axes.grid()
plt.show(block=True)