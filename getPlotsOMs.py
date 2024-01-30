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
    'size'   : 20}
plt.rc('font', **font)
plt.rcParams.update({'mathtext.default':  'regular' })


df = pd.read_excel(args.excelFilePath, sheet_name=args.sheetName, header=args.headerRow)
# df.loc[(df['column_name'] >= A) & (df['column_name'] <= B)]
# df = df.loc[df['Tissue'] != 'Myo']
df = df.loc[df['Pig'] != 2]

# CV------------------------------------------

plt.figure()
sns.catplot(data=df, x="View", y="median CV", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "CV_view.png"), dpi=500)


plt.figure()
sns.catplot(data=df, x="Stimulation Period (ms)", y="median CV", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "CV_stimfreq.png"), dpi=500)


plt.figure()
sns.catplot(data=df, x="Stimulation Type", y="median CV", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "CV_stimtype.png"), dpi=500)


plt.figure()
sns.catplot(data=df, x="Pig", y="median CV", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "CV_pig.png"), dpi=500)

# APD----------------------------------------------


plt.figure()
sns.catplot(data=df, x="View", y="median APD90", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "APD90_view.png"), dpi=500)


plt.figure()
sns.catplot(data=df, x="Stimulation Period (ms)", y="median APD90", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "APD90_stimfreq.png"), dpi=500)


plt.figure()
sns.catplot(data=df, x="Stimulation Type", y="median APD90", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "APD90_stimtype.png"), dpi=500)


plt.figure()
sns.catplot(data=df, x="Pig", y="median APD90", hue="Tissue")
plt.savefig(os.path.join(args.outFolder, "APD90_pig.png"), dpi=500)












    

