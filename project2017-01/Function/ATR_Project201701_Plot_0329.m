%% [ATR: Project2017-01] EMG-Based_Robot
%% plot
if flag.graphs == 1 % time domain
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2)', temp.ty)) % motion
        ATR_Project201701_Motion_0329;
        figure;
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m))
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = 1:size(data, 2) % number of session
                eval(sprintf('plot(data(%d).task_%s{1, %d}(:, %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
                    ylim([-4E6 4E6])
                end
            end
            eval(sprintf('temp.plot_%s = mean(comb_%s.timedomain.%s_ch%d, 2);', temp.ty, temp.ty, temp.state, temp_ch));
            eval(sprintf('plot(temp.plot_%s, ''k'', ''LineWidth'', 2)', temp.ty));
            
            eval(sprintf('temp = rmfield(temp, ''plot_%s'');', temp.ty));
        end
    end
elseif flag.graphs == 2 % amplitude spectrum; FFT
    %
elseif flag.graphs == 3 % power spectrum
    %
elseif flag.graphs == 4 % periodogram
    %
elseif flag.graphs == 5 % DWT
    for temp_m = 1:size(val2(1).cd1_dwt, 2) % number of trial
        figure;
        for temp_ch = 1:size(val2(1).cd1_dwt{1, 1}, 2)
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = 1:size(val2, 2) % number of session
                plot(val2(temp_s).cd1_dwt{1, temp_m}(:, temp_ch))
                if temp_s == 1
                    hold on;
                    if info.sub_name == 'Sub01'
                        ylim([-2E6 2E6])
                    end
                end
            end
            %         eval(sprintf('temp.plot_bf = mean(comb_bf.per_f.%s_ch%d, 2);', temp.state, temp_col));
            %         eval(sprintf('plot(temp.f, temp.plot_bf(temp.f), ''k'', ''LineWidth'', 2)'));
        end
    end
end