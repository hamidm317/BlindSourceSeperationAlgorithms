%% testing Score_Func_Kernel

m = 100000;
Q = 2 * randn(1, 10000) - 1;
Q = floor(Q * m) / m;

[N, edges] = histcounts(Q, m);

h = 1000;
window = gausswin(h, 5)';
window_prime = [0 diff(window)];

dist = zeros(1, m + 2 * h);
dist_prime = dist;

for i = 1 : m

    if N(i) ~= 0
        
        dist(i : i + h - 1) = dist(i : i + h - 1) + N(i) * window;
        dist_prime(i : i + h - 1) = dist_prime(i : i + h - 1) + N(i) * window_prime;
        
    end
    
end
    
plot(edges, dist(h : end - h))
plot(edges, dist_prime(h : end - h))

score_func = zeros(1, m);

for i = 1 : m
    
    if ~isnan(dist_prime(h / 2 + i) / dist(h / 2 + i))
        
        score_func(i) = dist_prime(h / 2 + i) / dist(h / 2 + i);
        
    end
    
end
% [Y, t] = Score_Func_Kernel(Q, 10, 10);

%% Testing my functions

m = 10000;
Q = 2 * randn(1, 1000) - 1;
Q = floor(Q * m) / m;

%% Again :")

hist = histogram(Q, 10000);
tmp = hist.Values;
bin_edge = hist.BinEdges;

h = 1000;
window = gausswin(h, 5)';
window_prime = [0 diff(window)];

dist = conv(window, tmp);
dist_prime = conv(window_prime, tmp);

figure();
plot(1 : length(dist), dist)
figure();
plot(1 : length(dist_prime), dist_prime)

%%

scr_f = -1 * dist_prime ./ dist;

%% 

plot(bin_edge, scr_f(500 : 10500))


%% 

m = 10000;

G = rand([1 m]) - 0.5;

[up, down] = score_func_kernel_test(G, 0.0001);

%%
[G_sorted, I] = sort(G);

figure()
subplot(2, 2, 1)
histogram(G, 100)
title('histogram of U')

subplot(2, 2, 2)
plot(G_sorted, down(I))
title('Derivative of estimated pdf')

subplot(2, 2, 3)
plot(G_sorted, up(I))
title('estimated pdf')

score_function = -1 * down ./ up;

subplot(2, 2, 4)
plot(G_sorted, score_function(I))
title('estimated score function')

%%
SS = (S(1, :) - mean(S(1, :))) / norm((S(1, :) - mean(S(1, :))));

diff_SS = abs(diff(SS));
step = min(diff_SS(diff_SS > 0));

[down_S, up_S] = score_func_kernel_test(SS, 0.000000001);


[S_sorted, I] = sort(SS);

figure()

subplot(2, 2, 1)
histogram(SS, 1000)

subplot(2, 2, 2)
plot(S_sorted, down_S(I))
title('Makhraj-e Kasr')

subplot(2, 2, 3)
plot(S_sorted, up_S(I))
title('Surat-e kasr')

S_score_function = -1 * up_S ./ down_S;

subplot(2, 2, 4)
plot(S_sorted, S_score_function(I))
title('Khod-e Kasr')

%% 

t_test = -0.5 : 1 / 1000 : 0.5;
g_ = g_pdf(t, 0.1);

%% 

m = 10000;
a = 0.5;
L = 2 * a * laplace_rand(0, 1, m, 1) - a;

[up, down] = score_func_kernel_test(L', 0.005);

%%

[L_sorted, I] = sort(L);

figure()
subplot(2, 2, 1)
histogram(L, 100)
title('histogram of L')

subplot(2, 2, 2)
plot(L_sorted, down(I))
title('Derivative of estimated pdf')

subplot(2, 2, 3)
plot(L_sorted, up(I))
title('estimated pdf')

score_function = -1 * down ./ up;

subplot(2, 2, 4)
plot(L_sorted, score_function(I))
title('estimated score function')


%%

m = 10000;

a = 1;
G1 = 2 * a * laplace_rand(0, 1, 1, m) - a;

% G1 = rand([1 m]) - 0.5;

SCF = score_func_polyno_calc(G1, 5);

[~, I] = sort(G1);

plot(G1(I), SCF(I))
title('Estimated score function of laplace data with degree = 5')
xlim([min(G1) max(G1)])

%%

SS = (S(1, :) - mean(S(1, :))) / norm((S(1, :) - mean(S(1, :))));

S_SCF = score_func_polyno_calc(SS, 10);

[~, I] = sort(SS);

plot(SS(I), SCF(I))