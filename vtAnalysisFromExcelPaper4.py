import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import argparse 
import os
import copy
import plotly.express as px
import plotly.graph_objects as go


font = {'family' : "Times New Roman",
    'weight' : 'normal',
    'size'   : 10}
plt.rc('font', **font)
plt.rcParams.update({'mathtext.default':  'regular' })

def custom_logic(value):
    if pd.isna(value):
        return value
    
    if value == "x":
        return "NC"
    elif "unsustained" in value:
        return "UVT"
    elif "no" in value:
        return "NR"
    else:
        return "VT"  # for unknown or irrelevant values
    
def createEHTPositionColumn(value):
    if "EHT1" in value:
        return "EHT1"
    elif "EHT2" in value:
        return "EHT2"
    else:
        return "No EHT"
    
def createStateColumn(value):
    if not "EHT" in value:
        return "MI"
    else:
        return "MI-EHT"
    
def createConductivityColumn(value):
    if ("EHT1L" in value) or ("EHT2L" in value):
        return "Low_c"
    elif ("EHT1H" in value) or ("EHT2H" in value):
        return "High_c"
    else:
        return "No EHT"
    
replacement = {
    "s2 295ms": "No EHT",
    "EHT1L s2 295ms": "EHT1L",
    "EHT2L s2 295ms": "EHT2L",
    "EHT1H s2 295ms": "EHT1H",
    "EHT2H s2 295ms": "EHT2H",
    "without CS": "No CS",
}

replacement2 = {
    "NC": 0,
    "NR": 0,
    "UVT": 1,
    "VT": 3,
}



def addHorizontalLinesToPlot(fig):
    # Get the matplotlib Axes
    try:
        fig._legend.remove()  # Remove the default legend
    except AttributeError:
        pass
    ax = fig.ax

    # Add horizontal lines
    ax.axhline(0.33, ls='--', color='gray', label='All UVT')
    ax.axhline(1.00, ls='--', color='black', label='All VT')

    # Add a legend for the horizontal lines
    # First combine with the existing legend handles/labels
    handles, labels = ax.get_legend_handles_labels()
    ax.legend(handles, labels, loc='center left', bbox_to_anchor=(0.9, 0.5))


def main():
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--excelFile',  type=str, required=True, help='path to data')
    parser.add_argument('--outPath',type=str, required=True, help='path to data')
    args = parser.parse_args()

    # Load the Excel file
    df_categories = pd.read_excel(args.excelFile, sheet_name='Main', header=15, usecols='A,C,D,E,F,G,H,K,O,T,W,Z')
    df_categories = df_categories.dropna(how='all')
    
    # Change the values to the three main categories
    columns_to_change = ["s2 250ms", "s2 265ms", "s2 280ms", "s2 295ms", "EHT1L s2 295ms", "EHT2L s2 295ms", "EHT1H s2 295ms", "EHT2H s2 295ms", "without CS"]
    for col in columns_to_change:
        df_categories[col] = df_categories[col].apply(custom_logic)

    # Make some plots 
    # MI versus all MI arrhtymias -> evaluates arrhtymicity on the MI baseline ---------------------------------------------------------
    tmp_df = copy.deepcopy(df_categories)
    tmp_df = tmp_df.melt(id_vars=["pig", "MI"], value_vars=["s2 265ms", "s2 280ms", "s2 295ms"]) # we put all together and drop the Not captured values
    tmp_df = tmp_df.loc[tmp_df["value"] != "NC"]
    # tmp_df = tmp_df.loc[tmp_df["value"] != "NR"]


    sns.catplot(data=tmp_df, x="MI", y="pig", hue="value", kind="swarm", s=60)
    plt.savefig(os.path.join(args.outPath, "figure1.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure1.pdf"), dpi=500)
    # plt.show()

    # MI on baseline no patch and EHT1 and EHT2 -------------------------------------------------------------------------------------
    # We pass results to numbers:
    # NR = 0, UVT = 1, VT = 2 NC = 0 
    
    tmp_df = copy.deepcopy(df_categories)
    tmp_df = tmp_df.melt(id_vars=["pig", "MI"], value_vars=["s2 295ms", "EHT1L s2 295ms", "EHT2L s2 295ms"]) # we put all together and drop the Not captured values
    tmp_df = tmp_df.loc[tmp_df["value"] != "NC"]
    tmp_df = tmp_df.dropna(how='any')
    tmp_df["variable"] = tmp_df["variable"].map(replacement)
    tmp_df["value"]    = tmp_df["value"].map(replacement2)

    tmp_df = tmp_df.rename(columns={"value": "Inducibility"})

    tmp_df1 = tmp_df.groupby(["pig", "variable"])["Inducibility"].mean().reset_index()
    tmp_df1['Inducibility'] = tmp_df1['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    tmp_df1['pig'] = tmp_df1['pig'].astype(int)
    fig2 = sns.catplot(data=tmp_df1, x="pig", y="Inducibility", hue="variable", kind="bar", hue_order=["No EHT", "EHT1L", "EHT2L"])
    addHorizontalLinesToPlot(fig2)
    plt.savefig(os.path.join(args.outPath, "figure2.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure2.pdf"), dpi=500)


    tmp_df2 = tmp_df.groupby(["MI", "variable"])["Inducibility"].mean().reset_index()
    tmp_df2['Inducibility'] = tmp_df2['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    fig2b = sns.catplot(data=tmp_df2, x="MI", y="Inducibility", hue="variable", kind="bar", hue_order=["No EHT", "EHT1L", "EHT2L"])
    addHorizontalLinesToPlot(fig2b)
    plt.savefig(os.path.join(args.outPath, "figure2b.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure2b.pdf"), dpi=500)
    # plt.show()


    # with and without CS -------------------------------------------------------------------------------------
    tmp_df = copy.deepcopy(df_categories)
    tmp_df = tmp_df.melt(id_vars=["pig", "MI"], value_vars=["s2 295ms", "without CS"])
    tmp_df = tmp_df.loc[tmp_df["value"] != "NC"]
    tmp_df = tmp_df.dropna(how='any')
    tmp_df['pig'] = tmp_df['pig'].astype(int)
    tmp_df = tmp_df[tmp_df["pig"].isin([6, 7, 11, 12])]

    tmp_df["variable"] = tmp_df["variable"].map({"s2 295ms": "With CS", "without CS": "Without CS"})

    sns.catplot(data=tmp_df, x="variable", y="pig", hue="value", kind="swarm", s=60, hue_order=["NR", "UVT", "VT"])
    plt.savefig(os.path.join(args.outPath, "figure3.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure3.pdf"), dpi=500)

    tmp_df["value"]    = tmp_df["value"].map(replacement2)
    tmp_df = tmp_df.rename(columns={"value": "Inducibility"})

    tmp_df1 = tmp_df.groupby(["pig", "variable"])["Inducibility"].mean().reset_index()
    tmp_df1['Inducibility'] = tmp_df1['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    fig3b = sns.catplot(data=tmp_df1, x="pig", y="Inducibility", hue="variable", kind="bar")
    addHorizontalLinesToPlot(fig3b)
    plt.savefig(os.path.join(args.outPath, "figure3b.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure3b.pdf"), dpi=500)


    tmp_df2 = tmp_df.groupby(["MI", "variable"])["Inducibility"].mean().reset_index()
    tmp_df2['Inducibility'] = tmp_df2['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    fig3c = sns.catplot(data=tmp_df2, x="MI", y="Inducibility", hue="variable", kind="bar")
    addHorizontalLinesToPlot(fig3c)
    plt.savefig(os.path.join(args.outPath, "figure3c.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure3c.pdf"), dpi=500)


    # More conductive EHT1 and EHT2 -------------------------------------------------------------------------------------
    tmp_df = copy.deepcopy(df_categories)
    tmp_df = tmp_df[["pig", "MI", "s2 295ms", "EHT1L s2 295ms", "EHT2L s2 295ms", "EHT1H s2 295ms", "EHT2H s2 295ms"]]
    tmp_df = tmp_df.dropna(how='any')
    tmp_df = tmp_df.melt(id_vars=["pig", "MI"], value_vars=["s2 295ms", "EHT1L s2 295ms", "EHT2L s2 295ms", "EHT1H s2 295ms", "EHT2H s2 295ms"])
    tmp_df["variable"] = tmp_df["variable"].map(replacement)
    tmp_df['pig'] = tmp_df['pig'].astype(int)

    sns.catplot(data=tmp_df, x="variable", y="pig", hue="value", kind="swarm", s=60, hue_order=["NR", "UVT", "VT"])
    plt.savefig(os.path.join(args.outPath, "figure4.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure4.pdf"), dpi=500)

    tmp_df["value"]    = tmp_df["value"].map(replacement2)
    tmp_df = tmp_df.rename(columns={"value": "Inducibility"})

    tmp_df1 = tmp_df.groupby(["pig", "variable"])["Inducibility"].mean().reset_index()
    tmp_df1 = tmp_df1.loc[tmp_df1['variable'] != 'No EHT']
    tmp_df1['Inducibility'] = tmp_df1['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    fig4b = sns.catplot(data=tmp_df1, x="pig", y="Inducibility", hue="variable", kind="bar", hue_order=["No EHT", "EHT1L", "EHT1H", "EHT2L", "EHT2H"])
    addHorizontalLinesToPlot(fig4b)
    plt.savefig(os.path.join(args.outPath, "figure4b.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure4b.pdf"), dpi=500)


    tmp_df2 = tmp_df.groupby(["MI", "variable"])["Inducibility"].mean().reset_index()
    tmp_df2['Inducibility'] = tmp_df2['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    fig4c = sns.catplot(data=tmp_df2, x="MI", y="Inducibility", hue="variable", kind="bar", hue_order=["No EHT", "EHT1L", "EHT1H", "EHT2L", "EHT2H"])
    addHorizontalLinesToPlot(fig4c)
    plt.savefig(os.path.join(args.outPath, "figure4c.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure4c.pdf"), dpi=500)

    tmp_df3 = tmp_df.groupby(["variable"])["Inducibility"].mean().reset_index()
    tmp_df3['Inducibility'] = tmp_df3['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    fig4d = sns.catplot(data=tmp_df3, x="variable", y="Inducibility", kind="bar", order=["No EHT", "EHT1L", "EHT1H", "EHT2L", "EHT2H"])
    addHorizontalLinesToPlot(fig4d)
    plt.savefig(os.path.join(args.outPath, "figure4d.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure4d.pdf"), dpi=500)

    tmp_df4 = tmp_df.groupby(["MI", "variable"])["Inducibility"].mean().reset_index()
    tmp_df4['Inducibility'] = tmp_df4['Inducibility'] / 3    # so due to the assigned we have 3 for the maximum arrhthmicity and 0 for none at all so we normalize to have 0-1 range
    fig4e = sns.catplot(data=tmp_df4, x="variable", y="Inducibility", hue="MI", kind="bar", order=["No EHT", "EHT1L", "EHT1H", "EHT2L", "EHT2H"])
    addHorizontalLinesToPlot(fig4e)
    plt.savefig(os.path.join(args.outPath, "figure4e.png"), dpi=500)
    plt.savefig(os.path.join(args.outPath, "figure4e.pdf"), dpi=500)


    # check plotly radar for pigs ------------------------------------------------------------------------------------------
    tmp_df = copy.deepcopy(df_categories)
    tmp_df = tmp_df.melt(id_vars=["pig", "MI"], value_vars=["s2 265ms", "s2 280ms", "s2 295ms", "EHT1L s2 295ms", "EHT2L s2 295ms", "EHT1H s2 295ms", "EHT2H s2 295ms"])
    tmp_df = tmp_df.loc[tmp_df["value"] != "NC"]
    tmp_df = tmp_df.dropna(how='any')
    tmp_df["value"]    = tmp_df["value"].map(replacement2)
    tmp_df = tmp_df.rename(columns={"value": "Inducibility"})
    tmp_df['pig'] = tmp_df['pig'].astype(int).astype(str)

    tmp_df = tmp_df.groupby(["pig"])["Inducibility"].mean().reset_index()
    tmp_df['Inducibility'] = tmp_df['Inducibility'] / 3 
    tmp_df['Inducibility VT'] = np.ones(tmp_df.shape[0])*1.0
    tmp_df['Inducibility UVT'] = np.ones(tmp_df.shape[0])*0.33

    tmp_df.loc[len(tmp_df)] = [tmp_df['pig'][0], tmp_df['Inducibility'][0], 1.0, 0.33]

    fig = go.Figure()
    fig.add_trace(go.Scatterpolar(
        r=tmp_df['Inducibility'],
        theta=tmp_df['pig'],
        fill='toself',
        name='Inducibility'
    ))
    fig.add_trace(go.Scatterpolar(
        r=tmp_df['Inducibility UVT'],
        theta=tmp_df['pig'],
        mode='lines',
        line=dict(color='black', dash='dash', shape='spline', smoothing=1),
        showlegend=True,
        name='all UVT'
    ))
    fig.add_trace(go.Scatterpolar(
        r=tmp_df['Inducibility VT'],
        theta=tmp_df['pig'],
        mode='lines',
        line=dict(color='black', dash='solid', shape='spline', smoothing=1, width=6),
        showlegend=True,
        name='all VT'
    ))
    fig.update_layout(
    polar=dict(
        radialaxis=dict(
        visible=True,
        range=[0, 1]
        )),
    showlegend=True
    )

    # fig.show()
    fig.write_image(os.path.join(args.outPath, "figure5.png"), width=800, height=600, scale=3) #this saves with that width and height to dpi 300
    fig.write_image(os.path.join(args.outPath, "figure5.pdf"))

    # check plotly radar for MI, cond, position -----------------------------------------------------
    tmp_df = copy.deepcopy(df_categories)
    tmp_df = tmp_df[["MI", "s2 265ms","s2 280ms", "s2 295ms", "EHT1L s2 295ms", "EHT2L s2 295ms", "EHT1H s2 295ms", "EHT2H s2 295ms"]]
    tmp_df = tmp_df.melt(id_vars=["MI"], value_vars=["s2 265ms","s2 280ms", "s2 295ms", "EHT1L s2 295ms", "EHT2L s2 295ms", "EHT1H s2 295ms", "EHT2H s2 295ms"])
    tmp_df["State"] = tmp_df["variable"].apply(createStateColumn)
    tmp_df["Conductivity"] = tmp_df["variable"].apply(createConductivityColumn)
    tmp_df["EHTPosition"] = tmp_df["variable"].apply(createEHTPositionColumn)
    tmp_df["value"]    = tmp_df["value"].map(replacement2)
    tmp_df = tmp_df.rename(columns={"value": "Inducibility"})
    tmp_df = tmp_df.dropna(how='any')


    # Make the calculations for radar plot and create the dataframe
    df_mi = tmp_df.groupby(["MI"])["Inducibility"].mean()
    df_state = tmp_df.groupby(["State"])["Inducibility"].mean()
    df_conductivity = tmp_df.groupby(["Conductivity"])["Inducibility"].mean()
    df_eht_position = tmp_df.groupby(["EHTPosition"])["Inducibility"].mean()

    combined = pd.concat([df_mi,df_conductivity,df_eht_position,df_state])
    combined = combined.drop('No EHT')
    tmp_df = pd.DataFrame(combined / 3)
    tmp_df['Inducibility VT'] = np.ones(tmp_df.shape[0])*1.0
    tmp_df['Inducibility UVT'] = np.ones(tmp_df.shape[0])*0.33

    # Add the first row to the end of the dataframe for closing the radar plot
    tmp_df = pd.concat([tmp_df, tmp_df.loc[[tmp_df.index[0]]]])

    fig = go.Figure()
    fig.add_trace(go.Scatterpolar(
        r=tmp_df['Inducibility'],
        theta=tmp_df.index,
        fill='toself',
        name='Inducibility'
    ))
    fig.add_trace(go.Scatterpolar(
        r=tmp_df['Inducibility UVT'],
        theta=tmp_df.index,
        mode='lines',
        line=dict(color='black', dash='dash', shape='spline', smoothing=1),
        showlegend=True,
        name='all UVT'
    ))
    fig.add_trace(go.Scatterpolar(
        r=tmp_df['Inducibility VT'],
        theta=tmp_df.index,
        mode='lines',
        line=dict(color='black', dash='solid', shape='spline', smoothing=1, width=6),
        showlegend=True,
        name='all VT'
    ))
    fig.update_layout(
    polar=dict(
        radialaxis=dict(
        visible=True,
        range=[0, 1]
        )),
    showlegend=True
    )

    # fig.show()
    fig.write_image(os.path.join(args.outPath, "figure6.png"), width=800, height=600, scale=3) #this saves with that width and height to dpi 300
    fig.write_image(os.path.join(args.outPath, "figure6.pdf"))

    fig.update_layout(
    polar=dict(
        radialaxis=dict(
        visible=True,
        range=[0, 0.5]
        )),
    showlegend=True
    )

    # fig.show()
    fig.write_image(os.path.join(args.outPath, "figure6b.png"), width=800, height=600, scale=3) #this saves with that width and height to dpi 300
    fig.write_image(os.path.join(args.outPath, "figure6b.pdf"))







if __name__ == '__main__':
    main()