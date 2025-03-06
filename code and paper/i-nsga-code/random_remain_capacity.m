function  remain_capacity = random_remain_capacity(change_times)
num_elements = length(change_times);
% ���ɱ�׼��̬�ֲ����������
std_normal_vector = randn(1, num_elements);

% �趨��̬�ֲ��ľ�ֵ�ͱ�׼�ʹ�ô󲿷���ֵ����0.15��0.25֮��
mean_value = 0.20; % ��������Ϊ0.15��0.25����ֵ
std_dev = 0.02;   % ��׼���Ҫ�㹻С��������ֵ��Ҫ����0.15��0.25֮��

% ����׼��̬�ֲ�ת��Ϊָ����ֵ�ͱ�׼�����̬�ֲ�
normal_vector = std_normal_vector * std_dev + mean_value;

% �ضϳ���0.15��0.25��Χ����ֵ
normal_vector(normal_vector < 0.15) = 0.15;
normal_vector(normal_vector > 0.25) = 0.25;

% �������뵽��λС��
remain_capacity = round(normal_vector * 100) / 100;
end

