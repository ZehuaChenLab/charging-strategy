function battery_stock_cost = calculate_battery_num_instock(x,change_times,chargeTimes,initialBatteryCount)
% ���������²�����
% change_times - һ��������������ʱ�̵��������Է���Ϊ��λ��
% chargeTimes - һ�����������ɳ������ʱ����������Է���Ϊ��λ��
% initialBatteryCount - ��ʼ���õ������    
% ʾ������
% change_times = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]; % ��������ʱ��
% chargeTimes = [20, 40, 60, 80, 100, 120, 140, 160, 180, 200]; % ��س������ʱ��
%finish_charge_time = 
%initialBatteryCount = 0; % ��ʼ���õ������
% newx = x(41:80);
finish_charge_time = change_times + chargeTimes+x(41:80);
sort(finish_charge_time);%���ճ�����ʱ������
BC = initialBatteryCount; % ��ʼ���õ������
BT = 0; % ��ʼ��Ҫ�������������
maxBT = 0; % һ��������BTֵ

% ����ÿ�����������¼�
for t  =  change_times
    % ��鵱ǰʱ����Ƿ��е����ɳ��
    while( ~isempty(finish_charge_time) && finish_charge_time(1) <= t)
        % �е����ɳ�磬���ӿ��õ������
        BC = BC + 1;
        finish_charge_time = finish_charge_time(2:end); % ����ʣ��ĳ�����ʱ��
    end
    % �����õ������
    if BC > 0
        % �п��õ�أ�����һ��
        BC = BC - 1;
    else
        % û�п��õ�أ�������Ҫ�Ŀ������
        BT = BT + 1;
    end
    
    % ��鲢��������BTֵ
    if BT > maxBT
        maxBT = BT;
    end
    
end

battery_stock_cost = maxBT;
end

