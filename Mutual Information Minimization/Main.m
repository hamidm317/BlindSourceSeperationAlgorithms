s1 = downsample(audioread('03-Mahi.mp3'), 10); % jazz one
s2 = downsample(audioread('03-Zolfaye_Ghejeri.mp3'), 10); % Sonneti one

%% 

fs = 4410;
n = 2;
%
clear S;

samples_number = 10000;

S(1, :) = s1(100000 : 100000 + samples_number - 1, 1);
S(2, :) = s2(10000 : 10000 + samples_number - 1, 1);
% S(3, :) = zeros(1, samples_number);

sound([S(1, :) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 S(2, :)], fs)
%% making sources

% samples_number = 100;
% S = zeros(2, samples_number);
% 
% S(1, :) = s1(5 * fs : 5 * fs + samples_number - 1, 1);
% S(2, :) = s2(5 * fs : 5 * fs + samples_number - 1, 1);

% S(1, :) = -1 + 2 * rand(1, samples_number);
% S(2, :) = -2 + 4 * rand(1, samples_number);

% % generating source matrix
% 
% n = 2;
% m = 1000;
% t = 0 : 1 / m : 1 - 1 / m;
% 
% S(1, :) = sin(2 * pi * 533 * t);
% S(1, :) = S(1, :) / norm(S(1, :));
% 
% S(2, :) = sin(2 * pi * 1600 * t);
% S(2, :) = S(2, :) / norm(S(2, :));

% t_sin = 0 : 1 / m : 0.125 - 1 / m;
% S(3, :) = [sin(2 * pi * 392 * t_sin) sin(2 * pi * 392 * t_sin) zeros(size(t_sin)) sin(2 * pi * 392 * t_sin) sin(2 * pi * 392 * t_sin) sin(2 * pi * 349.23 * t_sin) zeros(size(t_sin)) sin(2 * pi * 311.13 * t_sin)];
% S(3, :) = S(3, :) / norm(S(3, :));
%% generating random mixing matrix

% A = normc(abs(randn(n, n)))';

A = [1, 0.1; 0.1, 1];
%% making sensor domain data

X = A * S;

sound([X(1, :) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X(2, :)], fs)
%% input X for equivarant algorithm

B = Equivarent_MI_SS(X, 0.001, 0, 0.01, 0.1, 5);

%% estimating using B

Y = B * X;

Y(1, :) = Y(1, :) / norm(Y(1, :));
Y(2, :) = Y(2, :) / norm(Y(2, :));
Y(3, :) = Y(3, :) / norm(Y(3, :));

%%

nt = 10000;
P = 2 * randn(1, nt);

score_function_P = score_func_kernel_calc(P, 0.1);

figure()
histogram(P)
figure()
histogram(score_function_P)

% figure()
% plot(1 : nt, P)
% figure()
% plot(1 : nt, score_function_P)

%%

B_ = MI_SS(X, 0.01, 0, 0.1, 0.01, 30);

%% estimating using B

Y = B_ * X;

Y(1, :) = Y(1, :) / norm(Y(1, :));
Y(2, :) = Y(2, :) / norm(Y(2, :));
% Y(3, :) = Y(3, :) / norm(Y(3, :));

% figure();
% plot(t, Y(1, :))
% 
% figure();
% plot(t, Y(2, :))