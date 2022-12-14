% Question 1
% Use marginally stable IIR filter to generate the tones of 3 seconds
% when a key (a number from 0 to 9) is being input.

low_freqs   = [697 770 852 941]; % Low Frequencies (Rows)
high_freqs  = [1209 1336 1477]; % High Frequencies (Columns)

% Marginally stable IIR filter is determined by the zero-pole plot of 
% filter transfer function

% Stable: If and only if all the poles of the filter transfer 
% function lie inside the unit circle.

Fs  = 3000; % Sampling Frequency of 3kHz
t   = (1:9000)/Fs; % Sampled Waveform from t=0 to t=3 seconds

full_waveform = 0; % Establish a waveform of all frequencies

% Adding low_frequencies
for r=1:4
    full_waveform = full_waveform + sin(2*pi*t*low_freqs(r));
end

% Adding high_frequencies
for c=1:3
    full_waveform = full_waveform + sin(2*pi*t*high_freqs(c));
end

% IIR Bandpass Butterworth Filter to filter out the desired frequency

F = 697
Wp = [F-10 F+10]*2/Fs;            % Passband Frequencies
Ws = [F-500 F+500]*2/Fs;           % Stopband Frequencies 
Rp = 3;                         % Passband Ripple 
Rs = 40;                        % Min. stopband attenuation 
[n,Wn] = buttord(Wp,Ws,Rp,Rs);  % Filter order estimation 
[b,a] = butter(n,Wn);           % Designing filter

% Output the filter stablity (1 = STABLE)
fprintf("\nFilter stablity: %d\n", isstable(b,a))

% Here we will plot 3 graphs
% First graph is our filtered waveform
% Second graph is the actual waveform we should see
% Third graph is the frequency/magnitude response for our confirmation

sf = filter(b,a,full_waveform); % Filter the waveform
subplot(3,1,1);
plot(t,sf);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Waveform');
axis([0 0.01 -1.5 1.5]);

subplot(3,1,2);
plot(t,sin(2*pi*t*F)); % Plot the actual, theoretical waveform
xlabel('Time (s)');
ylabel('Amplitude');
title('Theoretical Waveform');
axis([0 0.01 -1.5 1.5]);

subplot(3,1,3);
% Plot the Frequency Response for our analysis
[H,w] = freqz(b,a,512);
plot(w*Fs/(2*pi),abs(H));
title('Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Mag. of Frequency Response');


