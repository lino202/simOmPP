 clear all
 close all 
 clc
 load('D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_endo_gaur/pECG.mat')

figure;
for i=1:12
    subplot(3,4,i); plot( time , pECG(:,i), "LineWidth", 2 ); title(pECGLabels(i));
    ylabel("Norm V"),xlabel("t(ms)");
end
% exportgraphics(gcf,append(outPath, outName, '.png'),'Resolution',400);