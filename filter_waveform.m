function filtered_waveform = filter_waveform(F, full_waveform)
    Fs = 8000; % Sampling Frequency of 3kHz
    Wp = [F-10 F+10]*2/Fs;          % Passband Frequencies
    Ws = [F-500 F+500]*2/Fs;        % Stopband Frequencies 
    Rp = 3;                         % Passband Ripple 
    Rs = 40;                        % Min. stopband attenuation 
    [n,Wn] = buttord(Wp,Ws,Rp,Rs);  % Filter order estimation 
    [b,a] = butter(n,Wn);           % Designing filter

    filtered_waveform = filter(b,a,full_waveform); % filter the waveform
end