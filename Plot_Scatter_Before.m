%This script plots scatter plot MRI vs OCM for "before water" phase
%% No normalization
scat_mri_runA_raw = mri_runA;
scat_ocm_runA_raw = ocm_runA;

%Get R-square
fit_OCM_bef = [ocm_runA];
fit_MRI_bef = [mri_runA];

mdl = fitlm(fit_MRI_bef,fit_OCM_bef);
R2 = mdl.Rsquared.Ordinary;
b = mdl.Coefficients.Estimate(1);
a = mdl.Coefficients.Estimate(2);
x = 0:0.1:5;
y = a*x+b;

figure;
markers = {'o', 'd', 's', 'v','^','v'};
numA_tot = 0;
for sub = 1:num_subject
    scatter(scat_mri_runA_raw(numA_tot+1:numA_tot+num_array_A(sub)),scat_ocm_runA_raw(numA_tot+1:numA_tot+num_array_A(sub)),60,'filled',markers{sub},'LineWidth',1.3); hold on;
    numA_tot = numA_tot+num_array_A(sub);
end

%xlim([0 1.0]);
%ylim([0 1.0]);
plot(x,y,'Color',[0,0,0]);
text(0.4,0.5, ['R^2 = ' num2str(R2)],'FontSize',10);

xlabel('MRI, DVF_{Mean Magnitude}');
ylabel('OCM, Mean Square Difference');
title('No normalization');
legend({'S1r1','S1r2','S2r1','S2r2','S3r1','S3r2'},'Location','northwest','FontSize',8);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
export_fig Scatter_bef_MRIvsOCM.png -q101
export_fig Scatter_bef_MRIvsOCM.pdf


%% Normaliza minimum to zero

% Devide by minimum of each volunteer
%[m_runA_norm_min, o_runA_norm_min] = Norm_by_min(num_subject, num_array_A, mri_runA, ocm_runA);
%scat_mri_runA_norm_min = m_runA_norm_min;
%scat_ocm_runA_norm_min = o_runA_norm_min;

[m_runA_norm_min] = Norm_by_min(num_subject, num_array_A, mri_runA, ocm_runA);
scat_mri_runA_norm_min = m_runA_norm_min;
scat_ocm_runA_norm_min = ocm_runA;

%Get R-square
%fit_OCM_bef = [o_runA_norm_min];
%fit_MRI_bef = [m_runA_norm_min];

mdl = fitlm(fit_MRI_bef,fit_OCM_bef);
R2 = mdl.Rsquared.Ordinary;
b = mdl.Coefficients.Estimate(1);
a = mdl.Coefficients.Estimate(2);
x = 0:0.1:5;
y = a*x+b;

figure;
markers = {'o', 'd', 's', 'v','^','v'};
numA_tot = 0;
for sub = 1:num_subject
    scatter(scat_mri_runA_norm_min(numA_tot+1:numA_tot+num_array_A(sub)),scat_ocm_runA_norm_min(numA_tot+1:numA_tot+num_array_A(sub)),60,'filled',markers{sub},'LineWidth',1.3); hold on;
    numA_tot = numA_tot+num_array_A(sub);
end

%xlim([0 1.0]);
%ylim([0 1.0]);
plot(x,y,'Color',[0,0,0]);
text(0.4,0.5, ['R^2 = ' num2str(R2)],'FontSize',10);

xlabel('MRI, DVF_{Mean Magnitude}');
ylabel('OCM, Mean Square Difference');
title('Normalize min to zero');
legend({'S1r1','S1r2','S2r1','S2r2','S3r1','S3r2'},'Location','northwest','FontSize',8);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
export_fig Scatter_bef_MRIvsOCM_min0.png -q101
export_fig Scatter_bef_MRIvsOCM_min0.pdf
