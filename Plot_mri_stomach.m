% import MRI measurement excel file and plot it


cd('C:\Users\Kwon\PycharmProjects\PancOCM_ML')
mri_stomach = xlsread('MRI_Measurement.xlsx', 4);

cd('C:\Users\Kwon\Documents\MATLAB\PCA')
%{
%% Unnormalized
i=1;
figure
set(gcf, 'Position', [0 0 650 450], 'Color', 'w')
i=i+1;
plot(mri_stomach(1:9,1),mri_stomach(1:9,i),'DisplayName','s1 exp1','LineStyle','-','Color',[0 0 1],'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach(1:10,i),'DisplayName','s1 exp2','LineStyle','--','Color',[0 0 1],'Marker','o'); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach(1:10,i),'DisplayName','s2 exp1','LineStyle','-','Color',[1 0 0],'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach(1:10,i),'DisplayName','s2 exp2','LineStyle','--','Color',[1 0 0],'Marker','s'); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach(1:10,i),'DisplayName','s3 exp1','LineStyle','-','Color',[0 0.6 0],'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach(1:10,i),'DisplayName','s3 exp2','LineStyle','--','Color',[0 0.6 0],'Marker','^'); hold on;

legend({'Subject1 exp1','Subject1 exp2','Subject2 exp1','Subject2 exp2','Subject3 exp1','Subject3 exp2'} ... 
    ,'Location','northwest','FontSize',10);

xlabel('Breath-holds');
ylabel('Stomach width (mm)');
ax = gca;
ax.FontSize = 12;
grid on;

export_fig mri_stomach.eps
export_fig mri_stomach.png

%% Normalized with all bh in state 1
% get average of state0
ave_0 = zeros(6,1);
mri_stomach_norm = zeros(10,6);
for i = 1:6
    ave_0(i,1) = mean(mri_stomach(1:5,i+1));
    mri_stomach_norm(:,i) = mri_stomach(1:10,i+1) / ave_0(i);
end

i=0;
figure
set(gcf, 'Position', [0 0 550 450], 'Color', 'w')
i=i+1;
plot(mri_stomach(1:9,1),mri_stomach_norm(1:9,i),'DisplayName','s1 exp1','LineStyle','-','Color',[0 0 1],'LineWidth',1.2,'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach_norm(1:10,i),'DisplayName','s1 exp2','LineStyle','--','Color',[0 0 1],'LineWidth',1.2,'Marker','o'); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach_norm(1:10,i),'DisplayName','s2 exp1','LineStyle','-','Color',[1 0 0],'LineWidth',1.2,'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach_norm(1:10,i),'DisplayName','s2 exp2','LineStyle','--','Color',[1 0 0],'LineWidth',1.2,'Marker','s'); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach_norm(1:10,i),'DisplayName','s3 exp1','LineStyle','-','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
i=i+1;
plot(mri_stomach(1:10,1),mri_stomach_norm(1:10,i),'DisplayName','s3 exp2','LineStyle','--','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^'); hold on;

legend({'Subject1 exp1','Subject1 exp2','Subject2 exp1','Subject2 exp2','Subject3 exp1','Subject3 exp2'} ... 
    ,'Location','northwest','FontSize',10);

xlim([1 10])
xticks(1:1:10);
ylim([0 4])
xlabel('Breath-holds');
ylabel('Relative stomach width');
ax = gca;
ax.FontSize = 12;
grid on;

box on;
export_fig mri_stomach_norm.eps
export_fig mri_stomach_norm.png

m_state1 = mean(mri_stomach_norm(1:5,1:6));
m_state2 = (mean(mri_stomach_norm(6:9,1))+mean(mri_stomach_norm(6:10,2))+mean(mri_stomach_norm(6:10,3)) ...
    +mean(mri_stomach_norm(6:10,4))+mean(mri_stomach_norm(6:10,5))+mean(mri_stomach_norm(6:10,6)))/6;

%}

%% Normalized with 1st bh
% get average of state0
ave_0_bh1 = zeros(6,1);
mri_stomach_norm_bh1 = zeros(10,6);
for i = 1:6
    ave_0_bh1(i,1) = mri_stomach(1,i+1);
    mri_stomach_norm_bh1(:,i) = mri_stomach(1:10,i+1) / ave_0_bh1(i);
end

i=0;
figure
set(gcf, 'Position', [0 0 550 450], 'Color', 'w')

% area plot
ha1 = area([1 5], [4 4], 'LineStyle','none'); hold on;
ha2 = area([6 10], [4 4], 'LineStyle','none'); hold on;
alpha(ha1,.15)
alpha(ha2,.15)

i=i+1;
p1 = plot(mri_stomach(1:9,1),mri_stomach_norm_bh1(1:9,i),'DisplayName','s1 exp1','LineStyle','-','Color',[0 0 1],'LineWidth',1.2,'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
i=i+1;
p2 = plot(mri_stomach(1:10,1),mri_stomach_norm_bh1(1:10,i),'DisplayName','s1 exp2','LineStyle','--','Color',[0 0 1],'LineWidth',1.2,'Marker','o'); hold on;
i=i+1;
p3 = plot(mri_stomach(1:10,1),mri_stomach_norm_bh1(1:10,i),'DisplayName','s2 exp1','LineStyle','-','Color',[1 0 0],'LineWidth',1.2,'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
i=i+1;
p4 = plot(mri_stomach(1:10,1),mri_stomach_norm_bh1(1:10,i),'DisplayName','s2 exp2','LineStyle','--','Color',[1 0 0],'LineWidth',1.2,'Marker','s'); hold on;
i=i+1;
p5 = plot(mri_stomach(1:10,1),mri_stomach_norm_bh1(1:10,i),'DisplayName','s3 exp1','LineStyle','-','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
i=i+1;
p6 = plot(mri_stomach(1:10,1),mri_stomach_norm_bh1(1:10,i),'DisplayName','s3 exp2','LineStyle','--','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^'); hold on;


legend([p1 p2 p3 p4 p5 p6], {'Subject1 exp1','Subject1 exp2','Subject2 exp1','Subject2 exp2','Subject3 exp1','Subject3 exp2'} ... 
    ,'Location','northwest','FontSize',12);

xlim([1 10])
xticks(1:1:10);
ylim([0 4])
xlabel('Breath-holds');
ylabel('Relative stomach width');
ax = gca;
ax.FontSize = 12;
grid on;

% calculate mean
m_state1 = (mean(mri_stomach_norm_bh1(1:5,1))+mean(mri_stomach_norm_bh1(1:5,2))+mean(mri_stomach_norm_bh1(1:5,3)) ...
    +mean(mri_stomach_norm_bh1(1:5,4))+mean(mri_stomach_norm_bh1(1:5,5))+mean(mri_stomach_norm_bh1(1:5,6)))/6;
m_state2 = (mean(mri_stomach_norm_bh1(6:9,1))+mean(mri_stomach_norm_bh1(6:10,2))+mean(mri_stomach_norm_bh1(6:10,3)) ...
    +mean(mri_stomach_norm_bh1(6:10,4))+mean(mri_stomach_norm_bh1(6:10,5))+mean(mri_stomach_norm_bh1(6:10,6)))/6;

box on;
export_fig mri_stomach_norm_bh1.eps
export_fig mri_stomach_norm_bh1.png
