%ISMRM figures
% ! Run after "vis_DVF_Difference.m" to get mri_runA,mri_runB,mri_runC
num_subject = 5;

%Color
X = linspace(0,pi*3,1000); 
Y = bsxfun(@(x,n)sin(x+2*n*pi/num_subject), X.', 1:num_subject); 
C = linspecer(num_subject); 
%Color: Blue; Red
Color_my = vega20c;


%% Import OCM data
ocm_runA = zeros(1,num_subject*3);
ocm_runB = zeros(1,num_subject*3);
ocm_runC = zeros(1,num_subject*3);

cd('C:\Users\jihun\Documents\US_MRI');
mean_square_diff = zeros(30,num_subject);
%mean_square_diff = xlsread('DataForFigures.xlsx',1);
%mean_square_diff = xlsread('DataForFigures_replist_corrected.xlsx',1);
mean_square_diff = xlsread('DataForFigures_300_700FOV_s3_3401.xlsx',1);
traces = xlsread('DataForFigures.xlsx',2);
cd('C:\Users\jihun\Documents\MATLAB\PCA');

for sub = 1:num_subject
    ocm_runA(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,3+(sub-1)*3); %Before water
    ocm_runB(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,4+(sub-1)*3); %Shortly after water
    ocm_runC(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,5+(sub-1)*3); %10 min after water
end


%% Get mean and max of OCM and MRI
ave_ocm_runA = mean(ocm_runA);
ave_ocm_runB = mean(ocm_runB);
ave_ocm_runC = mean(ocm_runC);

max_mri_abc = [max(mri_runA(:)) max(mri_runB(:)) max(mri_runC(:))];
max_ocm_abc = [max(ocm_runA(:)) max(ocm_runB(:)) max(ocm_runC(:))];
max_mri = max(max_mri_abc);
max_ocm = max(max_ocm_abc(:));

%{
%*****************************************************************
% Temporary when num of subject between MRI and OCM are different.
mri_runA_new = mri_runA(1:end/4*3);
mri_runB_new = mri_runB(1:end/4*3);
mri_runC_new = mri_runC(1:end/4*3);
%*****************************************************************
%}

% Devide by maximum of whole measurement
mri_runA_norm = mri_runA/max_mri;
mri_runB_norm = mri_runB/max_mri;
mri_runC_norm = mri_runC/max_mri;
ocm_runA_norm = ocm_runA/max_ocm;
ocm_runB_norm = ocm_runB/max_ocm;
ocm_runC_norm = ocm_runC/max_ocm;

% Devide by maximum of each volunteer
[m_runA_norm_sub, m_runB_norm_sub, m_runC_norm_sub, o_runA_norm_sub, o_runB_norm_sub, o_runC_norm_sub] ...
    = Norm_subject(num_subject, mri_runA, mri_runB, mri_runC, ocm_runA, ocm_runB, ocm_runC);

%% Plot Box plots. OCM and MRI together
%Normalized for maximum subject
ave_all_mri = [mri_runA_norm mri_runB_norm mri_runC_norm];
ave_all_ocm = [ocm_runA_norm ocm_runB_norm ocm_runC_norm];

g_mri = [zeros(1,length(mri_runA)), ones(1,length(mri_runB)), 2*ones(1,length(mri_runC))];
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
ave_all_mri_sub = [m_runA_norm_sub m_runB_norm_sub m_runC_norm_sub];
ave_all_ocm_sub = [o_runA_norm_sub o_runB_norm_sub o_runC_norm_sub];

figure('Position', [391 100 700 400]);
subaxis(1,2,1,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_ocm_sub, g_ocm);
ylabel('Mean Square Difference');
title('OCM (normalized for each subject)');
set(gcf, 'Color', 'w');
ylim([0 1.1]);

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_mri_sub, g_mri);
ylabel('DVF_{Mean Magnitude}');
title('MRI (normalized for each subject)');
ylim([0 1.1]);
set(gcf, 'Color', 'w');

saveas(gcf,'BoxPlots_norm.png');
export_fig BoxPlots_norm.png -q101
%% t-test 
% mri_runA vs mri_runB, 
[h_mri_23,p_mri_23] = ttest(mri_runB,mri_runC);
[h_ocm_23,p_ocm_23] = ttest(ocm_runB,ocm_runC);

[h_mri_norm_23,p_mri_norm_23] = ttest(m_runB_norm_sub,m_runC_norm_sub);
[h_ocm_norm_23,p_ocm_norm_23] = ttest(o_runB_norm_sub,o_runC_norm_sub);

%% Plot scatter plots. OCM and MRI together
scat_mri_runA = mri_runA_norm;
scat_mri_runB = mri_runB_norm;
scat_mri_runC = mri_runC_norm;

scat_ocm_runA = ocm_runA_norm;
scat_ocm_runB = ocm_runB_norm;
scat_ocm_runC = ocm_runC_norm;

%Get R-square
fit_OCM = [ave_all_ocm];
fit_MRI = [ave_all_mri];

mdl = fitlm(fit_OCM,fit_MRI);
R2 = mdl.Rsquared.Ordinary;
b = mdl.Coefficients.Estimate(1);
a = mdl.Coefficients.Estimate(2);
x = 0:0.1:1;
y = a*x+b;

figure;
markers = {'o', 'o', 's', 's','^'};
for sub = 1:num_subject
    scatter(scat_ocm_runA(1+(sub-1)*4:sub*4),scat_mri_runA(1+(sub-1)*4:sub*4),70,C(1,1:3),'filled',markers{sub}); hold on;
    scatter(scat_ocm_runB(1+(sub-1)*5:sub*5),scat_mri_runB(1+(sub-1)*5:sub*5),70,C(2,1:3),'filled',markers{sub}); hold on;
    scatter(scat_ocm_runC(1+(sub-1)*5:sub*5),scat_mri_runC(1+(sub-1)*5:sub*5),70,C(3,1:3),'filled',markers{sub}); hold on;
end

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
saveas(gcf,'Scatter_MRIvsOCM_runcolor.png');
export_fig Scatter_MRIvsOCM_runcolor.png -q101;

%{
figure;
for sub = 1:num_subject
    scatter(scat_ocm_runA(1+(sub-1)*4:sub*4),scat_mri_runA(1+(sub-1)*4:sub*4),50,C(sub,1:3),'filled',markers{sub}); hold on;
    scatter(scat_ocm_runB(1+(sub-1)*5:sub*5),scat_mri_runB(1+(sub-1)*5:sub*5),50,C(sub,1:3),'filled',markers{sub}); hold on;
    scatter(scat_ocm_runC(1+(sub-1)*5:sub*5),scat_mri_runC(1+(sub-1)*5:sub*5),50,C(sub,1:3),'filled',markers{sub}); hold on;
end

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
saveas(gcf,'Scatter_MRIvsOCM_subjectcolor.png');
export_fig Scatter_MRIvsOCM_subjectcolor.png -q101;
%}
%% scatter plots. normalize each subject with max MRI and OCM
scat_m_runA_sub = m_runA_norm_sub;
scat_m_runB_sub = m_runB_norm_sub;
scat_m_runC_sub = m_runC_norm_sub;

scat_o_runA_sub = o_runA_norm_sub;
scat_o_runB_sub = o_runB_norm_sub;
scat_o_runC_sub = o_runC_norm_sub;

%First scan of each run has to be removed to match with MRI.
if (size(ave_all_ocm_sub,2)==num_subject*15)
    for i = 5*num_subject:-1:1
        if rem(i,5) == 1
            scat_o_runA_sub(i) = [];
            ave_all_ocm_sub(i) = [];
        end
    end
end

%Get R-square
fit_OCM_norm_sub = [ave_all_ocm_sub];
fit_MRI_norm_sub = [ave_all_mri_sub];

mdl = fitlm(fit_OCM_norm_sub,fit_MRI_norm_sub);
R2 = mdl.Rsquared.Ordinary;
b = mdl.Coefficients.Estimate(1);
a = mdl.Coefficients.Estimate(2);
x = 0:0.1:1;
y = a*x+b;

%{
figure;
for sub = 1:num_subject
    scatter(scat_o_runA_sub(1+(sub-1)*4:sub*4),scat_m_runA_sub(1+(sub-1)*4:sub*4),70,C(1,1:3),'filled',markers{sub}); hold on;
    scatter(scat_o_runB_sub(1+(sub-1)*5:sub*5),scat_m_runB_sub(1+(sub-1)*5:sub*5),70,C(2,1:3),'filled',markers{sub}); hold on;
    scatter(scat_o_runC_sub(1+(sub-1)*5:sub*5),scat_m_runC_sub(1+(sub-1)*5:sub*5),70,C(3,1:3),'filled',markers{sub}); hold on;
end
%}

figure;
for sub = 1:num_subject
    scatter(scat_o_runA_sub(1+(sub-1)*4:sub*4),scat_m_runA_sub(1+(sub-1)*4:sub*4),70,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_o_runB_sub(1+(sub-1)*5:sub*5),scat_m_runB_sub(1+(sub-1)*5:sub*5),70,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_o_runC_sub(1+(sub-1)*5:sub*5),scat_m_runC_sub(1+(sub-1)*5:sub*5),70,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
end

xlim([0 1.0]);
ylim([0 1.0]);
plot(x,y,'Color',[0,0,0]);
text(0.4,0.5, ['R^2 = ' num2str(R2)],'FontSize',10);

xlabel('OCM, Mean Square Difference');
ylabel('MRI, DVF_{Mean Magnitude}');
legend({'Before water','Shortly after water','10 min after water'},'Location','southeast','FontSize',8);
legend boxoff 
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
saveas(gcf,'Scatter_MRIvsOCM_runcolor_normSub.png');
export_fig Scatter_MRIvsOCM_runcolor_normSub.png -q101;

%% Plot traces

figure('Position', [391 100 350 400]);
subaxis(3,1,1,'MarginLeft',0.15,'MarginBottom',0.15,'SpacingVert',0,'MR',0.04);
plot(traces(:,1),traces(:,2),'LineWidth',2);
xlim([2 6]);
ylim([0 1.15]);
set(gca,'XTickLabel',[]);
title('Before water intake','FontSize',12,'Units', 'normalized', 'Position', [0.14, 0.8, 0]);

subaxis(3,1,2,'SpacingVert',0,'MR',0.04);
plot(traces(:,1),traces(:,3),'LineWidth',2);
xlim([2 6]);
ylim([0 1.15]);
ylabel('Intensity','FontSize',14);
set(gca,'XTickLabel',[]);
title('Shortly after water intake','FontSize',12,'Units', 'normalized', 'Position', [0.19, 0.8, 0]);

subaxis(3,1,3,'SpacingVert',0,'MR',0.04);
plot(traces(:,1),traces(:,4),'LineWidth',2);
xlim([2 6]);
ylim([0 1.15]);
xlabel('Depth (cm)','FontSize',14);
title('10 min after water intake','FontSize',12,'Units', 'normalized', 'Position', [0.18, 0.8, 0]);
set(gcf, 'Color', 'w');
saveas(gcf,'Traces.png');
export_fig Traces.png -q101
