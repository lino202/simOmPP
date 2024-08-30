'''Here we plot a heat map from a dataFrame in excel
'''

import os
import argparse
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import copy

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
df = df.loc[df['Sample'] != 'DP1']
df = df.loc[df['Region'] != 'M']


# # Pore size -------------------------------------------------------------------------------------------------------
# # Basal  ---------------------------------
# tmp_df = copy.deepcopy(df)
# tmp_df = tmp_df.loc[tmp_df['Region'] != 'overall']
# tmp_df = tmp_df.loc[tmp_df['Stim'] == 'Basal']

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median CV", hue="Region", palette=sns.color_palette(['darkgreen', 'limegreen']), s=70)
# plt.savefig(os.path.join(args.outFolder, "CV_basal.png"), dpi=500)

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median APD90", hue="Region", palette=sns.color_palette(['darkgreen', 'limegreen']), s=70)
# plt.savefig(os.path.join(args.outFolder, "APD_basal.png"), dpi=500)

# # Stim 1000 ---------------------------------------------------
# tmp_df = copy.deepcopy(df)
# tmp_df = tmp_df.loc[tmp_df['Region'] != 'overall']
# tmp_df = tmp_df.loc[tmp_df['CL (ms)'] == 1000]

# tmp_df['Region_Stim'] = tmp_df['Region'] + '_' + tmp_df['Stim']

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median CV", hue="Region_Stim", palette=sns.color_palette(['darkgreen', 'limegreen', 'darkred', 'lightcoral']), s=70)
# plt.savefig(os.path.join(args.outFolder, "CV_stim_1000.png"), dpi=500)

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median APD90", hue="Region_Stim", palette=sns.color_palette(['darkgreen', 'limegreen', 'darkred', 'lightcoral']), s=70)
# plt.savefig(os.path.join(args.outFolder, "APD_stim_1000.png"), dpi=500)


# # Stim 2000 ---------------------------------------------------
# tmp_df = copy.deepcopy(df)
# tmp_df = tmp_df.loc[tmp_df['Region'] != 'overall']
# tmp_df = tmp_df.loc[tmp_df['CL (ms)'] == 2000]

# tmp_df['Region_Stim'] = tmp_df['Region'] + '_' + tmp_df['Stim']

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median CV", hue="Region_Stim", palette=sns.color_palette(['darkgreen', 'limegreen', 'darkred', 'lightcoral']), s=70)
# plt.savefig(os.path.join(args.outFolder, "CV_stim_2000.png"), dpi=500)

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median APD90", hue="Region_Stim", palette=sns.color_palette(['darkgreen', 'limegreen', 'darkred', 'lightcoral']), s=70)
# plt.savefig(os.path.join(args.outFolder, "APD_stim_2000.png"), dpi=500)

# # Pore shape -----------------------------------------------------------------------------------------
# # Basal 
# tmp_df = copy.deepcopy(df)
# tmp_df = tmp_df.loc[tmp_df['Region'] == 'overall']
# tmp_df = tmp_df.loc[tmp_df['Stim'] == 'Basal']

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median CV", hue="Pore", palette=sns.color_palette(['cornflowerblue', 'lightcoral', 'limegreen',]), s=70)
# plt.savefig(os.path.join(args.outFolder, "CV_basal_shape.png"), dpi=500)

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median APD90", hue="Pore", palette=sns.color_palette(['cornflowerblue', 'lightcoral', 'limegreen']), s=70)
# plt.savefig(os.path.join(args.outFolder, "APD_basal_shape.png"), dpi=500)


# # Stim 1000
# tmp_df = copy.deepcopy(df)
# tmp_df = tmp_df.loc[tmp_df['Region'] == 'overall']
# tmp_df = tmp_df.loc[tmp_df['CL (ms)'] == 1000]

# tmp_df['Pore_Stim'] = tmp_df['Pore'] + '_' + tmp_df['Stim']

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median CV", hue="Pore_Stim", palette=sns.color_palette(['mediumblue', 'cornflowerblue', 'darkred', 'lightcoral', 'darkgreen', 'limegreen']), s=70)
# plt.savefig(os.path.join(args.outFolder, "CV_stim_1000_shape.png"), dpi=500)

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median APD90", hue="Pore_Stim", palette=sns.color_palette(['mediumblue', 'cornflowerblue', 'darkred', 'lightcoral', 'darkgreen', 'limegreen']), s=70)
# plt.savefig(os.path.join(args.outFolder, "APD_stim_1000_shape.png"), dpi=500)


# # Stim 2000
# tmp_df = copy.deepcopy(df)
# tmp_df = tmp_df.loc[tmp_df['Region'] == 'overall']
# tmp_df = tmp_df.loc[tmp_df['CL (ms)'] == 2000]

# tmp_df['Pore_Stim'] = tmp_df['Pore'] + '_' + tmp_df['Stim']

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median CV", hue="Pore_Stim", palette=sns.color_palette(['mediumblue', 'cornflowerblue', 'darkred', 'lightcoral', 'darkgreen', 'limegreen']), s=70)
# plt.savefig(os.path.join(args.outFolder, "CV_stim_2000_shape.png"), dpi=500)

# plt.figure()
# sns.catplot(data=tmp_df, x="Sample", y="median APD90", hue="Pore_Stim", palette=sns.color_palette(['mediumblue', 'cornflowerblue', 'darkred', 'lightcoral', 'darkgreen', 'limegreen']), s=70)
# plt.savefig(os.path.join(args.outFolder, "APD_stim_2000_shape.png"), dpi=500)

# ------------------------------------------------
print("Getting simpler relative results")

# # Basal  ---------------------------------
# tmp_df = copy.deepcopy(df)
# tmp_df = tmp_df.loc[tmp_df['Region'] != 'overall']
# tmp_df = tmp_df.loc[tmp_df['Stim'] == 'Basal']

# ll = tmp_df.loc[tmp_df['Region'] == 'L'].reset_index()
# ss = tmp_df.loc[tmp_df['Region'] == 'S'].reset_index()

# tmp_df = tmp_df.drop('Region', axis=1)
# tmp_df = tmp_df.drop('median CV', axis=1)
# tmp_df = tmp_df.drop('median APD90', axis=1)
# tmp_df = tmp_df.drop_duplicates().reset_index()

# tmp_df['percentual relative CV']  = -1*(ll['median CV'] - ss['median CV']) / ll['median CV'] * 100
# tmp_df['percentual relative APD90']  = (ll['median APD90'] - ss['median APD90']) / ll['median APD90'] * 100

# plt.figure()
# fig = sns.catplot(data=tmp_df, x="Sample", y="percentual relative CV", palette=sns.color_palette(['limegreen']), s=70)
# fig.refline(y=0, color='black')
# plt.savefig(os.path.join(args.outFolder, "relative_CV_basal.png"), dpi=500)

# plt.figure()
# fig = sns.catplot(data=tmp_df, x="Sample", y="percentual relative APD90", palette=sns.color_palette(['limegreen']), s=70)
# fig.refline(y=0, color='black')
# plt.savefig(os.path.join(args.outFolder, "relative_APD_basal.png"), dpi=500)



# Stim 1000  ---------------------------------
tmp_df = copy.deepcopy(df)
tmp_df = tmp_df.loc[tmp_df['Region'] != 'overall']
tmp_df = tmp_df.loc[tmp_df['CL (ms)'] == 1000]

# tmp_df['Region_Stim'] = tmp_df['Region'] + '_' + tmp_df['Stim']

ll = tmp_df.loc[tmp_df['Region'] == 'L'].reset_index()
ss = tmp_df.loc[tmp_df['Region'] == 'S'].reset_index()

tmp_df = tmp_df.drop('Region', axis=1)
tmp_df = tmp_df.drop('median CV', axis=1)
tmp_df = tmp_df.drop('median APD90', axis=1)
tmp_df = tmp_df.drop_duplicates().reset_index()

tmp_df['percentual relative CV']  = -1*(ll['median CV'] - ss['median CV']) / ll['median CV'] * 100
tmp_df['percentual relative APD90']  = (ll['median APD90'] - ss['median APD90']) / ll['median APD90'] * 100

# we delete long and trans by doing the mean this can be commented and hue='Stim' added but for me is better this way
ll = tmp_df.loc[tmp_df['Stim'] == 'Long'].reset_index()
ss = tmp_df.loc[tmp_df['Stim'] == 'Trans'].reset_index()

tmp_df = tmp_df.drop('Stim', axis=1)
tmp_df = tmp_df.drop('index', axis=1)
tmp_df = tmp_df.drop('percentual relative CV', axis=1)
tmp_df = tmp_df.drop('percentual relative APD90', axis=1)
tmp_df = tmp_df.drop_duplicates().reset_index()

tmp_df['percentual relative CV'] = (ll['percentual relative CV']+ss['percentual relative CV'])/2
tmp_df['percentual relative APD90'] = (ll['percentual relative APD90']+ss['percentual relative APD90'])/2

plt.figure()
fig = sns.catplot(data=tmp_df, x="Sample", y="percentual relative CV", palette=sns.color_palette(['limegreen']), s=70)
fig.refline(y=0, color='black')
plt.savefig(os.path.join(args.outFolder, "relative_CV_stim_1000.png"), dpi=500)

plt.figure()
fig = sns.catplot(data=tmp_df, x="Sample", y="percentual relative APD90", palette=sns.color_palette(['limegreen']), s=70)
fig.refline(y=0, color='black')
plt.savefig(os.path.join(args.outFolder, "relative_APD_stim_1000.png"), dpi=500)




# Stim 2000  ---------------------------------
tmp_df = copy.deepcopy(df)
tmp_df = tmp_df.loc[tmp_df['Region'] != 'overall']
tmp_df = tmp_df.loc[tmp_df['CL (ms)'] == 2000]

# tmp_df['Region_Stim'] = tmp_df['Region'] + '_' + tmp_df['Stim']

ll = tmp_df.loc[tmp_df['Region'] == 'L'].reset_index()
ss = tmp_df.loc[tmp_df['Region'] == 'S'].reset_index()

tmp_df = tmp_df.drop('Region', axis=1)
tmp_df = tmp_df.drop('median CV', axis=1)
tmp_df = tmp_df.drop('median APD90', axis=1)
tmp_df = tmp_df.drop_duplicates().reset_index()

tmp_df['percentual relative CV']  = -1*(ll['median CV'] - ss['median CV']) / ll['median CV'] * 100
tmp_df['percentual relative APD90']  = (ll['median APD90'] - ss['median APD90']) / ll['median APD90'] * 100

# we delete long and trans by doing the mean this can be commented and hue='Stim' added but for me is better this way
ll = tmp_df.loc[tmp_df['Stim'] == 'Long'].reset_index()
ss = tmp_df.loc[tmp_df['Stim'] == 'Trans'].reset_index()

tmp_df = tmp_df.drop('Stim', axis=1)
tmp_df = tmp_df.drop('index', axis=1)
tmp_df = tmp_df.drop('percentual relative CV', axis=1)
tmp_df = tmp_df.drop('percentual relative APD90', axis=1)
tmp_df = tmp_df.drop_duplicates().reset_index()

tmp_df['percentual relative CV'] = (ll['percentual relative CV']+ss['percentual relative CV'])/2
tmp_df['percentual relative APD90'] = (ll['percentual relative APD90']+ss['percentual relative APD90'])/2

plt.figure()
fig = sns.catplot(data=tmp_df, x="Sample", y="percentual relative CV", palette=sns.color_palette(['limegreen']), s=70)
fig.refline(y=0, color='black')
plt.savefig(os.path.join(args.outFolder, "relative_CV_stim_2000.png"), dpi=500)

plt.figure()
fig = sns.catplot(data=tmp_df, x="Sample", y="percentual relative APD90", palette=sns.color_palette(['limegreen']), s=70)
fig.refline(y=0, color='black')
plt.savefig(os.path.join(args.outFolder, "relative_APD_stim_2000.png"), dpi=500)
    

