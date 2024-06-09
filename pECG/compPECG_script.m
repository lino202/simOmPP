% This script computes pseudoECG using the heart mesh H.
% This can be generated from getInput4PECG 
% The electrode position is the position of the 10 electrodes for the 12 lead ecgs.

%Options
%Leave this in slow if you are working with huge meshes (millions of cells) and low RAM (32GB)
%Also H can be provided with V or not deppending on RAM


sample = 'sample3/';
experiment = 'results_fib_standard_cs_intra_gaur_rv_septum/';

dataPath      = append('D:/Paper3/Simulations/invivo/he/', sample);
eletrodesPath = 'D:/Paper3/ECG_lead_positions/sampleX/original/';


slow             = 1;
nDigits          = 4;
startTime_ms     = 0;
endTime_ms       = 500;
dt               = 0.25;
outName          = 'pECG';
step             = 4;


compPECG_function(dataPath, eletrodesPath, experiment, slow, nDigits, startTime_ms, endTime_ms, dt, step, outName);
