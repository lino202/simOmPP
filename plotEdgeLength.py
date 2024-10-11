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

def main():

    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--filePath',  type=str, required=True, help='path to data')
    parser.add_argument('--outPath',  type=str, required=True, help='path to data')
    args = parser.parse_args()

    reader = vtk.vtkUnstructuredGridReader()
    reader.SetFileName(args.filePath)
    reader.Update()
    mesh    = reader.GetOutput()

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

    # plotHistAndBoxPlotSeaBorn(lengths, "Edge Length (mm)", args.outPath)

    binsNum = 100

    sns.set(style="ticks")
    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 20}

    plt.rc('font', **font)
    plt.rcParams.update({'mathtext.default':  'regular' })
    f, ax_hist = plt.subplots(1)
    # sns.boxplot(x=lengths, ax=ax_box)
    hist_plot = sns.histplot(x=lengths, ax=ax_hist, bins=binsNum, kde=True)
    # ax_box.set(yticks=[])
    ax_hist.set_ylabel("Count")
    ax_hist.set_xlabel("Edge Length (mm)")
    ax_hist.ticklabel_format(useOffset=False)
    ax_hist.xaxis.set_major_formatter(FormatStrFormatter('%.1f'))
    sns.despine(ax=ax_hist)

    hist_plot.axvline(np.mean(lengths), color='b')
    # sns.despine(ax=ax_box, left=True)
    plt.savefig(args.outPath, dpi=400) if args.outPath else plt.show(block=True)
    plt.close()



if __name__ == '__main__':
    start = time.time()
    main()
    print("Total time was {} s".format(time.time() - start))