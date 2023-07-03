function y = g_pdf(x, h)

    y = 1 / sqrt(2 * pi * h) * exp(-0.5 * x .^ 2 ./ h);

end

