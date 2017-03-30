%% [ATR: Project2017-01] EMG-Based_Robot
%% epoch
for temp_s = 1:size(data, 2)
    for temp_m = 1:size(data(temp_s).bandstop_f, 2)
        temp.startPNT = find(data(temp_s).epoch{1, temp_m}(:, 1) == 128, 1);
        temp.endPNT = temp.startPNT + find(data(temp_s).epoch{1, temp_m}(temp.startPNT:end, 1) == 256, 1);
        % before the onset;
        data(temp_s).task_bf{1, temp_m} = data(temp_s).bandstop_f{1, temp_m}(1:temp.startPNT - 1, :);
        % from the onset to offset; TRAINING SET 1
        data(temp_s).task_o{1, temp_m} = data(temp_s).bandstop_f{1, temp_m}(temp.startPNT:temp.endPNT, :);
        % include both before and onset; TRAINING SET 2
        data(temp_s).task_bfo{1, temp_m} = data(temp_s).bandstop_f{1, temp_m}(1:temp.endPNT, :);
        clear temp.startPNT temp.endPNT
    end
end

%% grand average
if flag.epoch_avg == 1
    temp.length_bf = []; temp.length_o = []; temp.length_bfo = [];
    for temp_s = 1:size(data, 2)
        for temp_m = 1:size(data(temp_s).task_bf, 2)
            temp.length_bf = [temp.length_bf; size(data(temp_s).task_bf{1, temp_m}, 1)];
            temp.length_o = [temp.length_o; size(data(temp_s).task_o{1, temp_m}, 1)];
            temp.length_bfo = [temp.length_bfo; size(data(temp_s).task_bfo{1, temp_m}, 1)];
        end
    end
    temp.min_bf = min(temp.length_bf);
    temp.min_o = min(temp.length_o);
    temp.min_bfo = min(temp.length_bfo);
    
    for temp_ty = 1:3 % number of types
        if temp_ty == 1
            temp.ty = 'bf';
        elseif temp_ty == 2
            temp.ty = 'o';
        elseif temp_ty == 3
            temp.ty = 'bfo';
        end
        for temp_s = 1:size(data, 2) % number of sessions
            for temp_m = 1:size(data(1).task_o, 2) % number of motion
                ATR_Project201701_Motion_0329;
                for temp_ch = 1:size(data(1).task_o{1, temp_m}, 2) % number of channel
                    eval(sprintf('comb_%s.timedomain.%s_ch%d(:, %d) = data(%d).task_%s{1, %d}(1:temp.min_%s, 1);', temp.ty, temp.state, temp_ch, temp_s, temp_s, temp.ty, temp_m, temp.ty));
                end
            end
        end
    end
    temp = rmfield(temp, {'length_bf', 'length_o', 'length_bfo', 'min_bf', 'min_o','min_bfo', 'ty'});
end


%% plot analyzing graphs
if flag.time_anlys == 1
    temp.ty = info.trainingSet;
    for temp_m = temp.time_m % motion
        figure;
        for temp_ch = 1:eval(sprintf('size(data(%d).task_%s{1, %d}, 2)', temp_s, temp.ty, temp_m)) % channel
            eval(sprintf('subplot(5, 1, %d)', temp_ch));
            for temp_s = temp.time_s % number of session
                eval(sprintf('plot(data(%d).task_%s{1, %d}(:, %d))', temp_s, temp.ty, temp_m, temp_ch));
                if temp_s == 1
                    hold on;
                    xlim([0 2*2048])
                    if flag.time_ylim == 1;
                        ylim([-4E6 4E6])
                    end
                end
            end
        end
    end
end