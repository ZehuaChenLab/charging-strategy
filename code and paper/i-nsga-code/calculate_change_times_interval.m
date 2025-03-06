function change_times = calculate_change_times_interval(L, K, H, E)  
    % ���帺�غͿ���״̬�µĵ������Ч�ʹ�ʽ
    p_1 = 1 / (2.240 + 1.144e-4 * E); % ����״̬
    p_2 = 1 / (1.736 + 1.756e-4 * E); % ����״̬
    
    % ����һ��·���������������
    E1 = (L / 2) * (1 / p_1 + 1 / p_2);
    
    % ����һ�λ�������֧�ֵ�·�ߴ���
    r = E * 0.8 / E1;
    
    % ����һ������Ļ������
    change_counts = K * H / r;    
    
    % ���ڻ����������������������ȡ��������
    total_change_counts = floor(change_counts);
    
    % ����һ���ж��ٷ���
    total_minutes_in_day = 24 * 60;
   
    % ����һ�λ���������ķ�����
    average_interval = total_minutes_in_day / total_change_counts;
    
    % ��ʼ������ʱ������
    change_times = zeros(1, total_change_counts);
    
    %������8����Ϊ��ʼ��Ӫʱ��
    start_time = 0;
    
    current_time  = start_time;
    for i = 1:total_change_counts
        change_times(i) = current_time;
        current_time = current_time + average_interval;
    end
    
end