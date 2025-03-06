function chargeDamage_cost = calculateChargeDamage(charging_method)
    E = 281.91;
    Value_of_perkWh = 180;
    %计算各个C-rate下的电池循环次数，以额定容量的80%作为电池的EOL
    times_1 = floor((20 - 150*0.02 - 650 * 0.0156)/0.0214) + 800; 
    times_2 = floor((20 - 150*0.0243 - 650 * 0.0175)/0.0209) + 800;
    times_3 = floor((20 - 150*0.032 - 450 * 0.0188)/0.0271) + 600;
    times_4 = floor((20 - 100*0.0472 - 300 * 0.0226)/0.0356) + 400; 
    
    %根据电池价格计算每次循环价格，Value_of_perkWh = 180$/kWh,E = 281.91kWh;
    value_1 = floor(E * Value_of_perkWh /times_1);
    value_2 = floor(E * Value_of_perkWh /times_2);
    value_3 = floor(E * Value_of_perkWh /times_3);
    value_4 = floor(E * Value_of_perkWh /times_4);
    
    %对损伤进行修正,以0.5C的充电损失作为基准，
%     damage_1 = 0;
%     damage_2 = value_2 - value_1;
%     damage_3 = value_3 - value_1;
%     damage_4 = value_4 - value_1;
% 定义损伤
%     damageCoefficients = [damage_1, damage_2, damage_3,damage_4]; % 对应充电方式 1, 2, 3 的损伤系数
    damageCoefficients = [value_1, value_2,value_3,value_4];
    % 初始化充电损伤向量
    n = length(charging_method) / 2; 
    chargeDamage = zeros(1,n);
        
    % 遍历充电方式向量
    for i = 1:length(chargeDamage)
        % 获取当前充电方式的索引
        chargingMethodIndex = charging_method(i);
        
        % 检查索引是否有效
        if chargingMethodIndex >= 1 && chargingMethodIndex <= 4
            % 计算当前充电方式的充电损伤
            chargeDamage(i) = damageCoefficients(chargingMethodIndex);
        else
            error('无效的充电方式索引。');
        end
    end
    
    chargeDamage_cost = sum(chargeDamage);
end