clear all
close all 
clc

root_path         = 'D:/Cinc2025/cocoro/';
experiments_names = {'Ani 025', 'Ani 03', 'Iso', 'Exp'};
result_names      = {'results_sigmaL01195_024transcond', 'results_sigmaL01195_03transcond', 'results_sigmaL01195_1transcond'};
dt_sim            = 0.001; %s
pecg_name         = {'pECG', 'pECG', 'pECG'};
results_folder_name = 'ecg_results_electrodesmanual_norot_byWave_alignment0';
alignment           = 0;


%% Generate the pECG.mat file 
for i=1:length(result_names)
    pecg_csv = readtable(append(root_path, string(result_names(i)), '/pECG.csv'));

    time = pecg_csv.Time_ms';
    time = time - min(time);
    pECG = table2array(pecg_csv(:,2:13));
    pECG = pECG(1:171,:);
    pECGLabels = string(pecg_csv.Properties.VariableNames(2:13));

    save(append(root_path, string(result_names(i)),'/pECG.mat'), 'pECG', 'pECGLabels', 'time');
end
%% Compute pECG comparison

[qrs_sim, qrs_exp, qrs_time] = function_processSampleECG_HE_byWave_Cinc2025(root_path, '', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);

