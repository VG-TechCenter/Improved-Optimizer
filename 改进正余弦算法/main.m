%% �����������
clear 
clc

%% ��������
N = 40;             % ��Ⱥ��ģ
Function_name = 'F23';       % ��F1��F23�Ĳ��Ժ��������ƣ������еı�1��2��3��
Max_iteration = 501;       % ����������
% ������ѡ��׼��������ϸ��Ϣ
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

cnt_max = 1;

Curve_SCA = zeros(1, Max_iteration);
Curve_PSO = zeros(1, Max_iteration);
Curve_BAS_SCA = zeros(1, Max_iteration);
Curve_PSCA = zeros(1, Max_iteration);
Curve_ESCA = zeros(1, Max_iteration);

for cnt = 1:cnt_max
    % ��ʼ����Ⱥλ��
    X = initialization(N, dim, ub, lb);

    [SCA_Best_score(cnt), SCA_Best_pos(cnt, :), SCA_Curve] = SCA(X, N, Max_iteration, lb, ub, dim, fobj);
    [PSO_Best_score(cnt), PSO_Best_pos(cnt, :), PSO_Curve] = PSO(X, N, Max_iteration, lb, ub, dim, fobj);
    [BAS_SCA_Best_score(cnt), BAS_SCA_Best_pos(cnt, :), BAS_SCA_Curve] = BAS_SCA(X, N, Max_iteration, lb, ub, dim, fobj);
    [PSCA_Best_score(cnt), PSCA_Best_pos(cnt, :), PSCA_Curve] = PSCA(X, N, Max_iteration, lb, ub, dim, fobj);
    [ESCA_Best_score(cnt), ESCA_Best_pos(cnt, :), ESCA_Curve] = ESCA(X, N, Max_iteration, lb, ub, dim, fobj);
    
    Curve_SCA = Curve_SCA+SCA_Curve;
    Curve_PSO = Curve_PSO+PSO_Curve;
    Curve_BAS_SCA = Curve_BAS_SCA+BAS_SCA_Curve;
    Curve_PSCA = Curve_PSCA+PSCA_Curve;
    Curve_ESCA = Curve_ESCA+ESCA_Curve;
    
end

Curve_SCA = Curve_SCA/cnt_max;
Curve_PSO = Curve_PSO/cnt_max;
Curve_BAS_SCA = Curve_BAS_SCA/cnt_max;
Curve_PSCA = Curve_PSCA/cnt_max;
Curve_ESCA = Curve_ESCA/cnt_max;

std_sca = std(SCA_Best_score);
std_pso = std(PSO_Best_score);
std_bas_sca = std(BAS_SCA_Best_score);
std_psca = std(PSCA_Best_score);
std_esca = std(ESCA_Best_score);

best_sca = min(SCA_Best_score);
best_pso = min(PSO_Best_score);
best_bas_sca = min(BAS_SCA_Best_score);
best_psca = min(PSCA_Best_score);
best_esca = min(ESCA_Best_score);

worst_sca = max(SCA_Best_score);
worst_pso = max(PSO_Best_score);
worst_bas_sca = max(BAS_SCA_Best_score);
worst_psca = max(PSCA_Best_score);
worst_esca = max(ESCA_Best_score);

mean_sca = mean(SCA_Best_score);
mean_pso = mean(PSO_Best_score);
mean_bas_sca = mean(BAS_SCA_Best_score);
mean_psca = mean(PSCA_Best_score);
mean_esca = mean(ESCA_Best_score);

%% ��ͼ
% 1��������ѡ��׼��������ά����ͼ��
figure;
func_plot(Function_name);
title(Function_name)
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

% 2������Ŀ�꺯��ֵ�仯����ͼ
figure;
t = 1:Max_iteration;
semilogy(t, Curve_SCA, 'go-', t, Curve_PSO, 'mx-', t, Curve_BAS_SCA, 'rd-', t, Curve_PSCA, 'ks-', t, Curve_ESCA, 'bv-', ...
'linewidth', 1.5, 'markersize', 8, 'MarkerIndices', 1:50:Max_iteration);
title(Function_name)
xlabel('��������');
ylabel('Ŀ�꺯��ֵ(Log)');
axis tight
grid on
box on
legend('SCA', 'PSO', 'BAS-SCA', 'PSCA', 'ESCA');

%% ��ʾ���
disp(['������', num2str(Function_name)]);
disp(['SCA������ֵ: ', num2str(best_sca), ',���ֵ:', num2str(worst_sca), ',ƽ��ֵ:', num2str(mean_sca), ',��׼��:', num2str(std_sca)]);
disp(['PSO������ֵ: ', num2str(best_pso), ',���ֵ:', num2str(worst_pso), ',ƽ��ֵ:', num2str(mean_pso), ',��׼��:', num2str(std_pso)]);
disp(['BAS-SCA������ֵ: ', num2str(best_bas_sca), ',���ֵ:', num2str(worst_bas_sca), ',ƽ��ֵ:', num2str(mean_bas_sca), ',��׼��:', num2str(std_bas_sca)]);
disp(['PSCA������ֵ: ', num2str(best_psca), ',���ֵ:', num2str(worst_psca), ',ƽ��ֵ:', num2str(mean_psca), ',��׼��:', num2str(std_psca)]);
disp(['ESCA������ֵ: ', num2str(best_esca), ',���ֵ:', num2str(worst_esca), ',ƽ��ֵ:', num2str(mean_esca), ',��׼��:', num2str(std_esca)]);


