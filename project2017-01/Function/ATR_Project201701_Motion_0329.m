%% [ATR: Project2017-01] EMG-Based_Robot
%% num2motion
if info.sub_name == 'Sub01'
    if temp_m == 1
        temp.state = 'neutral';
    elseif temp_m == 2
        temp.state = 'up';
    elseif temp_m == 3
        temp.state = 'down';
    elseif temp_m == 4
        temp.state = 'right';
    elseif temp_m == 5
        temp.state = 'left';
    elseif temp_m == 6
        temp.state = 'forward';
    elseif temp_m == 7 % right flip
        temp.state = 'right_flip';
    elseif temp_m == 8
        temp.state = 'left_flip';
    elseif temp_m == 9
        temp.state = 'rolling';
    elseif temp_m == 10
        temp.state = 'swallow';
    end
elseif info.sub_name == 'Sub02'
    if temp_m == 1
        temp.state = 'neutral';
    elseif temp_m == 2
        temp.state = 'up';
    elseif temp_m == 3
        temp.state = 'down';
    elseif temp_m == 4
        temp.state = 'right';
    elseif temp_m == 5
        temp.state = 'left';
    elseif temp_m == 6
        temp.state = 'forward';
    elseif temp_m == 7 % fold
        temp.state = 'fold';
    elseif temp_m == 8
        temp.state = 'left_flip';
    elseif temp_m == 9
        temp.state = 'rolling';
    elseif temp_m == 10
        temp.state = 'swallow';
    end
end