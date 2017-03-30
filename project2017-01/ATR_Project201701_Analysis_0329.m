%% [ATR: Project2017-01] EMG-Based_Robot
%% analysis
clear all
close all
clc

%% parameter setting %% PLEASE DOUBLE CHECK BEFORE EACH RUN
% load data
info.sub_name = 'Sub02';
info.trainingSet = 'o'; % trainng set 1 = 'o'; training set 2 = 'bfo'; training set 3 = 'bf'

% pre-processing: bandpass filter
val.n_bp = 8; % even number
val.Wn_bp = [5 512]; % 10-500 Hz; 20-470 Hz

% pre-processing: bandstop filter
val.n_bs = 8; % even number
val.Wn_bs = [59 61]; % cutoff frequency at 60 Hz

% epoch
flag.epoch_avg = 0; % grand average; 0 = off; 1 = on
flag.plot_timeDomain = 0; % plot; 1 = timeDomain
flag.time_anlys = 1; % analysis; 0 = off; 1 = on
if flag.time_anlys == 1
    temp.time_m = 4; %motion
    temp.time_s = 1:3; % session
    flag.time_ylim = 0; % ylim; 0 = off; 1 = on
    temp.time_ylim = [-4E6 4E6];
end

% fast Fourier transform
flag.FFT_avg = 0; % grand average; 0 = off; 1 = on
flag.plot_ampSpectrum = 0; % plot; 2 = ampSpectrum
flag.FFT_anlys = 1; % analysis; 0 = off; 1 = on
if flag.FFT_anlys == 1
    temp.FFT_m = 4; % motion
    temp.FFT_s = 1:5; % session
    temp.FFT_xlim = [5 512];
    flag.FFT_ylim = 0; % ylim; 0 = off; 1 = on
    temp.FFT_ylim = [-4E6 4E6];
end

% power spectrum
flag.PowSpectrum_avg = 0; % grand average; 0 = off; 1 = on
flag.plot_powSpectrum = 0; % plot; 3 = powSpectrum
flag.pow_anlys = 1; % analysis; 0 = off; 1 = on
if flag.pow_anlys == 1
    temp.pow_m = 4; % motion
    temp.pow_s = 1:2; % session
    temp.pow_xlim = [0.4 512];
    flag.pow_ylim = 0; % ylim; 0 = off; 1 = on
    temp.pow_ylim = [-4E6 4E6];
end

% periodogram; if choose to use this method, you don't need fft and power spectrum calculations

% root mean square

% grand average

% multilevel 1-D wavelet decomposition

%% load data
path(path, 'Function');
ATR_Project201701_LoadData_0329;


%% pre-processing
ATR_Project201701_PreProcessing_0329;


%% epoch
ATR_Project201701_Epoch_0329;

% plot a TIMEDOMAIN
flag.graphs = flag.plot_timeDomain; % 1 = timeDomain, 2 = ampSpectrum, 3 = powSpectrum, 4 = per, 5 = DWT
temp.ty = info.trainingSet;

ATR_Project201701_Plot_0329;

%% analysis
% fast Fourier transform
temp.ty = info.trainingSet;
ATR_Project201701_FFT_0330;

% power spectrum
temp.ty = info.trainingSet;
ATR_Project201701_PowSpectrum_0330;

% periodogram; if choose to use this method, you don't need fft and power spectrum calculations
temp.ty = info.trainingSet;
ATR_Project201701_Periodogram_0330;

% root mean square

% grand average

% multilevel 1-D wavelet decomposition
% temp.wname = 'db10'; % type
% temp.level = 7; % level; scale = 2^n
% flag.graphs = 0; % 1 = timeDomain, 2 = ampSpectrum, 3 = powSpectrum, 4 = per, 5 = DWT
% temp.ty = info.trainingSet;
% 
% ATR_Project201701_DWT_0329;
% ATR_Project201701_Plot_0329;


%% time window
% fast Fourier transform

% DWT
temp.wname = 'db1'; % type
temp.level = 8; % level; scale = 2^n
flag.graphs = 1; % 1 = timeDomain, 2 = ampSpectrum, 3 = powSpectrum, 4 = per, 5 = DWT
temp.ty = info.trainingSet;

ATR_Project201701_DWTwin_0329;


%% save
flag.timedomain = 0;
flag.ampSpectrum = 0;
flag.powSpectrum = 0;
flag.per = 0;
flag.DWT = 1;
ATR_Project201701_CSVWrite_0329;