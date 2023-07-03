function Z = preprocess(X)

%     [sources, ~] = size(X);
%     
%     Z = zeros(size(X));
%     
%     for source = 1 : sources
%         
%         X(source, :) = X(source, :) - mean(X(source, :));
%         
%     end
%     
%     Sig = X * X';
%     
%     W = chol(inv(Sig));
%     
%     Z = W * X;
    
    X = X - mean(X,2);
    Cx = cov(X');
    [U, S, ~] = svd(Cx);
    D = diag(1 ./ sqrt(diag(S))) * U';
    Z = D * X;

end

