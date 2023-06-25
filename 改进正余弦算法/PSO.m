function [fitnessgbest, gbest, zz] = PSO(X, N, maxgen, lb, ub, dim, fobj)

%% ������ʼ��
c1 = 2.5;                           % �����֪����
c2 = 2.5;                           % ������֪����
Vmax = 2;                      % ����ٶ�
Vmin = -2;                      % ��С�ٶ�
Wmax = 0.9; Wmin = 0.4;
V = rand(N, dim).*(Vmax-Vmin)+Vmin;
for i = 1:N
    fitness(i) = fobj(X(i, :));
end
%% 
[bestfitness, bestindex] = min(fitness);
gbest = X(bestindex, :);                      % Ⱥ�����ż�ֵ
zbest = X;                         % �������ż�ֵ
fitnessgbest = bestfitness;     % ��Ⱥ������Ӧ��ֵ
fitnesszbest = fitness;           % ����������Ӧ��ֵ

%% ��ʼ�����ʾ
disp(['��ʼλ�ã�' , num2str(gbest)]);
disp(['��ʼ����ֵ��', num2str(fitnessgbest)]);

%% ����Ѱ��
for i = 1:maxgen
    W = Wmax-((Wmax-Wmin)/maxgen)*i;
    for j=1:N
        % �ٶȸ���
        V(j, :) = W*V(j, :) + c1*rand*(zbest(j, :) - X(j, :)) + c2*rand*(gbest - X(j, :));
        V(j,find(V(j,:)>Vmax)) = Vmax;
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        % ��Ⱥ����
        X(j,:) = X(j,:) + V(j,:);
        X(j,find(X(j,:)>ub)) = ub;
        X(j,find(X(j,:)<lb)) = lb;
        
        % ��Ӧ��ֵ����
        fitness(j) = fobj(X(j,:));
    end
    %% �����Ⱥ�弫ֵ����
    for j = 1:N
        % �������Ÿ���
        if fitness(j) < fitnesszbest(j)
            zbest(j,:) = X(j,:);
            fitnesszbest(j) = fitness(j);
        end
        
        % Ⱥ�����Ÿ���
        if fitness(j) < fitnessgbest
            gbest = X(j,:);
            fitnessgbest = fitness(j);
        end
    end
    %% ÿһ��Ⱥ������ֵ����zz����
    zz(i) = fitnessgbest;
    
    disp(['PSO: At iteration ', num2str(i), ' ,the best fitness is ', num2str(zz(i))]);
end
% %% ���ս����ʾ
% disp(['����λ�ã�' , num2str(gbest)]);
% disp(['���պ���ֵ��', num2str(zz(end))]);
% %% ��ͼ
% figure;
% plot(zz, 'r', 'lineWidth', 2);          %  ��������ͼ
% xlabel('��������', 'fontsize', 12);
% ylabel('Ŀ�꺯��ֵ', 'fontsize', 12);
