function v = window_value_calc_deriv(x, h)

    v = -1 * x ./ sqrt(2 * pi * h ^ 3) .* exp(-0.5 * x .^ 2 / h);

end

