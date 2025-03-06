function chargingTimes = calculateChargingTime(charging_method, remain_capacity)
    %�����صĳ��ʱ�亯��������Ϊ������������������õĳ�緽ʽ���Լ���ص�ʣ�����������һ������ʱ��������
    
    % ��繦���趨����λ��kW��
    powerLevels = [150,200,300,400];
    
    % ������ѹ�׶ε���ֵ����λ���ٷֱȣ�
    thresholdEta = 0.8;
    E  = 281.91;
    
    % ������ѹ�׶ε�ʱ�䱶��
    beta = 3;
   
    % ��ʼ�����ʱ������
    chargingTimes = zeros(1, length(remain_capacity));
    
    % ����ÿ����ص�ʣ������
    for i = 1:length(remain_capacity)
        % ���ݳ�緽ʽ��ȡ��Ӧ�Ĺ���
        power = powerLevels(charging_method(i));
         
        % ���������ѹ�׶���Ҫ����ĵ�������λ��kWh��
        chargeToCapacity = (thresholdEta - remain_capacity(i)) * E;
        
        % ���������ѹ�׶�����ʱ�䣨��λ��Сʱ��
        if remain_capacity(i) < thresholdEta
            ccTime = floor(chargeToCapacity / power * 60);
            
            % ���������ѹ�׶�����ʱ�䣨��λ��Сʱ��
            cvTime = ccTime * beta;
            
            % �ܳ��ʱ��
            chargingTimes(i) = ccTime + cvTime;
        else
            % ���ʣ�������Ѿ���80%���ϣ�����Ҫ���
            chargingTimes(i) = 0;
        end
    end
end