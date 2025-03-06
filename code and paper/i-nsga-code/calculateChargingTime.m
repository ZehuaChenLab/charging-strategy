function chargingTimes = calculateChargingTime(charging_method, remain_capacity)
    %计算电池的充电时间函数，输入为两个向量，电池所采用的充电方式，以及电池的剩余容量，输出一个所需时间向量。
    
    % 充电功率设定（单位：kW）
    powerLevels = [150,200,300,400];
    
    % 恒流恒压阶段的阈值（单位：百分比）
    thresholdEta = 0.8;
    E  = 281.91;
    
    % 恒流变压阶段的时间倍数
    beta = 3;
   
    % 初始化充电时间向量
    chargingTimes = zeros(1, length(remain_capacity));
    
    % 遍历每个电池的剩余容量
    for i = 1:length(remain_capacity)
        % 根据充电方式获取相应的功率
        power = powerLevels(charging_method(i));
         
        % 计算恒流恒压阶段需要充入的电量（单位：kWh）
        chargeToCapacity = (thresholdEta - remain_capacity(i)) * E;
        
        % 计算恒流恒压阶段所需时间（单位：小时）
        if remain_capacity(i) < thresholdEta
            ccTime = floor(chargeToCapacity / power * 60);
            
            % 计算恒流变压阶段所需时间（单位：小时）
            cvTime = ccTime * beta;
            
            % 总充电时间
            chargingTimes(i) = ccTime + cvTime;
        else
            % 如果剩余容量已经是80%以上，则不需要充电
            chargingTimes(i) = 0;
        end
    end
end