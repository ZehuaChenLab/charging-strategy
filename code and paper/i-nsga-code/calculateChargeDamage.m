function chargeDamage_cost = calculateChargeDamage(charging_method)
    E = 281.91;
    Value_of_perkWh = 180;
    %�������C-rate�µĵ��ѭ���������Զ������80%��Ϊ��ص�EOL
    times_1 = floor((20 - 150*0.02 - 650 * 0.0156)/0.0214) + 800; 
    times_2 = floor((20 - 150*0.0243 - 650 * 0.0175)/0.0209) + 800;
    times_3 = floor((20 - 150*0.032 - 450 * 0.0188)/0.0271) + 600;
    times_4 = floor((20 - 100*0.0472 - 300 * 0.0226)/0.0356) + 400; 
    
    %���ݵ�ؼ۸����ÿ��ѭ���۸�Value_of_perkWh = 180$/kWh,E = 281.91kWh;
    value_1 = floor(E * Value_of_perkWh /times_1);
    value_2 = floor(E * Value_of_perkWh /times_2);
    value_3 = floor(E * Value_of_perkWh /times_3);
    value_4 = floor(E * Value_of_perkWh /times_4);
    
    %�����˽�������,��0.5C�ĳ����ʧ��Ϊ��׼��
%     damage_1 = 0;
%     damage_2 = value_2 - value_1;
%     damage_3 = value_3 - value_1;
%     damage_4 = value_4 - value_1;
% ��������
%     damageCoefficients = [damage_1, damage_2, damage_3,damage_4]; % ��Ӧ��緽ʽ 1, 2, 3 ������ϵ��
    damageCoefficients = [value_1, value_2,value_3,value_4];
    % ��ʼ�������������
    n = length(charging_method) / 2; 
    chargeDamage = zeros(1,n);
        
    % ������緽ʽ����
    for i = 1:length(chargeDamage)
        % ��ȡ��ǰ��緽ʽ������
        chargingMethodIndex = charging_method(i);
        
        % ��������Ƿ���Ч
        if chargingMethodIndex >= 1 && chargingMethodIndex <= 4
            % ���㵱ǰ��緽ʽ�ĳ������
            chargeDamage(i) = damageCoefficients(chargingMethodIndex);
        else
            error('��Ч�ĳ�緽ʽ������');
        end
    end
    
    chargeDamage_cost = sum(chargeDamage);
end