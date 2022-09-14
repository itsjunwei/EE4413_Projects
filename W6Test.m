% Making a signal with 3 sinusoidal components (5, 15 and 30Hz)
Fs=100; % Sampling Frequency
t=(1:100)/Fs; % Sampled waveform from t=0 to t=1 second
% For question 3, comment above, uncomment below
% t=(1:1000)/Fs;

% Setting up sinusoids
s1 = sin(2*pi*t*5); % 5Hz
s2 = sin(2*pi*t*15); % 15Hz
s3 = sin(2*pi*t*30); % 30Hz
% For question 2, comment line 9, uncomment below
% s2 = sin(2*pi*t*15.5);
s = s1 + s2 + s3; 

% First part of plotting the sinusoidal waveforms
figure();
plot(t,s);
title('Part 1, plotting the sinusoidal waveforms');
xlabel('Time (seconds)');
ylabel('Time Waveform');

% Second part of keeping the 15Hz sinusoid and getting rid of
% the 5, 30Hz components

% Creating an eighth order IIR filter with a passband of 
% 10 to 20 Hz and plotting the Freq Response

% [B,A] = ellip(N,Rp,Rs,Wp) 
% N     : Designs an Nth order lowpass elliptic filter 
% Rp    : Rp decibels of peak-to-peak ripple
% Rs    : minimum stopband attenuation of Rs decibels. 
% Wp    : passband-edge frequency (0 < Wp < 1)

% ellip returns the filter coefficients in
% length N+1 vectors B (numerator) and A (denominator).
[b,a] = ellip(4, 0.1, 40, [10 20]*2/Fs);

% [H,W] = freqz(B,A,N) returns the N-point complex frequency 
% response vector H and the N-point frequency vector W in 
% radians/sample of the filter
[H,w] = freqz(b,a,512);
figure();
plot(w*Fs/(2*pi),abs(H));
title('Part 2, plotting the Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude of Frequency Response');


% The signal is now a 15Hz sinusoid as expected

% filter(B,A,X) filters the data in vector X with the
% filter described by vectors A and B to create the filtered
% data Y.  The filter is a "Direct Form II Transposed"
sf = filter(b,a,s);
figure();
plot(t,sf);
title('Part 3, plotting the filtered 15Hz sinusoid');
xlabel('Time (seconds)');
ylabel('Time waveform');
axis([0 1 -1 1]);


% Plotting the frequency content of the signal before 
% and after filteirng. Notice the peaks at 5 and 30 Hz have been 
% effectively eliminated

% fft(X,N) is the N-point Discrete Fourier Transform (DFT), 
% padded with zeros if X has less than N points 
% and truncated if it has more.

S = fft(s,512);
SF = fft(sf,512);
w = (0:255)/256*(Fs/2);
figure();
plot(w, abs([S(1:256)' SF(1:256)']));
title('Part 4, plotting the before/after frequency content');
xlabel('Frequency (Hz)');
ylabel('Mag. of Fourier transform');