% 定义时间（分钟）和最大库存需求数据
time_minutes = [0,60,120,180,240,300,360,420,480,540,600,660,720,780,840,900,960,1020,1080,1140,1200,1260,1320,1380,1440];
max_stock_demand = [1, 2, 4, 5, 6, 7, 8, 8, 8, 9, 10, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12];

% 将时间从分钟转换为小时，并确定唯一的小时标记
time_hours = time_minutes / 60;
unique_hours = unique(time_hours); % 获取所有不重复的小时值
now_use = [0,0,0,0,1,0,0,1,0,0,0,0,0,2,0,0,1,2,0,1,3,4,4,3,3];
% 绘制图表
figure;
plot(time_hours, max_stock_demand, '--d', 'Color', 'blue', 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue', 'LineWidth', 2, 'MarkerSize', 8); % 使用蓝色圈圈标记数据点
hold on; % 保持图形，以便在同一图上绘制另一个序列

% 绘制现在使用电池数量
plot(time_hours, now_use, '--d', 'Color', 'red', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'none', 'LineWidth', 2, 'MarkerSize', 6); % 使用红色方块标记数据点，不填充颜色

% 设置横坐标刻度为每小时，并确保标签只显示整数小时
xticks(unique_hours);
xticklabels(unique_hours);

xlabel('Time (hours)');
ylabel('Battery Number');
legend('Deployed Battery', 'Available Battery');
%xlabel('时间 (小时)');
%legend('配置电池', '可用电池');
grid on; % 显示网格

% 为了让刻度更加整齐，可以考虑对横坐标范围进行微调，保证起始和结束都显示在刻度上
xlim([min(unique_hours)-0.5, max(unique_hours)+0.5]);