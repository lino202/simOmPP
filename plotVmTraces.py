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
    parser.add_argument('--dataPath',        type=str, required=True, help='path to data')
    parser.add_argument('--pointIdxs',       type=int, nargs='+', required=True, help='indices of points to plot')
    parser.add_argument('--vlines',          type=float, nargs='+', help='time points to add vertical lines')
    parser.add_argument('--timeStart',       type=float, required=True, help='start time in ms')
    parser.add_argument('--timeEnd',         type=float, required=True, help='end time in ms')
    parser.add_argument('--dt',              type=float, required=True, help='time step in ms')
    parser.add_argument('--nDigits',         type=int, required=True, help='number of digits in file names')
    parser.add_argument('--soluName',        type=str, help='solution name in file names', default='tissue_solution')
    parser.add_argument('--outPath',         type=str, required=True, help='path to data')
    args = parser.parse_args()

    fileNumbers = np.arange(args.timeStart/args.dt, args.timeEnd/args.dt + 1 ).astype(int)
    v = np.zeros((len(args.pointIdxs), fileNumbers.shape[0]), dtype=np.float32) #Electra's results precision is single (32 bits)
    
    for i, fileNumber in tqdm(enumerate(fileNumbers)):
        fileName = os.path.join(args.dataPath, '{}{}.ens'.format(args.soluName, str(fileNumber).zfill(args.nDigits)))
        with open(fileName, 'rb') as f:
            b = f.read()

        # See ensight variable file format 244 bytes before the first v value, and little endian
        # Electra save states in float32, offset is in bytes but count is items not bytes
        # https://docs.python.org/3/library/struct.html#format-characters
        allVs = np.frombuffer(b, dtype='<f', offset=244, count=-1) # Read all values and then select the ones we need
        v[:, i] = allVs[args.pointIdxs]

    
    # Plot the curves
    width_mm = 140  
    height_mm = 60 
    my_colors = ['#2ca02c', '#9467bd', '#f9db22', '#1f77b4', '#d62728'] # Green, Purple, Yellow, Blue, Red

    time = np.arange(0, args.timeEnd - args.timeStart + args.dt, args.dt)

    # 3. Apply the size here
    plt.figure(figsize=(mm_to_inch(width_mm), mm_to_inch(height_mm)), layout="constrained")

    for i in range(v.shape[0]):
        current_color = my_colors[i % len(my_colors)]
        plt.plot(time, v[i, :], label=args.pointIdxs[i], color=current_color, linewidth=1.5)


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