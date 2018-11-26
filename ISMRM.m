%ISMRM figures
% ! Run after "vis_DVF_Difference.m" to get ave_runA,ave_runB,ave_runC

ocm_runA = zeros(1,15);
ocm_runB = zeros(1,15);
ocm_runC = zeros(1,15);

cd('C:\Users\jihun\Documents\US_MRI');
mean_square_diff = zeros(30,9);
mean_square_diff = xlsread('DataForFigures.xlsx',1);
traces = xlsread('DataForFigures.xlsx',2);
cd('C:\Users\jihun\Documents\MATLAB\PCA');

%Before water
ocm_runA(1:5) = mean_square_diff(26:30,1); %Jeremy run1
ocm_runA(6:10) = mean_square_diff(26:30,4); %Jeremy run2
ocm_runA(11:15) = mean_square_diff(26:30,7); %Jihun run1

%Shortly after water
ocm_runB(1:5) = mean_square_diff(26:30,2); %Jeremy run1
ocm_runB(6:10) = mean_square_diff(26:30,5); %Jeremy run2
ocm_runB(11:15) = mean_square_diff(26:30,8); %Jihun run1

%10 min after water
ocm_runC(1:5) = mean_square_diff(26:30,3); %Jeremy run1
ocm_runC(6:10) = mean_square_diff(26:30,6); %Jeremy run2
ocm_runC(11:15) = mean_square_diff(26:30,9); %Jihun run1

ave_ocm_runA = mean(ocm_runA);
ave_ocm_runB = mean(ocm_runB);
ave_ocm_runC = mean(ocm_runC);

max_mri_abc = [max(ave_runA(:)) max(ave_runB(:)) max(ave_runC(:))];
max_ocm_abc = [max(ocm_runA(:)) max(ocm_runB(:)) max(ocm_runC(:))];
max_mri = max(max_mri_abc);
max_ocm = max(max_ocm_abc(:));

% Devide by maximum of whole measurement
mri_runA_norm = ave_runA/max_mri;
mri_runB_norm = ave_runB/max_mri;
mri_runC_norm = ave_runC/max_mri;
ocm_runA_norm = ocm_runA/max_ocm;
ocm_runB_norm = ocm_runB/max_ocm;
ocm_runC_norm = ocm_runC/max_ocm;

%{
% Devide by maximum of each volunteer
for i=1:12 %before water
    if (i<5) %Jeremy run1
        mri_runA_norm_subject(i) = ave_runA(i)/max(ave_runB(1:5));
    elseif (4<i && i<9) %Jeremy run2
        mri_runA_norm_subject(i) = ave_runA(i)/max(ave_runB(6:10));
    else  %Jihun run1
        mri_runA_norm_subject(i) = ave_runA(i)/max(ave_runB(11:15));
    end    
end

for i=1:15 %After water
    if (i<6) %Jeremy run1
        mri_runB_norm_subject(i) = ave_runB(i)/max(ave_runB(1:5));
        mri_runC_norm_subject(i) = ave_runC(i)/max(ave_runB(1:5));
        %ocm_runA contains tp=1 value. (total is 15 values)
        ocm_runA_norm_subject(i) = ocm_runA(i)/max(ocm_runB(1:5));
        ocm_runB_norm_subject(i) = ocm_runB(i)/max(ocm_runB(1:5));
        ocm_runC_norm_subject(i) = ocm_runC(i)/max(ocm_runC(1:5));
    elseif (5<i && i<11) %Jeremy run2
        mri_runB_norm_subject(i) = ave_runB(i)/max(ave_runB(6:10));
        mri_runC_norm_subject(i) = ave_runC(i)/max(ave_runB(6:10));
        ocm_runA_norm_subject(i) = ocm_runA(i)/max(ocm_runB(6:10));
        ocm_runB_norm_subject(i) = ocm_runB(i)/max(ocm_runB(6:10));
        ocm_runC_norm_subject(i) = ocm_runC(i)/max(ocm_runC(6:10));
    else %Jihun run1
        mri_runB_norm_subject(i) = ave_runB(i)/max(ave_runB(11:15));
        mri_runC_norm_subject(i) = ave_runC(i)/max(ave_runB(11:15));
        ocm_runA_norm_subject(i) = ocm_runA(i)/max(ocm_runB(11:15));
        ocm_runB_norm_subject(i) = ocm_runB(i)/max(ocm_runB(11:15));
        ocm_runC_norm_subject(i) = ocm_runC(i)/max(ocm_runC(11:15));
    end
end
%}


%% Plot Box plots. OCM and MRI together
%Normalized for maximum subject
ave_all_mri = [mri_runA_norm mri_runB_norm mri_runC_norm];
ave_all_ocm = [ocm_runA_norm ocm_runB_norm ocm_runC_norm];

g_mri = [zeros(1,length(ave_runA)), ones(1,length(ave_runB)), 2*ones(1,length(ave_runC))];
g_ocm = [zeros(1,length(ocm_runA)), ones(1,length(ocm_runB)), 2*ones(1,length(ocm_runC))];

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

%Normalized for each subject
% ave_all_mri_subject = [mri_runA_norm_subject mri_runB_norm_subject mri_runC_norm_subject];
% ave_all_ocm_subject = [ocm_runA_norm_subject ocm_runB_norm_subject ocm_runC_norm_subject];

figure('Position', [391 100 700 400]);
subaxis(1,2,1,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_ocm, g_ocm);
ylabel('Mean Square Difference');
title('OCM (normalized for each subject)');
set(gcf, 'Color', 'w');
ylim([0 1.1]);

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_mri, g_mri);
ylabel('DVF_{Mean Magnitude}');
title('MRI (normalized for each subject)');
ylim([0 1.1]);
set(gcf, 'Color', 'w');

saveas(gcf,'BoxPlots_norm.png');
export_fig BoxPlots_norm.png -q101
%% t-test 
% ave_runA vs ave_runB, 
[h_mri_23,p_mri_23] = ttest(ave_runB,ave_runC);
[h_ocm_23,p_ocm_23] = ttest(ocm_runB,ocm_runC);


%% Plot scatter plots. OCM and MRI together
scat_mri_runA = mri_runA_norm;
scat_mri_runB = mri_runB_norm;
scat_mri_runC = mri_runC_norm;

scat_ocm_runA = ocm_runA_norm;
scat_ocm_runB = ocm_runB_norm;
scat_ocm_runC = ocm_runC_norm;

%First scan of each run has to be removed to match with MRI.
if (size(ave_all_ocm,2)==45)
    scat_ocm_runA(11) = [];
    scat_ocm_runA(6) = [];
    scat_ocm_runA(1) = [];
    ave_all_ocm(11) = [];
    ave_all_ocm(6) = [];
    ave_all_ocm(1) = [];
end

%Get R-square
fit_OCM = [ave_all_mri];
fit_MRI = [ave_all_ocm];

mdl = fitlm(fit_OCM,fit_MRI);
R2 = mdl.Rsquared.Ordinary;
b = mdl.Coefficients.Estimate(1);
a = mdl.Coefficients.Estimate(2);
x = 0:0.1:1;
y = a*x+b;

figure;
scatter(scat_ocm_runA,scat_mri_runA,50,'filled','o'); hold on;
scatter(scat_ocm_runB,scat_mri_runB,50,'filled','d'); hold on;
scatter(scat_ocm_runC,scat_mri_runC,50,'filled','s');
xlim([0 1.0]);
ylim([0 1.0]);
plot(x,y,'Color',[0,0,0]);
text(0.4,0.5, ['R^2 = ' num2str(R2)],'FontSize',10);

xlabel('OCM, Mean Square Difference');
ylabel('MRI, DVF_{Mean Magnitude}');
legend({'Before water','Shortly after water','10 min after water'},'Location','southeast','FontSize',8);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
saveas(gcf,'Scatter_MRIvsOCM.png');
export_fig Scatter_MRIvsOCM.png -q101;

%% scatter plots. with R2 fitting line
%{
% v1a:Jeremy 1st, v1b:Jeremy 2nd, v2a: Jihun 1st.
% MRI
scat_mri_runA_v1a = mri_runA_norm(1:4); 
scat_mri_runA_v2a = mri_runA_norm(5:8);
scat_mri_runA_v1b = mri_runA_norm(9:12);

scat_mri_runB_v1a = mri_runB_norm(1:5);
scat_mri_runB_v2a = mri_runB_norm(6:10);
scat_mri_runB_v1b = mri_runB_norm(11:15);

scat_mri_runC_v1a = mri_runC_norm(1:5);
scat_mri_runC_v1b = mri_runC_norm(6:10);
scat_mri_runC_v2a = mri_runC_norm(11:15);

% OCM
scat_ocm_runA_v1a = ocm_runA_norm(1:5);
scat_ocm_runA_v1b = ocm_runA_norm(6:10);
scat_ocm_runA_v2a = ocm_runA_norm(11:15);

scat_ocm_runB_v1a = ocm_runB_norm(1:5);
scat_ocm_runB_v1b = ocm_runB_norm(6:10);
scat_ocm_runB_v2a = ocm_runB_norm(11:15);

scat_ocm_runC_v1a = ocm_runC_norm(1:5);
scat_ocm_runC_v1b = ocm_runC_norm(6:10);
scat_ocm_runC_v2a = ocm_runC_norm(11:15);

%First scan of each run has to be removed to match with MRI.
scat_ocm_runA_v1a(1) = [];
scat_ocm_runA_v1b(1) = [];
scat_ocm_runA_v2a(1) = [];

%Get R-square
fit_OCM_new = [scat_ocm_runA_v1a scat_ocm_runA_v1b scat_ocm_runA_v2a scat_ocm_runB_v1a ...
    scat_ocm_runB_v1b scat_ocm_runB_v2a scat_ocm_runC_v1a scat_ocm_runC_v1b scat_ocm_runC_v2a];
fit_MRI_new = [scat_mri_runA_v1a scat_mri_runA_v2a scat_mri_runA_v1b scat_mri_runB_v1a ...
    scat_mri_runB_v2a scat_mri_runB_v1b scat_mri_runC_v1a scat_mri_runC_v1b scat_mri_runC_v2a];

    
mdl_new = fitlm(fit_OCM_new,fit_MRI_new);
R2_new = mdl.Rsquared.Ordinary;
b_new = mdl.Coefficients.Estimate(1);
a_new = mdl.Coefficients.Estimate(2);
x_new = 0:0.1:1;
y_new = a_new*x_new+b_new;

figure;
scatter(scat_ocm_runA,scat_mri_runA,50,'filled','o'); hold on;
scatter(scat_ocm_runB,scat_mri_runB,50,'filled','d'); hold on;
scatter(scat_ocm_runC,scat_mri_runC,50,'filled','s');
%{
scatter(scat_ocm_runA_v1a,scat_mri_runA_v1a,50,'filled','o','MarkerFaceColor',[  0    0.4470    0.7410]); hold on;
scatter(scat_ocm_runB_v1a,scat_mri_runB_v1a,50,'filled','d','MarkerFaceColor',[  0.8500    0.3250    0.0980]); hold on;
scatter(scat_ocm_runC_v1a,scat_mri_runC_v1a,50,'filled','s','MarkerFaceColor',[    0.9290    0.6940    0.1250]); hold on;

scatter(scat_ocm_runA_v1b,scat_mri_runA_v1b,50,'filled','o','MarkerFaceColor',[  0    0.4470    0.7410]); hold on;
scatter(scat_ocm_runB_v1b,scat_mri_runB_v1b,50,'filled','d','MarkerFaceColor',[  0.8500    0.3250    0.0980]); hold on;
scatter(scat_ocm_runC_v1b,scat_mri_runC_v1b,50,'filled','s','MarkerFaceColor',[    0.9290    0.6940    0.1250]); hold on;

scatter(scat_ocm_runA_v2a,scat_mri_runA_v2a,50,'filled','o','MarkerFaceColor',[  0    0.4470    0.7410]); hold on;
scatter(scat_ocm_runB_v2a,scat_mri_runB_v2a,50,'filled','d','MarkerFaceColor',[  0.8500    0.3250    0.0980]); hold on;
scatter(scat_ocm_runC_v2a,scat_mri_runC_v2a,50,'filled','s','MarkerFaceColor',[    0.9290    0.6940    0.1250]); hold on;
%}

plot(x_new,y_new,'Color',[0,0,0]);
text(0.4,0.5, ['R^2 = ' num2str(R2_new)],'FontSize',10);

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
%}
%% Plot traces
%{
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
%}