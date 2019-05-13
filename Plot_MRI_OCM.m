%Plot OCM and MRI figures together
% ! Run after "vis_DVF_Difference.m" to get mri_runA,mri_runB,mri_runC
num_subject = 5;
xtl_time = {{'Before';'water intake'} {'Shortly after';'water intake'} {'10 min after';'water intake'}};

%number of datapoints
num_A = 4;
num_B = 5;
num_C = 5;

s1r1 = num_subject*4;
s1r2 = num_subject*4;
s2r1 = num_subject*4;
s2r2 = num_subject*4;
s3r1 = num_subject*4;

%Color
X = linspace(0,pi*3,1000); 
Y = bsxfun(@(x,n)sin(x+2*n*pi/num_subject), X.', 1:num_subject); 
C = linspecer(6); 
%C = [0.904605882352941,0.191764605882353,0.198823529411765;0.294117646058824,0.544605882352941,0.749411764605882;0.371764605882353,0.717646058823529,0.361176460588235;1,0.548235294117647,0.100000000000000;0.955000000000000,0.894646058823529,0.472176460588235;0.685882352941177,0.403529411764606,0.241176460588235;0.971764605882353,0.555294117646059,0.774117646058824];
%Color: Blue; Red
Color_my = vega20c;

%% Set parameter name
%param_name = ('r_c_d');
%% Import OCM data
ocm_runA = zeros(1,num_subject*3);
ocm_runB = zeros(1,num_subject*3);
ocm_runC = zeros(1,num_subject*3);

cd('C:\Users\Kwon\Documents\Panc_OCM');
mean_square_diff = zeros(30,num_subject);
%mean_square_diff = xlsread('DataForFigures.xlsx',1);
mean_square_diff = xlsread('DataForFigures_300_650FOV.xlsx',1);
%mean_square_diff = xlsread('DataForFigures_MA50_300_650FOV_lp5.xlsx',1);
cd('C:\Users\Kwon\Documents\MATLAB\PCA\OCM_Analysis');

for sub = 1:num_subject
    ocm_runA(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,3+(sub-1)*3); %Before water
    ocm_runB(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,4+(sub-1)*3); %Shortly after water
    ocm_runC(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,5+(sub-1)*3); %10 min after water
end

%% Remove first scan of each run in OCM
%First scan of each run has to be removed to match with MRI.
if (size(ocm_runA,2)==num_subject*5)
    for i = 5*num_subject:-1:1 %To maintain arrays, has to scan from end to start
        if rem(i,5) == 1
            ocm_runA(i) = [];
        end
    end
end

%% Remove outliers from both MRI and OCM.
if strcmp(param_name,'r_c_d')
    %Manually define outliers here (outlier is detected from Box and whiskers plot)
    outlier_A = [];  %S1r2:5,S1r1:3
    outlier_B = [];    %S1r1:7
    outlier_C = [];   %S3r1:13

    %Update subject datapoint number. manually change subtract value
    s1r1A = num_A;
    s1r1B = num_B;
    s1r1C = num_C;

    s1r2A = num_A; s1r2B = num_B; s1r2C = num_C;
    s2r1A = num_A; s2r1B = num_B; s2r1C = num_C;
    s2r2A = num_A; s2r2B = num_B; s2r2C = num_C;
    s3r1A = num_A; s3r1B = num_B; s3r1C = num_C;
    s3r2A = num_A; s3r2B = num_B; s3r2C = num_C;
elseif strcmp(param_name,'r_c_r_d')
    %Manually define outliers here (outlier is detected from Box and whiskers plot)
%     outlier_A = [4,3,2];  %S1r1:3
%     outlier_B = [3]; %S1r1:3
%     outlier_C = [24]; %S3r1:13
    outlier_A = [3];  %S1r1:3
    outlier_B = [12]; %S2r1:3
    outlier_C = [24]; %S3r1:13

    %Update subject datapoint number. manually change subtract value
    s1r1A = num_A - 1;
    s1r1B = num_B;
    s1r1C = num_C;

    s1r2A = num_A; s1r2B = num_B; s1r2C = num_C;
    s2r1A = num_A; s2r1B = num_B - 1; s2r1C = num_C;
    s2r2A = num_A; s2r2B = num_B; s2r2C = num_C;
    s3r1A = num_A; s3r1B = num_B; s3r1C = num_C - 1;
    s3r2A = num_A; s3r2B = num_B; s3r2C = num_C;
end

%Each subject, number of data points left.
num_array_A = [s1r1A,s1r2A,s2r1A,s2r2A,s3r1A,s3r2A];
num_array_B = [s1r1B,s1r2B,s2r1B,s2r2B,s3r1B,s3r2B];
num_array_C = [s1r1C,s1r2C,s2r1C,s2r2C,s3r1C,s3r2C];

if (size(ocm_runA,2)==num_subject*4)
    for cnt = 1:length(outlier_A)
        for i = 4*num_subject:-1:1
            if i == outlier_A(cnt)
                mri_runA(i) = [];
                ocm_runA(i) = [];
            end
        end
    end
end
if (size(ocm_runB,2)==num_subject*5)
    for cnt = 1:length(outlier_B)
        for i = 5*num_subject:-1:1
            if i == outlier_B(cnt)
                mri_runB(i) = [];
                ocm_runB(i) = [];
            end
        end
    end
end
if (size(ocm_runC,2)==num_subject*5)
    for cnt = 1:length(outlier_C)
        for i = 5*num_subject:-1:1
            if i == outlier_C(cnt)
                mri_runC(i) = [];
                ocm_runC(i) = [];
            end
        end
    end
end

%% Get mean and max of OCM and MRI
ave_ocm_runA = mean(ocm_runA);
ave_ocm_runB = mean(ocm_runB);
ave_ocm_runC = mean(ocm_runC);

max_mri_abc = [max(mri_runA(:)) max(mri_runB(:)) max(mri_runC(:))];
max_ocm_abc = [max(ocm_runA(:)) max(ocm_runB(:)) max(ocm_runC(:))];
max_mri = max(max_mri_abc);
max_ocm = max(max_ocm_abc(:));

% Devide by maximum of whole measurement
mri_runA_norm = mri_runA/max_mri;
mri_runB_norm = mri_runB/max_mri;
mri_runC_norm = mri_runC/max_mri;
ocm_runA_norm = ocm_runA/max_ocm;
ocm_runB_norm = ocm_runB/max_ocm;
ocm_runC_norm = ocm_runC/max_ocm;

% Devide by maximum of each volunteer
[m_runA_norm_sub, m_runB_norm_sub, m_runC_norm_sub, o_runA_norm_sub, o_runB_norm_sub, o_runC_norm_sub] ...
    = Norm_subject_aapm(num_subject, num_array_A, num_array_B, num_array_C, mri_runA, mri_runB, mri_runC, ocm_runA, ocm_runB, ocm_runC);

%% Plot Box plots. OCM and MRI together
%Normalized for maximum subject
ave_all_mri = [mri_runA_norm mri_runB_norm mri_runC_norm];
ave_all_ocm = [ocm_runA_norm ocm_runB_norm ocm_runC_norm];

g_mri = [zeros(1,length(mri_runA)), ones(1,length(mri_runB)), 2*ones(1,length(mri_runC))];
g_ocm = [zeros(1,length(ocm_runA)), ones(1,length(ocm_runB)), 2*ones(1,length(ocm_runC))];

figure('Position', [391 100 600 400]);
subaxis(1,2,1,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_ocm, g_ocm);
ylabel('Mean Square Difference');
title('OCM');
h = my_xticklabels(gca,[1 2 3],xtl_time);
set(gcf, 'Color', 'w');
ylim([0 1.1]);

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_mri, g_mri);
ylabel('DVF_{Mean Magnitude}');
title('MRI');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 1.1]);
set(gcf, 'Color', 'w');

export_fig BoxPlots.png -q101
export_fig BoxPlots.pdf

%Normalized for each subject
ave_all_mri_sub = [m_runA_norm_sub m_runB_norm_sub m_runC_norm_sub];
ave_all_ocm_sub = [o_runA_norm_sub o_runB_norm_sub o_runC_norm_sub];

figure('Position', [391 100 660 350]);
subaxis(1,2,1,'SpacingHoriz',0.05,'MR',0);
boxplot(ave_all_ocm_sub, g_ocm);
ylabel('Mean Square Difference');
title('OCM');
h = my_xticklabels(gca,[1 2 3],xtl_time);
set(gcf, 'Color', 'w');
ylim([0 1.1]);

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0);
boxplot(ave_all_mri_sub, g_mri);
ylabel('DVF_{Mean Magnitude}');
title('MRI');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 1.1]);
set(gcf, 'Color', 'w');

export_fig BoxPlots_norm.png -q101
export_fig BoxPlots_norm.pdf
%% t-test 
% mri_runA vs mri_runB, 
[h_mri_23,p_mri_23] = ttest(mri_runB,mri_runC);
[h_ocm_23,p_ocm_23] = ttest(ocm_runB,ocm_runC);

[h_mri_norm_23,p_mri_norm_23] = ttest(m_runB_norm_sub,m_runC_norm_sub);
[h_ocm_norm_23,p_ocm_norm_23] = ttest(o_runB_norm_sub,o_runC_norm_sub);

%% Plot scatter plots. OCM and MRI together. Normalized max among all the subjects.
scat_mri_runA = mri_runA_norm;
scat_mri_runB = mri_runB_norm;
scat_mri_runC = mri_runC_norm;

scat_ocm_runA = ocm_runA_norm;
scat_ocm_runB = ocm_runB_norm;
scat_ocm_runC = ocm_runC_norm;

%Get R-square
fit_OCM = [ave_all_ocm];
fit_MRI = [ave_all_mri];

mdl = fitlm(fit_MRI,fit_OCM);
R2 = mdl.Rsquared.Ordinary;
b = mdl.Coefficients.Estimate(1);
a = mdl.Coefficients.Estimate(2);
x = 0:0.1:1;
y = a*x+b;

figure;
%markers = {'o', 'o', 's', 's','^'};
markers = {'o', 'd', 's', 'v','^','v'};
numA_tot = 0;
numB_tot = 0;
numC_tot = 0;
for sub = 1:num_subject
    scatter(scat_mri_runA(numA_tot+1:numA_tot+num_array_A(sub)),scat_ocm_runA(numA_tot+1:numA_tot+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_mri_runB(numB_tot+1:numB_tot+num_array_B(sub)),scat_ocm_runB(numB_tot+1:numB_tot+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_mri_runC(numC_tot+1:numC_tot+num_array_C(sub)),scat_ocm_runC(numC_tot+1:numC_tot+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    
    numA_tot = numA_tot+num_array_A(sub);
    numB_tot = numB_tot+num_array_B(sub);
    numC_tot = numC_tot+num_array_C(sub);
end

xlim([0 1.0]);
ylim([0 1.0]);
plot(x,y,'Color',[0,0,0]);
text(0.4,0.5, ['R^2 = ' num2str(R2)],'FontSize',10);

xlabel('MRI, DVF_{Mean Magnitude}');
ylabel('OCM, Mean Square Difference');
title('Normalize by max among all subjects');
legend({'Before water intake','Shortly after water intake','10 min after water intake'},'Location','northwest','FontSize',8);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
export_fig Scatter_MRIvsOCM_runcolor.png -q101
export_fig Scatter_MRIvsOCM_runcolor.pdf

%% Plot each subject separetaly
figure('Position', [391 1 700 1000]);
numA_tot = 0;
numB_tot = 0;
numC_tot = 0;

for sub = 1:num_subject
    subaxis(3,2,sub,'SpacingVert',0.065,'SpacingHoriz',0.04);
    scatter(scat_mri_runA(numA_tot+1:numA_tot+num_array_A(sub)),scat_ocm_runA(numA_tot+1:numA_tot+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_mri_runB(numB_tot+1:numB_tot+num_array_B(sub)),scat_ocm_runB(numB_tot+1:numB_tot+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_mri_runC(numC_tot+1:numC_tot+num_array_C(sub)),scat_ocm_runC(numC_tot+1:numC_tot+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    
    numA_tot = numA_tot+num_array_A(sub);
    numB_tot = numB_tot+num_array_B(sub);
    numC_tot = numC_tot+num_array_C(sub);
    
    xlim([0 1.0]); ylim([0 1.0]);
    xlabel('MRI');
    ylabel('OCM, Mean Square Difference');
    
    if sub==1
        title('S1, run1');
    elseif sub==2
        title('S1, run2');
    elseif sub==3
        title('S2, run1');
    elseif sub==4
        title('S2, run2');
    elseif sub==5
        title('S3, run1');
    end
    %legend({'Before water intake','Shortly after water intake','10 min after water intake'},'Location','northwest','FontSize',8);
    box on;
    set(gcf, 'Color', 'w');
    pbaspect([1 1 1])
    
    %Get subject-specific R-square 
    fit_OCM_sub(sub,:) = [ocm_runA_norm((sub-1)*4+1:sub*4) ocm_runB_norm((sub-1)*5+1:sub*5) ocm_runC_norm((sub-1)*5+1:sub*5)];
    fit_MRI_sub(sub,:) = [mri_runA_norm((sub-1)*4+1:sub*4) mri_runB_norm((sub-1)*5+1:sub*5) mri_runC_norm((sub-1)*5+1:sub*5)];
    mdl_sub = fitlm(fit_MRI_sub(sub,:),fit_OCM_sub(sub,:));
    R2_sub = mdl_sub.Rsquared.Ordinary;
    b_sub = mdl_sub.Coefficients.Estimate(1);
    a_sub = mdl_sub.Coefficients.Estimate(2);
    x_sub = 0:0.1:1;
    y_sub = a_sub*x_sub+b_sub;
    plot(x_sub,y_sub,'Color',[0,0,0]);
    text(0.05,0.9, ['R^2 = ' num2str(R2_sub)],'FontSize',10);
end

subaxis(3,2,6,'SpacingVert',0.07,'SpacingHoriz',0.04);

numA_tot = 0;
numB_tot = 0;
numC_tot = 0;
for sub = 1:num_subject
    scatter(scat_mri_runA(numA_tot+1:numA_tot+num_array_A(sub)),scat_ocm_runA(numA_tot+1:numA_tot+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_mri_runB(numB_tot+1:numB_tot+num_array_B(sub)),scat_ocm_runB(numB_tot+1:numB_tot+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(scat_mri_runC(numC_tot+1:numC_tot+num_array_C(sub)),scat_ocm_runC(numC_tot+1:numC_tot+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    
    numA_tot = numA_tot+num_array_A(sub);
    numB_tot = numB_tot+num_array_B(sub);
    numC_tot = numC_tot+num_array_C(sub);
end

xlim([0 1.0]); ylim([0 1.0]);
plot(x,y,'Color',[0,0,0]);
text(0.05,0.9, ['R^2 = ' num2str(R2)],'FontSize',10);

xlabel('MRI');
ylabel('OCM, Mean Square Difference');
title('All data');
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
%legend({'Before water intake','Shortly after water intake','10 min after water intake'},'Location','southeastoutside','FontSize',8);
export_fig Scatter_EachSubject.png -q101

%Plot_Scatter_Before
Plot_Standardization