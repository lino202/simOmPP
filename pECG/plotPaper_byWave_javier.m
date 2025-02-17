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


%% Best beats
clear all
clc
close all 

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

load('D:/Paper3/Simulations/invivo/he/best_ecg/ecg_results_electrodesprecordmanual_final_rot3_byWave_alignment2/results.mat')
qrs_sim_aHERP = qrs_sim;

outpath = 'D:/Paper3/Simulations/invivo/he/best_ecg/';

experiments_names = {'Sim', 'Exp'};

%Plot
color1 = [0, 0.4470, 0.7410];
color2 = [0.9290, 0.6940, 0.1250];
color3 = [0.8500, 0.3250, 0.0980];
colors = {color1};

width = 23; %cm
height = 5; %cm


fig=figure;
set(fig, 'Units', 'centimeters');
set(fig, 'Position', [0, 0, width, height]);
t = tiledlayout(2,6, 'TileSpacing', 'none');
for i=1:size(qrs_sim_aHERP,2)
    %ax = subplot(4,3,i);
    ax = nexttile;
  
    for k=3:3
        plot(qrs_time, qrs_sim_aHERP(:,i,k), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth)
        hold on
    end
    
    
    plot(qrs_time, qrs_exp(:,i), 'k--', 'LineWidth',linewidth)
    hold on
    %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
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
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'norm V [a.u.]','FontSize',font_size);
xlabel(han,'time [ms]', 'FontSize',font_size);


set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperPositionMode', 'manual');
set(fig, 'PaperPosition', [0, 0, width, height]);
set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]

print(append(outpath, 'QRS_pig3_Javier.svg'), '-dsvg', '-r400')
print(append(outpath, 'QRS_pig3_Javier.png'), '-dpng', '-r400')



%% Best beats
clear all
clc
close all 

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

load('D:/Paper3/Simulations/invivo/he/best_ecg/ecg_results_electrodesprecordmanual_final_rot3_byWave_alignment2/results.mat')
qrs_sim_aHERP = t_sim;

outpath = 'D:/Paper3/Simulations/invivo/he/best_ecg/';

experiments_names = {'Sim', 'Exp'};

%Plot
color1 = [0, 0.4470, 0.7410];
color2 = [0.9290, 0.6940, 0.1250];
color3 = [0.8500, 0.3250, 0.0980];
colors = {color1};

width = 23; %cm
height = 5; %cm


fig=figure;
set(fig, 'Units', 'centimeters');
set(fig, 'Position', [0, 0, width, height]);
t = tiledlayout(2,6, 'TileSpacing', 'none');
for i=1:size(qrs_sim_aHERP,2)
    %ax = subplot(4,3,i);
    ax = nexttile;
  
    for k=1:1
        plot(t_time, qrs_sim_aHERP(:,i,k), 'Color', cell2mat(colors(1)), 'LineWidth',linewidth)
        hold on
    end
    
    
    plot(t_time, t_exp(:,i), 'k--', 'LineWidth',linewidth)
    hold on
    %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
    title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-0.6 0.6])

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
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'norm V [a.u.]','FontSize',font_size);
xlabel(han,'time [ms]', 'FontSize',font_size);


set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperPositionMode', 'manual');
set(fig, 'PaperPosition', [0, 0, width, height]);
set(fig, 'PaperSize', [width, height]);
% set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]

print(append(outpath, 'T_pig1_Javier.svg'), '-dsvg', '-r400')
print(append(outpath, 'T_pig1_Javier.png'), '-dpng', '-r400')



