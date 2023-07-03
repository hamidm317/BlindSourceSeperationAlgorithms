function B_ = EASI_alg(y_t, B, lambda)

    B_ = B - lambda * H_4(y_t) * B;

end

