function D = D_A_calculator(Y, X, type, h, d)

    if type
        score_function_Y = score_func_kernel_calc(Y, h);
    else
        score_function_Y = score_func_polyno_calc(Y, d);
    end
    
%     for i = 1 : min(size(Y))
%         
%         for j = 1 : min(size(Y))
%             
%             if i == j
%                 
%                 D(i, j) = 1 - mean(Y(i, :) .^ 2);
%                 
%             else
%                 
%                 D(i, j) = mean(score_function_Y(i, :) .* Y(j, :));
%                 
%             end
%             
%         end
%         
%     end

%     E_X = mean(X, 2);
%     
%     D = score_function_Y * E_X';

    D = 1 / 1000 * score_function_Y * X';

end

