import os  
import argparse
import numpy as np
import meshio
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 10}

plt.rc('font', **font)
plt.rcParams.update({'mathtext.default':  'regular' })

params = ["AT mean", "AT std", "AT min", "AT 10 percentile", "AT 25 percentile", "AT median", "AT 75 percentile", "AT 90 percentile", "AT max", 
          "APD mean", "APD std", "APD min", "APD 10 percentile", "APD 25 percentile", "APD median", "APD 75 percentile", "APD 90 percentile", "APD max", 
          "AT_perc mean", "AT_perc std", "AT_perc min", "AT_perc 10 percentile", "AT_perc 25 percentile", "AT_perc median", "AT_perc 75 percentile", "AT_perc 90 percentile", "AT_perc max", 
          "APD_perc mean", "APD_perc std", "APD_perc min", "APD_perc 10 percentile", "APD_perc 25 percentile", "APD_perc median", "APD_perc 75 percentile", "APD_perc 90 percentile", "APD_perc max"]


def makeHistograms(data1, data2, varName, histSteps, nameData1, nameData2, outPath):
    dataMin = np.min(np.array([np.min(data1), np.min(data2)]))
    dataMax = np.max(np.array([np.max(data1), np.max(data2)]))
    bins = np.linspace(dataMin, dataMax, histSteps)
    fig, ax = plt.subplots()
    ax.hist(data1, bins, alpha=0.5, label=nameData1, color = (0.2039,0.2039, 0.2039), ec = (0.2039,0.2039, 0.2039))
    ax.hist(data2, bins, alpha=0.5, label=nameData2, color = (0.3334,0.6667, 1.0), ec = (0.3334,0.6667, 1.0))
    ax.set_ylabel("Frequency")
    ax.set_xlabel(varName)
    ax.legend(loc='upper right')
    # plt.xlim([dataMin, dataMax])
    # plt.ylim([0, 15000])
    # ax.axis("off")
    plt.savefig(outPath, transparent=False, dpi=400)
    # plt.show()

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--mesh1',  type=str, required=True, help='path to data')
    parser.add_argument('--mesh2',type=str, required=True, help='path to data')
    parser.add_argument('--histSteps',type=int, required=True)
    parser.add_argument('--imgType',type=str, required=True)
    parser.add_argument('--outPath',type=str, required=True)
    args = parser.parse_args()

    mesh1 = meshio.read(args.mesh1)
    mesh2 = meshio.read(args.mesh2)
    ats1  = mesh1.point_data['ATs_(ms)']
    ats2  = mesh2.point_data['ATs_(ms)']
    apds1 = mesh1.point_data['APD90_(ms)']
    apds2 = mesh2.point_data['APD90_(ms)']

    atsError = np.abs(ats1 - ats2)
    apdsError = np.abs(apds1 - apds2)

    atsErrorPerc = np.ones(ats1.shape[0]) * np.nan
    np.divide(np.abs(ats1 - ats2), ats1, out=atsErrorPerc, where=ats1 != 0.)
    atsErrorPerc *= 100

    apdsErrorPerc = np.ones(apds1.shape[0]) * np.nan
    np.divide(np.abs(apds1 - apds2), apds1, out=apdsErrorPerc, where=apds1 != 0.)
    apdsErrorPerc *= 100
    
    # Make plots 
    makeHistograms(ats1, ats2, "AT (ms)", args.histSteps, 'OpenCARP', 'Cocoro', os.path.join(args.outPath,'AT_hists.{}'.format(args.imgType)))
    makeHistograms(apds1, apds2, r'$APD_{90} (ms)$', args.histSteps, 'OpenCARP', 'Cocoro', os.path.join(args.outPath,'APD_hists.{}'.format(args.imgType)))

    sns.set_context("paper", font_scale=3., rc={"lines.linewidth": 1.5})
    plt.figure(figsize=(12,9))
    sns.boxplot(data=[atsError, apdsError], palette="deep")
    plt.xticks(ticks=[0, 1], labels=['AT', r'$APD_{90}$'])
    plt.ylabel('Error (ms)', fontsize=45)
    plt.xlabel('', fontsize=45)
    plt.savefig(os.path.join(args.outPath,'nominal_errors.{}'.format(args.imgType)), dpi=400)

    sns.set_context("paper", font_scale=3., rc={"lines.linewidth": 1.5})
    plt.figure(figsize=(12,9))
    sns.boxplot(data=[atsErrorPerc, apdsErrorPerc], palette="deep")
    plt.xticks(ticks=[0, 1], labels=['AT', r'$APD_{90}$'])
    plt.ylabel('Error (%)', fontsize=45)
    plt.xlabel('', fontsize=45)
    plt.savefig(os.path.join(args.outPath,'percentual_errors.{}'.format(args.imgType)), dpi=400)

    
    # Save Error mesh
    point_data={'AT_error_(ms)': atsError, 'APD90_error_(ms)': apdsError, 'AT_error_(%)': atsErrorPerc, 'APD90_error_(%)': apdsErrorPerc}

    meshError = meshio.Mesh(mesh1.points, mesh1.cells, point_data=point_data)
    meshError.write(os.path.join(args.outPath, 'mesh_atapd_error.vtk'))
    
    # Print some results
    res = {}
    res["AT mean"]          = np.nanmean(atsError)
    res["AT std"]           = np.nanstd(atsError)
    res["AT min"]           = np.nanmin(atsError)
    res["AT 10 percentile"] = np.nanpercentile(atsError, 10)
    res["AT 25 percentile"] = np.nanpercentile(atsError, 25)
    res["AT median"]        = np.nanmedian(atsError)
    res["AT 75 percentile"] = np.nanpercentile(atsError, 75)
    res["AT 90 percentile"] = np.nanpercentile(atsError, 90)
    res["AT max"]           = np.nanmax(atsError)

    res["APD mean"]          = np.nanmean(apdsError)
    res["APD std"]           = np.nanstd(apdsError)
    res["APD min"]           = np.nanmin(apdsError)
    res["APD 10 percentile"] = np.nanpercentile(apdsError, 10)
    res["APD 25 percentile"] = np.nanpercentile(apdsError, 25)
    res["APD median"]        = np.nanmedian(apdsError)
    res["APD 75 percentile"] = np.nanpercentile(apdsError, 75)
    res["APD 90 percentile"] = np.nanpercentile(apdsError, 90)
    res["APD max"]           = np.nanmax(apdsError)

    res["AT_perc mean"]          = np.nanmean(atsErrorPerc)
    res["AT_perc std"]           = np.nanstd(atsErrorPerc)
    res["AT_perc min"]           = np.nanmin(atsErrorPerc)
    res["AT_perc 10 percentile"] = np.nanpercentile(atsErrorPerc, 10)
    res["AT_perc 25 percentile"] = np.nanpercentile(atsErrorPerc, 25)
    res["AT_perc median"]        = np.nanmedian(atsErrorPerc)
    res["AT_perc 75 percentile"] = np.nanpercentile(atsErrorPerc, 75)
    res["AT_perc 90 percentile"] = np.nanpercentile(atsErrorPerc, 90)
    res["AT_perc max"]           = np.nanmax(atsErrorPerc)

    res["APD_perc mean"]          = np.nanmean(apdsErrorPerc)
    res["APD_perc std"]           = np.nanstd(apdsErrorPerc)
    res["APD_perc min"]           = np.nanmin(apdsErrorPerc)
    res["APD_perc 10 percentile"] = np.nanpercentile(apdsErrorPerc, 10)
    res["APD_perc 25 percentile"] = np.nanpercentile(apdsErrorPerc, 25)
    res["APD_perc median"]        = np.nanmedian(apdsErrorPerc)
    res["APD_perc 75 percentile"] = np.nanpercentile(apdsErrorPerc, 75)
    res["APD_perc 90 percentile"] = np.nanpercentile(apdsErrorPerc, 90)
    res["APD_perc max"]           = np.nanmax(apdsErrorPerc)

    # # Save Excel
    # resExcel = os.path.join(args.outPath, 'results_ATAPD.xlsx')
    # stats  = np.ones(len(params)) * np.nan
    # for i, param in enumerate(params):
    #     try:
    #         stats[i] = res[params[i]]
    #     except KeyError:
    #         pass
    # df = pd.DataFrame([stats], index=['unique'], columns=params)
    # if not os.path.exists(resExcel):
    #     df.to_excel(resExcel, sheet_name='sheet1')
    # else:
    #     with pd.ExcelWriter(resExcel, engine="openpyxl", mode='a',if_sheet_exists="overlay") as writer:
    #         startrow = writer.sheets['sheet1'].max_row
    #         df.to_excel(writer, sheet_name='sheet1', startrow=startrow, header=False)

if __name__ == '__main__':
    main()