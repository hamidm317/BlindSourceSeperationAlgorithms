function [denom, numer] = score_func_kernel_test(Y, h)

    denom = zeros(size(Y));
    numer = zeros(size(Y));
%     yes = 0;
    [sensors_number, samples_number] = size(Y);
    
    for sensor = 1 : sensors_number
        
        for sample = 1 : samples_number
            
            
            for i = 1 : samples_number
                 
                if Y(sensor, sample) - Y(sensor, i) < 10 * h
                    
%                     yes = yes + 1;
                    denom(sensor, sample) = denom(sensor, sample) + window_value_calc(Y(sensor, sample) - Y(sensor, i), h);
                    numer(sensor, sample) = numer(sensor, sample) + window_value_calc_deriv(Y(sensor, sample) - Y(sensor, i), h);
                
                end
                
            end
            
%             a = yes
%             yes = 0
        end
        
    end
    
%     score_function_Y_is = -1 * numer ./ denom;

end

