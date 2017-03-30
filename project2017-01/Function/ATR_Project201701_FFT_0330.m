%% [ATR: Project2017-01] EMG-Based_Robot
%% fast Fourier transform
val.Fs_fft = 2048;
val.Fn_fft = val.Fs_fft/2; % nyquist
val.T_fft = 1/val.Fs_fft; % sampling period
% val2.L_fft = length(data(temp_s).bandstop_f{1, temp_t});
% val2.t_fft = (0:L-1) * val.T_fft;
% val2.f_fft = val.Fs_fft * (0:(val.L_fft/2))/val.L_fft;
% val2.P2_fft = abs(data(temp_s).fft_f{1, temp_t}(:, temp_col)/val.L_fft);
% val2.P1_fft = P2(1:L/2+1);
% val2.P1_fft(2:end-1) = 2*val.P1(2:end-1);

for temp_s = 1:size(data, 2) % number of session
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
        eval(sprintf('temp_file = data(%d).task_%s{1, %d};', temp_s, temp.ty, temp_m));
        eval(sprintf('val2(%d).L_fft_%s(1, %d) = length(temp_file);', temp_s, temp.ty, temp_m)); % length of signal
        eval(sprintf('val2(%d).n_fft_%s(1, %d) = 2 * (2^nextpow2(val2(%d).L_fft_%s(1, %d)));', temp_s, temp.ty, temp_m, temp_s, temp.ty, temp_m)); % transform length
        eval(sprintf('val2(%d).t_fft_%s{1, %d} = (0:val2(%d).L_fft_%s(1, %d)-1) * val.T_fft;', temp_s, temp.ty, temp_m, temp_s, temp.ty, temp_m)); % time vector
        
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('data(%d).fft_%s{1, %d}(:, %d) = fft(temp_file(:, %d), val2(%d).n_fft_%s(1, %d));', temp_s, temp.ty, temp_m, temp_ch, temp_ch, temp_s, temp.ty, temp_m));
            %                 eval(sprintf('val2(%d).P2_fft_%s{1, %d}(:, %d) = abs(data(%d).fft_%s{1, %d}(:, %d)/val2(%d).L_fft_%s(1, %d));', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m)); % P2 = abs(Y/L);
            eval(sprintf('val2(%d).P2_fft_%s{1, %d}(:, %d) = abs(data(%d).fft_%s{1, %d}(:, %d)/val2(%d).n_fft_%s(1, %d));', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m)); % P2 = abs(Y/n);
            %                 eval(sprintf('val2(%d).P1_fft_%s{1, %d}(:, %d) = val2(%d).P2_fft_%s{1, %d}(1:floor(val2(%d).L_fft_%s(1, %d)/2+1), %d);', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_s, temp.ty, temp_m, temp_ch)); % P1 = P2(1:L/2+1);
            eval(sprintf('val2(%d).P1_fft_%s{1, %d}(:, %d) = val2(%d).P2_fft_%s{1, %d}(1:floor(val2(%d).n_fft_%s(1, %d)/2+1), %d);', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_s, temp.ty, temp_m, temp_ch)); % P1 = P2(1:n/2+1);
            eval(sprintf('val2(%d).P1_fft_%s{1, %d}(2:end-1, %d) = 2*val2(%d).P1_fft_%s{1, %d}(2:end-1, %d);', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_ch));
        end
        clear temp_file
    end
end

%% grand average
if flag.FFT_avg == 1
    temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(val2(%d).P1_fft_%s{1, %d}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
            ATR_Project201701_Motion_0329;
            for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                eval(sprintf('comb_%s.fft_f.%s_ch%d(:, %d) = val2(%d).P1_fft_%s{1, %d}(1:%d, 1);', temp.ty, temp.state, temp_ch, temp_s, temp_s, temp.ty, temp_m, temp.length_min));
            end
        end
    end
    temp = rmfield(temp, {'length', 'length_min'});
end


%% plot analyzing graphs
if flag.FFT_anlys == 1
    for temp_m = temp.FFT_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_ch = 1eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = temp.FFT_s % number of session; size(data, 2)
                eval(sprintf('plot(val2(%d).P1_fft_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
                    xlim(temp.FFT_xlim)
                    if flag.FFT_ylim == 1;
                        ylim([-4E6 4E6])
                    end
                end
            end
        end
    end
end