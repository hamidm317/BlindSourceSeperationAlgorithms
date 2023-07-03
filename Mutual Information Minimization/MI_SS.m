function B = MI_SS(X, convergence_criteria, scr_func_type, h, mu_, d)

    [sensors_number, samples_number] = size(X);
    convergence_flag = 1;
    B = eye(sensors_number);
    
    iterations = 0;
    
    while convergence_flag
        
        Y = B * X;
        
        D = D_A_calculator(Y, X, scr_func_type, h, d) - inv(B');
        
        B = B - mu_ * normc(D);
        
%         minim = norm(D, 'fro');
        
        if norm(D, 'fro') < convergence_criteria || iterations == 1000
            
            convergence_flag = 0;
            minim = norm(D, 'fro')
            
        end
        
        iterations = iterations + 1;
        
    end

end

