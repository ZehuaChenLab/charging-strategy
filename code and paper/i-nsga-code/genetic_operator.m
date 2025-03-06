function f  = genetic_operator(parent_chromosome, M, V, change_times, remain_capacity,initialBatteryCount,pg_c,pg_m,steplength)
[N,~] = size(parent_chromosome);%N是交配池中的个体数量
clear m
p = 1;
was_crossover = 0;%是否交叉标志位
was_mutation = 0;%是否变异标志位
 
for i = 1 : 2*N%
    %交叉操作
    if rand(1) < pg_c%交叉概率0.9
        parent_1 = randi(N,1);
        parent_2 = randi(N,1);
        %防止选择的两个父代一样    
        while isequal(parent_chromosome(parent_1,:),parent_chromosome(parent_2,:))
            parent_2 = randi(N,1);
        end
        %索引到行向量的转变，提取出两个选择的父代
        parent_1 = parent_chromosome(parent_1,:);
        parent_2 = parent_chromosome(parent_2,:);
        
       crossPoint1 = randi([1,V]);
       crossPoint2 = randi([1,V]);
        
       [crossPoint1, crossPoint2] = sort([crossPoint1, crossPoint2]);
        child_1 = parent_1;
        child_2 = parent_2;
%        sg = child_2(crossPoint1);
%        child_2(crossPoint1) =child_1(crossPoint1);
%        child_1(crossPoint1) = sg;
        
        for i = crossPoint1:crossPoint2
        child_1(i) = child_2(i);
        child_2(i) = parent_1(i);
        end
        
        
%         for j = 1 : V
%             u(j) = rand(1);
%             if u(j) <= 0.5
%                child_1(j) = parent_2(j);
%                child_2(j) = parent_1(j);
%             else
%                child_1(j) = parent_1(j);
%                child_2(j) = parent_2(j);
%             end
%         end
        child_1(:,V + 1: M + V) = evaluate_objective(child_1, change_times, remain_capacity,initialBatteryCount);
        child_2(:,V + 1: M + V) = evaluate_objective(child_2, change_times, remain_capacity,initialBatteryCount);
        was_crossover = 1;
        was_mutation = 0;
    else%if >0.9
        parent_3 = randi(N,1);
        child_3 = parent_chromosome(parent_3,:);
        for j = 1 : V
           r(j) = rand(1);
           if r(j) < pg_m
               if(j <= 40)
                     s = randi([1, 4]);
                     while(s == child_3(j))
                     s = randi([1, 4]);
                     end
                     child_3(j) = s;
               else
                    delta = (2 * randi([0, 1]) - 1 ) * steplength + child_3(j);
                    delta = (2 * randi([0, 1]) - 1 ) * steplength + child_3(j);
                   if delta > 360
                      child_3(j) = 360;
                   elseif delta < 0
                      child_3(j) = 0;
                   else
                      child_3(j) = delta;
                   end
               end
           else
               child_3(j) = child_3(j);
           end
        end 
        child_3(:,V + 1: M + V) = evaluate_objective(child_3, change_times, remain_capacity,initialBatteryCount);
        was_mutation = 1;
        was_crossover = 0;
    end% if <0.9
    if was_crossover
        child(p,:) = child_1(1,1 : M + V);
        child(p+1,:) = child_2(1,1 : M + V);
        was_cossover = 0;
        p = p + 2;
    elseif was_mutation
        child(p,:) = child_3(1,1 : M + V);
        was_mutation = 0;
        p = p + 1;
    end
end
f = child;