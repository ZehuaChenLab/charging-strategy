function nsga_2_optimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
E = 281.91; % ��ض��������λ��kWh
L = 60; % ·����̳��ȣ���λ��mile 
K = 15;  % ���Ӵ�С    
H = 5;   % ƽ��ÿ������ÿ��������ɵ�·�ߴ���
initialBatteryCount = 0; % ��ʼ�ĵ�ؿ������
load('random_remain_capacity.mat');
remain_capacity = remain_capacity(1:40);
change_times = calculate_change_times_interval(L, K, H, E);

pop = 200; %��Ⱥ����
gen = 1000; %��������
M = 3; %Ŀ�꺯������````````````````````````````````````````
V =  2 * length(change_times); %ά�ȣ����߱����ĸ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chromosome = initialize_variables(pop, M, V, change_times, remain_capacity,initialBatteryCount);%��ʼ����Ⱥ
[chromosome,Cmetric_before] = non_domination_sort_mod(chromosome, M, V);%�Գ�ʼ����Ⱥ���з�֧����������ӵ���ȼ���
pg_c_now = 0.9;
delta_pc = 0.01;
pg_m_now = 0.05;
delta_pm = 0.005;
k1 = 0.5;
k2 = 0.2;
steplength = 72; 
steplength = 10;

for i = 1 : gen
    pool = round(pop/2);%round() ��������ȡ�� ����ش�С
    tour = 20;%������  ����ѡ�ָ���
    parent_chromosome = tournament_selection(chromosome, pool, tour);%������ѡ���ʺϷ�ֳ�ĸ���
    offspring_chromosome = genetic_operator(parent_chromosome,M, V, change_times, remain_capacity,initialBatteryCount,pg_c_now,pg_m_now,steplength);%���н����������Ӵ� 
    [main_pop,~] = size(chromosome);%������Ⱥ�Ĵ�С      
    [offspring_pop,~] = size(offspring_chromosome);%�Ӵ���Ⱥ�Ĵ�С
    
    clear temp  
    intermediate_chromosome(1:main_pop,:) = chromosome;
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M+V) = offspring_chromosome;%�ϲ�������Ⱥ���Ӵ���Ⱥ
    [intermediate_chromosome,Cmetric_now] = non_domination_sort_mod(intermediate_chromosome, M, V);%���µ���Ⱥ���п��ٷ�֧������
    chromosome = replace_chromosome(intermediate_chromosome, M, V, pop); %ѡ��ϲ���Ⱥ��ǰN�����ȵĸ����������Ⱥ
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