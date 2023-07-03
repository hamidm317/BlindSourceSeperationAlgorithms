function im = imagable(X, a, b, c)

    X = abs(X / max(abs(X)) * 256);
    
    im = uint8(reshape(X, [a, b, c]));

end

