function function_pecgCorrelations(root_path, experiments_names, result_names, time_res, s2_time)

    fs_sim            = 1/(time_res/1000); % in Hz
    cutoff            = 40;
    nLeads            = 12;

    s2_time           = s2_time + 10; % we add 10 ms in the simulation start
    tot_sim_time      = s2_time + 2000; % in ms, we need at most 2 seconds of sim after s2
    tot_samples       = tot_sim_time / time_res + 1;  % +1 to take into account the zero
    n_experiments = size(result_names, 2);

    ecg_path_results = append(root_path, 'ecg_correlation_results/');
    if ~exist(ecg_path_results, 'dir')
        mkdir(ecg_path_results)
    end

    pECG_tot_ecgs = zeros(tot_samples, nLeads, n_experiments);
    pECG_tot_time = 0:time_res:tot_sim_time;

    %% Load simulations pECGs and plot,
    % We plot the simulations ecg and save them without any normalization nor mean
    % dropping

    for i=1:n_experiments
        load(append(root_path, result_names{i}, '/', 'pECG_electrodesoriginal.mat'), 'pECG', 'pECGLabels');

        if size(pECG,1) == tot_samples
            pECG_tot_ecgs(:,:,i) = pECG;

        elseif size(pECG,1) < tot_samples
            % we extend with the last value
            pECG_tot_ecgs(1:size(pECG,1),:,i) = pECG;
            pECG_tot_ecgs(size(pECG,1)+1:end,:,i) = repmat(pECG(end, :), tot_samples - size(pECG,1), 1);

        elseif size(pECG,1) > tot_samples
            pECG_tot_ecgs(:,:,i) = pECG(1:tot_samples,:);
        end

    end

    fig=figure;
    for i=1:nLeads
        subplot(3,4,i);
        for j=1:n_experiments 
            plot( pECG_tot_time , pECG_tot_ecgs(:,i,j));
            hold on
        end
        ylabel("V"),xlabel("t(ms)");
        title(pECGLabels(i));
        legend(experiments_names,'FontSize',8)
        hold off
    end
    set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
    exportgraphics(gcf,append(ecg_path_results, 'simulations_baseline.png'),'Resolution',400);

    %% Filter pECG

    fN = fs_sim/2;

    fig=figure;
    for i=1:nLeads
        subplot(3,4,i);
        for j=1:n_experiments

            [Bfpb,Afpb]   = butter(3,cutoff/fN,'low');  
            pECG_tot_ecgs(:,i,j) = filtfilt(Bfpb,Afpb,pECG_tot_ecgs(:,i,j)); 

            plot( pECG_tot_time , pECG_tot_ecgs(:,i,j));
            hold on 

        end
        ylabel("V"),xlabel("t(ms)");
        title(pECGLabels(i));
        legend(experiments_names,'FontSize',8)
        hold off
    end
    set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]


    %% Plot pECG processed

    fig=figure;
    for i=1:nLeads
        subplot(3,4,i);
        for j=1:n_experiments 
            pECG_tot_ecgs(:,i,j) = (pECG_tot_ecgs(:,i,j) - min(pECG_tot_ecgs(:,i,j))) / (max(pECG_tot_ecgs(:,i,j))-min(pECG_tot_ecgs(:,i,j)));
            pECG_tot_ecgs(:,i,j) = pECG_tot_ecgs(:,i,j) - mean(pECG_tot_ecgs(1:0.01*fs_sim,i,j));
            plot( pECG_tot_time , pECG_tot_ecgs(:,i,j));
            hold on
        end
        ylabel("Norm V"),xlabel("t(ms)");
        title(pECGLabels(i));
        legend(experiments_names,'FontSize',8)
        hold off
    end
    set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
    exportgraphics(gcf,append(ecg_path_results, 'simulations_final_norm_filtered_', num2str(cutoff), '.png'),'Resolution',400);



    %% Add similarity coefficient and Save results
    % Compute the number of unique correlations (upper triangle without diagonal)
    num_unique = (n_experiments * (n_experiments - 1)) / 2;  % 6x6 matrix → 15 unique values
    excel_file = append(ecg_path_results, 'results.xlsx');

    % Initialize matrix to store unique correlations (15 rows, 12 columns)
    unique_corrs = NaN(num_unique, nLeads);

    % Store case pairs for reference
    pair_labels = cell(num_unique, 1);
    index = 1;


    % Extract unique correlation values for each signal
    for sig = 1:nLeads

        % Compute the correlation matrix (6x6)
        R = corrcoef(squeeze(pECG_tot_ecgs(:, sig, :)));

        % Extract upper triangular values (excluding diagonal)
        for i = 1:n_experiments
            for j = i+1:n_experiments
                unique_corrs(index, sig) = R(i, j);
                if sig == 1  % Only set labels once
                    pair_labels{index} = sprintf('%s-%s', experiments_names{i}, experiments_names{j});
                end
                index = index + 1;
            end
        end

        % Reset index for next signal
        index = 1;
    end

    % Convert to table for better formatting
    T = array2table(unique_corrs, 'RowNames', pair_labels, ...
        'VariableNames', strcat('Signal_', pECGLabels));


    writetable(T, excel_file, 'Sheet', 'Unique_Correlations', 'WriteRowNames', true);

    sim_ecgs  = pECG_tot_ecgs;
    sim_time  = pECG_tot_time;
    sim_labels = pECGLabels;
    save(append(ecg_path_results, 'final_ecgs_pECG.mat'), 'sim_ecgs', 'sim_time', 'fs_sim', 'sim_labels', 'experiments_names');
end

