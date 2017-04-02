%% [ATR: Project2017-01] EMG-Based_Robot
%% multilevel 1-D wavelet decomposition
% design a digital filter
for temp_s = 1:size(data, 2) % number of session
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion 
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('data(temp_s).fir_%s{1, temp_m}(:, temp_ch) = filtfilt(val.d1, data(temp_s).task_%s{1, temp_m}(:, temp_ch));', temp.ty, temp.ty));
        end
    end
end

%% convolution
for temp_s = 1:size(data, 2) % number of session
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion 
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('data(temp_s).conv_%s{1, temp_m}(:, temp_ch) = conv(data(temp_s).task_%s{1, temp_m}(:, temp_ch), data(temp_s).fir_%s{1, temp_m}(:, temp_ch), ''same'');', temp.ty, temp.ty, temp.ty));
        end
    end
end


%% grand average
if flag.fir_avg == 1
    temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(data(%d).fir_%s{1, %d}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
            ATR_Project201701_Motion_0329;
            for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                eval(sprintf('comb_%s.fir_f.%s_ch%d(:, %d) = data(%d).fir_%s{1, %d}(1:%d, 1);', temp.ty, temp.state, temp_ch, temp_s, temp_s, temp.ty, temp_m, temp.length_min));
            end
        end
    end
    temp = rmfield(temp, {'length', 'length_min'});
end

if flag.conv_avg == 1
    temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(data(%d).conv_%s{1, %d}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
            ATR_Project201701_Motion_0329;
            for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                eval(sprintf('comb_%s.conv_f.%s_ch%d(:, %d) = data(%d).conv_%s{1, %d}(1:%d, 1);', temp.ty, temp.state, temp_ch, temp_s, temp_s, temp.ty, temp_m, temp.length_min));
            end
        end
    end
    temp = rmfield(temp, {'length', 'length_min'});
end


%% plot analyzing graphs
if flag.fir_anlys == 1
    for temp_m = temp.fir_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = temp.fir_s % number of session; size(data, 2)
                eval(sprintf('plot(data(%d).fir_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
%                     xlim(temp.fir_xlim)
                    if flag.fir_ylim == 1;
                        ylim(temp.fir_ylim)
                    end
                end
            end
        end
    end
end

if flag.fir_anlys == 2
    for temp_m = temp.fir_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = temp.fir_s % number of session; size(data, 2)
                eval(sprintf('plot(data(%d).conv_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
%                     xlim(temp.fir_xlim)
                    if flag.fir_ylim == 1;
                        ylim(temp.fir_ylim)
                    end
                end
            end
        end
    end
end

if flag.fir_anlys == 3
    for temp_m = temp.fir_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_s = temp.fir_s % number of session
            subplot(size(temp.fir_s, 2), 2, 1 + 2 * (temp_s - min(temp.fir_s)))
            eval(sprintf('plot(data(%d).task_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
            subplot(size(temp.fir_s, 2), 2, 2 + 2 * (temp_s - min(temp.fir_s)))
            eval(sprintf('plot(data(%d).conv_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
        end
    end
end