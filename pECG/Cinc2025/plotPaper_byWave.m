
%% Cinc 2025
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
linewidth = 1;

load('D:/Cinc2025/cocoro/ecg_results_electrodesmanual_norot_byWave_alignment0/results.mat')


outpath = 'D:/Cinc2025/cocoro/ecg_results_electrodesmanual_norot_byWave_alignment0/';

experiments_names = {'Ani', 'Iso'};

%%

%Plot
color1 = [0, 0.4470, 0.7410];
color2 = [0.9290, 0.6940, 0.1250];
color3 = [0.8500, 0.3250, 0.0980];
colors = {color3, color1, color3};

width = 23; %cm
height = 5; %cm


fig=figure;
set(fig, 'Units', 'centimeters');
set(fig, 'Position', [0, 0, width, height]);
t = tiledlayout(2,6, 'TileSpacing', 'none');
for i=1:size(qrs_sim,2)
    %ax = subplot(4,3,i);
    ax = nexttile;
  
    for k=2:3    %we not consider the first which is 024_transcond
        plot(qrs_time, qrs_sim(:,i,k), 'Color', cell2mat(colors(k-1)), 'LineWidth',linewidth)
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

print(append(outpath, 'QRS.svg'), '-dsvg', '-r400')
print(append(outpath, 'QRS.png'), '-dpng', '-r400')

%%
%Plot
color1 = [0, 0.4470, 0.7410];
color2 = [0.9290, 0.6940, 0.1250];
color3 = [0.8500, 0.3250, 0.0980];
colors = {color3, color1, color3};

leads_to_show =[1,2,3,7,8,9,10,11,12];

width = 23; %cm
height = 3; %cm


fig=figure;
set(fig, 'Units', 'centimeters');
set(fig, 'Position', [0, 0, width, height]);
t = tiledlayout(1,length(leads_to_show), 'TileSpacing', 'none');

for i = leads_to_show(:)'
    ax = nexttile;
    
    for k=2:3    %we not consider the first which is 024_transcond
        plot(qrs_time, qrs_sim(:,i,k), 'Color', cell2mat(colors(k-1)), 'LineWidth',linewidth)
        hold on
    end
    
    plot(qrs_time, qrs_exp(:,i), 'k--', 'LineWidth',linewidth)
    hold on

    xticks([0 50 100])
    xticklabels({'0','50', '100'})
    %legend(experiments_names,'FontSize',font_size-4) %, 'Location', 'bestoutside')
    title(ECG_headers{i}, 'FontSize',font_size), xlim tight, ylim([-1 1])

    if i~=1 && i~=7
        ax.YTickLabel = [];
    else
%         ylabel('norm V [a.u.]','FontSize',font_size)
    end
% 
%     if i<7
%         ax.XTickLabel = [];
%     else
% %         xlabel('time [ms]', 'FontSize',font_size)
%     end
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

%     name = strrep(cell2mat(experiments_names(j)),'HE', '');
%     name = strrep(name,' ', '');

print(append(outpath, 'QRS_SOMELEADS.svg'), '-dsvg', '-r400')
print(append(outpath, 'QRS_SOMELEADS.png'), '-dpng', '-r400')

