clear;
clc;
data1 = readmatrix('200-1000完成改进11最优.csv');
data2 = readmatrix('200-1000未改进11.csv'); % 假设不读取变量名
col81_1 = data1(:, 81);%f1 充电电力成本
col82_1 = data1(:, 82);%f2 电池损耗
col83_1 = data1(:, 83);%f3 配置电池数量

col81_2 = data2(:, 81);
col82_2 = data2(:, 82); 
col83_2 = data2(:, 83);

figure;
plot(col81_2,col82_2, 'bo', 'MarkerFaceColor', 'b'); % 使用点来表示数据点
hold on;
plot(col81_1,col82_1, 'ro', 'MarkerFaceColor', 'r'); % 使用点来表示数据点
% 添加轴标签
ylabel('Battery Depletion/$','FontSize',30);
xlabel('Electricity Cost/$','FontSize',30);
legend('Unimproved(Blue Circles)', 'Imporved(Red Circles)','FontSize',25);
 % 显示图形
grid on; % 显示网格

