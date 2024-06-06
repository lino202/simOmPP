clear all
close all 
clc

experiment = 'results_fib_standard_cs_intra_gaur';
sample     = 'sample2';
data_path  = append('D:/pECGbyT.mat');
outPath    = append('D:/pECGbyT');
% 
% data_path  = append('D:/Paper3/Simulations/invivo/he/', sample, '/', experiment, '/pECG.mat');
% outPath    = append('D:/Paper3/Simulations/invivo/he/', sample, '/', experiment, '/pECG_plot');
load(data_path)

figure;
for i=1:12
    %subplot(3,4,i); plot( time , pECG(:,i), "LineWidth", 2 ); title(pECGLabels(i));
    subplot(3,4,i); plot(pECG(:,i) );
    ylabel("Norm V"),xlabel("t(ms)");
end
exportgraphics(gcf,append(outPath, '.png'),'Resolution',400);