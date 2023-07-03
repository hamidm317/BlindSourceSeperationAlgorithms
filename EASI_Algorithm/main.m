s1 = downsample(audioread('03-Mahi.mp3'), 5); % jazz one
s2 = downsample(audioread('27-Maghame_Gharibi.mp3'), 5); % Tanbour one

%% generating source matrix

n = 2;
m = 220500;

clear S

S(1, :) = s1(200000 : 200000 + m - 1, 1);
S(1, :) = S(1, :) / norm(S(1, :));

S(2, :) = s2(100 : 100 + m - 1, 1);
S(2, :) = S(2, :) / norm(S(2, :));
% S(3, :) = 2 * rand(1, m) - 1;

% t = 0 : 1 / m : 1 - 1 / m;
% S(2, :) = chirp(t, 0, 1, 1000);
% 
% t_sin = 0 : 1 / m : 0.0625 - 1 / m;
% S(3, :) = [sin(2 * pi * 392 * t_sin) zeros(size(t_sin)) zeros(size(t_sin)) zeros(size(t_sin)) zeros(size(t_sin)) zeros(size(t_sin)) sin(2 * pi * 392 * t_sin) zeros(size(t_sin)) zeros(size(t_sin)) zeros(size(t_sin)) sin(2 * pi * 349.23 * t_sin) zeros(size(t_sin)) zeros(size(t_sin)) zeros(size(t_sin)) sin(2 * pi * 311.13 * t_sin) zeros(size(t_sin))];
%% generating random mixing matrix

% A = normc(rand(n, n));

%% mixing sources

A = [1, 0.8; 0.2, 1];
X = A * S;

X(1, :) = X(1, :) / norm(X(1, :));
X(2, :) = X(2, :) / norm(X(2, :));

%% Testing EASI algorithm

B = normc(rand(n, n))';
lambda = 0.001;
Y = zeros(size(X));

for i = 1 : m
    
    Y(:, i) = B * X(:, i);
    B = EASI_alg(Y(:, i), B, lambda);
%     B = B / norm(B);
    
%     B = B_;
    
end

Y(1, :) = Y(1, :) / norm(Y(1, :));
Y(2, :) = Y(2, :) / norm(Y(2, :));

% Calculating SNRs

SNR_s1_x1 = SNR_calc(S(1, :), X(1, :));
SNR_s1_x2 = SNR_calc(S(1, :), X(2, :));
SNR_s2_x1 = SNR_calc(S(2, :), X(1, :));
SNR_s2_x2 = SNR_calc(S(2, :), X(2, :));

SNR_s1_y1 = SNR_calc(S(1, :), Y(1, :));
SNR_s1_y2 = SNR_calc(S(1, :), Y(2, :));
SNR_s2_y1 = SNR_calc(S(2, :), Y(1, :));
SNR_s2_y2 = SNR_calc(S(2, :), Y(2, :));

%% Storing outputs

audiowrite('EASI_Separated_Nmuber_1.wav', Y(1, :), 8820)
audiowrite('EASI_Separated_Nmuber_2.wav', Y(2, :), 8820)