% 读取CSV文件
clear;
clc;
data1 = readmatrix('200-1000未改进11.csv'); % 假设不读取变量名
data2 = readmatrix('200-1000完成改进4.csv');
% 检查数据是否至少有83列
if size(data1, 2) < 83
    error('CSV文件的列数不足83列！');
end

% 提取第81、82、83列的数据
col81_1 = data1(:, 81);
col82_1 = data1(:, 82);
col83_1 = data1(:, 83);

col81_2 = data2(:, 81);
col82_2 = data2(:, 82);
col83_2 = data2(:, 83);

% 绘制三维图
figure;
subplot(1,2,1)
plot(col83_1, col81_1, 'bo', 'MarkerFaceColor', 'b'); % 使用点来表示数据点
xlabel('Configured Batteries','FontSize',30);
ylabel('Electricity Cost/$','FontSize',30);
legend('Unimporved(Blue Circles)', 'FontSize',25);
% 显示图形
grid on; % 显示网格

subplot(1,2,2);
plot(col83_2,col81_2, 'ro', 'MarkerFaceColor', 'r');

% 添加轴标签
xlabel('Configured Batteries','FontSize',30);
ylabel('Electricity Cost/$','FontSize',30);
legend('Improved(Red Circles)','FontSize',25);
 
 % 显示图形
grid on; % 显示网格
