function ratio = SNR_calc(S, Y)

    P_source = mean(S .^ 2);
    P_error = mean((S - Y) .^ 2);
    
    ratio = 10 * log(P_source / P_error) / log(10);

end

