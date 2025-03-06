%计算评估值
clear;
clc;
data1 = readmatrix('200-1000未改进10.csv');
data2 = readmatrix('200-1000完成改进11最优.csv');

col81_1 = data1(:, 81);%f1 充电电力成本
col82_1 = data1(:, 82);%f2 充电损耗
col83_1 = data1(:, 83);%f3 配置电池数量

col81_2 = data2(:, 81);%f1 充电电力成本
col82_2 = data2(:, 82);%f2 充电损耗
col83_2 = data2(:, 83);%f3 配置电池数量

f1_1max = max(col81_1);%f1的最大值
f1_1min = min(col81_1);%f1的最小值
f2_1max = max(col82_1);%f2的最大值
f2_1min = min(col82_1);%f2的最小值
f3_1max = max(col83_1);%f3的最大值
f3_1min = min(col83_1);%f3的最小值

f1_2max = max(col81_2);%f1的最大值
f1_2min = min(col81_2);%f1的最小值
f2_2max = max(col82_2);%f2的最大值
f2_2min = min(col82_2);%f2的最小值
f3_2max = max(col83_2);%f3的最大值
f3_2min = min(col83_2);%f3的最小值

%计算目标函数的最大值和最小值
f1_min = min(f1_1min,f1_2min);
f1_max = max(f1_1max,f1_2max);

f2_min = min(f2_1min,f2_2min);
f2_max = max(f2_1max,f2_2max);

f3_min = min(f3_1min,f3_2min);
f3_max = max(f3_1max,f3_2max);
%分别计算归一化后的目标函数值
e1_1 = (col81_1 - f1_min) / (f1_max - f1_min);
e1_2 = (col82_1- f2_min) / (f2_max - f2_min);
e1_3 = (col83_1 - f3_min) / (f3_max - f3_min);

e2_1 = (col81_2 - f1_min) / (f1_max - f1_min);
e2_2 = (col82_2- f2_min) / (f2_max - f2_min);
e2_3 = (col83_2 - f3_min) / (f3_max - f3_min);
%计算加权评估值
W = [0.4,0.5,0.1];
nsga_1 = sum(W .* [e1_1,e1_2,e1_3],2); 
average_1 = mean(nsga_1);
disp(['未改进结果的平均值',num2str(average_1)]);
i_nsga_1 =sum(W .* [e2_1,e2_2,e2_3],2);
average_2 = mean(i_nsga_1);
disp(['改进结果的平均值',num2str(average_2)]);

[minValue_1, minIndex_1] = min(nsga_1); % 找到最小值和索引
[maxValue_1, maxIndex_1] = max(nsga_1); % 找到最大值和索引
[minValue_2, minIndex_2] = min(i_nsga_1); % 找到最小值和索引
[maxValue_2, maxIndex_2] = max(i_nsga_1);% 找到最大值和索引
%输出索引和索引对应的目标函数值

lastThreeColumnsValues_1_min = data1(minIndex_1, 81:83);
disp(['未改进最优的最小评估值索引为', num2str(minIndex_1)]);
disp(['data1第 ', num2str(minIndex_1), ' 行的后三列的值：']);
disp(lastThreeColumnsValues_1_min);
disp(min(nsga_1));

lastThreeColumnsValues_1_max = data1(maxIndex_1, 81:83);
disp(['未改进最优的最大评估值索引为', num2str(maxIndex_1)]);
disp(['data1第 ', num2str(maxIndex_1), ' 行的后三列的值：']);
disp(lastThreeColumnsValues_1_max);
disp(max(nsga_1));

disp(['改进最优的最小评估值索引为', num2str(minIndex_2)]);
lastThreeColumnsValues_2_min = data2(minIndex_2, 81:83);
disp(['data2第 ', num2str(minIndex_2), ' 行的后三列的值：']);
disp(lastThreeColumnsValues_2_min);
disp(min(i_nsga_1));

disp(['改进最优的最大评估值索引为', num2str(maxIndex_2)]);
lastThreeColumnsValues_2_max = data2(maxIndex_2, 81:83);
disp(['data2第 ', num2str(maxIndex_2), ' 行的后三列的值：']);
disp(lastThreeColumnsValues_2_max);
disp(max(i_nsga_1));


subplot(2,1,1);
% 绘制条形图
bar(nsga_1,'b');

% 添加标题和轴标签
xlabel('Individual Number','FontSize',25);
ylabel('Individual Valuation','FontSize',25);
legend('Unimproved Individuals(Blue)','FontSize',20)
% 设置x轴的刻度为每隔25个单位
xticks = 1:25:200; % 从1开始到200结束，步长为25

% 设置x轴的刻度标签
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels,'FontSize',20);


subplot(2,1,2);
bar(i_nsga_1,'r');

% 添加标题和轴标签
xlabel('Individual Number','FontSize',25);
ylabel('Individual Valuation','FontSize',25);
legend('Improved Individuals(Red)','FontSize',20)

% 设置x轴的刻度为每隔25个单位
xticks = 1:25:200; % 从1开始到200结束，步长为25

% 设置x轴的刻度标签
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels,'FontSize',20);






 




