%% [ATR: Project2017-01] EMG-Based_Robot
%% power spectrum
val.Fs_sp = 2048;

for temp_s = 1:size(data, 2) % number of session
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('data(%d).power_%s{1, %d}(:, %d) = val2(%d).P1_fft_%s{1, %d}(:, %d).^2;', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_ch)); % power spectrum
        end
        clear temp_file
    end
end

%% grand average
if flag.PowSpectrum_avg == 1
    temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(data(%d).power_%s{1, %d}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
            ATR_Project201701_Motion_0329;
            for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                eval(sprintf('comb_%s.power_f.%s_ch%d(:, %d) = data(%d).power_%s{1, %d}(1:%d, 1);', temp.ty, temp.state, temp_ch, temp_s, temp_s, temp.ty, temp_m, temp.length_min));
            end
        end
    end
    temp = rmfield(temp, {'length', 'length_min'});
end
