clear all
close all 
clc

%% QRS determination
% root_path         = 'D:/Paper3/Simulations/invivo/he/';
% experiments_names = {'{\it bi}-CS','{\it rvs}-CS', '{\it ap}-CS', 'Exp'};
% result_names      = {'results_fib_standard_cs_intra_gaur_CL769', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_CL769', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769'};
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesoriginal_norot',...
%                     'pECG_electrodesoriginal_norot', ...
%                     'pECG_electrodesoriginal_norot'};
% results_folder_name = 'ecg_results_electrodesoriginal_norot_byWave_alignment2';
% alignment           = 2;
% 
% for i=1:3 
%     close all 
%     clc
%     [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% end
% 
% 
% 
% pecg_name         = {'pECG_electrodesprecordmanual_norot',...
%                     'pECG_electrodesprecordmanual_norot', ...
%                     'pECG_electrodesprecordmanual_norot'};
% results_folder_name = 'ecg_results_electrodesprecordmanual_norot_byWave_alignment2';
% 
% for i=1:3 
%     close all 
%     clc
%     [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% end
% 
% 
% 
% pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3'};
% results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_byWave_alignment2';
% 
% for i=1:3 
%     close all 
%     clc
%     [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% end

%% Best beats
% clear all
% clc
% close all 
% 
% root_path         = 'D:/Paper3/Simulations/invivo/he/';
% experiments_names = {'pig1','pig2', 'pig3', 'Exp'};
% result_names      = {'sample1', 'sample2', 'sample3'};
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesprecordmanual_rot3_qrs_t',...
%                     'pECG_electrodesprecordmanual_rot3_qrs_t', ...
%                     'pECG_electrodesprecordmanual_rot3_qrs_t'};
% results_folder_name = 'ecg_results_electrodesprecordmanual_final_rot3_byWave_alignment2';
% alignment           = 2;
% 
% [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, 'best_ecg', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% 


%% QRS determination - endo vs intramyo
% clear all
% clc
% close all 
% 
% root_path         = 'D:/Paper3/Simulations/invivo/he/';
% experiments_names = {'{\it ap-e}-CS','{\it ap}-CS', 'Exp'};
% result_names      = {'results_fib_standard_cs_endo_gaur_rv_septum_lv_down_CL769', ...
%                      'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769'};
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
%                     'pECG_electrodesprecordmanual_rot3'};
% results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_CSINTRAENDO_byWave_alignment2';
% alignment           = 2;
% 
% for i=1:3 
%     close all 
%     clc
%     [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% end


%% APDSH determination
% clear all
% clc
% close all 
% 
% root_path         = 'D:/Paper3/Simulations/invivo/he/';
% experiments_names = {'{\it b}-APDSH', '{\it t}-APDSH', '{\it c}-APDSH', 'Exp'};
% result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769',...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_onlytransmural', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord'};
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3'};
% results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_APDHETER_byWave_alignment2';
% alignment           = 2;
% 
% for i=1:3 
%     close all 
%     clc
%     [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% end


%% FIBERS determination - REVIEW
% clear all
% clc
% close all 
% 
% root_path         = 'F:/Paper3/Simulations/invivo/he/';
% experiments_names = {'{\it s}-RBM', '{\it dw}-RBM', 'Exp'};
% result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord', ...
%                     'results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord'};
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
%                     'pECG_electrodesprecordmanual_rot3'};
% results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_meijbord_FIBERS_byWave_alignment2';
% alignment           = 2;
% 
% for i=1:3 
%     close all 
%     clc
%     [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% end



%% FIBERS determination - REVIEW
% clear all
% clc
% close all 
% 
% root_path         = 'F:/Paper3/Simulations/invivo/he/';
% experiments_names = {'{\it s}-RBM', 'Exp'};
% result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord'};
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesprecordmanual_rot3'};
% results_folder_name = 'ecg_results_electrodesprecordmanual_rot3_meijbord_FIBERS_byWave_alignment2';
% alignment           = 2;
% 
% for i=1:3 
%     close all 
%     clc
%     [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, append('sample',num2str(i)), experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);
% end


%% APDSH sensitivity - REVIEW
% clear all
% clc
% close all 
% 
% root_path         = 'F:/Paper3/Simulations/invivo/he/sample1/';
% experiments_names = {'baseline','APDSHL1', 'APDSHL2','APDSHL3', 'APDSHL4','APDSHL5', 'APDSHL6', ...
%                     'APDSHT1', 'APDSHT2','APDSHT3','APDSHT4', 'APDSHT5', 'APDSHT6', 'Exp'};
% result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL1', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL2', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL3', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL4', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL5', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHL6', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT1', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT2', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT3', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT4', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT5', ...
%                     'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_APDSHT6'
%                     };
% dt_sim            = 0.00025; %s
% pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3', ...
%                     'pECG_electrodesprecordmanual_rot3'};
% results_folder_name = 'ecg_results_review_APDSH_sensitivity_byWave_alignment2';
% alignment           = 2;
% 
% 
% [qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, '', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);

%% LDC CS REVIEW

clear all
clc
close all 

root_path         = 'F:/Paper3/Simulations/invivo/he/sample1/';
experiments_names = {'baseline','m20', 'p20', 'Exp'};
result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord', ...
                    'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_CSLDCm20', ...
                    'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_CSLDCp20'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
                    'pECG_electrodesprecordmanual_rot3', ...
                    'pECG_electrodesprecordmanual_rot3'};
results_folder_name = 'ecg_results_review_CSLDC_sensitivity_byWave_alignment2';
alignment           = 2;


[qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, '', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);


%% LDC myocardium REVIEW

clear all
clc
close all 

root_path         = 'F:/Paper3/Simulations/invivo/he/sample1/';
experiments_names = {'baseline','m20', 'p20', 'Exp'};
result_names      = {'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord', ...
                    'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_LDCm20', ...
                    'results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL769_meijbord_LDCp20'};
dt_sim            = 0.00025; %s
pecg_name         = {'pECG_electrodesprecordmanual_rot3',...
                    'pECG_electrodesprecordmanual_rot3', ...
                    'pECG_electrodesprecordmanual_rot3'};
results_folder_name = 'ecg_results_review_LDC_sensitivity_byWave_alignment2';
alignment           = 2;


[qrs_sim, t_sim, qrs_exp, t_exp, qrs_time, t_time] = function_processSampleECG_HE_byWave(root_path, '', experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment);

