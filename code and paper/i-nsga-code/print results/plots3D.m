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
plot3(col81_1, col82_1, col83_1, 'bo', 'MarkerFaceColor', 'b'); % 使用点来表示数据点
hold on;
plot3(col81_2,col82_2,col83_2, 'ro', 'MarkerFaceColor', 'r');

% 添加轴标签
%xlabel('电力成本/美元','FontSize',30);
%ylabel('电池损耗/美元','FontSize',30);
%zlabel('配置电池数量/个','FontSize',30);
%legend('未改进(Blue Circles)', '完成改进(Red Circles)','FontSize',20);

xlabel('Electricity Cost/$','FontSize',30);
ylabel('Battery Depletion/$','FontSize',30);
zlabel('Configured Batteries','FontSize',30);
legend('Unimproved(Blue Circles)', 'Improved(Red Circles)','FontSize',20);

