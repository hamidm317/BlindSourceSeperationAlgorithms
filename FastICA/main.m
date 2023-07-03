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

%% running FastICA_vec

n_comp = 2;
convergence_criteria = 0.000001;
[W, Y] = FastICA_vec(X, convergence_criteria, n_comp);

Y(1, :) = Y(1, :) / norm(Y(1, :));
Y(2, :) = Y(2, :) / norm(Y(2, :));

% sound(5 * Y(1, :), 8820);

% Calculating SNRs

SNR_s1_x1 = SNR_calc(S(1, :), X(1, :));
SNR_s1_x2 = SNR_calc(S(1, :), X(2, :));
SNR_s2_x1 = SNR_calc(S(2, :), X(1, :));
SNR_s2_x2 = SNR_calc(S(2, :), X(2, :));

SNR_s1_y1 = SNR_calc(S(1, :), Y(1, :));
SNR_s1_y2 = SNR_calc(S(1, :), Y(2, :));
SNR_s2_y1 = SNR_calc(S(2, :), Y(1, :));
SNR_s2_y2 = SNR_calc(S(2, :), Y(2, :));

%% Saving Sources, mixed sounds, and separated ones

audiowrite('Source_Nmuber_1.wav', S(1, :), 8820)
audiowrite('Source_Nmuber_2.wav', S(2, :), 8820)

audiowrite('Mixed_Nmuber_1.wav', X(1, :), 8820)
audiowrite('Mixed_Nmuber_2.wav', X(2, :), 8820)

audiowrite('Separated_Nmuber_1.wav', Y(1, :), 8820)
audiowrite('Separated_Nmuber_2.wav', Y(2, :), 8820)

%% testing ICA on image
%% fisrt, load two images

im1 = imread('Deer.jpg');
im2 = imread('Robot.jpg');

%% making image sources

is_1 = reshape(double(im1), [1, 1024 * 1024 * 3]);
is_2 = reshape(double(im2), [1, 1024 * 1024 * 3]);

S_i(1, :) = is_1;
S_i(2, :) = is_2;

%% mixing!!!

A_i = [1, 0.8; 0.8, 1];
X_i = A_i * S_i;

xi1 = imagable(X_i(1, :), 1024, 1024, 3);
figure()
subplot(1, 2, 1)
imshow(xi1)
title('First mixed image')
xi2 = imagable(X_i(2, :), 1024, 1024, 3);
subplot(1, 2, 2)
imshow(xi2)
title('Second mixed image')
%% Seperating using FastICA

n_comp = 2;
convergence_criteria = 0.000001;
[W_i, Y_i] = FastICA_vec(X_i, convergence_criteria, n_comp);

yi1 = imagable(Y_i(1, :), 1024, 1024, 3);
figure()
subplot(1, 2, 1)
imshow(yi1)
title('First separated image')
yi2 = imagable(Y_i(2, :), 1024, 1024, 3);
subplot(1, 2, 2)
imshow(yi2)
title('Second separated image')
%% showing every channel seperated
%% First:

figure()
subplot(1, 2, 1)
imshow(yi1(:, :, 1))
title('Result of ICA first channel')

subplot(1, 2, 2)
imshow(im1(:, :, 1))
title('Main image first channel')

figure()
subplot(1, 2, 1)
imshow(yi1(:, :, 2))
title('Result of ICA second channel')

subplot(1, 2, 2)
imshow(im1(:, :, 2))
title('Main image second channel')

figure()
subplot(1, 2, 1)
imshow(yi1(:, :, 3))
title('Result of ICA third channel')

subplot(1, 2, 2)
imshow(im1(:, :, 3))
title('Main image third channel')