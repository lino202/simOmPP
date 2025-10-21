import os  
import argparse
import numpy as np
import vtk
from vtk.util import numpy_support  # type: ignore
import time
from utils import plotHistAndBoxPlotSeaBorn
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter
from scipy.signal import find_peaks
import pandas as pd


def main():

    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--filePath',  type=str, required=True, help='path to data')
    parser.add_argument('--outPath',  type=str, required=True, help='path to data')
    parser.add_argument('--numModes',  type=int, help='says if we should search modes, if 0, no search', default=0)
    parser.add_argument('--binsNum',  type=int, help='number of bins for histogram', default=100)
    parser.add_argument('--resExcel',  type=str, help='path to results excel', default="None")
    args = parser.parse_args()

    reader = vtk.vtkUnstructuredGridReader()
    reader.SetFileName(args.filePath)
    reader.Update()
    mesh    = reader.GetOutput()

    nElems = mesh.GetNumberOfCells()
    nNodes = mesh.GetNumberOfPoints()

    filter = vtk.vtkExtractEdges()
    filter.SetInputData(mesh)
    filter.Update()
    mesh = filter.GetOutput()

    filter = vtk.vtkCellSizeFilter()
    filter.ComputeVertexCountOff()
    filter.ComputeLengthOn()
    filter.SetInputData(mesh)
    filter.Update()
    mesh = filter.GetOutput()

    lengths = vtk.util.numpy_support.vtk_to_numpy(mesh.GetCellData().GetArray('Length'))
    print("The edges lengths are: Mean: {0:.6f}, Median: {1:.6f}, Min: {2:.6f}, Max: {3:.6f}".format(np.mean(lengths), np.median(lengths), np.min(lengths), np.max(lengths)))

    # Find modes ----------------------------------------------------------------
    # Compute histogram
    if args.numModes != 0:
        counts, bin_edges = np.histogram(lengths, bins=args.binsNum)
        bin_centers = (bin_edges[:-1] + bin_edges[1:]) / 2

        # Find peaks
        peaks, _ = find_peaks(counts)

        # Get mode values from bin centers
        modes = bin_centers[peaks]
        modes = modes[0:args.numModes]
        print("Modes:", modes)


    # Plot ---------------------------------------------------------------------------------------------
    # plotHistAndBoxPlotSeaBorn(lengths, "Edge Length (mm)", args.outPath)

    sns.set(style="ticks")
    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 20}

    plt.rc('font', **font)
    plt.rcParams.update({'mathtext.default':  'regular' })
    f, ax_hist = plt.subplots(1)
    # sns.boxplot(x=lengths, ax=ax_box)
    hist_plot = sns.histplot(x=lengths, ax=ax_hist, bins=args.binsNum, kde=True)
    # ax_box.set(yticks=[])
    ax_hist.set_ylabel("Count")
    ax_hist.set_xlabel("Edge Length (mm)")
    ax_hist.ticklabel_format(useOffset=False)
    ax_hist.xaxis.set_major_formatter(FormatStrFormatter('%.1f'))
    sns.despine(ax=ax_hist)

    hist_plot.axvline(np.mean(lengths), color='b')

    if args.numModes != 0:
        for mode in modes:
            hist_plot.axvline(mode, color='g', linestyle='--')
            hist_plot.text(mode, 0.5, str(round(mode, 3)), rotation=90, color='g', fontsize=12)
    # sns.despine(ax=ax_box, left=True)
    plt.savefig(args.outPath, dpi=400) if args.outPath else plt.show(block=True)
    plt.close()

    # Save results to excel ------------------------------------------------
    if args.resExcel != "None":
        results = {'EdgeLength Mean': np.mean(lengths), 
                   'EdgeLength Median': np.median(lengths),
                   'EdgeLength Min': np.min(lengths),
                   'EdgeLength Max': np.max(lengths),
                   'EdgeLength Std': np.std(lengths),
                   'Total NumElems': nElems,
                   'TotalNumNodes': nNodes}
        
        if args.numModes != 0:
            for i in range(args.numModes):
                results['Mode ' + str(i)] = modes[i]

        df = pd.DataFrame(results, index=[args.filePath])
        if not os.path.exists(args.resExcel):
            df.to_excel(args.resExcel, sheet_name='sheet1')
        else:
            with pd.ExcelWriter(args.resExcel, engine="openpyxl", mode='a',if_sheet_exists="overlay") as writer:
                startrow = writer.sheets['sheet1'].max_row
                df.to_excel(writer, sheet_name='sheet1', startrow=startrow, header=False)





if __name__ == '__main__':
    start = time.time()
    main()
    print("Total time was {} s".format(time.time() - start))