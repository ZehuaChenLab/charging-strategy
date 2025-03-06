function charging_electric_cost = charging_electric_cost(change_times,chargingTimes,charging_method)
% 根据分时电价和所采用的充电方式，计算充电电力成本
% 此处显示详细说明

% 分时电价
price_Peak = 0.95;    % 尖峰时段电价
price_High = 0.790;   % 高峰时段电价
price_Normal = 0.584; % 平时段电价
price_Low = 0.395;    % 低谷时段电价

% 恒流恒压阶段的阈值（单位：百分比）
thresholdEta = 0.8;
E  = 281.91;

% 电价时段定义（24小时制）
peakHours = [18,19];
highHours = [8,9,10,17,20,21,22];
normalHours = [7,13,14,15,16,23];
lowHours = [1,2,3,4,5,6,11,12,24];

hourlyPrices = zeros(1, 24);
hourlyPrices(peakHours) = price_Peak;
hourlyPrices(highHours) = price_High;
hourlyPrices(normalHours) = price_Normal;
hourlyPrices(lowHours) = price_Low;

powerLevels = [150; 200; 300; 400];
ccTime = floor(E * thresholdEta ./ powerLevels * 60);
a = [-0.0102,-0.0227,-0.0341,-0.0703];
chargingCosts = zeros(size(change_times));

for i = 1:length(chargingTimes)
    t_start = change_times(i)+ charging_method(i + 40);
    cc_change_cv = chargingTimes(i) / 4 + charging_method(i + 40);
    t_end = t_start + chargingTimes(i);
    
    % 计算充电时段内的电价
    for t = t_start+1:1:t_end
        hour = mod(floor(t / 60),24);
        % 当前时间的小时部分 
        if hour == 0
            hour = 24;
        end
        if t <= cc_change_cv
            power = powerLevels(charging_method(i));
        else
            power = powerLevels(charging_method(i)) * exp(a(charging_method(i))*(t - cc_change_cv));
        end
        price = hourlyPrices(hour);
        % 计算充电成本并累积 两个部分 恒流阶段和恒压阶段
        chargingCosts(i) = chargingCosts(i) + power * price; % 1/60 将小时转换为分钟
    end
end
charging_electric_cost = sum(chargingCosts) * 0.147;%按照人民币换算为0.14美元;
end