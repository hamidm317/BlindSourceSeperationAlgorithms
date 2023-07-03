function output = H_4(y)

    output = y * y' - eye(length(y)) + f_prime(y) * y' - y * f_prime(y)';

end

