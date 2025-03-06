function  remain_capacity = random_remain_capacity(change_times)
num_elements = length(change_times);
% 生成标准正态分布的随机向量
std_normal_vector = randn(1, num_elements);

% 设定正态分布的均值和标准差，使得大部分数值落在0.15到0.25之间
mean_value = 0.20; % 可以设置为0.15到0.25的中值
std_dev = 0.02;   % 标准差，需要足够小以限制数值主要落在0.15到0.25之间

% 将标准正态分布转换为指定均值和标准差的正态分布
normal_vector = std_normal_vector * std_dev + mean_value;

% 截断超出0.15到0.25范围的数值
normal_vector(normal_vector < 0.15) = 0.15;
normal_vector(normal_vector > 0.25) = 0.25;

% 四舍五入到两位小数
remain_capacity = round(normal_vector * 100) / 100;
end

