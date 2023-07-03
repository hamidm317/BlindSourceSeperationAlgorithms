function theta_est = theta_estimator_3(Y, d)

    theta_est = zeros(1, 2);
    
    m_2 = mean(Y .^ 2);
    m_4 = mean(Y .^ 4);
    m_6 = mean(Y .^ 6);

    theta_est(1) = (m_6 - 3 * m_2 * m_4) / (m_2 * m_6 - m_4 ^ 2);
    theta_est(2) = (3 * m_2 ^ 2 - m_4) / (m_2 * m_6 - m_4 ^ 2);

end

