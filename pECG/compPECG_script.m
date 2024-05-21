% This script computes pseudoECG using the heart mesh H.
% This can be generated from getInput4PECG 
% The electrode position is the position of the 10 electrodes for the 12 lead ecgs.

%Options
%Leave this in slow if you are working with huge meshes (millions of cells) and low RAM (32GB)
%Also H can be provided with V or not deppending on RAM


% sample = sample1 
% experiment = 'results_fib_standard_cs_endo_tentusscher/';

dataPath      = append('D:/Paper3/Simulations/invivo/he/', sample);
eletrodesPath = 'D:/Paper3/ECG_lead_positions/sampleX/';


slow             = 1;
nDigits          = 5;
startTime_ms     = 2000;
endTime_ms       = 2600;
dt               = 0.25;
outName          = 'pECG';


compPECG_function(dataPath, eletrodesPath, experiment, slow, nDigits, startTime_ms, endTime_ms, dt, outName);
