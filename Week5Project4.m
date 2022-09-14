% Project 4 FIR Filter Design

% Question 16
% Using the function fir1, design a linear-phase FIR lowpass filter 
% meeting the specifications given in Question Q9 and plot its gain
% and phase responses. Use the order estimated using Kaiser's formula
% in Question Q9. Show the filter coefficients in a tabular form

% B = fir1(N,Wn) designs an N'th order lowpass FIR digital filter
% and returns the filter coefficients in length N+1 vector B.

% Table of specifications 
FT = 10;        % Sampling Freq
Fp = 2;         % Passband edge
Fs = 2.5;       % Stopband edge
rp = 0.005;     % Passband ripple
rs = 0.005;     % Stopband ripple
N = 46;         % Order estimated in Q9

% Wn = (Fp + Fs)/ FT
Wn = ((Fp + Fs)/(FT/2))/2;
B = fir1(N, Wn);    % Window-based FIR filter design
figure();           % Open the figure in another window
freqz(B,1,512);     % Frequency response of filter
title('Question 16 Frequency Response Graph using fir1');

[H,w] = freqz(B,1,512);
figure();
plot(w*FT/(2*pi),abs(H));
xlabel('Frequency (kHz)');
ylabel('Magnitude of Frequency Response');
title('Question 16 Magnitude Response Graph using fir1');

% Question 17
% The command [ b = fir1(N, Wn, taper) ]
% makes use of the specified window coefficients of 
% length N+1 in the vector taper

% Repeating Q16 using Hanning
b1 = fir1(N, Wn, hanning(N+1));
figure();
freqz(b1,1,512);
title('Question 17 Frequency Response Graph using Hanning');
[H,w] = freqz(b1,1,512);
figure();
plot(w*FT/(2*pi),abs(H));
xlabel('Frequency (kHz)');
ylabel('Magnitude of Frequency Response');
title('Question 17 Magnitude Response Graph using Hanning');

% Repeating Q16 using Blackman
b2 = fir1(N, Wn, blackman(N+1));
figure();
freqz(b2,1,512);
title('Question 17 Frequency Response Graph using Blackman');
[H,w] = freqz(b2,1,512);
figure();
plot(w*FT/(2*pi),abs(H));
xlabel('Frequency (kHz)');
ylabel('Magnitude of Frequency Response');
title('Question 17 Magnitude Response Graph using Blackman');

% Repeating Q16 using Doplh-Chebyshev
b3 = fir1(N, Wn, chebwin(N+1));
figure();
freqz(b3,1,512);
title('Question 17 Frequency Response Graph using Doplh-Chebyshev');
[H,w] = freqz(b3,1,512);
figure();
plot(w*FT/(2*pi),abs(H));
xlabel('Frequency (kHz)');
ylabel('Magnitude of Frequency Response');
title('Question 17 Magnitude Response Graph using Doplh-Chebyshev');


%% Question 18
% Repeating Q16 using the function remez(firpm)

% c = remezord(fedge,aval,dev,FT, 'cell')
% specifies a cell array whose elements are the parameters
% to remez (or, firpm)


% normFp 
Fp = 0.4;       % Normalized Passband edge
Fs = 0.5;       % Normalized Stopband edge
rp = 0.005;     % Passband ripple
rs = 0.005;     % Stopband ripple
N = 46;         % Order estimated in Q9

b = firpm(N, [0 Fp Fs 1], [1 1 0 0]); 
figure();
freqz(b,1,512);
title('Question 18 Frequency Response of firpm');

[h,w] = freqz(b,1,512);
figure();
plot([0 Fp Fs 1], [1 1 0 0],w/pi,abs(h));
legend('Ideal','firpm Design');
xlabel('Radian Frequency (\omega/\pi)');
ylabel('Magnitude');
title('Question 18 firpm design');

%% Question 19
% Using fir2, design an FIR filter of order 95 with three 
% different constant magnitude levels: 
% 0.4 in the frequency range 0 to 0.25, 
% 1.0 in the frequency range 0.3 to 0.45, 
% 0.8 in the frequency range 0.5 to 1.0. 

f = [0 0.25 0.3 0.45 0.5 1.0];  % Frequency breakpoints
m = [0.4 0.4 1.0 1.0 0.8 0.8];  % Magnitude breakpoints
N = 95;                         % Order of the filter
% Frequency sampling-based FIR filter design
b = fir2(N,f,m);
figure();
freqz(b,1,512); % Frequency response of the filter

% Plotting the gain
[h, w] = freqz(b,1,512);
figure();
plot(f, m,w/pi,abs(h)); % Ideal vs fir2 design
legend('Ideal','FIR2 Design');
xlabel('Radian Frequency (\omega/\pi)');
ylabel('Magnitude');
title('Question 19 FIR2 Design');


%% Question 20
% Using remez(firpm), design the below
% linear-phase bandpass FIR filter with the following specifications:
% passband edges= 1.8 and 3.6 kHz, 
% stopband edges = 1.2 and 4.2 kHz, 
% passband ripple ?p = 0.1, 
% stopband ripple ?s = 0.02, 
% sampling rate of 12 kHz
% order = 20

% wgts = max(?p, ?s ) [1/?s, 1/?p, 1/?s]
Fp = [0.3 0.6];
Fs = [0.2 0.7];
rp = 0.1;
rs = 0.02;
samplingFreq = 12;
N = 20;
b = firpm(20, [0 0.2 0.3 0.6 0.7 1], [0 0 1 1 0 0], [1/rs, 1/rp, 1/rs]);
figure();
freqz(b,1,512);
title('Question 20 Frequency Response of firpm');

[h,w] = freqz(b,1,512);
figure();
plot([0 0.2 0.3 0.6 0.7 1], [0 0 1 1 0 0], w/pi, abs(h));
legend('Ideal','firpm Design');
xlabel('Radian Frequency (\omega/\pi)');
ylabel('Magnitude');
title('Question 20 firpm design');


%% Question 21 
% Using remez (firpm), design an FIR bandpass filter 
% with the following specifications:
% passband edges = l.8 and 3.0 kHz, 
% stopband edges = 1.5 and 4.2 kHz, 
% passband ripple ?p = 0.1, 
% stopband ripple ?s = 0.02, 
% sampling rate of 12 kHz. 
% Estimate the filter order using kaiserord

Fp = [1.8 3.0];
Fs = [1.5 4.2];
rp = 0.1;
rs = 0.02;
FT = 12;
[N, Wn, beta, ftype] = kaiserord([3 4.2], [1 0], [rp rs], FT);
b = firpm(N, [0 1.5 1.8 3.0 4.2 FT/2]/(FT/2), [0 0 1 1 0 0], [1/rs, 1/rp, 1/rs]);
figure();
freqz(b,1,512);
title('Question 21 Frequency Response of firpm');

[h,w] = freqz(b,1,512);
figure();
plot([0 1.5 1.8 3.0 4.2 FT/2]/(FT/2), [0 0 1 1 0 0], w/pi, abs(h));
legend('Ideal','firpm Design');
xlabel('Radian Frequency (\omega/\pi)');
ylabel('Magnitude');
title('Question 21 firpm design');