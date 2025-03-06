function [pg_c, pg_m] = updateProbabilities(g, N, pg_c_now, pg_m_now, delta_pc, delta_pm, k1, k2,Cmetric_now,Cmetric_before)
    if Cmetric_now < Cmetric_before
        pg_c = (pg_c_now + delta_pc) * exp(-k1 * (g / N));
        pg_m = (pg_m_now + delta_pm) * exp(-k2 * (g / N));
    elseif Cmetric_now== Cmetric_before
        pg_c = pg_c_now;
        pg_m = pg_m_now;
    else
        pg_c = (pg_c_now - delta_pc) * exp(-k1 * (g / N));
        pg_m = (pg_m_now - delta_pm) * exp(-k2 * (g / N));
    end 
%     边界值处理
    if pg_c < 0.5
        pg_c = 0.5;
    elseif pg_c > 1
        pg_c = 1;
    end
    
    if pg_m < 0.01
        pg_m = 0.01;
    elseif pg_m > 0.3
        pg_m = 0.3;
    end
    
end