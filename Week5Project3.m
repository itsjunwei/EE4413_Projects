%% Question 9 
% Estimated the order of linear-phase lowpass FIR filter

FT1 = 10;   % Sampling Freq
Fp = 2;     % Passband edge
Fs = 2.5;   % Stopband edge
rp = 0.005; % Passband ripple
rs = 0.005; % Stopband ripple
N1 = kaiord(Fp,Fs,rp,rs,FT1);
fprintf('\nQ9: Answer = %d\n',N1);
%% Question 10
% 10a) Change Sampling rate to 20kHz
FTa = 20;
N2a = kaiord(Fp,Fs,rp,rs,FTa);

% 10b) Change passband and stopband ripple to 0.002
rpb = 0.002;
rsb = 0.002;
N2b = kaiord(Fp,Fs,rpb,rsb, FT1);

% 10c) Change stopband edge to 2.3kHz
Fsc = 2.3;
N2c = kaiord(Fp,Fsc,rp,rs,FT1);

% Displaying all 3 new orders
fprintf('\nQ10: The 3 new orders are: %d, %d, %d\n', N2a,N2b,N2c);

%% Question 11
% Repeat Q9 using function kaiserord
% [N, Wn, beta, ftype] = kaiserord(fedge, aval, dev)
% [N, Wn, beta, ftype] = kaiserord(fedge, aval, dev, FT)
% c = kaiserord(fedge, aval, dev, FT, 'cell')

[N, Wn, beta, ftype] = kaiserord([Fp Fs], [1 0], [rp rs], FT1);
fprintf('\nQ11: The order of the kaiserord is : %d\n', N);
% [N , Wn, beta, ftype] = kaiserord([2 2.5], [1 0], [0.005 0.005], 10);


%% Question 12
% Repeat Q9 using the function remezord

% [N, fts, mval, wgts] = remezord(fedge, aval, dev)
% [N, fts, mval, wgts] = remezord(fedge, aval, dev, FT)

[N, fts, mval, wgts] = remezord([Fp Fs], [1 0], [rp rs], FT1);
fprintf('\nQ12: The order of the remezord is : %d\n', N);


%% Question 13
% Using the function kaiord, estimate the order of a linear-phase
% bandpass FIR filter with the following specifications: 
% passband edges= 1.8 and 3.6 kHz 
% stopband edges = 1.2 and 4.2 kHz
% passband ripple ?p = 0.1
% stopband ripple ?s = 0.02
% sampling rate of 12 kHz

passbandEdges = [1.8 3.6];
stopbandEdges = [1.2 4.2];
passbandRipple = 0.1;
stopbandRipple = 0.02;
samplingRate = 12;

N = kaiord(passbandEdges, stopbandEdges, passbandRipple, ...
    stopbandRipple, samplingRate);

fprintf('\nQ13: The order of the filter is : %d\n', N);


%% Question 14 
% Repeat Q13 using the function kaiserord
[N, Wn, beta, ftype] = kaiserord([3.6 4.2], ...
    [1 0], [passbandRipple stopbandRipple], samplingRate);
fprintf('\nQ14: The order of the kaiserord is : %d\n', N);


%% Question 15 
% Repeat Q13 using function remezord
[N, fts, mval, wgts] = remezord([3.6 4.2], [1 0], ...
    [passbandRipple stopbandRipple], samplingRate);
fprintf('\nQ15: The order of the remezord is : %d\n', N);
