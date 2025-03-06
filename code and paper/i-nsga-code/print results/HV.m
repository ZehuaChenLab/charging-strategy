clear;
clc;
data = readmatrix('200-1000withoutblock3-5.csv'); % 假设不读取变量名
col81 = data(:, 81);
col82 = data(:, 82); 
col83 = data(:, 83);
[max_value_1, index_1] = max(col81);
[max_value_2, index_2] = max(col82);
[max_value_3, index_3] = max(col83);
HV_number_1 = 0;
HV_number_2 = 0;
HV_number_3 = 0;
for i = 1 : length(col81)
    hv = max_value_1 - col81(i);
    HV_number_1 = HV_number_1 + hv;
end

for i = 1 : length(col82)
    hv = max_value_2 - col82(i);
    HV_number_2 = HV_number_2 + hv;
end

for i = 1 : length(col83)
    hv = max_value_3 - col83(i);
    HV_number_3 = HV_number_3 + hv;
end
