function [CIs] = makeCIs(data)

    % this function computes CIs for a vector of data
    % O. Krigolson June 2018

    data_size = length(data);
    df = data_size - 1;
    t_critical = tinv(0.025,df);
    std_data = std(data);
    sqrtn = sqrt(data_size);
    CIrange = abs(t_critical*std_data/sqrtn);
    CIs(1) = mean(data);
    CIs(2) = mean(data) - CIrange;
    CIs(3) = mean(data) + CIrange;
    CIs(4) = CIrange;

end