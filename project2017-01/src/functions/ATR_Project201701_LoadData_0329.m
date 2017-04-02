%% [ATR: Project2017-01] EMG-Based_Robot
%% load data
if info.sub_name == 'Sub01'
    info.initial = 'Kim_DY';
    info.date = '170321';
    path(path, '/Users/DoYeon/Documents/ATR/Project 2017-01 - EMG-Based Robot/data/raw/sub01-0321');
elseif info.sub_name == 'Sub02'
    info.initial = 'Lee_GY';
    info.date = '170322';
    path(path, '/Users/DoYeon/Documents/ATR/Project 2017-01 - EMG-Based Robot/data/raw/sub02-0322');
elseif info.sub_name == 'Sub03'
    info.initial = 'Kim_KL';
    info.date = '170401';
    path(path, '/Users/DoYeon/Documents/ATR/Project 2017-01 - EMG-Based Robot/data/raw/sub03-0401');
elseif info.sub_name == 'Sub04'
    info.initial = 'Kim_KL';
    info.date = '170401';
    path(path, '/Users/DoYeon/Documents/ATR/Project 2017-01 - EMG-Based Robot/data/raw/sub04-0401');
end

for temp_s = info.sessionNum % number of sessions
    info.session_num = ['S', num2str(temp_s, '%02i')]; % '%02i' or '%02d'
    filename_output = [info.sub_name, '_', info.session_num, '-', info.initial, '_Output_Data_', info.date, '.mat'];
%     filename_seq = [info.sub_name, '_', info.session_num, '-', info.initial, '_Seq_', info.date, '.mat'];
    
    data(1, temp_s) = load(filename_output, '-mat');
end

clear filename_output