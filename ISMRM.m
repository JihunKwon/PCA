%ISMRM figures
% ! Run after "vis_DVF_Difference.m" to get ave_run1,ave_run2,ave_run3

ocm_run1 = zeros(1,15);
ocm_run2 = zeros(1,15);
ocm_run3 = zeros(1,15);

cd('C:\Users\jihun\Documents\US_MRI');
mean_square_diff = zeros(30,9);
mean_square_diff = xlsread('DataForFigures.xlsx',1);
traces = xlsread('DataForFigures.xlsx',2);
cd('C:\Users\jihun\Documents\MATLAB\PCA');

%Before water
ocm_run1(1:5) = mean_square_diff(26:30,1); 
ocm_run1(6:10) = mean_square_diff(26:30,4);
ocm_run1(11:15) = mean_square_diff(26:30,7);

%Shortly after water
ocm_run2(1:5) = mean_square_diff(26:30,2); 
ocm_run2(6:10) = mean_square_diff(26:30,5);
ocm_run2(11:15) = mean_square_diff(26:30,8);

%10 min after water
ocm_run3(1:5) = mean_square_diff(26:30,3); 
ocm_run3(6:10) = mean_square_diff(26:30,6);
ocm_run3(11:15) = mean_square_diff(26:30,9);

ave_ocm_run1 = mean(ocm_run1);
ave_ocm_run2 = mean(ocm_run2);
ave_ocm_run3 = mean(ocm_run3);

max_mri = max(ave_run2(3:end));
max_ocm = max(ocm_run2(:));

% Devide by maximum of whole measurement
% mri_run1_norm = ave_run2/max_mri;
% mri_run2_norm = ave_run2/max_mri;
% mri_run3_norm = ave_run3/max_mri;
ocm_run1_norm = ocm_run1/max_ocm;
ocm_run2_norm = ocm_run2/max_ocm;
ocm_run3_norm = ocm_run3/max_ocm;

% Devide by maximum of each volunteer
for i=1:12
    if (i<5) %v1 run1
        mri_run1_norm(i) = ave_run1(i)/max(ave_run2(1:4));
    elseif (4<i && i<9) %v2 run1
        mri_run1_norm(i) = ave_run1(i)/max(ave_run2(5:8));
    else  %v1 run2
        mri_run1_norm(i) = ave_run1(i)/max(ave_run2(9:12));
    end    
end

% find max for v2run1 because it has extremely high outlier.
max_v2run1_mri = max(ave_run2(8:10));
if max_v2run1_mri < ave_run2(6)
    max_v2run1_mri = ave_run2(6);
end

for i=1:15
    if (i<6) %v1 run1
        mri_run2_norm(i) = ave_run2(i)/max(ave_run2(1:5));
        mri_run3_norm(i) = ave_run3(i)/max(ave_run2(1:5));
    elseif (5<i && i<11) %v2 run1
        mri_run2_norm(i) = ave_run2(i)/max_v2run1_mri;
        mri_run3_norm(i) = ave_run3(i)/max_v2run1_mri;
    else %v1 run2
        mri_run2_norm(i) = ave_run2(i)/max(ave_run2(11:15));
        mri_run3_norm(i) = ave_run3(i)/max(ave_run2(11:15));
    end
end


%% Plot Box plots. OCM and MRI together
ave_all_mri = [mri_run1_norm mri_run2_norm mri_run3_norm];
ave_all_ocm = [ocm_run1_norm ocm_run2_norm ocm_run3_norm];

g_mri = [zeros(1,length(ave_run1)), ones(1,length(ave_run2)), 2*ones(1,length(ave_run3))];
g_ocm = [zeros(1,length(ocm_run1)), ones(1,length(ocm_run2)), 2*ones(1,length(ocm_run3))];

figure('Position', [391 100 700 400]);
subaxis(1,2,1,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_ocm, g_ocm);
ylabel('Mean Square Difference');
title('OCM');
set(gcf, 'Color', 'w');
ylim([0 1.1]);

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_mri, g_mri);
ylabel('DVF_{Mean Magnitude}');
title('MRI');
ylim([0 1.1]);
set(gcf, 'Color', 'w');

saveas(gcf,'BoxPlots.png');
export_fig BoxPlots.png -q101

%% t-test 
%{
% For t-test, two gropus have to be the same sample size. Since ave_run2
% has outlier (element 2), remove max value from ave_run3 too.
[val_run2, idx_run2] = max(ave_run2);

if val_run2 > 2.7
    ave_run2(idx_run2) = [];
    [val_run3, idx_run3] = max(ave_run3);
    ave_run3(idx_run3) = [];
end

% ave_run1 vs ave_run2, 
[h_mri_23,p_mri_23] = ttest(ave_run2,ave_run3);
[h_ocm_23,p_ocm_23] = ttest(ocm_run2,ocm_run3);
%}

%% Plot scatter plots. OCM and MRI together

scat_mri_run1 = mri_run1_norm;
scat_mri_run2 = mri_run2_norm;
scat_mri_run3 = mri_run3_norm;

scat_ocm_run1 = ocm_run1_norm;
scat_ocm_run2 = ocm_run2_norm;
scat_ocm_run3 = ocm_run3_norm;

%First scan of each run has to be removed to match with MRI.
scat_ocm_run1(11) = [];
scat_ocm_run1(6) = [];
scat_ocm_run1(1) = [];

figure;
scatter(scat_ocm_run1,scat_mri_run1,50,'filled','o'); hold on;
scatter(scat_ocm_run2,scat_mri_run2,50,'filled','d'); hold on;
scatter(scat_ocm_run3,scat_mri_run3,50,'filled','s');
xlim([0 1.0]);
ylim([0 1.0]);

xlabel('OCM, Mean Square Difference');
ylabel('MRI, DVF_{Mean Magnitude}');
legend({'Before water','Shortly after water','10 min after water'},'Location','northwest','FontSize',8);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
saveas(gcf,'Scatter_MRIvsOCM.png');
export_fig Scatter_MRIvsOCM.png -q101;


%% scatter plots. V2r1 removed
% v1a:Jeremy 1st, v1b:Jeremy 2nd, v2a: Jihun 1st.
% MRI
scat_mri_run1_v1a = mri_run1_norm(1:4); 
scat_mri_run1_v2a = mri_run1_norm(5:8);
scat_mri_run1_v1b = mri_run1_norm(9:12);

scat_mri_run2_v1a = mri_run2_norm(1:5);
scat_mri_run2_v2a = mri_run2_norm(6:10);
scat_mri_run2_v1b = mri_run2_norm(11:15);

scat_mri_run3_v1a = mri_run3_norm(1:5);
scat_mri_run3_v1b = mri_run3_norm(6:10);
scat_mri_run3_v2a = mri_run3_norm(11:15);

% OCM
scat_ocm_run1_v1a = ocm_run1_norm(1:5);
scat_ocm_run1_v1b = ocm_run1_norm(6:10);
scat_ocm_run1_v2a = ocm_run1_norm(11:15);

scat_ocm_run2_v1a = ocm_run2_norm(1:5);
scat_ocm_run2_v1b = ocm_run2_norm(6:10);
scat_ocm_run2_v2a = ocm_run2_norm(11:15);

scat_ocm_run3_v1a = ocm_run3_norm(1:5);
scat_ocm_run3_v1b = ocm_run3_norm(6:10);
scat_ocm_run3_v2a = ocm_run3_norm(11:15);

%First scan of each run has to be removed to match with MRI.
scat_ocm_run1_v1a(1) = [];
scat_ocm_run1_v1b(1) = [];
scat_ocm_run1_v2a(1) = [];

%Get R-square
fit_OCM = [scat_ocm_run1_v1a scat_ocm_run1_v1b scat_ocm_run1_v2a ...
    scat_ocm_run2_v1a scat_ocm_run2_v1b scat_ocm_run3_v1a scat_ocm_run3_v1b];
fit_MRI = [scat_mri_run1_v1a scat_mri_run1_v1b scat_mri_run1_v2a ...
    scat_mri_run2_v1a scat_mri_run2_v1b scat_mri_run3_v1a scat_mri_run3_v1b];

%remove outlier (which shows very high MRI value)
fit_OCM(14) = [];
fit_MRI(14) = [];

mdl = fitlm(fit_OCM,fit_MRI);
R2 = mdl.Rsquared.Ordinary;
b = mdl.Coefficients.Estimate(1);
a = mdl.Coefficients.Estimate(2);
x = 0:0.1:1;
y = a*x+b;

figure;
scatter(scat_ocm_run1_v1a,scat_mri_run1_v1a,50,'filled','o','MarkerFaceColor',[  0    0.4470    0.7410]); hold on;
scatter(scat_ocm_run2_v1a,scat_mri_run2_v1a,50,'filled','d','MarkerFaceColor',[  0.8500    0.3250    0.0980]); hold on;
scatter(scat_ocm_run3_v1a,scat_mri_run3_v1a,50,'filled','s','MarkerFaceColor',[    0.9290    0.6940    0.1250]); hold on;

scatter(scat_ocm_run1_v1b,scat_mri_run1_v1b,50,'filled','o','MarkerFaceColor',[  0    0.4470    0.7410]); hold on;
scatter(scat_ocm_run2_v1b,scat_mri_run2_v1b,50,'filled','d','MarkerFaceColor',[  0.8500    0.3250    0.0980]); hold on;
scatter(scat_ocm_run3_v1b,scat_mri_run3_v1b,50,'filled','s','MarkerFaceColor',[    0.9290    0.6940    0.1250]); hold on;

scatter(scat_ocm_run1_v2a,scat_mri_run1_v2a,50,'filled','o','MarkerFaceColor',[  0    0.4470    0.7410]); hold on;

plot(x,y,'Color',[0,0,0]);
text(0.4,0.5, ['R^2 = ' num2str(R2)],'FontSize',10);

xlim([0 1.0]);
ylim([0 1.0]);

xlabel('OCM, Mean Square Difference');
ylabel('MRI, DVF_{Mean Magnitude}');
legend({'Before water','Shortly after water','10 min after water'},'Location','southeast','FontSize',10);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
saveas(gcf,'Scatter_MRIvsOCM_new.png');
export_fig Scatter_MRIvsOCM_new.png -q101

%% Plot traces
figure('Position', [391 100 350 400]);
subaxis(3,1,1,'MarginLeft',0.15,'MarginBottom',0.15,'SpacingVert',0,'MR',0.04);
plot(traces(:,1),traces(:,2),'LineWidth',2);
xlim([2 6]);
ylim([0 1.15]);
set(gca,'XTickLabel',[]);
title('Before Water','FontSize',12,'Units', 'normalized', 'Position', [0.14, 0.8, 0]);

subaxis(3,1,2,'SpacingVert',0,'MR',0.04);
plot(traces(:,1),traces(:,3),'LineWidth',2);
xlim([2 6]);
ylim([0 1.15]);
ylabel('Intensity','FontSize',14);
set(gca,'XTickLabel',[]);
title('Shortly After Water','FontSize',12,'Units', 'normalized', 'Position', [0.19, 0.8, 0]);

subaxis(3,1,3,'SpacingVert',0,'MR',0.04);
plot(traces(:,1),traces(:,4),'LineWidth',2);
xlim([2 6]);
ylim([0 1.15]);
xlabel('Depth (cm)','FontSize',14);
title('10 min After Water','FontSize',12,'Units', 'normalized', 'Position', [0.18, 0.8, 0]);
set(gcf, 'Color', 'w');
saveas(gcf,'Traces.png');
export_fig Traces.png -q101
