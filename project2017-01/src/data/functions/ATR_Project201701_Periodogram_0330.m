%% [ATR: Project2017-01] EMG-Based_Robot
%% periodogram; if choose to use this method, you don't need fft and power spectrum calculations
val.Fs_per = 2048;
val.f_per = val.Wn_bp; % [10 500];

for temp_s = 1:size(data, 2) % number of session
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
        eval(sprintf('temp_file = data(%d).task_%s{1, %d};', temp_s, temp.ty, temp_m));
        eval(sprintf('val2(%d).n_per_%s(1, %d) = 2 * (2^nextpow2(val2(%d).L_fft_%s(1, %d)));', temp_s, temp.ty, temp_m, temp_s, temp.ty, temp_m)); % transform length
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('[data(%d).per_%s{1, %d}(:, %d) val2(%d).f_per_%s{1, %d}(:, %d)] = periodogram(temp_file(:, %d), hamming(length(temp_file(:, %d))), val2(%d).n_per_%s(1, %d), %d);', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_ch, temp_ch, temp_ch, temp_s, temp.ty, temp_m, val.Fs_per)); % periodogram; [pxx, f] = periodogram(x, window, nfft, fs)
        end
    end
end


%% grand average
if flag.per_avg == 1
    temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(size(%d).per_%s{1, %d}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
            ATR_Project201701_Motion_0329;
            for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                eval(sprintf('comb_%s.per.%s_ch%d(:, %d) = data(%d).per_%s{1, %d}(1:%d, 1);', temp.ty, temp.state, temp_ch, temp_s, temp_s, temp.ty, temp_m, temp.length_min));
            end
        end
    end
    temp = rmfield(temp, {'length', 'length_min'});
end


%% plot analyzing graphs
if flag.per_anlys == 1
    for temp_m = temp.per_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_ch = eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = temp.per_s % number of session; size(data, 2)
                eval(sprintf('plot(data(%d).per_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
                    xlim(temp.per_xlim)
                    if flag.per_ylim == 1;
                        ylim([-4E6 4E6])
                    end
                end
            end
        end
    end
end
