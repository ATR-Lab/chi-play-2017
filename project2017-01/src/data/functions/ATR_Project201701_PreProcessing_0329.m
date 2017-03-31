%% [ATR: Project2017-01] EMG-Based_Robot
%% preprocessing
% subtract offset; remove mean value
for temp_s = 1:size(data, 2) % number of sessions
    for temp_t = 1:size(data(temp_s).epoch, 2)
        for temp_ch = 2:size(data(temp_s).epoch{1, temp_t}, 2) % number of channels
            data(temp_s).detrend_f{1, temp_t}(:, temp_ch - 1) = detrend(data(temp_s).epoch{1, temp_t}(:, temp_ch));
        end
    end
end

% bandpass filter
% val.n_bp = 8; % even number
val.Fs_bp = 2048; % 64 Hz (?)
% val.Wn_bp = [10 500]; % 10-500 Hz
val.Fn_bp = val.Fs_bp/2;
[val.b_bp, val.a_bp] = butter(val.n_bp, val.Wn_bp/val.Fn_bp, 'bandpass'); % a bandpass filter of order 2n if Wn is a two-element vectr
for temp_s = 1:size(data, 2) % number of sessions
    for temp_t = 1:size(data(temp_s).epoch, 2)
        for temp_ch = 1:size(data(temp_s).detrend_f{1, temp_t}, 2)
            data(temp_s).bandpass_f{1, temp_t}(:, temp_ch) = filtfilt(val.b_bp, val.a_bp, data(temp_s).detrend_f{1, temp_t}(:, temp_ch));
        end
    end
end

% bandstop filter
% val.n_bs = 8; % even number
val.Fs_bs = 2048;
% val.Wn_bs = [59 61]; % cutoff frequency at 60 Hz
val.Fn_bs = val.Fs_bs/2;
[val.b_bs, val.a_bs] = butter(val.n_bs, val.Wn_bs/val.Fn_bs, 'stop'); % bandstop Butterworth filter design; [b, a] = butter(n, Wn, ftype)
for temp_s = 1:size(data, 2) % number of sessions
    for temp_t = 1:size(data(temp_s).bandpass_f, 2)
        for temp_ch = 1:size(data(temp_s).bandpass_f{1, temp_t}, 2)
            data(temp_s).bandstop_f{1, temp_t}(:, temp_ch) = filtfilt(val.b_bp, val.a_bp, data(temp_s).bandpass_f{1, temp_t}(:, temp_ch));
        end
    end
end