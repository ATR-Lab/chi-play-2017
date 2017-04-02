%% [ATR: Project2017-01] EMG-Based_Robot
%% save
%% time domain
if flag.save_time == 1
        temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(data(temp_s).task_%s{1, temp_m}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    temp = rmfield(temp, 'length');
    
    output_data.temp_time = zeros(30 * 10, 1 + temp.length_min * 5);
    
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
        ATR_Project201701_Motion_0329;
        for temp_s = 1:size(data, 2) % number of session
            temp.output = [];
            for temp_ch = temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                if temp_ch == 1
                    temp.output = [temp.output, temp_m];
                end
                eval(sprintf('temp.output = [temp.output, data(%d).task_%s{1, %d}(1:%d, %d)''];', temp_s, temp.ty, temp_m, temp.length_min, temp_ch));
            end
            output_data.temp_time(temp_s + (temp_m - 1) * 30, :) = temp.output;
            temp = rmfield(temp, 'output');
        end
    end
    
    % merge into a single file
    eval(sprintf('temp.variable = cell(1, size(data(temp_s).task_%s{1, 1}, 2) * temp.length_min);', temp.ty));
    for temp_ch = 1:size(val2(temp_s).cd1_dwt{1, 1}, 2)
        for temp_coeff = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            temp.variable{1, temp.length_min * (temp_ch - 1) + temp_coeff} = ['ch', num2str(temp_ch), '_' num2str(temp_coeff)];
        end
    end
    temp.row = cell(size(output_data.temp_time, 1), 1);
    for temp_cnt = 1:size(output_data.temp_time, 1)
        temp_m = output_data.temp_time(temp_cnt, 1);
        ATR_Project201701_Motion_0329;
        temp.row{temp_cnt, 1} = temp.state;
    end
    
    temp.table_1 = table(categorical(temp.row), 'VariableNames', {'Class'});
    temp.table_2 = array2table(output_data.temp_dwt(:, 2:end), 'VariableNames', temp.variable);
    output_data.time_f = [temp.table_1 temp.table_2];
    
    filename_time = [info.sub_name, '-', info.initial, '_', info.trainingName, '_TimeDomain_',info.date, '.csv'];
    writetable(output_data.time_f, filename_time);
    temp = rmfield(temp, 'variable', 'row', 'table_1', 'table_2');
end

%% ampSpectrum
if flag.save_amp == 1
            temp.length = [];
    for temp_s = 1:size(data, 2) % number of session
        for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
            eval(sprintf('temp.length = [temp.length; size(val2(temp_s).P1_fft_%s{1, temp_m}, 1)];', temp_s, temp.ty, temp_m));
        end
    end
    temp.length_min = min(temp.length);
    temp = rmfield(temp, 'length');
    
    output_data.temp_amp = zeros(30 * 10, 1 + temp.length_min * 5);
    
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
        ATR_Project201701_Motion_0329;
        for temp_s = 1:size(data, 2) % number of session
            temp.output = [];
            for temp_ch = temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
                if temp_ch == 1
                    temp.output = [temp.output, temp_m];
                end
                eval(sprintf('temp.output = [temp.output, data(%d).task_%s{1, %d}(1:%d, %d)''];', temp_s, temp.ty, temp_m, temp.length_min, temp_ch));
            end
            output_data.temp_time(temp_s + (temp_m - 1) * 30, :) = temp.output;
            temp = rmfield(temp, 'output');
        end
    end
    
    % merge into a single file
    eval(sprintf('temp.variable = cell(1, size(data(temp_s).task_%s{1, 1}, 2) * temp.length_min);', temp.ty));
    for temp_ch = 1:size(val2(temp_s).cd1_dwt{1, 1}, 2)
        for temp_coeff = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            temp.variable{1, temp.length_min * (temp_ch - 1) + temp_coeff} = ['ch', num2str(temp_ch), '_' num2str(temp_coeff)];
        end
    end
    temp.row = cell(size(output_data.temp_time, 1), 1);
    for temp_cnt = 1:size(output_data.temp_time, 1)
        temp_m = output_data.temp_time(temp_cnt, 1);
        ATR_Project201701_Motion_0329;
        temp.row{temp_cnt, 1} = temp.state;
    end
    
    temp.table_1 = table(categorical(temp.row), 'VariableNames', {'Class'});
    temp.table_2 = array2table(output_data.temp_dwt(:, 2:end), 'VariableNames', temp.variable);
    output_data.time_f = [temp.table_1 temp.table_2];
    
    filename_time = [info.sub_name, '-', info.initial, '_', info.trainingName, '_TimeDomain_',info.date, '.csv'];
    writetable(output_data.time_f, filename_time);
    temp = rmfield(temp, 'variable', 'row', 'table_1', 'table_2');
end


%% DWT
if flag.save_dwt == 1
    temp.length = [];
    for temp_s = 1:size(val2, 2) % session
        for temp_m = 1:size(val2(temp_s).cd1_dwt, 2) % motion
            temp.length = [temp.length; size(val2(temp_s).cd1_dwt{1, temp_m}, 1)];
        end
    end
    temp.length_min = min(temp.length);
    temp = rmfield(temp, 'length');
    
    output_data.temp_dwt = zeros(30 * 10, 1 + temp.length_min * 5);
    
    for temp_m = 1:size(val2(temp_s).cd1_dwt, 2) % motion
        ATR_Project201701_Motion_0329;
        for temp_s = 1:size(val2, 2) % session
            temp.output = [];
            for temp_ch = 1:size(val2(temp_s).cd1_dwt{1, 1}, 2)
                if temp_ch == 1
                    temp.output = [temp.output, temp_m];
                end
                temp.output = [temp.output, val2(temp_s).cd1_dwt{1, temp_m}(1:temp.length_min, temp_ch)'];
            end
            output_data.temp_dwt(temp_s + (temp_m - 1) * 30, :) = temp.output;
            temp = rmfield(temp, 'output');
        end
    end
    
    % merge into a single file
    temp.variable = cell(1, size(val2(temp_s).cd1_dwt{1, 1}, 2) * temp.length_min);
    %     temp.variable{1, 1} = {'Class'};
    for temp_ch = 1:size(val2(temp_s).cd1_dwt{1, 1}, 2)
        for temp_coeff = 1:temp.length_min
            temp.variable{1, temp.length_min * (temp_ch - 1) + temp_coeff} = ['ch', num2str(temp_ch), '_' num2str(temp_coeff)];
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
    
    filename_dwt = [info.sub_name, '-', info.initial, '_DWT_', temp.wname, 'L', num2str(temp.level), '_',info.date, '.csv'];
    writetable(output_data.dwt_f, filename_dwt);
end
