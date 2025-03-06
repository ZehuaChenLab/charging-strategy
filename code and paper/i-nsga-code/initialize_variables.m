function f = initialize_variables(N, M, V, change_times, remain_capacity,initialBatteryCount)%f是一个由种群个体组成的矩阵
% min = min_range;
% max = max_range;
K = M + V;%%K是数组的总元素个数。为了便于计算，决策变量和目标函数串在一起形成一个数组。  
%对于交叉和变异，利用目标变量对决策变量进行选择
f = zeros(N, M+V); % 预分配空间

% 生成前40维，取值为1, 2, 3, 4
f(:, 1:V/2) = randi([1, 4], N, V/2);

% 生成后40维，取值范围为0-360
f(:, V/2 + 1: V) = randi([0, 360], N, V/2);

for i = 1 : N
    f(i,V + 1: K) = evaluate_objective(f(i,:),change_times, remain_capacity,initialBatteryCount); 
    % M是目标函数数量 V是决策变量个数
    %为了简化计算将对应的目标函数值储存在染色体的V + 1 到 K的位置。
end