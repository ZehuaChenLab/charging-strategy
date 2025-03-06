function f = evaluate_objective(x,change_times, remain_capacity,initialBatteryCount)%%计算每个个体的M个目标函数值
    f = [];
    newx = x(1:40);
    chargeTimes = calculateChargingTime(newx, remain_capacity);
    charging_electric_costs = charging_electric_cost(change_times,chargeTimes,x);
    battery_stock_cost = calculate_battery_num_instock(x,change_times,chargeTimes,initialBatteryCount);
    chargeDamage_cost = calculateChargeDamage(newx);
    f(1) = charging_electric_costs;
    f(2) = chargeDamage_cost;
    f(3) = battery_stock_cost; 
end