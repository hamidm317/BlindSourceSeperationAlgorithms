function D = D_calculator(Y, type, h, d)

    if type
        score_function_Y = score_func_kernel_calc(Y, h);
    else
        score_function_Y = score_func_polyno_calc(Y, d);
    end
    
    for i = 1 : min(size(Y))
        
        for j = 1 : min(size(Y))
            
            if i == j
                
                D(i, j) = 1 - mean(Y(i, :) .^ 2);
                
            else
                
                D(i, j) = mean(score_function_Y(i, :) .* Y(j, :));
                
            end
            
        end
        
    end

end
