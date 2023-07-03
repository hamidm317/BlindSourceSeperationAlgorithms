function w_ = one_step_gradient(Z, w)

%     w_ = g_expected_calc(Z, w) - g_prime_expected_calc(Z, w) * w;
    
    w_ = mean(Z .* repmat(g(w' * Z), size(Z,1), 1), 2) - mean(g_prime(w' * Z)) * w;

end

