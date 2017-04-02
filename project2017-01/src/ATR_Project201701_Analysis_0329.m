%% [ATR: Project2017-01] EMG-Based_Robot
%% analysis
clear all
close all
clc

%% parameter setting %% PLEASE DOUBLE CHECK BEFORE EACH RUN
info.anlys = '0401';

% load data
info.sub_name = 'Sub02';
info.trainingSet = 'o'; % trainng set 1 = 'o'; training set 2 = 'bfo'; training set 3 = 'bf'
info.sessionNum = 1:30; % number of sessions
if info.trainingSet == 'o'
    info.trainingName = 'Training Set 1';
elseif info.trainingSet == 'bfo'
    info.trainingName = 'Training Set 2';
elseif info.trainingSet == 'bf'
    info.trainingName = 'Training Set 3';
end

% pre-processing: bandpass filter
val.n_bp = 8; % even number
val.Wn_bp = [20 470]; % 10-500 Hz; 20-470 Hz

% pre-processing: bandstop filter
val.n_bs = 8; % even number
val.Wn_bs = [59 61]; % cutoff frequency at 60 Hz

% epoch
flag.plot_timeDomain = 0; % plot; 1 = timeDomain
flag.time_anlys = 0; % analysis; 0 = off; 1 = on; 2 = graph of before (L) and on (R)
if flag.time_anlys == 1 || flag.time_anlys == 2
    temp.time_m = 4; % motion
    temp.time_s = 1:3; % session
    if flag.time_anlys == 2
        temp.time_ch = 1; % channel
    end
    flag.time_ylim = 0; % ylim; 0 = off; 1 = on
    temp.time_ylim = [-4E6 4E6];
end

% design a digital filter; FIR
temp.d1_filter = 'lowpassfir';
temp.d1_order = 16;
temp.d1_type = 'CutoffFrequency';
temp.d1_type_val = 10; % in Hz
temp.d1_method = 'window'; % 'equiripple'; 'freqsamp'; 'kaiserwin'; 'ls'; 'maxflat'; 'window'
temp.d1_window = 'hamming';
flag.fir_avg = 0; % grand average; 0 = off; 1 = on
flag.conv_avg = 0; % grand average; 0 = off; 1 = on
% flag.plot_timeDomain = 0; % plot; 1 = timeDomain
flag.fir_anlys = 3; % analysis; 0 = off; 1 = fir analysis; 2 = conv analysis; 3 = 5x2 figures
if flag.fir_anlys == 1 || flag.fir_anlys == 2 || flag.fir_anlys == 3
    temp.fir_m = 3; %motion
    temp.fir_s = 1:5; % session
    flag.fir_ylim = 0; % ylim; 0 = off; 1 = on
    temp.fir_ylim = [-4E6 4E6];
    if flag.fir_anlys == 2
        temp.fir_xlim = [1 4000];
    end
end

temp.d1_Fs = 2048; % sampling rate
% using window
val.d1 = designfilt('lowpassfir', 'FilterOrder', temp.d1_order, temp.d1_type, temp.d1_type_val, 'SampleRate', temp.d1_Fs, 'DesignMethod', temp.d1_method, 'Window', temp.d1_window);
% val.d1 = fir1(temp.d1_order, temp.d1_type_val/2048/2);
% using window with sidelobe attenuation
% val.d1 = designfilt('lowpassfir', 'FilterOrder', temp.d1_order, temp.d1_type, temp.d1_type_val, 'SampleRate', temp.d1_Fs, 'DesignMethod', temp.d1_method, 'Window', {temp.d1_window, 90});

% fast Fourier transform
flag.FFT_avg = 0; % grand average; 0 = off; 1 = on
flag.plot_ampSpectrum = 0; % plot; 2 = ampSpectrum
flag.FFT_anlys = 0; % analysis; 0 = off; 1 = on
if flag.FFT_anlys == 1
    temp.FFT_m = 4; % motion
    temp.FFT_s = 1:5; % session
    temp.FFT_xlim = val.Wn_bp; % [5 512];
    flag.FFT_ylim = 0; % ylim; 0 = off; 1 = on
    temp.FFT_ylim = [-4E6 4E6];
end

% power spectrum
flag.PowSpectrum_avg = 0; % grand average; 0 = off; 1 = on
flag.plot_powSpectrum = 0; % plot; 3 = powSpectrum
flag.pow_anlys = 0; % analysis; 0 = off; 1 = on
if flag.pow_anlys == 1
    temp.pow_m = 4; % motion
    temp.pow_s = 1:2; % session
    temp.pow_xlim = val.Wn_bp; % [0.4 512];
    flag.pow_ylim = 0; % ylim; 0 = off; 1 = on
    temp.pow_ylim = [-4E6 4E6];
end

% periodogram; if choose to use this method, you don't need fft and power spectrum calculations
flag.per_avg = 0; % grand average; 0 = off; 1 = on
flag.plot_per = 0; % plot; 4 = per
flag.per_anlys = 0; % analysis; 0 = off; 1 = on
if flag.per_anlys == 1
    temp.per_m = 4; % motion
    temp.per_s = 1:2; % session
    temp.per_xlim = val.Wn_bp; % [0.4 512];
    flag.per_ylim = 0; % ylim; 0 = off; 1 = on
    temp.per_ylim = [-4E6 4E6];
end

% root mean square

% grand average

% multilevel 1-D wavelet decomposition
% val.wname = 'sym8'; % type
% val.level = 4; % level; scale = 2^n
% val.wname = 'db2'; % type
% val.level = 4; % level; scale = 2^n
% val.wname = 'db1'; % type
% val.level = 8; % level; scale = 2^n
% val.wname = 'db4'; % type
% val.level = 3; % level; scale = 2^n
% val.wname = 'db4'; % type
% val.level = 6; % level; scale = 2^n
% val.wname = 'db5'; % type
% val.level = 5; % level; scale = 2^n
% val.wname = 'db10'; % type
% val.level = 8; % level; scale = 2^n
% val.wname = 'sym4'; % type
% val.level = 8; % level; scale = 2^n
val.wname = 'sym5'; % type
val.level = 8; % level; scale = 2^n
flag.dwt_avg = 0; % grand average; 0 = off; 1 = on
flag.plot_dwt = 0; % plot; 5 = DWT
flag.dwt_anlys = 2; % analysis; 0 = off; 1 = on
if flag.dwt_anlys == 1 || flag.dwt_anlys == 2 
    temp.dwt_m = 4; % motion
    temp.dwt_s = 21:30; % session
    if flag.dwt_anlys == 2
        temp.dwt_ch = 3; % channel
    end
    flag.dwt_ylim = 0; % ylim; 0 = off; 1 = on
    temp.dwt_ylim = [-4E6 4E6];
end

% save
flag.timedomain = 0;
flag.ampSpectrum = 0;
flag.powSpectrum = 0;
flag.per = 0;
flag.DWT = 0;
flag.timedomain_ch = 0;

%% load data
path(path, 'functions');
ATR_Project201701_LoadData_0329;


%% pre-processing
ATR_Project201701_PreProcessing_0329;


%% epoch
ATR_Project201701_Epoch_0329;

% plot a TIMEDOMAIN
flag.graphs = flag.plot_timeDomain; % 1 = timeDomain, 2 = ampSpectrum, 3 = powSpectrum, 4 = per, 5 = DWT
temp.ty = info.trainingSet;

ATR_Project201701_Plot_0329;

% fir
temp.ty = info.trainingSet;
% ATR_Project201701_FIR_0401;

%% analysis
% fast Fourier transform
temp.ty = info.trainingSet;
% ATR_Project201701_FFT_0330;

% power spectrum
temp.ty = info.trainingSet;
% ATR_Project201701_PowSpectrum_0330;

% periodogram; if choose to use this method, you don't need fft and power spectrum calculations
temp.ty = info.trainingSet;
% ATR_Project201701_Periodogram_0330;

% root mean square

% grand average

% multilevel 1-D wavelet decomposition
temp.ty = info.trainingSet;
% ATR_Project201701_DWT_0329;
ATR_Project201701_DWTwin_0329;

%% plot
temp.ty = info.trainingSet;
% ATR_Project201701_Plot_0329;


%% save
ATR_Project201701_CSVWrite_0329;
ATR_Project201701_perCh_0401;