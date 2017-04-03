%% [ATR: Project2017-01] EMG-Based_Robot
%% multilevel 1-D wavelet decomposition
temp.length = [];
for temp_s = 1:size(data, 2) % number of sessions
    for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
        temp.length = eval(sprintf('[temp.length; size(data(%d).task_%s{1, %d}, 1)];', temp_s, temp.ty, temp_m));
    end
%     for temp_m = 1:eval(sprintf('size(data(temp_s).conv_%s, 2)', temp.ty)) % motion
%         temp.length = eval(sprintf('[temp.length; size(data(temp_s).conv_%s{1, temp_m}, 1)];', temp.ty));
%     end
end
temp.length_min = min(temp.length);
val.dwt_Fs = 2048/8; % number of samples per window
temp.win = floor(temp.length_min/val.dwt_Fs); % number of windows

for temp_s = 1:size(data, 2) % number of sessions
    for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
        temp_file = eval(sprintf('data(%d).task_%s{1, %d}', temp_s, temp.ty, temp_m));
%         temp_file = eval(sprintf('data(%d).conv_%s{1, %d}', temp_s, temp.ty, temp_m));
        for temp_col = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            for temp_win = 1:temp.win % number of windows
                [val2(temp_s).c_dwt{1, temp_m}{1, temp_col}, val2(temp_s).l_dwt{1, temp_m}{1, temp_col}] = wavedec(temp_file(val.dwt_Fs * (temp_win - 1) + 1:val.dwt_Fs * temp_win, temp_col), val.level, val.wname);
                val2(temp_s).cd1_dwt{1, temp_m}{1, temp_col}(:, temp_win) = detcoef(val2(temp_s).c_dwt{1, temp_m}{:, temp_col}, val2(temp_s).l_dwt{1, temp_m}{:, temp_col}, val.level);
                %             [val2(temp_s).c_dwt{1, temp_t}(:, temp_col), val2(temp_s).l_dwt{1, temp_t}(:, temp_col)] = dwt(temp_file, temp.wname);
            end
        end
        clear temp_file
    end
end

temp = rmfield(temp, {'length', 'length_min'});


%% plot analyzing graphs
if flag.dwt_anlys == 1
    for temp_m = temp.dwt_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = temp.dwt_s % number of session; size(data, 2)
                eval(sprintf('plot(val2(%d).P1_fft_%s{1, %d}(: , %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
                    xlim(temp.dwt_xlim)
                    if flag.dwt_ylim == 1;
                        ylim(temp.dwt_ylim)
                    end
                end
            end
        end
    end
end

if flag.dwt_anlys == 2
    for temp_s = 1:size(data, 2) % number of sessions
        for temp_m = 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty)) % motion
            for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                temp.cd1 = [];
                for temp_win = 1:size(val2(temp_s).cd1_dwt{1, temp_m}{1, temp_ch}, 2)
                    temp.cd1_temp = val2(temp_s).cd1_dwt{1, temp_m}{1, temp_ch}(:, temp_win)';
                    temp.cd1 = [temp.cd1, temp.cd1_temp];
                    temp = rmfield(temp, {'cd1_temp'});
                end
                val2(temp_s).cd1_coeff{1, temp_m}{1, temp_ch}(1, :) = temp.cd1;
                temp = rmfield(temp, {'cd1'});
            end
        end
    end
    
    for temp_m = temp.dwt_m % motion; 1:eval(sprintf('size(data(%d).task_%s, 2)', temp_s, temp.ty))
        figure;
        for temp_s = temp.dwt_s % number of session
            subplot(size(temp.dwt_s, 2), 2, 1 + 2 * (temp_s - min(temp.dwt_s)))
            eval(sprintf('plot(data(%d).task_o{1, %d}(: , %d))', temp_s, temp_m, temp.dwt_ch));
%             eval(sprintf('plot(data(temp_s).conv_%s{1, temp_m}(:, temp.dwt_ch))', temp.ty));
            subplot(size(temp.dwt_s, 2), 2, 2 + 2 * (temp_s - min(temp.dwt_s)))
%             eval(sprintf('plot(val2(%d).cd1_dwt{1, %d}{1 , %d}(1, :))', temp_s, temp_m, temp.dwt_ch));
            eval(sprintf('plot(val2(%d).cd1_coeff{1, %d}{1 , %d}(1, :))', temp_s, temp_m, temp.dwt_ch));
        end
    end
end

%% save
% output_data.temp_dwt = zeros(max(info.sessionNum) * 10, temp.win * 5 * size(val2(1).cd1_dwt{1, 1}, 1) + 1);
output_data.temp_dwt = zeros(max(info.sessionNum) * 10, 5 * size(val2(1).cd1_coeff{1, 1}{1, 1}, 2) + 1);

for temp_m = 1:size(val2(1).cd1_dwt, 2) % motion
    ATR_Project201701_Motion_0329;
    for temp_s = 1:size(val2, 2) % session
        temp.output = [];
        for temp_ch = 1:size(val2(temp_s).cd1_dwt{1, 1}, 2)
            if temp_ch == 1
                temp.output = [temp.output, temp_m];
            end
%             temp.output = [temp.output, val2(temp_s).cd1_dwt{1, temp_m}{1, temp_ch}];
            temp.output = [temp.output, val2(temp_s).cd1_coeff{1, temp_m}{1, temp_ch}(1, :)];
        end
        output_data.temp_dwt(temp_s + (temp_m - 1) * max(info.sessionNum), :) = temp.output;
        temp = rmfield(temp, 'output');
    end
end

% merge into a single file
% temp.variable = cell(1, size(val2(1).cd1_dwt{1, 1}, 2) * temp.win); % val2(1).cd1_dwt{1, 1}{1, 1}
% for temp_ch = 1:size(val2(temp_s).cd1_dwt{1, 1}, 2)
%     for temp_coeff = 1:temp.win
%         temp.variable{1, temp.win * (temp_ch - 1) + temp_coeff} = ['ch', num2str(temp_ch), '_' num2str(temp_coeff)];
%     end
% end
temp.variable = cell(1, size(val2(1).cd1_coeff{1, 1}{1, 1}, 2) * 5); % val2(1).cd1_dwt{1, 1}{1, 1}
for temp_ch = 1:size(val2(temp_s).cd1_dwt{1, 1}, 2)
    for temp_coeff = 1:size(val2(1).cd1_coeff{1, 1}{1, 1}, 2)
        temp.variable{1, temp_coeff + size(val2(1).cd1_coeff{1, 1}{1, 1}, 2) * (temp_ch - 1)} = ['ch', num2str(temp_ch), '_' num2str(temp_coeff)];
    end
end
temp.row = cell(size(output_data.temp_dwt, 1), 1);
for temp_cnt = 1:size(output_data.temp_dwt, 1)
    temp_m = output_data.temp_dwt(temp_cnt, 1);
    ATR_Project201701_Motion_0329;
    temp.row{temp_cnt, 1} = temp.state;
end

%     output_data.dwt_f = table(output_data.temp_dwt(:, 2:end), 'VariableNames', temp.variable, 'RowNames', temp.row);
temp.table_1 = table(categorical(temp.row), 'VariableNames', {'Class'});
temp.table_2 = array2table(output_data.temp_dwt(:, 2:end), 'VariableNames', temp.variable);
output_data.dwt_f = [temp.table_1 temp.table_2];

filename_dwt = [info.sub_name, '-', info.initial, '_DWT_', val.wname, 'L', num2str(val.level), '_',info.date, '.csv'];
writetable(output_data.dwt_f, filename_dwt);