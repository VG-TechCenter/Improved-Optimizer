function [fitnessgbest, gbest, Curve] = BAS_SCA(X, N, maxgen, lb, ub, dim, fobj)

%% BAS-SCA����
alpha = 0.05;
c = 5;
s0 = 0.9; s1 = 0.4;
for i = 1:N    %Ϊ��Ⱥ��ģ30
    fitness(i) = fobj(X(i, :));
end
% ��ʼ����
[bestfitness, bestindex] = min(fitness);
gbest = X(bestindex, :);              % Ⱥ�����ż�ֵ
fitnessgbest = bestfitness;         % ��Ⱥ������Ӧ��ֵ

%% ����Ѱ��
for t = 1:maxgen   %Ϊ����������500
    %%  �ݼ�����r1�ĸı�
    r1 = alpha*exp(cos(pi*t/(maxgen+t)));
    %% ��������ӦȨ��
    w = 0.2*cos(pi/2*(1-t/maxgen));
    % ���¸���λ��
    for i = 1:N
        for j = 1:dim 
            % ��Eq. (3.3)����r2,r3,r4
            r2 = (2*pi)*rand();
            r3 = 2*rand;
            r4 = rand();
            
            % Eq. (3.3)
            if r4 < 0.5
                % Eq. (3.1)
                X(i, j) = w*X(i, j)+(r1*sin(r2)*abs(r3*gbest(j)-X(i, j)));
            else
                % Eq. (3.2)
                X(i, j) = w*X(i, j)+(r1*cos(r2)*abs(r3*gbest(j)-X(i, j)));
            end
        end
    end
    
    for i = 1:N
        % �߽紦��
        Flag4ub = X(i, :) > ub;
        Flag4lb = X(i, :) < lb;
        X(i, :) = (X(i, :).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        % ������Ӧ��ֵ
        fitness(i) = fobj(X(i, :));
        
        % �������Ž�
        if fitness(i) < fitnessgbest
            gbest = X(i, :);
            fitnessgbest = fitness(i);
        end
    end
    %%  �䲽����������
    delta = s1*(s0/s1)^(maxgen/(maxgen+10*t));
    d0 = delta/c;
    dir = rands(1, dim);%dim=inputnum*hiddenLayerSize+outputnum*hiddenLayerSize+hiddenLayerSize+outputnum;
    dir = dir/(eps+norm(dir)); %��һ��
    Xleft = gbest+dir*d0/2;
    Xright = gbest-dir*d0/2;
    % �߽紦��
    Xleft = boundcheck(Xleft, lb, ub);
    Xright = boundcheck(Xright, lb, ub);
    fright = fobj(Xright);
    fleft = fobj(Xleft);
    new_gbest = gbest-delta*dir*sign(fleft-fright);
    % �߽紦��
    new_gbest = boundcheck(new_gbest, lb, ub);
    % ̰��ѡ��
    if fobj(new_gbest) < fitnessgbest
        fitnessgbest = fobj(new_gbest);
        gbest = new_gbest;
    end
    % ��¼ÿ�����Ž�
    Curve(t) = fitnessgbest;
    % ��ʾ������Ϣ
    display(['BAS-SCA:At iteration ', num2str(t), ' the best fitness is ', num2str(Curve(t))]);
end

%% �߽紦����
function x = boundcheck(x, lb, ub)
x = min(x, ub);
x = max(x, lb);
end

end

