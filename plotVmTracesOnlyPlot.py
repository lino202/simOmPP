import argparse
import numpy as np
import matplotlib.pyplot as plt
from tqdm import tqdm
import os
import pickle

font = {'family' : "Times New Roman",
'weight' : 'normal',
'size'   : 10}

plt.rc('font', **font)
plt.rcParams.update({'mathtext.default':  'regular' })



def mm_to_inch(mm):
    return mm / 25.4

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--dataPath',        type=str, nargs='+', required=True, help='path to data')
    parser.add_argument('--timeStart',       type=float, required=True, help='start time in ms')
    parser.add_argument('--timeEnd',         type=float, required=True, help='end time in ms')
    parser.add_argument('--dt',              type=float, required=True, help='time step in ms')
    parser.add_argument('--vlines',          type=float, nargs='+', help='time points to add vertical lines')
    parser.add_argument('--nSignals',        type=int, help='total amount of signals to plot')
    parser.add_argument('--outPath',         type=str, required=True, help='path to data')
    args = parser.parse_args()

    # Read pickle data
    # Assuming the dataPath contains paths to multiple pickle files, we will read them and concatenate the data
    # Each pickle file is expected to contain a dictionary with 'time' and 'v' keys
    v = np.zeros((args.nSignals, int((args.timeEnd - args.timeStart) / args.dt) + 1)) # Initialize an empty array for v
    counter = 0
    for i, path in enumerate(args.dataPath):
        with open(path, 'rb') as f: 
            data = pickle.load(f) 

            for j in range(data['v'].shape[0]):

                v[counter,:] = data['v'][j,:] 
                counter += 1

            time = data['time']
    
    # Plot the curves
    width_mm = 140  
    height_mm = 60 
    my_colors = ['#2ca02c', '#9467bd', '#f9db22', '#1f77b4', '#d62728'] # Green, Purple, Yellow, Blue, Red

    # 3. Apply the size here
    plt.figure(figsize=(mm_to_inch(width_mm), mm_to_inch(height_mm)), layout="constrained")

    for i in range(v.shape[0]):
        current_color = my_colors[i % len(my_colors)]
        plt.plot(time, v[i, :], color=current_color, linewidth=1.5)


    for t in args.vlines:
        plt.axvline(x=t, color='black', linestyle='--', linewidth=1, alpha=0.6)

    # Set Y-ticks as requested previously
    plt.yticks([-90, 40]) 
    # plt.legend(loc="upper right")
    plt.ylabel("Vm (mV)")
    plt.xlabel("time (ms)")

    # Note: Avoid bbox_inches='tight' if you need the EXACT mm dimensions preserved
    plt.savefig(args.outPath, dpi=400)

    # save the data for later use if needed 
    with open(args.outPath.replace('.pdf', '.pkl'), 'wb') as f: 
        pickle.dump({'time': time, 'v': v}, f)

if __name__ == '__main__':
    main()