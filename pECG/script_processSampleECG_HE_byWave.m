clear all
close all 
clc

%% QRS determination
root_path         = 'D:/Paper3/Simulations/invivo/he/';
experiments_names = {'{\it bi}-CS','{\it rvs}-CS', '{\it ap}-CS', 'Exp'};
result_names      = {'results_fib_standard_cs_intra_gaur_CL769', ...
                    'results_fib_standard_cs_intra_gaur_rv_septum_CL769', ...
                    'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesoriginal_norot',...
                    'pECG_electrodesoriginal_norot', ...
                    'pECG_electrodesoriginal_norot'};
results_folder_name = 'ecg_results_electrodesoriginal_norot_byWave_alignment2';
alignment           = 2;

for i=1:3 
    close all 
    clc
    [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
end



pecg_name         = {'pECG_electrodesprecordmanual_norot',...
                    'pECG_electrodesprecordmanual_norot', ...
                    'pECG_electrodesprecordmanual_norot'};
results_folder_name = 'ecg_results_electrodesprecordmanual_norot_byWave_alignment2';

for i=1:3 
    close all 
    clc
    [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
end



pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
                    'pECG_electrodesprecordmanual_rot3', ...
                    'pECG_electrodesprecordmanual_rot3'};
results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_byWave_alignment2';

for i=1:3 
    close all 
    clc
    [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
end

%% Best beats
clear all
clc
close all 

root_path         = 'D:/Paper3/Simulations/invivo/he/';
experiments_names = {'pig1','pig2', 'pig3', 'Exp'};
result_names      = {'sample1', 'sample2', 'sample3'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesprecordmanual_rot3_qrs_t',...
                    'pECG_electrodesprecordmanual_rot3_qrs_t', ...
                    'pECG_electrodesprecordmanual_rot3_qrs_t'};
results_folder_name = 'ecg_results_electrodesprecordmanual_final_rot3_byWave_alignment2';
alignment           = 2;

[qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, 'best_ecg', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);



%% QRS determination - endo vs intramyo
clear all
clc
close all 

root_path         = 'D:/Paper3/Simulations/invivo/he/';
experiments_names = {'{\it ap-e}-CS','{\it ap}-CS', 'Exp'};
result_names      = {'results_fib_standard_cs_endo_gaur_rv_septum_lv_down_CL769', ...
                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
                    'pECG_electrodesprecordmanual_rot3'};
results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_CSINTRAENDO_byWave_alignment2';
alignment           = 2;

for i=1:3 
    close all 
    clc
    [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
end


%% APDSH determination
clear all
clc
close all 

root_path         = 'D:/Paper3/Simulations/invivo/he/';
experiments_names = {'{\it b}-APDSH', '{\it t}-APDSH', '{\it c}-APDSH', 'Exp'};
result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769',...
                    'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_onlytransmural', ...
                    'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
                    'pECG_electrodesprecordmanual_rot3', ...
                    'pECG_electrodesprecordmanual_rot3'};
results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_APDHETER_byWave_alignment2';
alignment           = 2;

for i=1:3 
    close all 
    clc
    [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
end


%% FIBERS determination
clear all
clc
close all 

root_path         = 'D:/Paper3/Simulations/invivo/he/';
experiments_names = {'{\it s}-RBM', '{\it dw}-RBM', 'Exp'};
result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord', ...
                    'results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
                    'pECG_electrodesprecordmanual_rot3'};
results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_meijbord_FIBERS_byWave_alignment2';
alignment           = 2;

for i=1:3 
    close all 
    clc
    [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
end


