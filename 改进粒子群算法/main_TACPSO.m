close all
clear all 
clc

SearchAgents_no=40; % ��Ⱥ��Ŀ
N=SearchAgents_no;
Function_name='F15'; % ���Ժ���

Max_iteration=500;  % ��������
%Max_iter=Max_iteration;

% ������Ӧ�Ⱥ���
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
cnt_max =1;
for cnt = 1:cnt_max
    %[ABest_scoreChimp(cnt),ABest_posChimp,Chimp_curve]=Chimp(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    %[ABest_scoreChimp_2(cnt),ABest_posChimp_2,Chimp_curve_SLWChoA]=SLWChoA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    [PSO_gBestScore(cnt),PSO_gBest,PSO_cg_curve]=PSO(N,Max_iteration,lb,ub,dim,fobj);
    [TACPSO_gBestScore(cnt),TACPSO_gBest,TACPSO_cg_curve]=TACPSO(N,Max_iteration,lb,ub,dim,fobj);
    [MPSO_gBestScore(cnt),MPSO_gBest,MPSO_cg_curve]=MPSO(N,Max_iteration,lb,ub,dim,fobj);
    %[IPSO_gBestScore(cnt),HHO_gBest,HHO_cg_curve]=HHO(N,Max_iteration,lb,ub,dim,fobj);
    %[AO_gBestScore(cnt),AO_gBest,AO_cg_curve]=AO(N,Max_iteration,lb,ub,dim,fobj);
end


figure
func_plot(Function_name);
title('�����ռ�')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

%%
figure;
t = 1:Max_iteration;
semilogy(t, MPSO_cg_curve, 'rd-',t,  PSO_cg_curve, 'c^-',t, TACPSO_cg_curve, 'g<-',...
    'linewidth', 1.5, 'MarkerSize', 6, 'MarkerIndices', 1:25:Max_iteration);
title(Function_name)
xlabel('��������');
ylabel('log(��Ӧ��ֵ)');
axis fill
grid on
box on
legend('MPSO','PSO','TACPSO');
set(gca,'fontname','���� ')
%display(['The best optimal value of the objective funciton found by SLWChoa is : ', num2str(ABest_scoreChimp_2)])
display(['The best optimal value of the objective funciton found by TACPSO is : ', num2str(TACPSO_gBestScore)]);
display(['The best optimal value of the objective funciton found by PSO is : ', num2str(PSO_gBestScore)]);
display(['The best optimal value of the objective funciton found by MPSO is : ', num2str(MPSO_gBestScore)]);
%display(['The best optimal value of the objective funciton found by Chimp is : ', num2str(ABest_scoreChimp)]);
%display(['The best optimal value of the objective funciton found by HHO is : ', num2str(HHO_gBestScore)]);
%display(['The best optimal value of the objective funciton found by AO is : ', num2str(AO_gBestScore)]);
%%
disp(['������', num2str(Function_name)]);
%worst_SLWchoa = max(ABest_scoreChimp_2);best_SLWchoa = min(ABest_scoreChimp_2);mean_SLWchoa = mean(ABest_scoreChimp_2);std_SLWchoa= std(ABest_scoreChimp_2);
worst_PSO = max(PSO_gBestScore);best_PSO = min(PSO_gBestScore);mean_PSO = mean(PSO_gBestScore);std_PSO = std(PSO_gBestScore);
%worst_Chimp= max(ABest_scoreChimp);best_Chimp = min(ABest_scoreChimp);mean_Chimp = mean(ABest_scoreChimp);std_Chimp = std(ABest_scoreChimp);
worst_TACPSO = max(TACPSO_gBestScore);best_TACPSO = min(TACPSO_gBestScore);mean_TACPSO = mean(TACPSO_gBestScore);std_TACPSO = std(TACPSO_gBestScore);
worst_MPSO= max(MPSO_gBestScore);best_MPSO = min(MPSO_gBestScore);mean_MPSO = mean(MPSO_gBestScore);std_MPSO = std(MPSO_gBestScore);
%worst_HHO= max(HHO_gBestScore);best_HHO = min(HHO_gBestScore);mean_HHO = mean(HHO_gBestScore);std_HHO = std(HHO_gBestScore);
%worst_AO= max(AO_gBestScore);best_AO = min(AO_gBestScore);mean_AO = mean(AO_gBestScore);std_AO = std(AO_gBestScore);

% disp(['SLWChoa�����ֵ: ', num2str(worst_SLWchoa), ', ����ֵ: ', num2str(best_SLWchoa), ',ƽ��ֵ: ', num2str(mean_SLWchoa), ',��׼��: ', num2str(std_SLWchoa), ...
%     ', �Ⱥͼ���: ', num2str(ranksum(ABest_scoreChimp_2, ABest_scoreChimp_2))]);
% disp(['PSO�����ֵ: ', num2str(worst_PSO), ', ����ֵ: ', num2str(best_PSO), ',ƽ��ֵ: ', num2str(mean_PSO), ',��׼��: ', num2str(std_PSO), ...
%     ', �Ⱥͼ���: ', num2str(ranksum(PSO_gBestScore, ABest_scoreChimp_2))]);
% disp(['Chimp�����ֵ: ', num2str(worst_Chimp), ', ����ֵ: ', num2str(best_Chimp), ',ƽ��ֵ: ', num2str(mean_Chimp), ',��׼��: ', num2str(std_Chimp), ...
%     ', �Ⱥͼ���: ', num2str(ranksum(ABest_scoreChimp, ABest_scoreChimp_2))]);
% disp(['TACPSO�����ֵ: ', num2str(worst_TACPSO), ', ����ֵ: ', num2str(best_TACPSO), ',ƽ��ֵ: ', num2str(mean_TACPSO), ',��׼��: ', num2str(std_TACPSO), ...
%     ', �Ⱥͼ���: ', num2str(ranksum(TACPSO_gBestScore, ABest_scoreChimp_2))]);
% disp(['MPSO�����ֵ: ', num2str(worst_MPSO), ', ����ֵ: ', num2str(best_MPSO), ', ƽ��ֵ: ', num2str(mean_MPSO), ', ��׼��: ', num2str(std_MPSO), ...
%     ', �Ⱥͼ���: ', num2str(ranksum(MPSO_gBestScore, ABest_scoreChimp_2))]);
% disp(['HHO�����ֵ: ', num2str(worst_HHO), ', ����ֵ: ', num2str(best_HHO), ', ƽ��ֵ: ', num2str(mean_HHO), ', ��׼��: ', num2str(std_HHO), ...
%     ', �Ⱥͼ���: ', num2str(ranksum(HHO_gBestScore, ABest_scoreChimp_2))]);
% disp(['AO�����ֵ: ', num2str(worst_AO), ', ����ֵ: ', num2str(best_AO), ', ƽ��ֵ: ', num2str(mean_AO), ', ��׼��: ', num2str(std_AO), ...
%     ', �Ⱥͼ���: ', num2str(ranksum(AO_gBestScore, ABest_scoreChimp_2))]);

        



