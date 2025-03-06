function nsga_2_optimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
E = 281.91; % 电池额定容量，单位：kWh
L = 60; % 路线里程长度，单位：mile 
K = 15;  % 车队大小    
H = 5;   % 平均每辆卡车每天所需完成的路线次数
initialBatteryCount = 0; % 初始的电池库存数量
load('random_remain_capacity.mat');
remain_capacity = remain_capacity(1:40);
change_times = calculate_change_times_interval(L, K, H, E);

pop = 200; %种群数量
gen = 1000; %迭代次数
M = 3; %目标函数数量````````````````````````````````````````
V =  2 * length(change_times); %维度（决策变量的个数）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chromosome = initialize_variables(pop, M, V, change_times, remain_capacity,initialBatteryCount);%初始化种群
[chromosome,Cmetric_before] = non_domination_sort_mod(chromosome, M, V);%对初始化种群进行非支配快速排序和拥挤度计算
pg_c_now = 0.9;
delta_pc = 0.01;
pg_m_now = 0.05;
delta_pm = 0.005;
k1 = 0.5;
k2 = 0.2;
steplength = 72; 
steplength = 10;

for i = 1 : gen
    pool = round(pop/2);%round() 四舍五入取整 交配池大小
    tour = 20;%锦标赛  参赛选手个数
    parent_chromosome = tournament_selection(chromosome, pool, tour);%锦标赛选择适合繁殖的父代
    offspring_chromosome = genetic_operator(parent_chromosome,M, V, change_times, remain_capacity,initialBatteryCount,pg_c_now,pg_m_now,steplength);%进行交叉变异产生子代 
    [main_pop,~] = size(chromosome);%父代种群的大小      
    [offspring_pop,~] = size(offspring_chromosome);%子代种群的大小
    
    clear temp  
    intermediate_chromosome(1:main_pop,:) = chromosome;
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M+V) = offspring_chromosome;%合并父代种群和子代种群
    [intermediate_chromosome,Cmetric_now] = non_domination_sort_mod(intermediate_chromosome, M, V);%对新的种群进行快速非支配排序
    chromosome = replace_chromosome(intermediate_chromosome, M, V, pop); %选择合并种群中前N个优先的个体组成新种群
    [pg_c_now,pg_m_now] = updateProbabilities(i,pop,pg_c_now, pg_m_now, delta_pc, delta_pm, k1, k2,Cmetric_now,Cmetric_before);
    Cmetric_before = Cmetric_now;
    if ~mod(i,100)
        disp(chromosome(:,V + 1:V + M));
        fprintf('%d generations completed\n',i); 
        steplength = steplength - 5;
        if steplength < 0
            steplength = 1; 
        end
    end
end

if M == 2
      writematrix(chromosome, 'output.csv', 'Delimiter', ',');
      plot(chromosome(:,V + 1),chromosome(:,V + 2),'*');
      xlabel('f_1'); ylabel('f_2');
      title('Pareto Optimal Front');
   elseif M == 3
      writematrix(chromosome, 'output.csv', 'Delimiter', ',');
      plot3(chromosome(:,V + 1),chromosome(:,V + 2),chromosome(:,V + 3),'*');
      xlabel('f_1'); ylabel('f_2'); zlabel('f_3');
      title('Pareto Optimal Surface');
end