function output = f_prime(y)

    output = 1 - tanh(y) .^ 2;
%     output = exp(-2 .* y);

end

