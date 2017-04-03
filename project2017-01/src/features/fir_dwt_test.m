## User must be in parent directory "chi-play-2017# in order for the code to work# # The following code use the alternative DWT library for Octave:# http://ltfat.sourceforge.net/doc/wavelets/fwt.php# http://ltfat.sourceforge.net/doc/wavelets/fwt.php## Filter reference:# https://www.mathworks.com/help/wavelet/ref/wfilters.html# http://ltfat.sourceforge.net/doc/wavelets/index.php## Wavelet families# https://www.mathworks.com/help/wavelet/gs/introduction-to-the-wavelet-families.html#clear allclose allclcpkg load signal################f_slash       = "/";sub           = "sub02-170322";training_set  = "set1";task          = "on";filter        = "time-domain";motions       = ["down", "fold", "forward", "left", "left-flip", "neutral", "right", "right-flip", "swallow"];%motion        = "down";motion        = "swallow";path          = [pwd, "/data/intermediate/", sub, f_slash, training_set, f_slash, task, f_slash, filter, f_slash, motion];filename      = ["Sub02-Lee_GY_o_TimeDomain_", motion, "_ch1_170322.csv"];ch1_filename  = [path, f_slash, filename];csv_output    = csvread(ch1_filename);% data_points   = 4097;Fs            = 2048; % Sampling frequency/rate 2048HzTs            = 1/Fs; % Sampling perioddt            = 0:Ts:4000-Ts% Signal duration%dt            = 0:Ts:5e-3-Ts% Signal duration from video tutorialplot_num = 1;figure_num = 1;figure(figure_num);for trial_num = 1:20      if (mod(trial_num, 5) == 1 && trial_num > 1)    figure_num++;    figure(figure_num);    plot_num = 1;  endif    trial_data = csv_output(:, [trial_num]); %select a specific column  trial_data = trial_data(:);   subplot(5, 2, plot_num)  plot(trial_data);  title("Time Domain Without Filter");  xlim([1, 4000]);    %nfft  = length(trial_data);  %nfft2 = 2.^nextpow2(nfft);  %fy    = fft(trial_data, nfft2);  %fy    = fy(1:nfft2/2);  %xfft  = Fs.*(0:nfft2/2-1)/nfft2;  %plot(xfft, abs(fy/max(fy)));  #  # Time Domain data with FIR filter  cut_off = 10; %400 Hz  cut_off = cut_off/Fs/2; %normalize it to Nyquist frequency    % order   = 16;  order   = 64;  #  h       = fir1(order, cut_off);  con     = conv(trial_data, h);  %plot(con);  %title("Time Domain with FIR Filter");  %xlim([1, 4000]);    #  # DWT of Time Domain data with FIR filter  #  plot_num++;  [c1,info]=fwt(con,'sym8',14);   %[c1,info]=fwt(conv,'db4',4);   subplot(5, 2, plot_num);  plot(c1);  title("DWT of Time Domain with FIR Filter");  xlim([1,2000]);  plot_num++;     % Testing Daubeuchies  %[c1,info]=fwt(trial_data,'db8',4);    %plotwavelets(c1,info,fs,'dynrange',dr);  %plotwavelets(c1,info,fs);     end  ## Useful row count snippet#%% http://stackoverflow.com/questions/12176519/is-there-a-way-in-matlab-to-determine-the-number-of-lines-in-a-file-without-loop/12176649#12176649#{if (isunix) %# Linux, mac    [status, result] = system( ['wc -l ', ch1_filename] );    numlines = str2num(result);elseif (ispc) %# Windows    numlines = str2num( perl('countlines.pl', ch1_filename) );else    error('...');end#}