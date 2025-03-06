clear;
clc;
data = readmatrix('200-1000withoutblock3-5.csv'); % 假设不读取变量名
col81 = data(:, 81);
col82 = data(:, 82); 
col83 = data(:, 83);
average_1 = mean(col81);
average_2 = mean(col82); 
average_3 = mean(col83);
sp_1 = 0;
sp_2 = 0;  
sp_3 = 0;
for i = 1 : length(col81)
    sp_1 = sp_1 + (col81(i) - average_1)^2;
    sp_2 = sp_2 + (col82(i) - average_1)^2;
    sp_3 = sp_3 + (col83(i) - average_1)^2;
end
sp_1 =sqrt( sp_1 / (length(col81) - 1));
sp_2 =sqrt( sp_2 / (length(col82) - 1));
sp_3 =sqrt( sp_3 / (length(col83) - 1));