"""Here we get statistics for scalar maps obtained from dti with the segemetation of the myo and scar,
usually Mean Diffusivity (MD -> the mean eigen value = (lambda1 + lambda2 + lambda 3) /3) and FA maps obtained with Slicer. 
See implementations in https://github.com/Slicer/Slicer/blob/861bc7e61a5aea3b556a907c92d585fdcb581463/Libs/vtkTeem/vtkDiffusionTensorMathematics.cxx#L1069
Also an explanation of what MD and FA see is on https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7975803/

The segmentation needs to be a label in order to save both
the scalar map and the label as .nii and the label should have 0 values as background, 1 as myo, 2 as scar
not used overlapped combination of both cause only one value will be saved

Here we plot nicely and for both variables MD and FA"""

import numpy as np
import os
import argparse
import nibabel as nib
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--dataPath',    type=str, required=True, help='path to file and file name')
parser.add_argument('--resExcel',    type=str, required=True, help='path to file and file name')
args = parser.parse_args()

mdMapPath = os.path.join(args.dataPath, "mean_diff.nii")
faMapPath = os.path.join(args.dataPath, "fa.nii")
labelMapPath = os.path.join(args.dataPath, "label_hemi.nii")
mdMapArray = nib.load(mdMapPath).get_fdata()
faMapArray = nib.load(faMapPath).get_fdata()
labelMapArray = nib.load(labelMapPath).get_fdata()

slices = np.linspace(0, labelMapArray.shape[2]-1,30).astype(int)
f = plt.figure()
for i, s in enumerate(slices):
    ax = f.add_subplot(5,6,i+1)
    ax.imshow(labelMapArray[:,:,s])
    ax.set_title("HE should be 1 and MI 2")
plt.show(block=True)

idxsHE = np.where(labelMapArray==1)
nHE    = idxsHE[0].shape[0]
idxsMI = np.where(labelMapArray==2)
nMI    = idxsMI[0].shape[0]

mds = np.concatenate((mdMapArray[idxsHE], mdMapArray[idxsMI]))
fas = np.concatenate((faMapArray[idxsHE], faMapArray[idxsMI]))

tissues = ["HE"] * nHE
tissues += ["MI"] * nMI

df = pd.DataFrame({"Mean Diffusivity": mds, "Fractional Anysotropy": fas, "Tissue": tissues})

sns.set(style="ticks")
font = {'family' : "Times New Roman",
    'weight' : 'normal',
    'size'   : 60}

plt.rc('font', **font)
plt.rcParams.update({'mathtext.default':  'regular' })

plt.figure()
sns.histplot(df, x="Mean Diffusivity", hue="Tissue", bins=50, hue_order=["MI","HE"], palette=["C1", "C0"])
plt.savefig(os.path.join(args.dataPath, "results_MDFA", "hist_mds.png"), transparent=False, dpi=400)
plt.show(block=True)

plt.figure()
sns.histplot(df, x="Fractional Anysotropy", hue="Tissue", bins=50,  hue_order=["MI","HE"], palette=["C1", "C0"])
plt.savefig(os.path.join(args.dataPath, "results_MDFA", "hist_fas.png"), transparent=False, dpi=400)
plt.show(block=True)

plt.figure()
sns.boxplot(data=df, y="Mean Diffusivity", x="Tissue", orient='v')
plt.savefig(os.path.join(args.dataPath, "results_MDFA", "boxplot_mds.png"), transparent=False, dpi=400)
plt.show(block=True)


plt.figure()
sns.boxplot(data=df, y="Fractional Anysotropy", x="Tissue", orient='v')
plt.savefig(os.path.join(args.dataPath, "results_MDFA", "boxplot_fas.png"), transparent=False, dpi=400)
plt.show(block=True)


# Calculate params
res = {}
# params = ["MD HE mean", "MD HE std", "MD HE median", "MD HE min", "MD HE max", 
#           "MD MI mean", "MD MI std", "MD MI median", "MD MI min", "MD MI max",
#           "FA HE mean", "FA HE std", "FA HE median", "FA HE min", "FA HE max", 
#           "FA MI mean", "FA MI std", "FA MI median", "FA MI min", "FA MI max"]

params = ["MD HE mean", "MD HE std", "MD HE median", 
          "MD MI mean", "MD MI std", "MD MI median",
          "FA HE mean", "FA HE std", "FA HE median", 
          "FA MI mean", "FA MI std", "FA MI median"]

res["MD HE mean"]   = np.nanmean(mdMapArray[idxsHE])
res["MD HE std"]    = np.nanstd(mdMapArray[idxsHE])
res["MD HE median"] = np.nanmedian(mdMapArray[idxsHE])
# res["MD HE min"]    = np.nanmin(mdMapArray[idxsHE])
# res["MD HE max"]    = np.nanmax(mdMapArray[idxsHE])

res["MD MI mean"]   = np.nanmean(mdMapArray[idxsMI])
res["MD MI std"]    = np.nanstd(mdMapArray[idxsMI])
res["MD MI median"] = np.nanmedian(mdMapArray[idxsMI])
# res["MD MI min"]    = np.nanmin(mdMapArray[idxsMI])
# res["MD MI max"]    = np.nanmax(mdMapArray[idxsMI])


res["FA HE mean"]   = np.nanmean(faMapArray[idxsHE])
res["FA HE std"]    = np.nanstd(faMapArray[idxsHE])
res["FA HE median"] = np.nanmedian(faMapArray[idxsHE])
# res["FA HE min"]    = np.nanmin(faMapArray[idxsHE])
# res["FA HE max"]    = np.nanmax(faMapArray[idxsHE])

res["FA MI mean"]   = np.nanmean(faMapArray[idxsMI])
res["FA MI std"]    = np.nanstd(faMapArray[idxsMI])
res["FA MI median"] = np.nanmedian(faMapArray[idxsMI])
# res["FA MI min"]    = np.nanmin(faMapArray[idxsMI])
# res["FA MI max"]    = np.nanmax(faMapArray[idxsMI])

#Save--------------------------------------------------------------------
indexs = ["_".join(args.dataPath.split("/")[-3:])]
stats  = np.ones(len(params)) * np.nan
for i, param in enumerate(params):
    try:
        stats[i] = res[params[i]]
    except KeyError:
        pass
df = pd.DataFrame([stats], index=indexs, columns=params)
if not os.path.exists(args.resExcel):
    df.to_excel(args.resExcel, sheet_name='sheet1')
else:
    with pd.ExcelWriter(args.resExcel, engine="openpyxl", mode='a',if_sheet_exists="overlay") as writer:
        startrow = writer.sheets['sheet1'].max_row
        df.to_excel(writer, sheet_name='sheet1', startrow=startrow, header=False)