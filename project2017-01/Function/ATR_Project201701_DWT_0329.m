%% [ATR: Project2017-01] EMG-Based_Robot
%% multilevel 1-D wavelet decomposition
for temp_s = 1:size(data, 2) % number of sessions
    for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
        temp_file = eval(sprintf('data(%d).task_%s{1, %d}', temp_s, temp.ty, temp_m));
        for temp_col = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            [val2(temp_s).c_dwt{1, temp_m}(:, temp_col), val2(temp_s).l_dwt{1, temp_m}(:, temp_col)] = wavedec(temp_file(:, temp_col), temp.level, temp.wname);
            val2(temp_s).cd1_dwt{1, temp_m}(:, temp_col) = detcoef(val2(temp_s).c_dwt{1, temp_m}(:, temp_col), val2(temp_s).l_dwt{1, temp_m}(:, temp_col), temp.level);
%             [val2(temp_s).c_dwt{1, temp_t}(:, temp_col), val2(temp_s).l_dwt{1, temp_t}(:, temp_col)] = dwt(temp_file, temp.wname);
        end
        clear temp_file
    end
end