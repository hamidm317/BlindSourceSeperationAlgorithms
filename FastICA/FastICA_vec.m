function [W, Y] = FastICA_vec(X, convergence_criteria, n_comp)

    % initialization
    
    m = min(size(X));
    Z = preprocess(X);
    
    W = zeros(n_comp, size(Z,1));
    Y = zeros(n_comp, size(Z,2));
    
%     W = normer(W);
    k = 0;
    do_it = 1;
    
    for i = 1 : n_comp % number of components
        
        w = randn(size(Z,1), 1);
        w = w / norm(w);
        
    
        while do_it

            k = k + 1;

            w_ = one_step_gradient(Z, w);

            w_ = normer(w_);

            if abs(abs(dot(w, w_)) - 1) < convergence_criteria

                do_it = 0;

            end

            w = w_;

        end
        
        W(i,:) = w';

        Y(i,:) = w'*Z;

        Z = Z - w*Y(i,:);
        
    end

end

