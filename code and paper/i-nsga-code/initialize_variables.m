function f = initialize_variables(N, M, V, change_times, remain_capacity,initialBatteryCount)%f��һ������Ⱥ������ɵľ���
% min = min_range;
% max = max_range;
K = M + V;%%K���������Ԫ�ظ�����Ϊ�˱��ڼ��㣬���߱�����Ŀ�꺯������һ���γ�һ�����顣  
%���ڽ���ͱ��죬����Ŀ������Ծ��߱�������ѡ��
f = zeros(N, M+V); % Ԥ����ռ�

% ����ǰ40ά��ȡֵΪ1, 2, 3, 4
f(:, 1:V/2) = randi([1, 4], N, V/2);

% ���ɺ�40ά��ȡֵ��ΧΪ0-360
f(:, V/2 + 1: V) = randi([0, 360], N, V/2);

for i = 1 : N
    f(i,V + 1: K) = evaluate_objective(f(i,:),change_times, remain_capacity,initialBatteryCount); 
    % M��Ŀ�꺯������ V�Ǿ��߱�������
    %Ϊ�˼򻯼��㽫��Ӧ��Ŀ�꺯��ֵ������Ⱦɫ���V + 1 �� K��λ�á�
end