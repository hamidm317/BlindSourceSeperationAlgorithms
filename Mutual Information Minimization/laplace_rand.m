function x = laplace_rand(mu, lambda, M, N)

    if nargin < 1
      mu  = 0;
    end
    if nargin < 2 
      lambda = 1;
      % lambda = sqrt(2); % this gives a std=var=1.
    end
    if nargin < 3
      M = 1;
    end
    if nargin < 4
      N = 1;
    end

    z = rand(M,N);
    x = zeros(M,N);

    in = z<=.5;
    ip = z> .5;
    x(in) =  1/lambda *log(2*z(in));
    x(ip) = -1/lambda *log(2*(1-z(ip)));

end