clear all
close all 
clc


set(0, 'DefaultAxesFontName', 'Times New Roman', ...
    'defaultUicontrolFontName', 'Times New Roman', ...
    'defaultUitableFontName', 'Times New Roman', ...
    'defaultAxesFontName', 'Times New Roman', ...
    'defaultTextFontName', 'Times New Roman', ...
    'defaultUipanelFontName', 'Times New Roman');
set(groot, 'DefaultAxesFontSize', 9); 
font_size = 10;
ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
linewidth = 1;

%% One image

% load('D:/Paper3/Simulations/invivo/he/sample3/ecg_results_electrodesoriginal_norot_byWave_alignment2/results.mat')
% qrs_sim_bHERP = qrs_sim;
% 
% load('D:/Paper3/Simulations/invivo/he/sample3/ecg_results_electrodesprecordmanual_rot3_byWave_alignment2/results.mat')
% qrs_sim_aHERP = qrs_sim;
% 
% outpath = 'D:/Paper3/Simulations/invivo/he/sample3/';
% 
% experiments_names = {'{\it bi}-CS','{\it rvs}-CS', '{\it ap}-CS', '{\it bi}-CS','{\it rvs}-CS', '{\it ap}-CS', 'Exp'};
% %%Plot
% 
% alpha = 0.6;
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% color4 = alpha * color1 + (1- alpha) * [1, 1, 1];
% color5 = alpha * color2 + (1- alpha) * [1, 1, 1];
% color6 = alpha * color3 + (1- alpha) * [1, 1, 1];
% colors = {color4, color5, color6, color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(qrs_sim_bHERP,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for j=1:size(qrs_sim_bHERP,3)
%         plot(qrs_time, qrs_sim_bHERP(:,i,j), 'Color', cell2mat(colors(j)), 'LineWidth',linewidth)
%         hold on
%         
%     end
%     for k=1:size(qrs_sim_aHERP,3)
%         plot(qrs_time, qrs_sim_aHERP(:,i,k), 'Color', cell2mat(colors(j+k)), 'LineWidth',linewidth)
%         hold on
%     end
%     
%     
%     plot(qrs_time, qrs_exp(:,i), 'k--', 'LineWidth',linewidth)
%     hold on
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V [a.u.]','FontSize',font_size);
% xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% % Set paper size and position
% 
% 
% exportgraphics(fig,append(outpath, 'QRS_sample3_PAPER.pdf'),'Resolution',400);
% exportgraphics(fig,append(outpath, 'QRS_sample3_PAPER.png'),'Resolution',400);









%% Best beats
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 9); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/he/best_ecg/ecg_results_electrodesprecordmanual_final_rot3_byWave_alignment2/results.mat')
% qrs_sim_aHERP = qrs_sim;
% 
% outpath = 'D:/Paper3/Simulations/invivo/he/best_ecg/';
% 
% experiments_names = {'pig 1','pig 2', 'pig 3', 'Exp'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(qrs_sim_aHERP,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for k=1:size(qrs_sim_aHERP,3)
%         plot(qrs_time, qrs_sim_aHERP(:,i,k), 'Color', cell2mat(colors(k)), 'LineWidth',linewidth)
%         hold on
%     end
%     
%     
%     plot(qrs_time, qrs_exp(:,i), 'k--', 'LineWidth',linewidth)
%     hold on
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V [a.u.]','FontSize',font_size);
% xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% exportgraphics(fig,append(outpath, 'QRS_best_ecg_PAPER.pdf'),'Resolution',400);
% exportgraphics(fig,append(outpath, 'QRS_best_ecg_PAPER.png'),'Resolution',400);



%% APD heterogeneity
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 9); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/he/sample1/ecg_results_electrodesprecordmanual_rot3_APDHETER_byWave_alignment2/results.mat')
% t_sim_aHERP = t_sim;
% 
% outpath = 'D:/Paper3/Simulations/invivo/he/sample1/';
% 
% experiments_names = {'b-APDSH','t-APDSH', 'c-APDSH', 'Exp'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 6; %cm
% 
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(t_sim_aHERP,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for k=1:size(t_sim_aHERP,3)
%         plot(t_time, t_sim_aHERP(:,i,k), 'Color', cell2mat(colors(k)), 'LineWidth',linewidth)
%         hold on
%     end
%     
%     
%     plot(t_time, t_exp(:,i), 'k--', 'LineWidth',linewidth)
%     hold on
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-0.6 0.6])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V [a.u.]','FontSize',font_size);
% xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% exportgraphics(fig,append(outpath, 'T_APD_heterogeneity_PAPER.pdf'),'Resolution',400);
% exportgraphics(fig,append(outpath, 'T_APD_heterogeneity_PAPER.png'),'Resolution',400);


%% Fibers
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('F:/Paper3/Simulations/invivo/he/sample3/ecg_results_electrodesprecordmanual_rot3_meijbord_FIBERS_byWave_alignment2/results.mat')
% 
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/sample3/';
% 
% experiments_names = {'s-RBM','dw-RBM'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% time_end = 350; %ms
% 
% time_end_idx = find(pECG_tot_time(:,1)==time_end);
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(pECG_tot_ecgs,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for j=1:size(pECG_tot_ecgs,3)
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j), 'Color', cell2mat(colors(j)), 'LineWidth',linewidth)
%         hold on
%     end
%     xticks([0 175 350])
%     xticklabels({'0','175', '350'})
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V [a.u.]','FontSize',font_size);
% xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% % exportgraphics(fig,append(outpath, 'pECG_FIBERS_PAPER.pdf'),'Resolution',400);
% % exportgraphics(fig,append(outpath, 'pECG_FIBERS_PAPER.png'),'Resolution',400);
% 
% print(append(outpath, 'pECG_FIBERS_exp_PAPER.svg'), '-dsvg', '-r400')
% print(append(outpath, 'pECG_FIBERS_exp_PAPER.png'), '-dpng', '-r400')



%% MI - mi-CS vs ap-CS
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 9); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/mi/cx/sample6_x/ecg_results_electrodesoriginal_norot_REMODELLING_NOscar_CS_byWave_alignment2/results.mat')
% qrs_sim_aHERP = qrs_sim;
% 
% outpath = 'D:/Paper3/Simulations/invivo/mi/cx/sample6_x/';
% 
% experiments_names = {'ap-CS','mi-CS', 'Exp'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(qrs_sim_aHERP,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for k=1:size(qrs_sim_aHERP,3)
%         plot(qrs_time, qrs_sim_aHERP(:,i,k), 'Color', cell2mat(colors(k)), 'LineWidth',linewidth)
%         hold on
%     end
%     
%     
%     plot(qrs_time, qrs_exp(:,i), 'k--', 'LineWidth',linewidth)
%     hold on
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V [a.u.]','FontSize',font_size);
% xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'QRS_miCS_PAPER.svg'), '-dsvg', '-r300')
% print(append(outpath, 'QRS_miCS_PAPER.png'), '-dpng', '-r300')

%% MI - mi-CS vs ap-CS
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 9); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('F:/Paper3/Simulations/invivo/mi/cx/sample6_x/ecg_results_electrodesoriginal_norot_REMODELLING_NOscar_CS_byWave_alignment2/results.mat')
% t_sim_aHERP = t_sim;
% 
% outpath = 'F:/Paper3/Simulations/invivo/mi/cx/sample6_x/';
% 
% experiments_names = {'ap-CS','mi-CS', 'Exp'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color3};
% 
% width = 23; %cm
% height = 6; %cm
% 
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(t_sim_aHERP,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for k=1:size(t_sim_aHERP,3)
%         plot(t_time, t_sim_aHERP(:,i,k), 'Color', cell2mat(colors(k)), 'LineWidth',linewidth)
%         hold on
%     end
%     
%     
%     plot(t_time, t_exp(:,i), 'k--', 'LineWidth',linewidth)
%     hold on
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-0.9 0.8])
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'T_miCS_PAPER.svg'), '-dsvg', '-r300')
% print(append(outpath, 'T_miCS_PAPER.png'), '-dpng', '-r300')


%% MI - ap-CS vs EAM QRS
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 9); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/mi/cx/sample6_x/ecg_results_electrodesoriginal_norot_REMODELLING_NOscar_EAM_byWave_alignment2_RBF/results.mat')
% qrs_sim_aHERP = qrs_sim;
% 
% outpath = 'D:/Paper3/Simulations/invivo/mi/cx/sample6_x/';
% 
% experiments_names = {'ap-CS','e-EAM', 'i-EAM', 'Exp'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(qrs_sim_aHERP,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for k=1:size(qrs_sim_aHERP,3)
%         plot(qrs_time, qrs_sim_aHERP(:,i,k), 'Color', cell2mat(colors(k)), 'LineWidth',linewidth)
%         hold on
%     end
%     
%     
%     plot(qrs_time, qrs_exp(:,i), 'k--', 'LineWidth',linewidth)
%     hold on
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V [a.u.]','FontSize',font_size);
% xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'QRS_CS_EAM_PAPER.svg'), '-dsvg', '-r300')
% print(append(outpath, 'QRS_CS_EAM_PAPER.png'), '-dpng', '-r300')



%% MI - ap-CS vs EAM T
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 9); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/mi/cx/sample6_x/ecg_results_electrodesoriginal_norot_REMODELLING_NOscar_EAM_byWave_alignment2_RBF/results.mat')
% t_sim_aHERP = t_sim;
% 
% outpath = 'D:/Paper3/Simulations/invivo/mi/cx/sample6_x/';
% 
% experiments_names = {'ap-CS','e-EAM', 'i-EAM', 'Exp'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 6; %cm
% 
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% for i=1:size(t_sim_aHERP,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%   
%     for k=1:size(t_sim_aHERP,3)
%         plot(t_time, t_sim_aHERP(:,i,k), 'Color', cell2mat(colors(k)), 'LineWidth',linewidth)
%         hold on
%     end
%     
%     
%     plot(t_time, t_exp(:,i), 'k--', 'LineWidth',linewidth)
%     hold on
%     %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-0.9 0.8])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
%     
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V [a.u.]','FontSize',font_size);
% xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% % set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'T_CS_EAM_PAPER.svg'), '-dsvg', '-r300')
% print(append(outpath, 'T_CS_EAM_PAPER.png'), '-dpng', '-r300')

%% All ECGs LCx
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/mi/cx/ecg_results_electrodesoriginal_norot_miECG_LCx/results.mat')
% 
% 
% outpath = 'D:/Paper3/Simulations/invivo/mi/cx/';
% 
% experiments_names = cleaned_experiment_names;
% 
% %Plot
% colorHE = [0 0.4470 0.7410];
% colorMI = [0.8500 0.3250 0.0980];
% 
% colors = {colorHE, colorMI, colorHE, colorMI, colorHE, colorMI, colorHE, colorMI};
% 
% lines = ["-","-","--","--",":",":","-.","-."];
% 
% width = 23; %cm
% height = 5; %cm
% 
% time_end = 500; %ms
% 
% time_end_idx = find(pECG_tot_time(:,1)==time_end);
% 
% for j=1:2:size(pECG_tot_ecgs,3)
%     fig=figure;
%     set(fig, 'Units', 'centimeters');
%     set(fig, 'Position', [0, 0, width, height]);
%     t = tiledlayout(2,6, 'TileSpacing', 'none');
%     for i=1:size(pECG_tot_ecgs,2)
%         ax = nexttile;
% 
% 
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j), 'Color', colorHE, 'LineWidth',linewidth)
%         hold on
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j+1), 'Color', colorMI, 'LineWidth',linewidth)
% 
%         xticks([0 250 500])
%         xticklabels({'0','250', '500'})
%         %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%         title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%         if i~=1 && i~=7
%             ax.YTickLabel = [];
%         else
%     %         ylabel('norm V [a.u.]','FontSize',font_size)
%         end
% 
%         if i<7
%             ax.XTickLabel = [];
%         else
%     %         xlabel('time [ms]', 'FontSize',font_size)
%         end
%     end
% 
%     han=axes(fig,'visible','off'); 
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han,'norm V [a.u.]','FontSize',font_size);
%     xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
%     set(fig, 'PaperUnits', 'centimeters');
%     set(fig, 'PaperPositionMode', 'manual');
%     set(fig, 'PaperPosition', [0, 0, width, height]);
%     set(fig, 'PaperSize', [width, height]);
% 
%     name = strrep(cell2mat(experiments_names(j)),'HE', '');
%     name = strrep(name,' ', '');
%     
%     print(append(outpath, 'pECG_ALL_ECGS_LCx_',name,'.svg'), '-dsvg', '-r400')
%     print(append(outpath, 'pECG_ALL_ECGS_LCx_',name,'.png'), '-dpng', '-r400')
% end

%% All ECGs LADx
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/mi/la/ecg_results_electrodesoriginal_norot_miECG_LADx/results.mat')
% 
% 
% outpath = 'D:/Paper3/Simulations/invivo/mi/la/';
% 
% experiments_names = cleaned_experiment_names;
% 
% %Plot
% colorHE = [0 0.4470 0.7410];
% colorMI = [0.8500 0.3250 0.0980];
% 
% colors = {colorHE, colorMI, colorHE, colorMI, colorHE, colorMI, colorHE, colorMI};
% 
% lines = ["-","-","--","--",":",":","-.","-."];
% 
% width = 23; %cm
% height = 5; %cm
% 
% time_end = 500; %ms
% 
% time_end_idx = find(pECG_tot_time(:,1)==time_end);
% 
% for j=1:2:size(pECG_tot_ecgs,3)
%     fig=figure;
%     set(fig, 'Units', 'centimeters');
%     set(fig, 'Position', [0, 0, width, height]);
%     t = tiledlayout(2,6, 'TileSpacing', 'none');
%     for i=1:size(pECG_tot_ecgs,2)
%         ax = nexttile;
% 
% 
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j), 'Color', colorHE, 'LineWidth',linewidth)
%         hold on
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j+1), 'Color', colorMI, 'LineWidth',linewidth)
% 
%         xticks([0 250 500])
%         xticklabels({'0','250', '500'})
%         %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%         title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%         if i~=1 && i~=7
%             ax.YTickLabel = [];
%         else
%     %         ylabel('norm V [a.u.]','FontSize',font_size)
%         end
% 
%         if i<7
%             ax.XTickLabel = [];
%         else
%     %         xlabel('time [ms]', 'FontSize',font_size)
%         end
%     end
% 
%     han=axes(fig,'visible','off'); 
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han,'norm V [a.u.]','FontSize',font_size);
%     xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
%     set(fig, 'PaperUnits', 'centimeters');
%     set(fig, 'PaperPositionMode', 'manual');
%     set(fig, 'PaperPosition', [0, 0, width, height]);
%     set(fig, 'PaperSize', [width, height]);
% 
%     name = strrep(cell2mat(experiments_names(j)),'HE', '');
%     name = strrep(name,' ', '');
%     
%     print(append(outpath, 'pECG_ALL_ECGS_LADx_',name,'.svg'), '-dsvg', '-r400')
%     print(append(outpath, 'pECG_ALL_ECGS_LADx_',name,'.png'), '-dpng', '-r400')
% end


%% Some leads ECGs LCx
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/mi/cx/ecg_results_electrodesoriginal_norot_miECG_LCx/results.mat')
% 
% 
% outpath = 'D:/Paper3/Simulations/invivo/mi/cx/';
% 
% experiments_names = cleaned_experiment_names;
% 
% %Plot
% colorHE = [0 0.4470 0.7410];
% colorMI = [0.8500 0.3250 0.0980];
% 
% leads_to_show =[1,2,3,8,9,10,11];
% 
% width = 23; %cm
% height = 3; %cm
% 
% time_end = 500; %ms
% 
% time_end_idx = find(pECG_tot_time(:,1)==time_end);
% 
% for j=1:2:size(pECG_tot_ecgs,3)
%     fig=figure;
%     set(fig, 'Units', 'centimeters');
%     set(fig, 'Position', [0, 0, width, height]);
%     t = tiledlayout(1,7, 'TileSpacing', 'none');
%     for i = leads_to_show(:)'
%         ax = nexttile;
% 
% 
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j), 'Color', colorHE, 'LineWidth',linewidth)
%         hold on
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j+1), 'Color', colorMI, 'LineWidth',linewidth)
% 
%         xticks([0 250 500])
%         xticklabels({'0','250', '500'})
%         %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%         title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%         if i~=1 && i~=7
%             ax.YTickLabel = [];
%         else
%     %         ylabel('norm V [a.u.]','FontSize',font_size)
%         end
% % 
% %         if i<7
% %             ax.XTickLabel = [];
% %         else
% %     %         xlabel('time [ms]', 'FontSize',font_size)
% %         end
%     end
% 
%     han=axes(fig,'visible','off'); 
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han,'norm V [a.u.]','FontSize',font_size);
%     xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
%     set(fig, 'PaperUnits', 'centimeters');
%     set(fig, 'PaperPositionMode', 'manual');
%     set(fig, 'PaperPosition', [0, 0, width, height]);
%     set(fig, 'PaperSize', [width, height]);
% 
%     name = strrep(cell2mat(experiments_names(j)),'HE', '');
%     name = strrep(name,' ', '');
%     
%     print(append(outpath, 'pECG_ALL_ECGS_LCx_',name,'_SOMELEADS.svg'), '-dsvg', '-r400')
%     print(append(outpath, 'pECG_ALL_ECGS_LCx_',name,'_SOMELEADS.png'), '-dpng', '-r400')
% end

%% Some leads LADx
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% load('D:/Paper3/Simulations/invivo/mi/la/ecg_results_electrodesoriginal_norot_miECG_LADx/results.mat')
% 
% 
% outpath = 'D:/Paper3/Simulations/invivo/mi/la/';
% 
% experiments_names = cleaned_experiment_names;
% 
% %Plot
% colorHE = [0 0.4470 0.7410];
% colorMI = [0.8500 0.3250 0.0980];
% 
% colors = {colorHE, colorMI, colorHE, colorMI, colorHE, colorMI, colorHE, colorMI};
% 
% lines = ["-","-","--","--",":",":","-.","-."];
% 
% leads_to_show =[1,2,3,8,9,10,11];
% 
% width = 23; %cm
% height = 3; %cm
% 
% time_end = 500; %ms
% 
% time_end_idx = find(pECG_tot_time(:,1)==time_end);
% 
% for j=1:2:size(pECG_tot_ecgs,3)
%     fig=figure;
%     set(fig, 'Units', 'centimeters');
%     set(fig, 'Position', [0, 0, width, height]);
%     t = tiledlayout(1,7, 'TileSpacing', 'none');
%     for i=leads_to_show(:)'
%         ax = nexttile;
% 
% 
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j), 'Color', colorHE, 'LineWidth',linewidth)
%         hold on
%         plot(pECG_tot_time(1:time_end_idx,1), pECG_tot_ecgs(1:time_end_idx,i,j+1), 'Color', colorMI, 'LineWidth',linewidth)
% 
%         xticks([0 250 500])
%         xticklabels({'0','250', '500'})
%         %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%         title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%         if i~=1 && i~=7
%             ax.YTickLabel = [];
%         else
%     %         ylabel('norm V [a.u.]','FontSize',font_size)
%         end
% 
% %         if i<7
% %             ax.XTickLabel = [];
% %         else
% %     %         xlabel('time [ms]', 'FontSize',font_size)
% %         end
%     end
% 
%     han=axes(fig,'visible','off'); 
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han,'norm V [a.u.]','FontSize',font_size);
%     xlabel(han,'time [ms]', 'FontSize',font_size);
% 
% 
%     set(fig, 'PaperUnits', 'centimeters');
%     set(fig, 'PaperPositionMode', 'manual');
%     set(fig, 'PaperPosition', [0, 0, width, height]);
%     set(fig, 'PaperSize', [width, height]);
% 
%     name = strrep(cell2mat(experiments_names(j)),'HE', '');
%     name = strrep(name,' ', '');
%     
%     print(append(outpath, 'pECG_ALL_ECGS_LADx_',name,'_SOMELEADS.svg'), '-dsvg', '-r400')
%     print(append(outpath, 'pECG_ALL_ECGS_LADx_',name,'_SOMELEADS.png'), '-dpng', '-r400')
% end


%% Review - plot complete ecgs

% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 1;
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/';
% 
% experiments_names = {'pig 1', 'pig 2', 'pig 3'};
% 
% %Plot
% color1 = [0, 0.4470, 0.7410];
% color2 = [0.9290, 0.6940, 0.1250];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% 
% signals_sim = [];
% for j=1:3
%     % We use the s-RBM for all pigs and plot the complete simulate and exp ECG
%     load(append('F:/Paper3/Simulations/invivo/he/sample', string(j), '/ecg_results_electrodesprecordmanual_rot3_meijbord_FIBERS_byWave_alignment2/results.mat'));
%     if j==1
%         signals_sim = zeros(size(signal_sim,1), size(signal_sim,2),3);
%     end
%     
%     signals_sim(:,:,j) = signal_sim(:,:,1); % The fix 1 is for the s-RBM you can check in script_processSampleECG_HE_byWave
%     
%     
% end
% 
% for i=1:size(ECG_headers,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
% 
%     for j=1:3
%         plot(signal_time_sim, signals_sim(:,i,j), 'Color', cell2mat(colors(j)), 'LineWidth',linewidth) 
%         hold on
%     end
%     
%     plot(signal_time_exp, signal_exp(:,i), 'k--','LineWidth',linewidth)
%     hold on
%     
%     xticks([0 200 400])
%     xticklabels({'0','200', '400'})
%     legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
% end
% 
% 
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% % exportgraphics(fig,append(outpath, 'pECG_FIBERS_PAPER.pdf'),'Resolution',400);
% % exportgraphics(fig,append(outpath, 'pECG_FIBERS_PAPER.png'),'Resolution',400);
% 
% print(append(outpath, 'pECG_FIBERS_complete_with_exp_PAPER_review.svg'), '-dsvg', '-r400')
% print(append(outpath, 'pECG_FIBERS_complete_with_exp_PAPER_review.png'), '-dpng', '-r400')





%% Review - plot complete ecgs

% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 0.5;
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/sample1/';
% 
% experiments_names = {'APDSHL1', 'APDSHL2','APDSHL3', 'APDSHL4','APDSHL5', 'APDSHL6', ...
%                     'APDSHT1', 'APDSHT2','APDSHT3','APDSHT4', 'APDSHT5', 'APDSHT6', 'baseline'};
% 
% Colors
% 1. Black
% color1 = [0, 0, 0, 1];
% 
% 2-7. Different shades of Blue (Light to Dark)
% color2 = [0.90, 0.95, 1.00, 0.4]; % Very Light Blue
% color3 = [0.67, 0.85, 0.90, 0.4]; % Sky Blue
% color4 = [0.39, 0.58, 0.93, 0.4]; % Cornflower Blue
% color5 = [0.00, 0.45, 0.74, 0.4]; % MATLAB Standard Blue
% color6 = [0.00, 0.27, 0.53, 0.4]; % Navy Blue
% color7 = [0.00, 0.10, 0.25, 0.4]; % Midnight Blue
% 
% 8-13. Different shades of Red/Orange (Light to Dark)
% color8 = [1.00, 0.90, 0.85, 0.4]; % Peach/Very Light Red
% color9 = [1.00, 0.65, 0.40, 0.4]; % Light Orange
% color10 = [0.93, 0.40, 0.15, 0.4]; % Burnt Orange
% color11 = [0.85, 0.33, 0.10, 0.4]; % MATLAB Standard Orange/Red
% color12 = [0.60, 0.15, 0.10, 0.4]; % Dark Red
% color13 = [0.35, 0.05, 0.05, 0.4]; % Maroon/Deep Red
% 
% Combined Cell Array
% colors = {color1, color2, color3, color4, color5, color6, color7, ...
%           color8, color9, color10, color11, color12, color13};
% 
% width = 23; %cm
% height = 5; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% 
% load(append('F:/Paper3/Simulations/invivo/he/sample1/ecg_results_review_APDSH_sensitivity_byWave_alignment2/results.mat'));
% 
% for i=1:size(ECG_headers,2)
%     ax = subplot(4,3,i);
%     ax = nexttile;
% 
%     for j=1:size(experiments_names,2)
%         if j==size(experiments_names,2)
%             plot(signal_time_sim, signal_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
%         else
%             plot(signal_time_sim, signal_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
%         end
%         hold on
%     end
%     
%     xticks([0 200 400])
%     xticklabels({'0','200', '400'})
%     
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
%         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
%         xlabel('time [ms]', 'FontSize',font_size)
%     end
%     
%     if i==6
%         legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
%     end
% 
% end
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'pECG_APDSH_sensitivity_PAPER_review.svg'), '-dsvg', '-r400', '-painters')
% print(append(outpath, 'pECG_APDSH_sensitivity_PAPER_review.png'), '-dpng', '-r400', '-painters')


%% Review - plot complete ecgs - T wave

% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 0.5;
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/sample1/';
% 
% experiments_names = {'baseline','APDSHL1', 'APDSHL2','APDSHL3', 'APDSHL4','APDSHL5', 'APDSHL6', ...
%                     'APDSHT1', 'APDSHT2','APDSHT3','APDSHT4', 'APDSHT5', 'APDSHT6'};
% 
% %Colors
% % 1. Black
% color1 = [0, 0, 0, 1];
% 
% % 2-7. Different shades of Blue (Light to Dark)
% color2 = [0.90, 0.95, 1.00, 0.8]; % Very Light Blue
% color3 = [0.67, 0.85, 0.90, 0.8]; % Sky Blue
% color4 = [0.39, 0.58, 0.93, 0.8]; % Cornflower Blue
% color5 = [0.00, 0.45, 0.74, 0.8]; % MATLAB Standard Blue
% color6 = [0.00, 0.27, 0.53, 0.8]; % Navy Blue
% color7 = [0.00, 0.10, 0.25, 0.8]; % Midnight Blue
% 
% % 8-13. Different shades of Red/Orange (Light to Dark)
% color8 = [1.00, 0.90, 0.85, 0.8]; % Peach/Very Light Red
% color9 = [1.00, 0.65, 0.40, 0.8]; % Light Orange
% color10 = [0.93, 0.40, 0.15, 0.8]; % Burnt Orange
% color11 = [0.85, 0.33, 0.10, 0.8]; % MATLAB Standard Orange/Red
% color12 = [0.60, 0.15, 0.10, 0.8]; % Dark Red
% color13 = [0.35, 0.05, 0.05, 0.8]; % Maroon/Deep Red
% 
% % Combined Cell Array
% colors = {color1, color2, color3, color4, color5, color6, color7, ...
%           color8, color9, color10, color11, color12, color13};
% 
% width = 23; %cm
% height = 10; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% 
% load(append('F:/Paper3/Simulations/invivo/he/sample1/ecg_results_review_APDSH_sensitivity_byWave_alignment2/results.mat'));
% 
% for i=1:size(ECG_headers,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%     
%     for j=1:size(experiments_names,2)
%         if j==size(experiments_names,2)
%             plot(t_time, t_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
%         else
%             plot(t_time, t_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
%         end
%         hold on
%     end
%     
%     xticks([0 100 200])
%     xticklabels({'0','100', '200'})
%     
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-0.6 0.6])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
%     
%     if i==6
%         legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
%     end
% 
% end
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'pECG_APDSH_sensitivity_PAPER_review_Twave.svg'), '-dsvg', '-r400', '-painters')
% print(append(outpath, 'pECG_APDSH_sensitivity_PAPER_review_Twave.png'), '-dpng', '-r400', '-painters')

%% LDC CS Review

% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 0.5;
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/sample1/';
% 
% experiments_names = {'m20', 'p20', 'baseline'};
% 
% %Colors
% % 1. Black
% color1 = [0, 0, 0, 1];
% color2 = [0, 0.4470, 0.7410];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% 
% load(append('F:/Paper3/Simulations/invivo/he/sample1/ecg_results_review_CSLDC_sensitivity_byWave_alignment2/results.mat'));
% 
% for i=1:size(ECG_headers,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
% 
%     for j=1:size(experiments_names,2)
%         if j==size(experiments_names,2)
%             plot(signal_time_sim, signal_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
%         else
%             plot(signal_time_sim, signal_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
%         end
%         hold on
%     end
%     
%     xticks([0 200 400])
%     xticklabels({'0','200', '400'})
%     
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
%     
%     if i==6
%         legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
%     end
% 
% end
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'pECG_CSLDC_sensitivity_PAPER_review.svg'), '-dsvg', '-r400', '-painters')
% print(append(outpath, 'pECG_CSLDC_sensitivity_PAPER_review.png'), '-dpng', '-r400', '-painters')
% 
% % QRS
% 
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 0.5;
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/sample1/';
% 
% experiments_names = {'m20', 'p20', 'baseline'};
% 
% %Colors
% % 1. Black
% color1 = [0, 0, 0, 1];
% color2 = [0, 0.4470, 0.7410];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% 
% load(append('F:/Paper3/Simulations/invivo/he/sample1/ecg_results_review_CSLDC_sensitivity_byWave_alignment2/results.mat'));
% 
% for i=1:size(ECG_headers,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%     
%     for j=1:size(experiments_names,2)
%         if j==size(experiments_names,2)
%             plot(qrs_time, qrs_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
%         else
%             plot(qrs_time, qrs_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
%         end
%         hold on
%     end
%     
%     xticks([0 50 100])
%     xticklabels({'0','50', '100'})
%     
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
%     
%     if i==6
%         legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
%     end
% 
% end
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'pECG_CSLDC_sensitivity_PAPER_review_QRS.svg'), '-dsvg', '-r400', '-painters')
% print(append(outpath, 'pECG_CSLDC_sensitivity_PAPER_review_QRS.png'), '-dpng', '-r400', '-painters')


%% LDC myocardium Review

% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 0.5;
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/sample1/';
% 
% experiments_names = {'m20', 'p20', 'baseline'};
% 
% %Colors
% % 1. Black
% color1 = [0, 0, 0, 1];
% color2 = [0, 0.4470, 0.7410];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% 
% load(append('F:/Paper3/Simulations/invivo/he/sample1/ecg_results_review_LDC_sensitivity_byWave_alignment2/results.mat'));
% 
% for i=1:size(ECG_headers,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
% 
%     for j=1:size(experiments_names,2)
%         if j==size(experiments_names,2)
%             plot(signal_time_sim, signal_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
%         else
%             plot(signal_time_sim, signal_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
%         end
%         hold on
%     end
%     
%     xticks([0 200 400])
%     xticklabels({'0','200', '400'})
%     
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
%     
%     if i==6
%         legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
%     end
% 
% end
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'pECG_LDC_sensitivity_PAPER_review.svg'), '-dsvg', '-r400', '-painters')
% print(append(outpath, 'pECG_LDC_sensitivity_PAPER_review.png'), '-dpng', '-r400', '-painters')
% 
% % QRS
% 
% clear all
% clc
% close all 
% 
% set(0, 'DefaultAxesFontName', 'Times New Roman', ...
%     'defaultUicontrolFontName', 'Times New Roman', ...
%     'defaultUitableFontName', 'Times New Roman', ...
%     'defaultAxesFontName', 'Times New Roman', ...
%     'defaultTextFontName', 'Times New Roman', ...
%     'defaultUipanelFontName', 'Times New Roman');
% set(groot, 'DefaultAxesFontSize', 10); 
% font_size = 10;
% ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% linewidth = 0.5;
% 
% outpath = 'F:/Paper3/Simulations/invivo/he/sample1/';
% 
% experiments_names = {'m20', 'p20', 'baseline'};
% 
% %Colors
% % 1. Black
% color1 = [0, 0, 0, 1];
% color2 = [0, 0.4470, 0.7410];
% color3 = [0.8500, 0.3250, 0.0980];
% colors = {color1, color2, color3};
% 
% width = 23; %cm
% height = 5; %cm
% 
% fig=figure;
% set(fig, 'Units', 'centimeters');
% set(fig, 'Position', [0, 0, width, height]);
% t = tiledlayout(2,6, 'TileSpacing', 'none');
% 
% load(append('F:/Paper3/Simulations/invivo/he/sample1/ecg_results_review_LDC_sensitivity_byWave_alignment2/results.mat'));
% 
% for i=1:size(ECG_headers,2)
%     %ax = subplot(4,3,i);
%     ax = nexttile;
%     
%     for j=1:size(experiments_names,2)
%         if j==size(experiments_names,2)
%             plot(qrs_time, qrs_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
%         else
%             plot(qrs_time, qrs_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
%         end
%         hold on
%     end
%     
%     xticks([0 50 100])
%     xticklabels({'0','50', '100'})
%     
%     title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])
% 
%     if i~=1 && i~=7
%         ax.YTickLabel = [];
%     else
% %         ylabel('norm V [a.u.]','FontSize',font_size)
%     end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
%     
%     if i==6
%         legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
%     end
% 
% end
% han=axes(fig,'visible','off'); 
% han.Title.Visible='on';
% han.XLabel.Visible='on';
% han.YLabel.Visible='on';
% ylabel(han,'norm V (a.u.)','FontSize',font_size);
% xlabel(han,'time (ms)', 'FontSize',font_size);
% 
% 
% set(fig, 'PaperUnits', 'centimeters');
% set(fig, 'PaperPositionMode', 'manual');
% set(fig, 'PaperPosition', [0, 0, width, height]);
% set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
% 
% print(append(outpath, 'pECG_LDC_sensitivity_PAPER_review_QRS.svg'), '-dsvg', '-r400', '-painters')
% print(append(outpath, 'pECG_LDC_sensitivity_PAPER_review_QRS.png'), '-dpng', '-r400', '-painters')


%% gNa sample 6 BZ REVIEW

clear all
clc
close all 

set(0, 'DefaultAxesFontName', 'Times New Roman', ...
    'defaultUicontrolFontName', 'Times New Roman', ...
    'defaultUitableFontName', 'Times New Roman', ...
    'defaultAxesFontName', 'Times New Roman', ...
    'defaultTextFontName', 'Times New Roman', ...
    'defaultUipanelFontName', 'Times New Roman');
set(groot, 'DefaultAxesFontSize', 10); 
font_size = 10;
ECG_headers = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
linewidth = 0.5;

outpath = 'F:/Paper3/Simulations/invivo/mi/cx/sample6_x/';

experiments_names = {'m15', 'p15', 'baseline'};

%Colors
% 1. Black
color1 = [0, 0, 0, 1];
color2 = [0, 0.4470, 0.7410];
color3 = [0.8500, 0.3250, 0.0980];
colors = {color1, color2, color3};

width = 23; %cm
height = 5; %cm

fig=figure;
set(fig, 'Units', 'centimeters');
set(fig, 'Position', [0, 0, width, height]);
t = tiledlayout(2,6, 'TileSpacing', 'none');

load(append('F:/Paper3/Simulations/invivo/mi/cx/sample6_x/ecg_results_electrodesoriginal_norot_BZgNa_sensitivity_byWave_alignment2/results.mat'));

for i=1:size(ECG_headers,2)
    %ax = subplot(4,3,i);
    ax = nexttile;

    for j=1:size(experiments_names,2)
        if j==size(experiments_names,2)
            plot(pECG_tot_time(:,1), pECG_tot_ecgs(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
        else
            plot(pECG_tot_time(:,j+1), pECG_tot_ecgs(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
        end
        hold on
    end
    
    xticks([0 250 500])
    xticklabels({'0','250', '500'})
    
    title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])

    if i~=1 && i~=7
        ax.YTickLabel = [];
    else
%         ylabel('norm V [a.u.]','FontSize',font_size)
    end

    if i<7
        ax.XTickLabel = [];
    else
%         xlabel('time [ms]', 'FontSize',font_size)
    end
    
    if i==6
        legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
    end

end
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'norm V (a.u.)','FontSize',font_size);
xlabel(han,'time (ms)', 'FontSize',font_size);


set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperPositionMode', 'manual');
set(fig, 'PaperPosition', [0, 0, width, height]);
set(fig, 'PaperSize', [width, height]);
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]

print(append(outpath, 'pECG_BZgNa_sensitivity_PAPER_review.svg'), '-dsvg', '-r400', '-painters')
print(append(outpath, 'pECG_BZgNa_sensitivity_PAPER_review.png'), '-dpng', '-r400', '-painters')

% T wave

clc
close all 

width = 23; %cm
height = 5; %cm

fig=figure;
set(fig, 'Units', 'centimeters');
set(fig, 'Position', [0, 0, width, height]);
t = tiledlayout(2,6, 'TileSpacing', 'none');

for i=1:size(ECG_headers,2)
    %ax = subplot(4,3,i);
    ax = nexttile;
    
    for j=1:size(experiments_names,2)
        if j==size(experiments_names,2)
            plot(t_time, t_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
        else
            plot(t_time, t_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
        end
        hold on
    end
    
    xticks([0 100 200])
    xticklabels({'0','100', '200'})
    
    title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-0.9 0.9])

    if i~=1 && i~=7
        ax.YTickLabel = [];
    else
%         ylabel('norm V [a.u.]','FontSize',font_size)
    end

    if i<7
        ax.XTickLabel = [];
    else
%         xlabel('time [ms]', 'FontSize',font_size)
    end
    
    if i==6
        legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
    end

end
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'norm V (a.u.)','FontSize',font_size);
xlabel(han,'time (ms)', 'FontSize',font_size);


set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperPositionMode', 'manual');
set(fig, 'PaperPosition', [0, 0, width, height]);
set(fig, 'PaperSize', [width, height]);
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]

print(append(outpath, 'pECG_BZgNa_sensitivity_PAPER_review_Twave.svg'), '-dsvg', '-r400', '-painters')
print(append(outpath, 'pECG_BZgNa_sensitivity_PAPER_review_Twave.png'), '-dpng', '-r400', '-painters')



% QRS

clc
close all 

width = 23; %cm
height = 5; %cm

fig=figure;
set(fig, 'Units', 'centimeters');
set(fig, 'Position', [0, 0, width, height]);
t = tiledlayout(2,6, 'TileSpacing', 'none');

for i=1:size(ECG_headers,2)
    %ax = subplot(4,3,i);
    ax = nexttile;
    
    for j=1:size(experiments_names,2)
        if j==size(experiments_names,2)
            plot(qrs_time, qrs_sim(:,i,1), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth, 'LineStyle', '-')
        else
            plot(qrs_time, qrs_sim(:,i,j+1), 'Color', cell2mat(colors(j+1)), 'LineWidth',linewidth)
        end
        hold on
    end
    
    xticks([0 50 100])
    xticklabels({'0','50', '100'})
    
    title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])

    if i~=1 && i~=7
        ax.YTickLabel = [];
    else
%         ylabel('norm V [a.u.]','FontSize',font_size)
    end

    if i<7
        ax.XTickLabel = [];
    else
%         xlabel('time [ms]', 'FontSize',font_size)
    end
    
    if i==6
        legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
    end

end
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'norm V (a.u.)','FontSize',font_size);
xlabel(han,'time (ms)', 'FontSize',font_size);


set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperPositionMode', 'manual');
set(fig, 'PaperPosition', [0, 0, width, height]);
set(fig, 'PaperSize', [width, height]);
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]

print(append(outpath, 'pECG_BZgNa_sensitivity_PAPER_review_QRS.svg'), '-dsvg', '-r400', '-painters')
print(append(outpath, 'pECG_BZgNa_sensitivity_PAPER_review_QRS.png'), '-dpng', '-r400', '-painters')