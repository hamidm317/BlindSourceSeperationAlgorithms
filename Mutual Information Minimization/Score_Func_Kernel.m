function [Y, t] = Score_Func_Kernel(X, h, up)

    [n, m] = size(X);
    
    if n > 1
        
        Y = 0;
        
    else 
        
        X = floor(X * 10000) / 10000;
        
        tmp = sort(X);
        C = unique(X);
        Dist = zeros(size(C));

        for i = 1 : length(C)

            flag = 0;

            for j = 1 : m

                if tmp(j) == C(i)

                    flag = 1;
                    Dist(i) = Dist(i) + 1;

%                 else
% 
%                     if flag == 1
% 
%                         j = m;
% 
%                     end

                end

            end

        end

        Y = upsample(Dist, up);
        t = upsample(C, up);
        
    end

end

