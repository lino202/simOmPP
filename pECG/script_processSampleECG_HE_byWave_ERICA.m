clear all
close all 
clc

%% QRS determination
root_path         = 'G:/Data/RM/Erica/DTI126V2/myresults/Simulations';
experiments_names = {'HE','MI R1', 'MI R2', 'MI NS R3', 'MI NS R4', 'Exp'};
result_names      = {'results_he', 'results_mi_rand1', 'results_mi_rand2', ...
                     'results_mi_noscar_rand1', 'results_mi_noscar_rand2'};
dt_sim            = 0.001; %s
pecg_name         = {'pECG', 'pECG', 'pECG', 'pECG', 'pECG'};
results_folder_name = 'ecg_results_byWave_alignment2';
alignment           = 2;

[qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, '', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);