%% [ATR: Project2017-01] EMG-Based_Robot
%% save files per channel
if flag.timedomain_ch == 1
    for temp_m = 1:eval(sprintf('size(data(1).task_%s, 2);', temp.ty))
        ATR_Project201701_Motion_0329;
        for temp_ch = 1:eval(sprintf('size(data(1).task_%s{1, 1}, 2);', temp.ty))
            % time domain
            filename_timedomain = [info.sub_name, '-', info.initial, '_TimeDomain_', temp.state, '_ch', num2str(temp_ch), '_Ord', num2str(val.n_bp), '_W', num2str(val.Wn_bp), '_', info.anlys, '.csv'];
            eval(sprintf('csvwrite(''%s'', comb_%s.timedomain.%s_ch%d);', filename_timedomain, temp.ty, temp.state, temp_ch));
        end
    end
end