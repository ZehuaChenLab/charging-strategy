function battery_stock_cost = calculate_battery_num_instock(x,change_times,chargeTimes,initialBatteryCount)
% 假设有以下参数：
% change_times - 一个包含汽车到达时刻的向量（以分钟为单位）
% chargeTimes - 一个包含电池完成充电所需时间的向量（以分钟为单位）
% initialBatteryCount - 初始可用电池数量    
% 示例数据
% change_times = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]; % 汽车到达时刻
% chargeTimes = [20, 40, 60, 80, 100, 120, 140, 160, 180, 200]; % 电池充电所需时间
%finish_charge_time = 
%initialBatteryCount = 0; % 初始可用电池数量
% newx = x(41:80);
finish_charge_time = change_times + chargeTimes+x(41:80);
sort(finish_charge_time);%按照充电完成时间排序
BC = initialBatteryCount; % 初始可用电池数量
BT = 0; % 初始需要换电的汽车数量
maxBT = 0; % 一天中最大的BT值

% 处理每个汽车到达事件
for t  =  change_times
    % 检查当前时间点是否有电池完成充电
    while( ~isempty(finish_charge_time) && finish_charge_time(1) <= t)
        % 有电池完成充电，增加可用电池数量
        BC = BC + 1;
        finish_charge_time = finish_charge_time(2:end); % 更新剩余的充电完成时间
    end
    % 检查可用电池数量
    if BC > 0
        % 有可用电池，减少一个
        BC = BC - 1;
    else
        % 没有可用电池，增加需要的库存数量
        BT = BT + 1;
    end
    
    % 检查并更新最大的BT值
    if BT > maxBT
        maxBT = BT;
    end
    
end

battery_stock_cost = maxBT;
end

