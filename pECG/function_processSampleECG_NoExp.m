function function_processSampleECG_NoExp(root_path, experiments_names, result_names, dt_sim, pecg_name, results_folder_name, colors, lines)

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
cutoff            = 40;
nLeads            = 12;
tot_time_ms       = 600;
linewidth = 2;

n_experiments     = size(result_names,2);
fs_sim            = 1/dt_sim; % in Hz;
samples_per_beat_sim = 1 + tot_time_ms / (dt_sim*1000);    % minimum sim duration to be use so cropped to this amount
ecg_path_results = append(root_path, results_folder_name, '/');

%% Initialization

if ~exist(ecg_path_results, 'dir')
    mkdir(ecg_path_results)
end
ecg_path_results_debug = append(ecg_path_results, 'debug_images/');
if ~exist(ecg_path_results_debug, 'dir')
    mkdir(ecg_path_results_debug)
end

cleaned_experiment_names = cell(1,n_experiments);
for i=1:n_experiments
    cleaned_experiment_names{i}= strrep(experiments_names{i},'}','');
    cleaned_experiment_names{i}= strrep(cleaned_experiment_names{i},'{\it ','');
end

pECG_tot_ecgs = zeros(samples_per_beat_sim, nLeads, n_experiments);
pECG_tot_time = zeros(samples_per_beat_sim, n_experiments);

%% Load simulations pECGs and plot,
% We plot the simulations ecg and save them without any normalization nor mean
% dropping

for i=1:n_experiments
    load(append(root_path, result_names{i}, '/', pecg_name{i}), 'pECG', 'time', 'pECGLabels');
    pECG_tot_ecgs(:,:,i) = pECG(1:samples_per_beat_sim,:);
    pECG_tot_time(:,i) = time(1:samples_per_beat_sim);
end

fig=figure;
for i=1:nLeads
    subplot(3,4,i);
    for j=1:n_experiments 
        plot( pECG_tot_time(:,j) , pECG_tot_ecgs(:,i,j), 'Color', cell2mat(colors(j)), 'LineStyle', lines(j), 'LineWidth',linewidth);
        hold on
    end
    ylabel("V [a.u.]"),xlabel("t [ms]");
    title(pECGLabels(i));
    legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
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
        
        plot( pECG_tot_time(:,j) - min(pECG_tot_time(:,j)), pECG_tot_ecgs(:,i,j), 'Color', cell2mat(colors(j)), 'LineStyle', lines(j), 'LineWidth',linewidth);
        hold on 
        
    end
    ylabel("V [a.u.]"),xlabel("t [ms]");
    title(pECGLabels(i));
    legend(experiments_names,'FontSize',font_size-4, 'Location', 'bestoutside')
    hold off
end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
exportgraphics(gcf,append(ecg_path_results, 'simulations_filtered.png'),'Resolution',400);
%% Compute the qrs, t and qt dur,
% We also get the qrs and t peak times for for aligning with the experimental ecg

sim_qrs_locs = zeros(n_experiments,nLeads,3); % QRSon, QRS, QRSoff
sim_t_locs = zeros(n_experiments,nLeads,3);   % Ton, T, Toff
filename       = 'simple_ecg';
for j=1:n_experiments
    for i=1:nLeads
%         if j==5 && i==5
%             disp("Hola");
%         end
        single_ecg    = repmat(pECG_tot_ecgs(:,i,j)',[1,10]);
        single_time   = 0:1/fs_sim*1000:size(single_ecg,2)/fs_sim*1000 - 1/fs_sim*1000;
        
        sim_path = append(root_path, result_names{j}, '/'); % just a path to put some tmp files
        [positionqrs_sim] = wavedelianation_func(append(pwd,'/stable/'), sim_path, filename, single_ecg, fs_sim, [0 0 0], []);
        
        %Check if T wave exist and is not taken as qrs
        if ((~isempty(positionqrs_sim.qrs)) && ~((any(isnan(positionqrs_sim.T(3:end-2))) || any(isnan(positionqrs_sim.Ton(3:end-2))) || any(isnan(positionqrs_sim.Toff(3:end-2))))) && ...
            ~((any(isnan(positionqrs_sim.qrs(3:end-2))) || any(isnan(positionqrs_sim.QRSon(3:end-2))) || any(isnan(positionqrs_sim.QRSoff(3:end-2))))))
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
        title(pECGLabels(i)), xlim tight, xlabel('time [ms]'),ylabel('V')
        hold off
        exportgraphics(gcf,append(ecg_path_results_debug, cleaned_experiment_names{j},'_',pECGLabels(i), '.png'));
        
        % Get the results and qrs and t idxs
        idx = find(positionqrs_sim.qrs>samples_per_beat_sim*5, 1 );
        
        if positionqrs_sim.T(idx) - samples_per_beat_sim*5 > samples_per_beat_sim % Mainly the qrs is taken as T and T as qrs
            
            fprintf('Check experiment  %s and lead %s\n',cleaned_experiment_names{j},pECGLabels(i));
            
            sim_qrs_locs(j,i,1) = positionqrs_sim.Ton(idx-1) - samples_per_beat_sim*5;
            sim_qrs_locs(j,i,2) = positionqrs_sim.T(idx-1) - samples_per_beat_sim*5;
            sim_qrs_locs(j,i,3) = positionqrs_sim.Toff(idx-1) - samples_per_beat_sim*5;
            sim_t_locs(j,i,1)   = positionqrs_sim.QRSon(idx) - samples_per_beat_sim*5;
            sim_t_locs(j,i,2)   = positionqrs_sim.qrs(idx) - samples_per_beat_sim*5;
            sim_t_locs(j,i,3)   = positionqrs_sim.QRSoff(idx) - samples_per_beat_sim*5;
            
            
            figure(100), plot(single_time, single_ecg),
            try
                hold on, plot(single_time(positionqrs_sim.T(3:end-2)),    single_ecg(positionqrs_sim.T(3:end-2)), 'r*'),
                hold on, plot(single_time(positionqrs_sim.Ton(3:end-2)),  single_ecg(positionqrs_sim.Ton(3:end-2)), 'r*'),
                hold on, plot(single_time(positionqrs_sim.Toff(3:end-2)), single_ecg(positionqrs_sim.Toff(3:end-2)), 'r*'),
                hold on, plot(single_time(positionqrs_sim.qrs(3:end-2)),    single_ecg(positionqrs_sim.qrs(3:end-2)), 'g+'),
                hold on, plot(single_time(positionqrs_sim.QRSon(3:end-2)),  single_ecg(positionqrs_sim.QRSon(3:end-2)), 'g+'),
                hold on, plot(single_time(positionqrs_sim.QRSoff(3:end-2)), single_ecg(positionqrs_sim.QRSoff(3:end-2)), 'g+'),
            catch

            end
            title(pECGLabels(i)), xlim tight, xlabel('time [ms]'),ylabel('V')
            hold off
            exportgraphics(gcf,append(ecg_path_results_debug, cleaned_experiment_names{j},'_',pECGLabels(i), '.png'));
        else
            sim_qrs_locs(j,i,1) = positionqrs_sim.QRSon(idx) - samples_per_beat_sim*5;
            sim_qrs_locs(j,i,2) = positionqrs_sim.qrs(idx) - samples_per_beat_sim*5;
            sim_qrs_locs(j,i,3) = positionqrs_sim.QRSoff(idx) - samples_per_beat_sim*5;
            sim_t_locs(j,i,1)   = positionqrs_sim.Ton(idx) - samples_per_beat_sim*5;
            sim_t_locs(j,i,2)   = positionqrs_sim.T(idx) - samples_per_beat_sim*5;
            sim_t_locs(j,i,3)   = positionqrs_sim.Toff(idx) - samples_per_beat_sim*5;
        end
        


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
        plot( pECG_tot_time(:,j) , pECG_tot_ecgs(:,i,j), 'Color', cell2mat(colors(j)), 'LineStyle', lines(j), 'LineWidth',linewidth);
        hold on
    end
    ylabel("norm V [a.u.]"),xlabel("t [ms]");
    title(pECGLabels(i));
    legend(experiments_names,'Location', 'bestoutside','FontSize',font_size-4)
    hold off
end
set(fig, 'Position', [0, 0, 2000, 1200]); % [left, bottom, width, height]
exportgraphics(gcf,append(ecg_path_results, 'simulations_filtered_norm.png'),'Resolution',400);


%% Save results 
excel_file = append(ecg_path_results, 'results_byWave.xlsx');
tot_resuls_4_excel = cell(n_experiments*nLeads+1,6); %we have 4 columns (exp, lead_name,lead_number, qrs_dur, qt_dur, t_dur), and the rows need to contain the header 

tot_resuls_4_excel{1,1} = 'name';
tot_resuls_4_excel{1,2} = 'lead_number';
tot_resuls_4_excel{1,3} = 'lead_name';
tot_resuls_4_excel{1,4} = 'qrs_dur';
tot_resuls_4_excel{1,5} = 'qt_dur';
tot_resuls_4_excel{1,6} = 't_dur';

for i=1:nLeads
    for j=1:n_experiments
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),1} = cleaned_experiment_names{j};
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),2} = i;
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),3} = pECGLabels(i);
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),4} = (sim_qrs_locs(j,i,3) - sim_qrs_locs(j,i,1)) * 1/fs_sim*1000;
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),5} = (sim_t_locs(j,i,2) - sim_qrs_locs(j,i,2)) * 1/fs_sim*1000;
        tot_resuls_4_excel{(i+1)+nLeads*(j-1),6} = (sim_t_locs(j,i,3) - sim_t_locs(j,i,1)) * 1/fs_sim*1000;
    end
end 
        
writecell(tot_resuls_4_excel, excel_file);

save(append(ecg_path_results,'results.mat'), 'pECG_tot_ecgs', 'pECG_tot_time', 'pECGLabels', 'cleaned_experiment_names')
end

