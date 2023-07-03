function Sc_Fun = score_func_polyno_calc(Y, d)

%     [m, n] = size(Y);    
    sample_number = max(size(Y));
    sensor_number = min(size(Y));
    
    Sc_Fun = zeros(size(Y));
    
    for i = 1 : sensor_number

        if ~d
        
            theta_est = theta_estimator_3(Y(i, :));

            Sc_Fun(i, :) = theta_est * [Y(i, :); Y(i, :) .^ 3];
            
        else
            
            k_x = zeros(d, sample_number);
            k_prime_x = zeros(d, sample_number);
            
            for degree = 1 : d
                
                k_x(degree, :) = Y(i, :) .^ (degree - 1);
                k_prime_x(degree, :) = (degree - 1) * Y(i, :) .^ (degree - 2);
                
            end
            
            theta_est = theta_estimator(k_x, k_prime_x);
            
            Sc_Fun(i, :) = theta_est' * k_x;
            
        end
        
    end

end