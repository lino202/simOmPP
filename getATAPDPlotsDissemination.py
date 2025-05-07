import os  
import argparse
import numpy as np
import meshio
import matplotlib.pyplot as plt

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 10}

plt.rc('font', **font)
plt.rcParams.update({'mathtext.default':  'regular' })

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--meshes',  type=str, nargs='+', required=True, help='path to data')
    parser.add_argument('--meshNames',  type=str, nargs='+', required=True, help='path to data')
    parser.add_argument('--imgType',type=str, required=True)
    parser.add_argument('--outPath',type=str, required=True)
    args = parser.parse_args()


    # color_pairs = {
    #     0: (0.0, 0.0, 0.2),  # light blue
    #     1: (0.0, 0.0, 0.6),      # dark blue
    #     2: (0.2, 0.0, 0.0),  # light coral
    #     3: (0.6, 0.0, 0.0),      # dark red
    # }

    # color_pairs = {
    #     0: (0.121, 0.466, 0.705),  # blue
    #     # 1: (1.0, 0.498, 0.054),    # orange
    #     # 2: (0.172, 0.627, 0.172),  # green
    #     1: (0.839, 0.153, 0.157),  # red
    # }

    color_pairs = {
        0: (0.121, 0.466, 0.705),  # blue
        # 1: (1.0, 0.498, 0.054),    # orange
        # 2: (0.172, 0.627, 0.172),  # green
        1: (0.839, 0.153, 0.157),  # red
    }

    ats_dict = {}
    apds_dict = {}
    ats_total = np.array([])
    apds_total = np.array([])
    for i, meshPath in enumerate(args.meshes):
        mesh = meshio.read(meshPath)

        ats = mesh.point_data['ATs_(ms)']
        ats_dict[args.meshNames[i]] = ats
        ats_total = np.concatenate((ats_total, ats)) if ats_total.size else ats

        apds = mesh.point_data['APD90_(ms)']
        apds_dict[args.meshNames[i]] = apds
        apds_total = np.concatenate((apds_total, apds)) if apds_total.size else apds


    # ----------------------------------------- ATs-------------------------------------------
    fig1, ax1 = plt.subplots()
    dataMin = np.min(ats_total)
    dataMax = np.max(ats_total)
    bins = np.linspace(dataMin, dataMax, 65)
    
    for i, meshPath in enumerate(args.meshes):

        ax1.hist(ats_dict[args.meshNames[i]], bins, alpha=0.5, label=args.meshNames[i], color = color_pairs[i], ec = color_pairs[i])
    
    ax1.set_ylabel("Frequency")
    ax1.set_xlabel("AT (ms)")
    ax1.legend(loc='upper right')
    plt.xlim([dataMin, dataMax])
    # plt.ylim([0, 15000])
    # ax1.axis("off")
    plt.savefig(os.path.join(args.outPath,'final_AT_hists.{}'.format(args.imgType)), transparent=False, dpi=400)
    # plt.show()


    # ----------------------------------------- APDs-------------------------------------------
    fig2, ax2 = plt.subplots()
    dataMin = np.min(apds_total)
    dataMax = np.max(apds_total)
    bins = np.linspace(dataMin, dataMax, 42)
    
    for i, meshPath in enumerate(args.meshes):

        ax2.hist(apds_dict[args.meshNames[i]], bins, alpha=0.5, label=args.meshNames[i], color = color_pairs[i], ec = color_pairs[i])
    
    ax2.set_ylabel("Frequency")
    ax2.set_xlabel(r'$APD_{90} (ms)$')
    ax2.legend(loc='upper right')
    plt.xlim([dataMin, dataMax])
    # plt.ylim([0, 15000])
    # ax2.axis("off")
    plt.savefig(os.path.join(args.outPath,'final_APD_hists.{}'.format(args.imgType)), transparent=False, dpi=400)
    # plt.show()
    

if __name__ == '__main__':
    main()