clear all
close all 
clc

% For using this code you need to delineate the signal with
% BiosigBrowser from https://bsicos.i3a.es/

addpath Tools/

root_path         = 'D:/Paper3/Simulations/invivo/he/';
sample            = 'best_ecg';

experiments_names = {'s1', 's2', 's3', 'exp'};
result_names      = {'sample1', ...
                     'sample2', ...
                     'sample3'};

n_experiments     = 3;
dt_sim            = 0.00025; %s
exp_sim_factor    = 1;%0.7686;      % RR ratio between exp and sim, put to 1 for having the real simulation timings
dt_sim_out        = dt_sim * exp_sim_factor;

fs_sim            = 1/dt_sim_out; % in Hz;
cutoff            = 40;
pecg_name         = 'pECG_precord_manual_v6_rot3.mat';
nLeads            = 12;

tot_time_ms          = 500;
samples_per_beat_sim = 1 + tot_time_ms / (dt_sim*1000);    % minimum sim duration to be use so cropped to this amount

ecg_path_results = append(root_path, sample, '/', 'ecg_results_precord_manual_v6_rot3_40_best/');
if ~exist(ecg_path_results, 'dir')
    mkdir(ecg_path_results)
end
ecg_path_results_debug = append(ecg_path_results, 'debug_images/');
if ~exist(ecg_path_results_debug, 'dir')
    mkdir(ecg_path_results_debug)
end

pECG_tot_ecgs = zeros(samples_per_beat_sim, nLeads, n_experiments);
pECG_tot_time = zeros(samples_per_beat_sim, n_experiments);

%% Load simulations pECGs and plot,
% We plot the simulations ecg and save them without any normalization nor mean
% dropping

for i=1:n_experiments
    load(append(root_path, sample,'/', result_names{i}, '/', pecg_name));
    pECG_tot_ecgs(:,:,i) = pECG(1:samples_per_beat_sim,:);
    pECG_tot_time(:,i) = time(1:samples_per_beat_sim) * exp_sim_factor;
end

fig=figure;
for i=1:nLeads
    subplot(3,4,i);
    for j=1:n_experiments 
        plot( pECG_tot_time(:,j) , pECG_tot_ecgs(:,i,j));
        hold on
    end
    ylabel("V (a.u.)"),xlabel("t(ms)");
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
        
        plot( pECG_tot_time(:,j) - min(pECG_tot_time(:,j)), pECG_tot_ecgs(:,i,j));
        hold on 
        
    end
    ylabel("V (a.u.)"),xlabel("t(ms)");
    title(pECGLabels(i));
    legend(experiments_names,'FontSize',8)
    hold off
end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
%% Compute the qrs, t and qt dur,
% We also get the qrs for every lead and sim so a mean per lead is used for aligning
% the experimental ecg

sim_qrses_locs = zeros(n_experiments,nLeads);
results_sim    = cell(n_experiments,nLeads);
filename       = 'simple_ecg';
for j=1:n_experiments
    for i=1:nLeads
        results_sim{j,i} = cell(6,2);
        results_sim{j,i}{1,1} = 'name';
        results_sim{j,i}{1,2} = append(experiments_names{j}, '_', pECGLabels{i});

        single_ecg    = repmat(pECG_tot_ecgs(:,i,j)',[1,10]);
        single_time   = 0:1/fs_sim*1000:size(single_ecg,2)/fs_sim*1000 - 1/fs_sim*1000;
        
        sim_path = append(root_path, sample,'/', result_names{j}, '/'); % just a path to put some tmp files
        [positionqrs_sim] = wavedelianation_func(append(pwd,'/stable/'), sim_path, filename, single_ecg, fs_sim, [0 0 0], []);
        
        %Check if T wave exist and is not taken as qrs
        if (~isempty(positionqrs_sim.qrs))
            if (all(isnan(positionqrs_sim.T)) || all(isnan(positionqrs_sim.Ton)) || all(isnan(positionqrs_sim.Toff)))
                [pks, locs] = findpeaks(single_ecg(positionqrs_sim.qrs));

                if isempty(pks)

                    ann.time    = positionqrs_sim.qrs';
                    ann.anntyp  = repmat('N', size(positionqrs_sim.qrs'));
                else
                    ann.time    = positionqrs_sim.qrs(locs)';
                    ann.anntyp  = repmat('N', size(positionqrs_sim.qrs(locs)'));
                end


                writeannot(strcat(sim_path,filename,'.qrs'),ann); 
                [positionqrs_sim] = wavedelianation_func(append(pwd,'/stable/'), sim_path, filename, single_ecg, fs_sim, [1 0 0], 0);
                delete(strcat(sim_path,filename,'.qrs'));
            end
        else
            % Try with findpeaks if wavedet failed
            [pks, locs] = findpeaks(abs(single_ecg), "MinPeakDistance", size(single_ecg,2)/10 - 2);
            if isempty(pks)
                error("Could not find qrs pks!")
            else
                ann.time    = locs';
                ann.anntyp  = repmat('N', size(locs'));
            end
            writeannot(strcat(sim_path,filename,'.qrs'),ann); 
            [positionqrs_sim] = wavedelianation_func(append(pwd,'/stable/'), sim_path, filename, single_ecg, fs_sim, [1 0 0], 0);
            delete(strcat(sim_path,filename,'.qrs'));
        end
        
        figure(100), plot(single_time, single_ecg),
        try
            hold on, plot(single_time(positionqrs_sim.qrs(3:end-2)),    single_ecg(positionqrs_sim.qrs(3:end-2)), 'r*'),
            hold on, plot(single_time(positionqrs_sim.QRSon(3:end-2)),  single_ecg(positionqrs_sim.QRSon(3:end-2)), 'r*'),
            hold on, plot(single_time(positionqrs_sim.QRSoff(3:end-2)), single_ecg(positionqrs_sim.QRSoff(3:end-2)), 'r*'),
            hold on, plot(single_time(positionqrs_sim.T(3:end-2)),    single_ecg(positionqrs_sim.T(3:end-2)), 'g+'),
            hold on, plot(single_time(positionqrs_sim.Ton(3:end-2)),  single_ecg(positionqrs_sim.Ton(3:end-2)), 'g+'),
            hold on, plot(single_time(positionqrs_sim.Toff(3:end-2)), single_ecg(positionqrs_sim.Toff(3:end-2)), 'g+'),
        catch
    
        end
        title(pECGLabels(i)), xlim tight, xlabel('time (ms)'),ylabel('V')
        hold off
        exportgraphics(gcf,append(ecg_path_results_debug, results_sim{j,i}{1,2}, '.png'));
        
        idx = find(positionqrs_sim.qrs>samples_per_beat_sim*5, 1 );
        sim_qrses_locs(j,i) = positionqrs_sim.qrs(idx) - samples_per_beat_sim*5;
        results_sim{j,i}{2,1} = 'qrs_dur';
        results_sim{j,i}{2,2} = (positionqrs_sim.QRSoff(5) - positionqrs_sim.QRSon(5)) * 1/fs_sim*1000; %ms
        results_sim{j,i}{3,1} = 'qt_dur';   
        results_sim{j,i}{3,2} = (positionqrs_sim.Toff(5)   - positionqrs_sim.QRSon(5)) * 1/fs_sim*1000;
        results_sim{j,i}{4,1} = 't_dur';
        results_sim{j,i}{4,2} = (positionqrs_sim.Toff(5)   - positionqrs_sim.Ton(5))   * 1/fs_sim*1000;

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
        plot( pECG_tot_time(:,j) , pECG_tot_ecgs(:,i,j));
        hold on
    end
    ylabel("Norm V"),xlabel("t(ms)");
    title(pECGLabels(i));
    legend(experiments_names,'Location','best','FontSize',8)
    hold off
end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
exportgraphics(gcf,append(ecg_path_results, 'simulations_filtered_norm.png'),'Resolution',400);
%% Load experimental

exp_path = 'D:/Paper3/Experimental/ECGs/ecg_cerdo_sano_dylan/median_beats/';
load(append(exp_path, 'median_beats.mat'));
fs_exp = fs;

%% Extract ventricular from experimental ECG
final_exp_ecgs  = cell(1,nLeads);
final_exp_time  = cell(1,nLeads);
results_exp     = cell(1,nLeads);
ms_to_qrs = median(sim_qrses_locs) * (1000/fs_sim);
for i=1:nLeads
    results_exp{i} = cell(4,2);
    results_exp{i}{1,1} = 'name';
    results_exp{i}{1,2} = append('exp_', ECG_headers{i});
    
    single_ecg    = repmat(median_beats(:,i)',[1,10]);
    single_time   = 0:1/fs_exp*1000:size(single_ecg,2)/fs_exp*1000 - 1/fs_exp*1000;
    [positionqrs_exp] = wavedelianation_func(append(pwd,'/stable/'), sim_path, filename, single_ecg, fs_exp, [0 0 0], []);
    
    figure(200), plot(single_time, single_ecg),
    hold on, plot(single_time(positionqrs_exp.qrs(3:end-2)),    single_ecg(positionqrs_exp.qrs(3:end-2)), 'r*'),
    hold on, plot(single_time(positionqrs_exp.QRSon(3:end-2)),  single_ecg(positionqrs_exp.QRSon(3:end-2)), 'r*'),
    hold on, plot(single_time(positionqrs_exp.QRSoff(3:end-2)), single_ecg(positionqrs_exp.QRSoff(3:end-2)), 'r*'),
    hold on, plot(single_time(positionqrs_exp.T(3:end-2)),    single_ecg(positionqrs_exp.T(3:end-2)), 'g+'),
    hold on, plot(single_time(positionqrs_exp.Ton(3:end-2)),  single_ecg(positionqrs_exp.Ton(3:end-2)), 'g+'),
    hold on, plot(single_time(positionqrs_exp.Toff(3:end-2)), single_ecg(positionqrs_exp.Toff(3:end-2)), 'g+'),
    title(ECG_headers{i}), xlim tight, xlabel('time (ms)'),ylabel('V')
    hold off
    exportgraphics(gcf,append(ecg_path_results_debug, results_exp{i}{1,2}, '.png'));
    
    results_exp{i}{2,1} = 'qrs_dur';
    results_exp{i}{2,2} = (positionqrs_exp.QRSoff(5) - positionqrs_exp.QRSon(5)) * 1/fs_exp*1000; %ms
    results_exp{i}{3,1} = 'qt_dur';
    results_exp{i}{3,2} = (positionqrs_exp.Toff(5)   - positionqrs_exp.QRSon(5)) * 1/fs_exp*1000;
    results_exp{i}{4,1} = 't_dur';
    results_exp{i}{4,2} = (positionqrs_exp.Toff(5)   - positionqrs_exp.Ton(5))   * 1/fs_exp*1000; 
    
    before = round((ms_to_qrs(1,i)/1000) * fs_exp); %Add X ms before for aligning with sims
    before = round((mean(ms_to_qrs)/1000) * fs_exp);
    after  = round(0.01*fs_exp); %Add 10 ms after for having the complete T wave
    
    % We re normalize even if that was done before and start for 0 the
    % voltage
    final_exp_beat = single_ecg(positionqrs_exp.qrs(5)-before:positionqrs_exp.Toff(5)+after);
    final_exp_beat = (final_exp_beat-min(final_exp_beat)) / (max(final_exp_beat) - min(final_exp_beat));
    final_exp_beat = final_exp_beat - final_exp_beat(1);
    
    final_exp_ecgs{i} = final_exp_beat;
    final_exp_time{i} = 0:1/fs_exp*1000:(size(final_exp_ecgs{i},2)-1)/fs_exp*1000;


end


%% Plot exp and simulations
pECG_tot_time = pECG_tot_time - min(pECG_tot_time);

fig=figure;
for i=1:nLeads
    subplot(4,3,i)
    for j=1:n_experiments
        plot(pECG_tot_time(1:end-(100*fs_sim/1000),j), pECG_tot_ecgs(1:end-(100*fs_sim/1000),i,j)) % We throw the last 100 ms
        hold on
    end
    plot(final_exp_time{i}, final_exp_ecgs{i}, 'k--')
    
    hold on
    
    legend(experiments_names,'FontSize',8, 'Location', 'bestoutside')
    title(ECG_headers{i}), xlim tight, xlabel('time (ms)'),ylabel('norm V')

end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
exportgraphics(gcf,append(ecg_path_results, 'simulations_final_filtered_', num2str(cutoff), '.png'),'Resolution',400);



for i=1:nLeads
    fig=figure;
    for j=1:n_experiments
        plot(pECG_tot_time(1:end-(100*fs_sim/1000),j), pECG_tot_ecgs(1:end-(100*fs_sim/1000),i,j)) % We throw the last 100 ms
        hold on
    end
    plot(final_exp_time{i}, final_exp_ecgs{i}, 'k--')
    
    hold on
    
    legend(experiments_names,'FontSize',8)
    title(ECG_headers{i}), xlim tight, xlabel('time (ms)'),ylabel('norm V')
    set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
    exportgraphics(gcf,append(ecg_path_results, 'simulations_final_', ECG_headers{i}, '.png'),'Resolution',400);

end


%% Add similarity coefficient

for i=1:n_experiments
    for j=1:nLeads
        results_sim{i,j}{5,1} = 'sim_coeff_rel';
        C = corrcoef(squeeze(pECG_tot_ecgs(:,j,:)));
        results_sim{i,j}{5,2} = C(i,:);
        
        % We downsample sims as they have higher fs and complete the exp
        % beats to match sims size, this to get corrcoef
        results_sim{i,j}{6,1} = 'sim_coeff_exp';
        single_ecg_sim = squeeze(pECG_tot_ecgs(1:round(fs_sim/fs_exp):end,j,i));
        single_ecg_exp = final_exp_ecgs{j}';
        chunk_size = size(single_ecg_sim,1) - size(single_ecg_exp,1);
        if (chunk_size > 0)
            single_ecg_exp = [single_ecg_exp; ones(chunk_size,1)*single_ecg_exp(end)];
        elseif (chunk_size < 0)
            single_ecg_sim = [single_ecg_sim; ones(abs(chunk_size),1)*single_ecg_sim(end)];
        else

        end
        
        C = corrcoef(single_ecg_sim, single_ecg_exp);
        results_sim{i,j}{6,2} = C(1,2);
    end
end



%% Save results 
excel_file = append(ecg_path_results, 'results.xlsx');
tot_resuls_4_excel = cell((n_experiments+1)*nLeads+1,6); %6 is the amount of data for case, plus 1 for exp and plus 1 for headers

tot_resuls_4_excel{1,1} = 'name';
tot_resuls_4_excel{1,2} = 'qrs_dur';
tot_resuls_4_excel{1,3} = 'qt_dur';
tot_resuls_4_excel{1,4} = 't_dur';
tot_resuls_4_excel{1,5} = 'sim_coeff_rel';
tot_resuls_4_excel{1,6} = 'sim_coeff_exp';

for i=1:nLeads
    tot_resuls_4_excel{i+1,1} = results_exp{i}{1,2};
    tot_resuls_4_excel{i+1,2} = results_exp{i}{2,2};
    tot_resuls_4_excel{i+1,3} = results_exp{i}{3,2};
    tot_resuls_4_excel{i+1,4} = results_exp{i}{4,2};
end

for i=1:nLeads
    for j=1:n_experiments
        tot_resuls_4_excel{i+1+nLeads*j,1} = results_sim{j,i}{1,2};
        tot_resuls_4_excel{i+1+nLeads*j,2} = results_sim{j,i}{2,2};
        tot_resuls_4_excel{i+1+nLeads*j,3} = results_sim{j,i}{3,2};
        tot_resuls_4_excel{i+1+nLeads*j,4} = results_sim{j,i}{4,2};
        tot_resuls_4_excel{i+1+nLeads*j,5} = results_sim{j,i}{5,2};
        tot_resuls_4_excel{i+1+nLeads*j,6} = results_sim{j,i}{6,2};
    end
end 
        
writecell(tot_resuls_4_excel, excel_file);

sim_ecgs  = pECG_tot_ecgs;
exp_names = experiments_names{1:end-1};
sim_time  = pECG_tot_time;
sim_labels = pECGLabels;
save(append(ecg_path_results, 'final_ecgs_pECG.mat'), 'sim_ecgs', 'sim_time', 'fs_sim', 'sim_labels', 'exp_names');

exp_ecgs = final_exp_ecgs;
exp_time = final_exp_time;
exp_labels = ECG_headers;
save(append(ecg_path_results, 'final_ecgs_exp.mat'), 'exp_ecgs', 'exp_time', 'fs_exp', 'exp_labels');
