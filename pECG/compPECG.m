% This script computes pseudoECG using the heart mesh H.
% This can be generated from getInput4PECG 
% The electrode position is the one provided by Ana, and we apply rigid
% deformation in order to match geometries.
clear all; clc; close all;
addpath Tools/

%Options
dataPath = 'F:/Simulations/electra_sims/Heart/OM_RM_MI/sampleP21_389/maxvol/healthy/';
load(append(dataPath, 'sampleP21_389_PECG.mat'));
slow = 1; %Leave this in slow if you are working with huge meshes (millions of cells) and low RAM (32GB)
T = 0:1:size(H.v,2)-1;

% Position of each electrode
eLA = [ 14.41309000  ,  -3.80047600 ,  13.59785000 ];
eRA = [ -15.74411000 ,  -4.34325800 ,  14.09159000 ];
eLL = [ 12.14477000  ,  -9.14008000 , -25.43759000 ];
eRL = [ -11.02025000 , -12.03128000 , -24.49993000 ];
eV1 = [ -1.78257000  , -14.36168000 ,  -2.99636400 ];
eV2 = [ 0.83096220   , -14.26329000 ,  -3.32246100 ];
eV3 = [ 4.47476800   , -14.48092000 ,  -5.08418200 ];
eV4 = [ 7.88471500   , -13.67258000 ,  -7.50228200 ];
eV5 = [ 13.47446000  ,  -8.68600900 ,  -6.12646600 ];
eV6 = [ 15.52410000  ,  -0.24334610 ,  -3.30821600 ];

E = [ eLA ; eRA ; eLL ; eRL ; eV1 ; eV2 ; eV3 ; eV4 ; eV5 ; eV6 ];
E = E*10;  %electrodes are based ina geometry in cm, so to be in mm -> *10


% Center of the tetrahedra
H.triCENTER = meshFacesCenter( H );

% Volume of the tetrahedra
H.triVOL    = meshVolume( H , 'volume' );

% Precomputation of the linear operator to calculate the voltage gradient at each time.
H.Gop       = meshGradient( H );

tic
if slow
    pECG = zeros(numel(T),12);
    for t = 1:numel(T)
      disp(t)

      H.triG = reshape( H.Gop * H.v(:,t), [],3);
      % Computation of pseudoECG.
      pECG(t,:) = computePECG( H , E );
    end
else
    for t=1:numel(T)
        disp(t)
        H.triG(:,:,t) = reshape( H.Gop * H.v(:,t), [], 3);
    end
    % Computation of pseudoECG.
    pECG = computePECG( H , E );  
end
toc

pECGLabels = [ "I" , "II" , "III" , "aVR" , "aVL" , "aVF" , "V1" , "V2" , "V3" , "V4" , "V5" , "V6" ];
figure;
for i=1:12
    subplot(3,4,i); plot( T , pECG(:,i), "LineWidth", 2 ); title(pECGLabels(i));
    ylabel("V(mV)"),xlabel("t(ms)");
end

saveas(gcf, append(dataPath, 'pECG.png'));
save(append(dataPath, 'pECG.mat'), 'pECG');





