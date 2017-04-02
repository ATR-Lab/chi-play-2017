%% [ATR: Project2017-01] EMG-Based_Robot
%% multilevel 1-D wavelet decomposition
for temp_s = 1:size(data, 2) % number of sessions
    for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
        temp_file = eval(sprintf('data(%d).task_%s{1, %d}', temp_s, temp.ty, temp_m));
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('[val2(%d).c_dwt_%s{1, %d}(:, %d), val2(%d).l_dwt_%s{1, %d}(:, %d)] = wavedec(temp_file(:, %d), %d, %d);', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_ch, temp_ch, val.level, val.wname));
            eval(sprintf('val2(temp_s).cd1_dwt{1, temp_m}(:, temp_col) = detcoef(val2(temp_s).c_dwt{1, temp_m}(:, temp_col), val2(temp_s).l_dwt{1, temp_m}(:, temp_col), temp.level);', temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_ch, temp_s, temp.ty, temp_m, temp_ch, val.level));
%             [val2(temp_s).c_dwt{1, temp_t}(:, temp_col), val2(temp_s).l_dwt{1, temp_t}(:, temp_col)] = dwt(temp_file, temp.wname);
        end
        clear temp_file
    end
end


%% grand average
if flag.dwt_avg == 1
    temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(val2(%d).cd1_dwt_%s{1, %d}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
            ATR_Project201701_Motion_0329;
            for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                eval(sprintf('comb_%s.per_f.%s_ch%d(:, %d) = val2(%d).cd1_dwt_%s{1, %d}(1:%d, 1);', temp.ty, temp.state, temp_ch, temp_s, temp_s, temp.ty, temp_m, temp.length_min));
            end
        end
    end
    temp = rmfield(temp, {'length', 'length_min'});
end


%% plot analyzing graphs
if flag.dwt_anlys == 1
    for temp_m = temp.dwt_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_ch = eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = temp.dwt_s % number of session; size(data, 2)
                eval(sprintf('plot(val2(%d).cd1_dwt_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
                    xlim(temp.dwt_xlim)
                    if flag.dwt_ylim == 1;
                        ylim([-4E6 4E6])
                    end
                end
            end
        end
    end
end