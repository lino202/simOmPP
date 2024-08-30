'''Here we plot a heat map from a dataFrame in excel
'''

import os
import argparse
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd


parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--excelFilePath',type=str, required=True, help='path to data')
parser.add_argument('--sheetName',type=str, required=True)
parser.add_argument('--headerRow',type=int, required=True)
parser.add_argument('--outFolder',type=str, required=True)
args = parser.parse_args()

font = {'family' : "Times New Roman",
    'weight' : 'normal',
    'size'   : 10}
plt.rc('font', **font)
plt.rcParams.update({'mathtext.default':  'regular' })


df = pd.read_excel(args.excelFilePath, sheet_name=args.sheetName, header=args.headerRow)
df = df.loc[df['Region'] == 'overall']
df = df.loc[df['Sample'] != 'DP1']
# df = df.loc[df['Region'] != 'M']
df = df.loc[df['CL (ms)'] == 2000]
df = df.loc[df['Stim'] == 'Trans']
# CV------------------------------------------

# plt.figure()
# sns.catplot(data=df, x="Stim Type", y="median CV", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "CV_stimtype.png"), dpi=500)


# plt.figure()
# sns.catplot(data=df, x="CL (ms)", y="median CV", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "CV_cl.png"), dpi=500)


# plt.figure()
# sns.catplot(data=df, x="Stim", y="median CV", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "CV_stim.png"), dpi=500)


# plt.figure()
# sns.catplot(data=df, x="Sample", y="median CV", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "CV_sample_poresize.png"), dpi=500)

plt.figure()
sns.catplot(data=df, x="Sample", y="median CV", hue="Pore")
plt.savefig(os.path.join(args.outFolder, "CV_sample_poreshape.png"), dpi=500)

# APD----------------------------------------------


# plt.figure()
# sns.catplot(data=df, x="Stim Type", y="median APD90", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "APD90_stimtype.png"), dpi=500)


# plt.figure()
# sns.catplot(data=df, x="CL (ms)", y="median APD90", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "APD90_cl.png"), dpi=500)


# plt.figure()
# sns.catplot(data=df, x="Stim", y="median APD90", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "APD90_stim.png"), dpi=500)


# plt.figure()
# sns.catplot(data=df, x="Sample", y="median APD90", hue="Region")
# plt.savefig(os.path.join(args.outFolder, "APD90_samplesize.png"), dpi=500)

plt.figure()
sns.catplot(data=df, x="Sample", y="median APD90", hue="Pore")
plt.savefig(os.path.join(args.outFolder, "APD90_sample_poreshape.png"), dpi=500)


print("End")








    

