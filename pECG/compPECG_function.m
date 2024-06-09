function compPECG_function(dataPath, eletrodesPath, experiment, slow, nDigits, startTime_ms, endTime_ms, dt, step, outName)

    % This script computes pseudoECG using the heart mesh H.
    % This can be generated from getInput4PECG 
    % The electrode position is the position of the 10 electrodes for the 12 lead ecgs.

    %Options
    %Leave this in slow if you are working with huge meshes (millions of cells) and low RAM (32GB)
    %Also H can be provided with V or not deppending on RAM

    addpath Tools/
    load(append(dataPath, 'mesh_aligned_sampleX.mat'), 'H');
    load(append(eletrodesPath, 'electrodes_positions.mat'), 'electrodes_positions');
    outPath = append(dataPath, experiment);
    ensPath = append(dataPath, experiment, 'tissue/tissue_solution');

    samples = startTime_ms*1/dt:step:endTime_ms*1/dt;
    n_samples = numel(samples);
    n_nodes   = size(H.xyz,1);

    % Position of each electrode
    E = [ electrodes_positions.eLA ; electrodes_positions.eRA ; 
        electrodes_positions.eLL ; electrodes_positions.eRL ;
        electrodes_positions.eV1 ; electrodes_positions.eV2 ;
        electrodes_positions.eV3 ; electrodes_positions.eV4 ;
        electrodes_positions.eV5 ; electrodes_positions.eV6 ];


    % Center of the tetrahedra
    H.triCENTER = meshFacesCenter( H );

    % Volume of the tetrahedra
    H.triVOL    = meshVolume( H , 'volume' );

    % Precomputation of the linear operator to calculate the voltage gradient at each time.
    H.Gop       = meshGradient( H );

    tic
    if (slow && isfield(H, 'v'))

        %CASE 1
        disp("Compute ECG in slow mode (step by step) with Voltages per node on H matrix")
        pECG = zeros(numel(samples),12);
        for t = 1:numel(samples)
            fprintf("Step %d/%d", t, n_samples);
            H.triG = reshape( H.Gop * H.v(:,t), [],3);
            pECG(t,:) = computePECG( H , E );
        end

    elseif (slow && ~isfield(H, 'v'))

        %CASE 2
        disp("Compute ECG in slow mode (step by step) with reading Voltages per step")
        pECG = zeros(numel(samples),12);
        for t = 1:numel(samples)

            %This read only is valid for .ens in binary saved by Electra
            numberSolFile = num2str(samples(t), append('%0',int2str(nDigits),'d'));
            name          = append(ensPath, '', numberSolFile, '.ens');
            fprintf("Step %d/%d: %s\n", t, n_samples, name);

            Voltage       = readEnsBinaryElectra(name, n_nodes);
            %As voltage is single precision cast it
            H.triG        = reshape( H.Gop * double(Voltage(:)), [], 3);
            pECG(t,:)     = computePECG( H , E );
        end

    else

        %CASE 3
        disp("Compute ECG in fast mode but with an increase RAM requirement")
        for t=1:numel(samples)
            fprintf("Step %d/%d", t, n_samples);
            H.triG(:,:,t) = reshape( H.Gop * H.v(:,t), [], 3);
        end
        pECG = computePECG( H , E );  

    end
    toc

    %% Plot and Save

    time = samples * dt;
    pECGLabels = [ "I" , "II" , "III" , "aVR" , "aVL" , "aVF" , "V1" , "V2" , "V3" , "V4" , "V5" , "V6" ];
%     figure;
%     for i=1:12
%         subplot(3,4,i); plot( time , pECG(:,i), "LineWidth", 2 ); title(pECGLabels(i));
%         ylabel("Norm V"),xlabel("t(ms)");
%     end
%     exportgraphics(gcf,append(outPath, outName, '.png'),'Resolution',400);
    save(append(outPath, outName, '.mat'), 'pECG', 'time', 'pECGLabels');

end
