%Created by Katherine McDonald
%If you use my script, I kindly ask for co-authorship on your work as a
%significant contributor to your data processing pipeline
% 
% eeglab;
workpath = '/Volumes/Data/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/EO_EEG/EO_EEG_Rest/Post/';  % This is the path to your main processing folder
addpath '/Users/katherinemcdonald/Documents/MATLAB/natsortfiles'; %for sorting files
refchans = {'M1' 'M2'}; %These are your references channels (i.e. M1 and M2)
unusedchans = {'F11' 'F12' 'FT11' 'FT12' 'CB1' 'CB2'};  %Unused channels

%% Covert cdt to set 
cd([workpath]);
file_struct = dir('*.cdt'); % grab cdt files containing specified string
file_struct_EEG = {file_struct.name};
fullSetsName_list = cellfun(@(S) S(1:end-4), file_struct_EEG, 'Uniform', 0);
b = 1; 
for subnum = 1:length(file_struct_EEG)  
    EEG = loadcurry([workpath, file_struct_EEG{subnum}], 'CurryLocations', 'False');
     EEG = pop_saveset( EEG, 'filename',[fullSetsName_list{subnum}],'filepath', [workpath 'Set/']);
 end

%% ICA
cd([workpath 'Set/']);
file_struct = dir('*.set');
file_struct_set = {file_struct.name};
b = 1;

% Reanme file for better handling
for i = 1:size(file_struct)
    
file_struct([b]).name = file_struct([b]).name(1:end-4);
b = b+1;

end

file_struct_set = {file_struct.name};
file_struct_set = natsortfiles(file_struct_set);

for subnum = 1:length(file_struct_set)
    subject = file_struct_set{subnum};

    EEG = pop_loadset('filename', [subject '.set'], 'filepath', [workpath 'Set/']);
    
    EEG = pop_chanedit(EEG, 'lookup',[workpath 'standard-10-5-cap385.elp']);

    % Remove unused channels
    EEG = pop_select( EEG,'nochannel',unusedchans);

    % Re-reference to M1 and M2
    EEG = pop_reref( EEG, [refchans],'keepref','off');

    % Save after re-reference
    EEG = pop_saveset( EEG, 'filename', [subject '_Ref'],'filepath',[workpath 'Re-referenced/']);           

    % Notch filter
    EEG  = pop_basicfilter( EEG, 1:EEG.nbchan , 'Cutoff',  60, 'Design', 'notch', 'Filter', 'PMnotch', 'Order',  180 ); 
    
    % Save after notch filter
    EEG = pop_saveset(EEG, 'filename',[subject '_afterNotch', '.set'],'filepath',[workpath 'NotchCheck/']);
    
    % High-pass filtering
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan , 'Boundary', 'boundary', 'Cutoff',  1, 'Design', 'butter', 'Filter', 'highpass', 'Order',  2 );% high-pass filter 1 Hz (ERP lab function) https://sccn.ucsd.edu/wiki/Makoto's_preprocessing_pipeline#High-pass_filter_the_data_at_1-Hz_.28for_ICA.2C_ASR.2C_and_CleanLine.29.2809.2F23.2F2019_updated.29 (recommend)
    
    % Bad channel removal
    EEG = pop_rejchan(EEG, 'elec',[1:56] ,'threshold',5,'norm','on','measure','kurt'); % reject channel(s) with absolute power >5SD
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
    % Skip eye channels for ICA
    EEG = movechannels(EEG,'Location','skipchannels','Direction','Remove','Channels',{'VEO','HEO'}); % 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = eeg_checkset( EEG );
    
    % Run ICA and save
    EEG = pop_runica(EEG, 'icatype', 'runica', 'options', {'extended',1,'block',floor(sqrt(EEG.pnts/3)),'anneal',0.98});
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = eeg_checkset(EEG);
    EEG = pop_saveset(EEG, 'filename',[subject '_ICA'],'filepath', [workpath 'ICA/']);
    
end
    
%% reject ICA 

for subnum = 1:length(file_struct_set)
    subject = file_struct_set{subnum};
    
    % Find and assign ICA for rejection
    EEG = pop_loadset('filename', [subject '_ICA.set'], 'filepath', [workpath 'ICA/']);
    EEG.icaquant = icablinkmetrics(EEG,'ArtifactChannel', EEG.skipchannels.data(1,:));
    disp('ICA Metrics are located in: EEG.icaquant.metrics')
    disp('Selected ICA component(s) are located in: EEG.icaquant.identifiedcomponents')
    [~,index] = sortrows([EEG.icaquant.metrics.convolution].');
    EEG.icaquantzmetrics = EEG.icaquant.metrics(index(end:-1:1)); clear index
    
    %Remove ICA component(s)
    if EEG.icaquant.identifiedcomponents == 0
    EEG = eeg_checkset( EEG );
    EEGref = pop_loadset('filename', [subject '_Ref.set'],'filepath', [workpath 'Re-referenced/']);
    EEG = pop_interp(EEG, EEGref.chanlocs, 'spherical');   
    EEG = pop_basicfilter( EEG,  1:EEG.nbchan , 'Cutoff',  50, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  4 );%low-pass filter  
    EEG = eeg_checkset( EEG );
    RejICA(subnum) = {EEG.icaquant.identifiedcomponents};% count number of rejected ICA compoents
    EEG = eeg_regepochs(EEG, 'recurrence',2, 'limits', [-2 0],'rmbase', NaN);%epoch the continous data by a 2-second epoch (unit must be second)
    EEG = pop_rmbase( EEG, [],1:EEG.nbchan);% each epoch will be baseline corrected with entire epoch
    Trials(subnum) = EEG.trials;%Returns the total number of epochs
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = pop_eegthresh(EEG,1,[1:56] ,-100,100,-2,0,0,1);%Artifact rejection (time unit must be second)
    EEG = eeg_checkset( EEG );
    Clean_Trials(subnum) = EEG.trials;% Returns epochs after artifact rejection
    EEG = pop_saveset( EEG, 'filename',[subject '_afterICA'],'filepath', [workpath 'ICA/']);
    else 
    EEG = pop_subcomp(EEG,EEG.icaquant.identifiedcomponents,0);
    EEGref = pop_loadset('filename', [subject '_Ref.set'],'filepath', [workpath 'Re-referenced/']);
    EEG = pop_interp(EEG, EEGref.chanlocs, 'spherical');
    EEG = pop_basicfilter( EEG,  1:EEG.nbchan , 'Cutoff',  50, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  4 );  
    EEG = eeg_checkset( EEG );
    RejICA(subnum) = {EEG.icaquant.identifiedcomponents};% count number RejICA compoents
    EEG = eeg_regepochs(EEG, 'recurrence',2, 'limits', [-2 0],'rmbase', NaN);
    EEG = pop_rmbase( EEG , [], 1:EEG.nbchan);
    Trials(subnum) = EEG.trials;
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = pop_eegthresh(EEG,1,[1:56] ,-100,100,-2,0,0,1);
    EEG = eeg_checkset( EEG );
    Clean_Trials(subnum) = EEG.trials;
    EEG = pop_saveset( EEG, 'filename',[subject '_afterICA'],'filepath', [workpath 'ICA/']);
    end

end

%% Returns totoal epochs, valid epochs, and number of rejected IC for each participant
Trials = Trials';
Clean_Trials = Clean_Trials';
RejICA = RejICA';

%% FFT
chan = 56; 
fs = 1000;% fs = sampling rate
window = 1000*2; % get data points = sampling rate * 2s (because 2 seconds per epoch
manychan = zeros(56, floor(window/2+1)); % floor(window/2+1) = frequency bins, +1 = 0Hz; 
alldata = zeros(length(file_struct_set), chan, floor(window/2+1));

for subnum = 1:length(file_struct_set)
    subject = file_struct_set{subnum};
    
    EEG = pop_loadset('filename', [subject '_afterICA.set'], 'filepath', [workpath 'ICA/']);
%     pop_currentsourcedensity(EEG);
    EEG = eeg_checkset( EEG );
    
    for m =1:chan
    sig = reshape( EEG.data(m,:,:) ,1,[]);
    [sig_w, f] = pwelch ( sig, hamming(window), [], window, EEG.srate,'power');%hamming or hanning/overlap 50%
    sig_w = sig_w';
    manychan(m,:) = sig_w;
    end
    
    alldata (subnum, :, :) = manychan ;

end

cd([workpath]);
save ( 'SNEACY2_Child_Resting_EEG_Rest_Post', 'alldata');

%% Calculate frequency data
subject = length(file_struct_set);
outchan = 7; %the number of channels for output
outfreq = 4; %the number of bandwidths for output
output = outfreq*outchan;

% Create matrix for output
meanPower = zeros(subject, 56, outfreq);
meanPowerChannel = zeros(subject, outchan, outfreq);
LogMeanPowerChannel = zeros(subject, outchan, outfreq);
MasterOutput = zeros(subject, output);

% Frequency: get each of your frequency of interest for each channel (format = subjects x channels x freuqecny  74 x 32 x 4
for n = 1:subject
   for c = 1:56
       meanPower(n, c, 1) = mean(alldata(n, c, 4:8));% 1.5-3.5Hz = Delta
       meanPower(n, c, 2) = mean(alldata(n, c, 9:16));% 4-7.5Hz = Theta
       meanPower(n, c, 3) = mean(alldata(n, c, 17:25));% 8-12Hz = Alpha
       meanPower(n, c, 4) = mean(alldata(n, c, 28:45));% 13.5-25Hz = Beta
   end
end

% Channel: get each your interest channels 
for n = 1:subject
    meanPowerChannel(n, 1, :) =  meanPower(n, 10, :); % FZ
    meanPowerChannel(n, 2, :) =  meanPower(n, 18, :); % FCZ
    meanPowerChannel(n, 3, :) =  meanPower(n, 26, :); % CZ
    meanPowerChannel(n, 4, :) =  meanPower(n, 35, :); % CPZ
    meanPowerChannel(n, 5, :) =  meanPower(n, 44, :); % PZ
    meanPowerChannel(n, 6, :) =  meanPower(n, 51, :); % POZ
    meanPowerChannel(n, 7, :) =  meanPower(n, 55, :); % OZ
end

%Natural log trans
LogMeanPowerChannel = log(meanPowerChannel);

for n=1:subject
    MasterOutput(n,:) = reshape(LogMeanPowerChannel(n,:,:),1,[]);
end

%Excel output
xlswrite('SNEACY2_Child_EO_EEG_Rest_Post.xls', MasterOutput);

