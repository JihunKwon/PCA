% This script import excel file of AUC ROC and generate bar plot

cd C:\Users\Kwon\PycharmProjects\PancOCM_ML
auc_data = xlsread('State3_AUC2.xlsx');

ocm0_12 = auc_data(1:5,1);
ocm1_12 = auc_data(1:6,2);
ocm2_12 = auc_data(1:6,3);
ocm0_13 = auc_data(1:5,7);
ocm1_13 = auc_data(1:6,8);
ocm2_13 = auc_data(1:6,9);

bar_input = [mean(ocm0_12), mean(ocm1_12), mean(ocm2_12);
             mean(ocm0_13), mean(ocm1_13), mean(ocm2_13)];
err_input = [std(ocm0_12), std(ocm1_12), std(ocm2_12);
             std(ocm0_13), std(ocm1_13), std(ocm2_13)];
errorbar_groups(bar_input,err_input,'bar_colors',[0.93,0.93,0.93;0.45,0.45,0.45], ...
                'bar_names',{'OCM0', 'OCM1', 'OCM2'}, ...
                'bar_width',0.8, ...
                'optional_bar_arguments',{'LineWidth',1.5}, ...
                'optional_errorbar_arguments',{'LineStyle','none','Marker','none','LineWidth',1.5});

set(gcf,'Position',[0 0 400 400], 'Color', 'w')
ylabel('Average AUC','FontSize',15);
legend('State 1 vs. State 2','State 1 vs. State 3')
legend('Location', 'northwest','FontSize',11)
xticklabel = get(gca, 'XTickLabel');
yticklabel = get(gca, 'YTickLabel');
set(gca,'XTickLabel',xticklabel,'fontsize',15);
set(gca,'YTickLabel',yticklabel,'fontsize',12);
set(gca,'linewidth',1.5)
box on;
ylim([0, 1.39]); 
savename = strcat('AUC_bar.png');
export_fig(sprintf(savename), '-q101');


%% statistical analysis
[h_0,p_0] = ttest(ocm0_12, ocm0_13);
[h_1,p_1] = ttest(ocm1_12, ocm1_13);
[h_2,p_2] = ttest(ocm2_12, ocm2_13);