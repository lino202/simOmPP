clear all
close all 
clc


%% CS 
clear all
clc
close all 

root_path         = 'D:/Paper3/Simulations/invivo/mi/cx/';
experiments_names = {'{\it ap}-CS', '{\it mi}-CS', 'Exp'};
result_names      = {'results_mi_CL898_2694ms_AVERAGE_noscar_BASE', 'results_mi_CL898_2694ms_AVERAGE_noscar_csintrami'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesoriginal_norot',...
                    'pECG_electrodesoriginal_norot'};
results_folder_name = 'ecg_results_electrodesoriginal_norot_REMODELLING_NOscar_CS_byWave_alignment2';
alignment           = 2;

[qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_MI_byWave(root_path, 'sample6_x', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);


%% CS vs EAM endo and intramyo
% clear all
% clc
% close all 
% 
% root_path         = 'D:/Paper3/Simulations/invivo/mi/cx/';
% experiments_names = {'{\it ap}-CS', '{\it e}-EAM', '{\it i}-EAM', 'Exp'};
% result_names      = {'results_mi_CL898_2694ms_AVERAGE_noscar', ...
%                     'results_mi_CL898_2694ms_AVERAGE_noscar_EAM_endo', ...
%                     'results_mi_CL898_2694ms_AVERAGE_noscar_EAM_intramyo'};
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesoriginal_norot',...
%                     'pECG_electrodesoriginal_norot', ...
%                     'pECG_electrodesoriginal_norot'};
% results_folder_name = 'ecg_results_electrodesoriginal_norot_REMODELLING_NOscar_EAM_byWave_alignment2';
% alignment           = 2;
% 
% [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_MI_byWave(root_path, 'sample6_x', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);


%% CS vs EAM endo and intramyo RBF
clear all
clc
close all 

root_path         = 'D:/Paper3/Simulations/invivo/mi/cx/';
experiments_names = {'{\it ap}-CS', '{\it e}-EAM', '{\it i}-EAM', 'Exp'};
result_names      = {'results_mi_CL898_2694ms_AVERAGE_noscar_BASE', ...
                    'results_mi_CL898_2694ms_AVERAGE_noscar_EAM_endo_rbf_bipolar', ...
                    'results_mi_CL898_2694ms_AVERAGE_noscar_EAM_intramyo_rbf_bipolar'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesoriginal_norot',...
                    'pECG_electrodesoriginal_norot', ...
                    'pECG_electrodesoriginal_norot'};
results_folder_name = 'ecg_results_electrodesoriginal_norot_REMODELLING_NOscar_EAM_byWave_alignment2_RBF';
alignment           = 2;

[qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_MI_byWave(root_path, 'sample6_x', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);



