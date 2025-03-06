function charging_electric_cost = charging_electric_cost(change_times,chargingTimes,charging_method)
% ���ݷ�ʱ��ۺ������õĳ�緽ʽ������������ɱ�
% �˴���ʾ��ϸ˵��

% ��ʱ���
price_Peak = 0.95;    % ���ʱ�ε��
price_High = 0.790;   % �߷�ʱ�ε��
price_Normal = 0.584; % ƽʱ�ε��
price_Low = 0.395;    % �͹�ʱ�ε��

% ������ѹ�׶ε���ֵ����λ���ٷֱȣ�
thresholdEta = 0.8;
E  = 281.91;

% ���ʱ�ζ��壨24Сʱ�ƣ�
peakHours = [18,19];
highHours = [8,9,10,17,20,21,22];
normalHours = [7,13,14,15,16,23];
lowHours = [1,2,3,4,5,6,11,12,24];

hourlyPrices = zeros(1, 24);
hourlyPrices(peakHours) = price_Peak;
hourlyPrices(highHours) = price_High;
hourlyPrices(normalHours) = price_Normal;
hourlyPrices(lowHours) = price_Low;

powerLevels = [150; 200; 300; 400];
ccTime = floor(E * thresholdEta ./ powerLevels * 60);
a = [-0.0102,-0.0227,-0.0341,-0.0703];
chargingCosts = zeros(size(change_times));

for i = 1:length(chargingTimes)
    t_start = change_times(i)+ charging_method(i + 40);
    cc_change_cv = chargingTimes(i) / 4 + charging_method(i + 40);
    t_end = t_start + chargingTimes(i);
    
    % ������ʱ���ڵĵ��
    for t = t_start+1:1:t_end
        hour = mod(floor(t / 60),24);
        % ��ǰʱ���Сʱ���� 
        if hour == 0
            hour = 24;
        end
        if t <= cc_change_cv
            power = powerLevels(charging_method(i));
        else
            power = powerLevels(charging_method(i)) * exp(a(charging_method(i))*(t - cc_change_cv));
        end
        price = hourlyPrices(hour);
        % ������ɱ����ۻ� �������� �����׶κͺ�ѹ�׶�
        chargingCosts(i) = chargingCosts(i) + power * price; % 1/60 ��Сʱת��Ϊ����
    end
end
charging_electric_cost = sum(chargingCosts) * 0.147;%��������һ���Ϊ0.14��Ԫ;
end