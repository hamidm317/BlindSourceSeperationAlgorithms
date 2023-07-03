function thetas = theta_estimator(k_x, k_prime_x)


    degree = min(size(k_x));
    sample_number = max(size(k_x));
    
    term1 = 1 / sample_number * (k_x * k_x');
    
    term2 = mean(k_prime_x, 2);
    
    thetas = pinv(term1) * term2;

end

