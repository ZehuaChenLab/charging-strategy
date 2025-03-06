function change_times = calculate_change_times_interval(L, K, H, E)  
    % 定义负载和空载状态下的电池能量效率公式
    p_1 = 1 / (2.240 + 1.144e-4 * E); % 负载状态
    p_2 = 1 / (1.736 + 1.756e-4 * E); % 空载状态
    
    % 计算一次路线所需的能量消耗
    E1 = (L / 2) * (1 / p_1 + 1 / p_2);
    
    % 计算一次换电所能支持的路线次数
    r = E * 0.8 / E1;
    
    % 计算一天所需的换电次数
    change_counts = K * H / r;    
    
    % 由于换电次数必须是整数，我们取整数部分
    total_change_counts = floor(change_counts);
    
    % 计算一天有多少分钟
    total_minutes_in_day = 24 * 60;
   
    % 计算一次换电所间隔的分钟数
    average_interval = total_minutes_in_day / total_change_counts;
    
    % 初始化换电时间向量
    change_times = zeros(1, total_change_counts);
    
    %以早上8点作为起始运营时间
    start_time = 0;
    
    current_time  = start_time;
    for i = 1:total_change_counts
        change_times(i) = current_time;
        current_time = current_time + average_interval;
    end
    
end