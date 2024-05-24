clear all
close all 
clc

sample = 'sample1';

%% Load simulations and median exp beats
load(append('D:/Paper3/Simulations/invivo/he/', sample,'/results_fib_standard_cs_endo_gaur/pECG.mat'));
load(append('D:/Paper3/Simulations/invivo/he/', sample,'/results_fib_standard_cs_endo_gaur/pECG.mat'));
load(append('D:/Paper3/Simulations/invivo/he/', sample,'/results_fib_standard_cs_endo_gaur/pECG.mat'));
load(append('D:/Paper3/Simulations/invivo/he/', sample,'/results_fib_standard_cs_endo_gaur/pECG.mat'));
load(append('D:/Paper3/Simulations/invivo/he/', sample,'/results_fib_standard_cs_endo_gaur/pECG.mat'));
load(append('D:/Paper3/Simulations/invivo/he/', sample,'/results_fib_standard_cs_endo_gaur/pECG.mat'));
load()

figure;
for i=1:12
subplot(3,4,i); plot( time , pECG(:,i), "LineWidth", 2 ); title(pECGLabels(i));
ylabel("Norm V"),xlabel("t(ms)");
end


figure
for i=1:size(ECG_headers,2)

    subplot(4,3,i)
    plot(ECG_time, median_beats(:,i))
    title(ECG_headers(i)), xlim tight, xlabel('time (ms)'),ylabel('norm V')

end

% exportgraphics(gcf,append(outPath, outName, '.png'),'Resolution',400);