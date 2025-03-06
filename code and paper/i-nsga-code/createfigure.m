function createfigure(X1, Y1, Z1)
%CREATEFIGURE(X1, Y1, Z1)
%  X1:  x 数据的向量
%  Y1:  y 数据的向量
%  Z1:  z 数据的向量

%  由 MATLAB 于 06-Jun-2024 16:54:18 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0865217391304348 0.218050847457627 0.397733187663531 0.57665254237288]);
hold(axes1,'on');

% 创建 plot3
plot3(X1,Y1,Z1,'Parent',axes1,'Marker','.','LineStyle','none',...
    'Color',[1 0 0]);

% 创建 zlabel
zlabel('额外电池数量/个','FontSize',18);

% 创建 ylabel
ylabel('电池损耗/美元','FontSize',18);

% 创建 xlabel
xlabel('电力成本/美元','FontSize',18);

% 创建 title
title('总体种群分布','FontWeight','bold','FontSize',20);

% 取消以下行的注释以保留坐标区的 X 范围
% xlim(axes1,[778.519653320312 5178.51965332031]);
% 取消以下行的注释以保留坐标区的 Y 范围
% ylim(axes1,[789.757781982422 1669.75778198242]);
% 取消以下行的注释以保留坐标区的 Z 范围
% zlim(axes1,[11.9500866889954 17.4500866889954]);
view(axes1,[-34.3558797690671 30.2842541280546]);
grid(axes1,'on');
hold(axes1,'off');
% 创建 axes
axes2 = axes('Parent',figure1,...
    'Position',[0.573402758447921 0.232881355932203 0.334659090909091 0.671779661016949]);
hold(axes2,'on');

% 创建 plot
plot(X1,Y1,'Parent',axes2,'Marker','.','LineStyle','none','Color',[1 0 0]);

% 创建 ylabel
ylabel('电池损耗/美元','FontSize',18);

% 创建 xlabel
xlabel('电力成本/美元','FontSize',18);

% 创建 title
title('F1-F2维度种群分布','FontWeight','bold','FontSize',20);

% 取消以下行的注释以保留坐标区的 X 范围
% xlim(axes2,[733.506928133753 5573.50692813376]);
% 取消以下行的注释以保留坐标区的 Y 范围
% ylim(axes2,[884.114294081601 1731.1142940816]);
box(axes2,'on');
hold(axes2,'off');
