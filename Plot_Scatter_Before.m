%This script plots scatter plot MRI vs OCM for "before water" phase
%% No normalization
scat_mri_runA_raw = mri_runA;
scat_ocm_runA_raw = ocm_runA;

%Get R-square
fit_OCM_bef = [ocm_runA_norm];
fit_MRI_bef = [mri_runA_norm];

for sub = 1:num_subject
    %Get subject-specific R-square 
%     fit_OCM_bef = [ocm_runA_norm((sub-1)*4+1:sub*4)];
%     fit_MRI_bef = [mri_runA_norm((sub-1)*4+1:sub*4)];
end

mdl_bef = fitlm(fit_MRI_bef,fit_OCM_bef);
R2 = mdl_bef.Rsquared.Ordinary;
b = mdl_bef.Coefficients.Estimate(1);
a = mdl_bef.Coefficients.Estimate(2);
x = 0:0.1:5;
y = a*x+b;

figure;
markers = {'o', 'd', 's', 'v','^','v'};
numA_tot = 0;
for sub = 1:num_subject
    scatter(scat_mri_runA(numA_tot+1:numA_tot+num_array_A(sub)),scat_ocm_runA(numA_tot+1:numA_tot+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    numA_tot = numA_tot+num_array_A(sub);
end

xlim([0 1.0]);
ylim([0 1.0]);
plot(x,y,'Color',[0,0,0]);
text(0.05,0.9, ['R^2 = ' num2str(R2_sub)],'FontSize',10);

xlabel('MRI');
ylabel('OCM');
title('Before water intake');
%legend({'S1r1','S1r2','S2r1','S2r2','S3r1'},'Location','northwest','FontSize',8);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
export_fig Scatter_bef_MRIvsOCM.png -q101
export_fig Scatter_bef_MRIvsOCM.pdf