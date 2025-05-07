function [qrs_sim, qrs_exp,qrs_time] = function_processSampleECG_HE_byWave_Cinc2025(root_path, sample, experiments_names, result_names, dt_sim, pecg_name, results_folder_name, alignment)

% For using this code you need to delineate the signal with
% BiosigBrowser from https://bsicos.i3a.es/

% alignment has several ways of alignments:
%     1 - alignment == 1 ; we use the individual fiducial for moving leads individually and the max corr
%     2 - alignment == 2 ; move all leads equally for one case, no use maxcorr (just using the fiducials)
%     3 - alignment == any numb ; signals are aligned individually and no max corr

addpath Tools/
set(0, 'DefaultAxesFontName', 'Times New Roman', ...
    'defaultUicontrolFontName', 'Times New Roman', ...
    'defaultUitableFontName', 'Times New Roman', ...
    'defaultAxesFontName', 'Times New Roman', ...
    'defaultTextFontName', 'Times New Roman', ...
    'defaultUipanelFontName', 'Times New Roman');
set(groot, 'DefaultAxesFontSize', 13); 
font_size = 16;

% FIXED ATTRIBUTES
cutoff            = 55;
nLeads            = 12;
tot_time_ms       = 170;
qrs_width = 50;
linewidth = 2;

n_experiments     = size(result_names,2);
fs_sim            = 1/dt_sim; % in Hz;
samples_per_beat_sim = 1 + tot_time_ms / (dt_sim*1000);    % minimum sim duration to be use so cropped to this amount
ecg_path_results = append(root_path, sample, '/', results_folder_name, '/');

sim_path = append(root_path, sample,'/', result_names{1}, '/'); % just a path to put some tmp files
%% Initialization

if ~exist(ecg_path_results, 'dir')
    mkdir(ecg_path_results)
end
ecg_path_results_debug = append(ecg_path_results, 'debug_images/');
if ~exist(ecg_path_results_debug, 'dir')
    mkdir(ecg_path_results_debug)
end

cleaned_experiment_names = cell(1,n_experiments);
for i=1:n_experiments+1
    cleaned_experiment_names{i}= strrep(experiments_names{i},'}','');
    cleaned_experiment_names{i}= strrep(cleaned_experiment_names{i},'{\it ','');
end

pECG_tot_ecgs = zeros(samples_per_beat_sim, nLeads, n_experiments);
pECG_tot_time = zeros(samples_per_beat_sim, n_experiments);

%% Load simulations pECGs and plot,
% We plot the simulations ecg and save them without any normalization nor mean
% dropping

for i=1:n_experiments
    load(append(root_path, sample,'/', result_names{i}, '/', pecg_name{i}), 'pECG', 'time', 'pECGLabels');
    pECG_tot_ecgs(:,:,i) = pECG(1:samples_per_beat_sim,:);
    pECG_tot_time(:,i) = time(1:samples_per_beat_sim);
end

fig=figure;
for i=1:nLeads
    subplot(3,4,i);
    for j=1:n_experiments 
        plot( pECG_tot_time(:,j) , pECG_tot_ecgs(:,i,j));
        hold on
    end
    ylabel("V [a.u.]"),xlabel("t [ms]");
    title(pECGLabels(i));
    legend(experiments_names,'FontSize',font_size-4)
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
        
        plot( pECG_tot_time(:,j) - min(pECG_tot_time(:,j)), pECG_tot_ecgs(:,i,j));
        hold on 
        
    end
    ylabel("V [a.u.]"),xlabel("t [ms]");
    title(pECGLabels(i));
    legend(experiments_names,'FontSize',font_size-4)
    hold off
end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
%% Compute the qrs, t and qt dur,
% We also get the qrs and t peak times for for aligning with the experimental ecg

sim_qrs_locs = zeros(n_experiments,nLeads,3); % QRSon, QRS, QRSoff
filename       = 'simple_ecg';
for j=1:n_experiments
    for i=1:nLeads

        single_ecg    = repmat(pECG_tot_ecgs(:,i,j)',[1,10]);
        single_time   = 0:1/fs_sim*1000:size(single_ecg,2)/fs_sim*1000 - 1/fs_sim*1000;
        

        % Try with findpeaks 
        [pks, locs] = findpeaks(abs(single_ecg), "MinPeakDistance", size(single_ecg,2)/10 - 2);
        if isempty(pks)
            error("Could not find qrs pks!")
        end
        
        figure(100), plot(single_time, single_ecg),
        try
            hold on, plot(single_time(locs(3:end-2)),    single_ecg(locs(3:end-2)), 'r*'),

        catch
    
        end
        title(pECGLabels(i)), xlim tight, xlabel('time [ms]'),ylabel('V')
        hold off
        exportgraphics(gcf,append(ecg_path_results_debug, cleaned_experiment_names{j},'_',pECGLabels(i), '.png'));
        
        % Get the results and qrs and t idxs
        idx = find(locs>samples_per_beat_sim*5, 1 );

        sim_qrs_locs(j,i,2) = locs(idx) - samples_per_beat_sim*5;


    end
end


%% Plot pECG processed and time zeroed

fig=figure;
for i=1:nLeads
    subplot(3,4,i);
    for j=1:n_experiments 
        % We normalize each one separately for comparing with exp
        % but if its all simulations you can do it with the largest and
        % smallest value from the pool, as in that situation you can
        % compare ecgs amplitude but no with experimental ones.
        pECG_tot_ecgs(:,i,j) = (pECG_tot_ecgs(:,i,j) - min(pECG_tot_ecgs(:,i,j))) / (max(pECG_tot_ecgs(:,i,j))-min(pECG_tot_ecgs(:,i,j)));
%         pECG_tot_ecgs(:,i,j) = (pECG_tot_ecgs(:,i,j) - min(pECG_tot_ecgs,[],'all')) / (max(pECG_tot_ecgs,[],'all')-min(pECG_tot_ecgs,[],'all'));

        
        pECG_tot_ecgs(:,i,j) = pECG_tot_ecgs(:,i,j) - pECG_tot_ecgs(1,i,j);
        pECG_tot_time(:,j)   = pECG_tot_time(:,j) - min(pECG_tot_time(:,j));
        plot( pECG_tot_time(:,j) , pECG_tot_ecgs(:,i,j), 'LineWidth',linewidth);
        hold on
    end
    ylabel("norm V [a.u.]"),xlabel("t [ms]");
    title(pECGLabels(i));
    legend(experiments_names,'Location','best','FontSize',font_size-4)
    hold off
end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
exportgraphics(gcf,append(ecg_path_results, 'simulations_filtered_norm.png'),'Resolution',400);
%% Load experimental

exp_path = 'F:/Paper3/Experimental/ECGs/ecg_cerdo_sano_dylan/median_beats/';
load(append(exp_path, 'median_beats.mat'), 'median_beats','ECG_headers', 'fs');

% as fs is 2000 so we have 2000 samples per second, taking 1 every 2 samples
% we have a fs of 1000 -> 1000 samples per second
median_beats = median_beats(1:2:end,:);
fs_exp = 1000;

%% Extract ventricular from experimental ECG
exp_qrs_locs = zeros(1,nLeads,3);
exp_t_locs   = zeros(1,nLeads,3);

for i=1:nLeads
    median_beats(:,i) = (median_beats(:,i)-min(median_beats(:,i))) / (max(median_beats(:,i)) - min(median_beats(:,i)));
    median_beats(:,i) = median_beats(:,i) - median_beats(1,i);
    single_ecg    = repmat(median_beats(:,i)',[1,10]);
    samples_per_beat_exp = size(median_beats(:,i),1);
    single_time   = 0:1/fs_exp*1000:size(single_ecg,2)/fs_exp*1000 - 1/fs_exp*1000;
    [positionqrs_exp] = wavedelianation_func(append(pwd,'/stable/'), sim_path, filename, single_ecg, fs_exp, [0 0 0], []);
    
    figure(200), plot(single_time, single_ecg),
    hold on, plot(single_time(positionqrs_exp.qrs(3:end-2)),    single_ecg(positionqrs_exp.qrs(3:end-2)), 'r*'),
    hold on, plot(single_time(positionqrs_exp.QRSon(3:end-2)),  single_ecg(positionqrs_exp.QRSon(3:end-2)), 'r*'),
    hold on, plot(single_time(positionqrs_exp.QRSoff(3:end-2)), single_ecg(positionqrs_exp.QRSoff(3:end-2)), 'r*'),
    hold on, plot(single_time(positionqrs_exp.T(3:end-2)),    single_ecg(positionqrs_exp.T(3:end-2)), 'g+'),
    hold on, plot(single_time(positionqrs_exp.Ton(3:end-2)),  single_ecg(positionqrs_exp.Ton(3:end-2)), 'g+'),
    hold on, plot(single_time(positionqrs_exp.Toff(3:end-2)), single_ecg(positionqrs_exp.Toff(3:end-2)), 'g+'),
    title(ECG_headers{i}), xlim tight, xlabel('time [ms]'),ylabel('V')
    hold off
    exportgraphics(gcf,append(ecg_path_results_debug, cleaned_experiment_names{end}, '_',pECGLabels(i), '.png'));
    
    exp_qrs_locs(1,i,1) = positionqrs_exp.QRSon(5) - samples_per_beat_exp*5;
    exp_qrs_locs(1,i,2) = positionqrs_exp.qrs(5) - samples_per_beat_exp*5;
    exp_qrs_locs(1,i,3) = positionqrs_exp.QRSoff(5) - samples_per_beat_exp*5;
    
    exp_t_locs(1,i,1) = positionqrs_exp.Ton(5) - samples_per_beat_exp*5;
    exp_t_locs(1,i,2) = positionqrs_exp.T(5) - samples_per_beat_exp*5;
    exp_t_locs(1,i,3) = positionqrs_exp.Toff(5) - samples_per_beat_exp*5;

end



%% Cut QRS and T, save and plot
% We can only use fs_exp here because the simulations were sampled at a
% higher freq than the experiment
qrs_sim = zeros(round(qrs_width*2*(fs_exp/1000)+1),nLeads, n_experiments);
qrs_exp = zeros(round(qrs_width*2*(fs_exp/1000)+1),nLeads);
qrs_time = 0:1/fs_exp*1000:qrs_width*2;



% QRS
fig=figure;
for i=1:nLeads
    subplot(4,3,i);
    
    % Experimental
    median_qrs_loc_exp = round(median(exp_qrs_locs(1,:,2)));
    qrs_exp(:,i) = median_beats(median_qrs_loc_exp-round(qrs_width*(fs_exp/1000)):median_qrs_loc_exp+round(qrs_width*(fs_exp/1000)),i);
%     qrs_exp(:,i) = (qrs_exp(:,i)-min(qrs_exp(:,i))) / (max(qrs_exp(:,i)) - min(qrs_exp(:,i)));
%     qrs_exp(:,i) = qrs_exp(:,i) - qrs_exp(1,i);
    for j=1:n_experiments
        if alignment == 2
            median_qrs_loc_sim = round(median(sim_qrs_locs(j,:,2)));
        else
            median_qrs_loc_sim = sim_qrs_locs(j,i,2);
        end

        
        if median_qrs_loc_sim - round(qrs_width*(fs_sim/1000)) < 0
            samples_to_add = abs(median_qrs_loc_sim-round(qrs_width*(fs_sim/1000)));
            tmp_sim = [ones(1,samples_to_add)*pECG_tot_ecgs(1,i,j) pECG_tot_ecgs(1:round(qrs_width*2*(fs_sim/1000))-samples_to_add+1,i,j)'];
        elseif median_qrs_loc_sim - round(qrs_width*(fs_sim/1000)) == 0
            tmp_sim = pECG_tot_ecgs(median_qrs_loc_sim-round(qrs_width*(fs_sim/1000))+1:median_qrs_loc_sim+round(qrs_width*(fs_sim/1000)+1),i,j);
        else
            tmp_sim = pECG_tot_ecgs(median_qrs_loc_sim-round(qrs_width*(fs_sim/1000)):median_qrs_loc_sim+round(qrs_width*(fs_sim/1000)),i,j);
        end
        
        qrs_sim(:,i,j) = tmp_sim(1:round(fs_sim/fs_exp):end);

        if alignment == 1
            % Align with xcorr for having the max correlation
            tmp_sim = qrs_sim(:,i,j);
            [corrs, lags]= xcorr(qrs_exp(:,i), tmp_sim, 'normalized');
            [~,idx] = max(abs(corrs));
            delay = lags(idx);

            % we checked with circshift this is ok
            if delay<0
                qrs_sim(:,i,j) = [tmp_sim(-delay+1:end); ones(-delay,1)*tmp_sim(end)]; % add one as matlab uses not 0 index
            else
                qrs_sim(:,i,j) = [ones(delay,1)*tmp_sim(1); tmp_sim(1:end-(delay))];
            end
        end


        
        plot(qrs_time, qrs_sim(:,i,j), 'LineWidth',linewidth)
        hold on
    end
    plot(qrs_time, qrs_exp(:,i), 'k--', 'LineWidth',linewidth)
    hold on
    legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside', 'Interpreter','latex')
    title(ECG_headers{i}, 'FontSize',font_size), xlim tight, xlabel('time [ms]', 'FontSize',font_size),ylabel('norm V [a.u.]','FontSize',font_size)

end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
exportgraphics(gcf,append(ecg_path_results, 'QRS_final_filtered_', num2str(cutoff), '.pdf'),'Resolution',400);
exportgraphics(gcf,append(ecg_path_results, 'QRS_final_filtered_', num2str(cutoff), '.png'),'Resolution',400);


%% Add similarity coefficient
results    = ones(2,nLeads,n_experiments)*nan;
for i=1:nLeads
    for j=1:n_experiments
        C = corrcoef(qrs_sim(:,i,j), qrs_exp(:,i));
        results(1,i,j) = C(1,2);
    end
end

%% Save results 
excel_file = append(ecg_path_results, 'results_byWave.xlsx');
tot_resuls_4_excel = cell(n_experiments*nLeads+1,6); %we have 4 columns (exp, lead_name,lead_number, qrs, t), and the rows need to contain the header 

tot_resuls_4_excel{1,1} = 'simulation';
tot_resuls_4_excel{1,2} = 'lead_number';
tot_resuls_4_excel{1,3} = 'lead_name';
tot_resuls_4_excel{1,4} = 'qrs_similarity';
tot_resuls_4_excel{1,5} = 't_similarity';

for i=1:nLeads
    for j=1:n_experiments
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),1} = cleaned_experiment_names{j};
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),2} = i;
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),3} = ECG_headers{i};
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),4} = results(1,i,j);
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),5} = results(2,i,j);
    end
end 
        
writecell(tot_resuls_4_excel, excel_file);

save(append(ecg_path_results,'results.mat'), 'qrs_sim', 'qrs_exp', 'qrs_time', 'pECG_tot_ecgs', 'pECG_tot_time')
end

