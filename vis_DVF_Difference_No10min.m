%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% Modified on 12/27/2018 by Jihun Kwon
% Visualize Box plot and DVF distribution except 10min after water intake
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

base_name = ('C:\Users\Kwon\Documents\MATLAB\PCA');
cd(base_name);
num_subject = 6;
param_name = ('r_c_d');

% Import OCM data
ocm_runA = zeros(1,num_subject*3);
ocm_runB = zeros(1,num_subject*3);

cd('C:\Users\Kwon\Documents\Panc_OCM');
mean_square_diff = zeros(30,num_subject);
mean_square_diff = xlsread('DataForFigures_300_650FOV_inv_corrected.xlsx',1);
cd('C:\Users\Kwon\Documents\MATLAB\PCA\OCM_Analysis');

for sub = 1:num_subject
    ocm_runA(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,3+(sub-1)*3); %Before water
    ocm_runB(1+(sub-1)*5:sub*5) = mean_square_diff(26:30,4+(sub-1)*3); %Shortly after water
end

%% Calculate average of vector scolar 
for i=1:num_subject
    if i==1
        subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928'); %JB run1
    elseif i==2
        subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102'); %JB run2
    elseif i==3
        subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102'); %JK run1
    elseif i==4
        subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220'); %JK run2
    elseif i==5
        subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228'); %NV run1
    elseif i==6
        subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320'); %NV run2
    end
    
    dirname = strcat(subject_name,'\',param_name);
    cd(dirname);
    load('DVF_ave.mat');
    load('DVF_hist_thr.mat');
    
    mri_runA(4*(i-1)+1:4*i) = data_xyz_thr_per(1:4); %A is before drink water
    mri_runB(5*(i-1)+1:5*i) = data_xyz_thr_per(5:9); %B is shortly before drink water
end

A = zeros(3,5*num_subject);
A(1,1:4*(num_subject)) = mri_runA;
A(2,:) = mri_runB;
filename = 'MRI_DVF_matlab.xlsx';
xlswrite(filename,A,1)

y_min = 0;
y_max = 7;
y_max_mri = 100;

cd(base_name)

%Percentage number of voxels which scalar is greater than the threshold 
figure
ave_all_root = [mri_runA mri_runB];
g = [zeros(1,length(mri_runA)), ones(1,length(mri_runB))];
boxplot(ave_all_root, g,'Labels',{'State 1','State 2'});
ylabel('Relative number of voxels (%)');
set(gcf, 'Color', 'w');
ylim([y_min y_max_mri]);
export_fig Ave_DVF_root_relative.png -q101
export_fig Ave_DVF_root_relative.pdf

%% Plot OCM and MRI figures together
xtl_time = {{'State 1'} {'State 2'}};

%number of datapoints
num_A = 4;
num_B = 5;

s1r1 = num_subject*4;
s1r2 = num_subject*4;
s2r1 = num_subject*4;
s2r2 = num_subject*4;
s3r1 = num_subject*4;
s3r2 = num_subject*4;

%% Remove first scan of each run in OCM
%First scan of each run has to be removed to match with MRI.
if (size(ocm_runA,2)==num_subject*5)
    for i = 5*num_subject:-1:1 %To maintain arrays, has to scan from end to start
        if rem(i,5) == 1
            ocm_runA(i) = [];
        end
    end
end
%Manually define outliers here (outlier is detected from Box and whiskers plot)
outlier_A = [];
outlier_B = [];
outlier_C = [];

%Update subject datapoint number. manually change subtract value
s1r1A = num_A; s1r1B = num_B;
s1r2A = num_A; s1r2B = num_B;
s2r1A = num_A; s2r1B = num_B;
s2r2A = num_A; s2r2B = num_B;
s3r1A = num_A; s3r1B = num_B;
s3r2A = num_A; s3r2B = num_B;

%Each subject, number of data points left.
num_array_A = [s1r1A,s1r2A,s2r1A,s2r2A,s3r1A,s3r2A];
num_array_B = [s1r1B,s1r2B,s2r1B,s2r2B,s3r1B,s3r2B];

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

%% Get mean and max of OCM and MRI
ave_ocm_runA = mean(ocm_runA);
ave_ocm_runB = mean(ocm_runB);

max_mri_abc = [max(mri_runA(:)) max(mri_runB(:))];
max_ocm_abc = [max(ocm_runA(:)) max(ocm_runB(:))];
max_mri = max(max_mri_abc);
max_ocm = max(max_ocm_abc(:));

% Devide by maximum of whole measurement
mri_runA_norm = mri_runA/max_mri;
mri_runB_norm = mri_runB/max_mri;
ocm_runA_norm = ocm_runA/max_ocm;
ocm_runB_norm = ocm_runB/max_ocm;

%% Plot Box plots. OCM and MRI together
%Normalized for maximum subject
ave_all_mri = [mri_runA_norm mri_runB_norm];
ave_all_ocm = [ocm_runA_norm ocm_runB_norm];

g_mri = [zeros(1,length(mri_runA)), ones(1,length(mri_runB))];
g_ocm = [zeros(1,length(ocm_runA)), ones(1,length(ocm_runB))];

figure('Position', [391 100 600 300]);
subaxis(1,2,1,'SpacingHoriz',0.1,'MR',0,'MarginBottom',0.1);
boxplot(ave_all_ocm, g_ocm);
ylabel('Mean Square Difference');
title('OCM');
h = my_xticklabels(gca,[1 2],xtl_time);
set(gcf, 'Color', 'w');
ylim([0 1.1]);

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0.01,'MarginBottom',0.1);
boxplot(ave_all_mri, g_mri);
ylabel('Relative number of voxels');
title('MRI');
h = my_xticklabels(gca,[1 2],xtl_time);
ylim([0 1.1]);
set(gcf, 'Color', 'w');
saveas(gcf,'BoxPlots.png')
%export_fig('BoxPlots', '-png', '-pdf', '-nocrop')

%% Statistical Significancy
%F-test
%h = vartest2(ocm_runA,ocm_runB);

%Un-paired t-test 
% mri_runA vs mri_runB, 
[h_mri_23,p_mri_23] = ttest2(mri_runA,mri_runB);
[h_ocm_23,p_ocm_23] = ttest2(ocm_runA,ocm_runB);
ave_ocm_runA_norm = mean(ocm_runA_norm);
ave_ocm_runB_norm = mean(ocm_runB_norm);
ave_mri_runA_norm = mean(mri_runA_norm);
ave_mri_runB_norm = mean(mri_runB_norm);
sd_ocm_runA_norm = std(ocm_runA_norm);
sd_ocm_runB_norm = std(ocm_runB_norm);
sd_mri_runA_norm = std(mri_runA_norm);
sd_mri_runB_norm = std(mri_runB_norm);

%% Plot distribution
%Draw distribution of averages
x_A=1:4*num_subject;
x_B=1:5*num_subject;

%% MRI DVF Distribution
figure('Position', [391 10 450 450]);
font_size=11;
subaxis(1,2,1,'SpacingHoriz',0.05,'MR',0.1,'ML',0.12,'MB',0.1);
plot(x_A(1:4),mri_runA(1:4),'LineStyle','-','Color',[0 0 1],'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
plot(x_A(1:4),mri_runA(5:8),'LineStyle','--','Color',[0 0 1],'Marker','o'); hold on;
plot(x_A(1:4),mri_runA(9:12),'LineStyle','-','Color',[1 0 0],'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
plot(x_A(1:4),mri_runA(13:16),'LineStyle','--','Color',[1 0 0],'Marker','s'); hold on;
plot(x_A(1:4),mri_runA(17:20),'LineStyle','-','Color',[0 0.6 0],'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
plot(x_A(1:4),mri_runA(21:24),'LineStyle','--','Color',[0 0.6 0],'Marker','^'); hold on;
title('State 1','FontSize',font_size);
legend({'Subject1 exp1','Subject1 exp2','Subject2 exp1','Subject2 exp2','Subject3 exp1','Subject3 exp2'} ... 
    ,'Location','northeast','FontSize',9);
xticks([1 2 3 4]);
xticklabels({'2','3','4','5'})
xlim([1 4]);
ylim([0 80]);
xlabel('Breath holds');
ylabel('Relative number of voxels (%)');
ax = gca; 
ax.FontSize = 10;
grid on;

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0.05);
plot(x_B(5:9),mri_runB(1:5),'LineStyle','-','Color',[0 0 1],'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
plot(x_B(5:9),mri_runB(6:10),'LineStyle','--','Color',[0 0 1],'Marker','o'); hold on;
plot(x_B(5:9),mri_runB(11:15),'LineStyle','-','Color',[1 0 0],'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
plot(x_B(5:9),mri_runB(16:20),'LineStyle','--','Color',[1 0 0],'Marker','s'); hold on;
plot(x_B(5:9),mri_runB(21:25),'LineStyle','-','Color',[0 0.6 0],'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
plot(x_B(5:9),mri_runB(26:30),'LineStyle','--','Color',[0 0.6 0],'Marker','^'); hold on;
title('State 2','FontSize',font_size);
xlabel('Breath holds');
xlim([5 9]);
xticks([5 6 7 8 9]);
xticklabels({'6','7','8','9','10'})
ylim([0 80]);
xlabel('Breath holds'); 
ax = gca; 
ax.FontSize = 10;
set(gcf, 'Color', 'w');
grid on;
export_fig Dist_DVF.png -q101
export_fig Dist_DVF.pdf
export_fig Fig4.png


%% OCM Distribution
y_max_ocm = 0.05;

figure('Position', [391 10 465 450]);
font_size=11;
subaxis(1,2,1,'SpacingHoriz',0.05,'MR',0.1,'ML',0.15,'MB',0.1);
plot(x_A(1:4),ocm_runA(1:4),'LineStyle','-','Color',[0 0 1],'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
plot(x_A(1:4),ocm_runA(5:8),'LineStyle','--','Color',[0 0 1],'Marker','o'); hold on;
plot(x_A(1:4),ocm_runA(9:12),'LineStyle','-','Color',[1 0 0],'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
plot(x_A(1:4),ocm_runA(13:16),'LineStyle','--','Color',[1 0 0],'Marker','s'); hold on;
plot(x_A(1:4),ocm_runA(17:20),'LineStyle','-','Color',[0 0.6 0],'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
plot(x_A(1:4),ocm_runA(21:24),'LineStyle','--','Color',[0 0.6 0],'Marker','^'); hold on;
title('State 1','FontSize',font_size);
legend({'Subject1 exp1','Subject1 exp2','Subject2 exp1','Subject2 exp2','Subject3 exp1','Subject3 exp2'} ... 
    ,'Location','northeast','FontSize',9);
xticks([1 2 3 4]);
xticklabels({'2','3','4','5'})
xlim([1 4]);
ylim([y_min y_max_ocm]);
xlabel('Breath holds');
ylabel('Mean Square Difference (a.u.)');
ax = gca; 
ax.FontSize = 10;
grid on;

subaxis(1,2,2,'SpacingHoriz',0.1,'MR',0.05);
plot(x_B(5:9),ocm_runB(1:5),'LineStyle','-','Color',[0 0 1],'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
plot(x_B(5:9),ocm_runB(6:10),'LineStyle','--','Color',[0 0 1],'Marker','o'); hold on;
plot(x_B(5:9),ocm_runB(11:15),'LineStyle','-','Color',[1 0 0],'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
plot(x_B(5:9),ocm_runB(16:20),'LineStyle','--','Color',[1 0 0],'Marker','s'); hold on;
plot(x_B(5:9),ocm_runB(21:25),'LineStyle','-','Color',[0 0.6 0],'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
plot(x_B(5:9),ocm_runB(26:30),'LineStyle','--','Color',[0 0.6 0],'Marker','^'); hold on;
title('State 2','FontSize',font_size);
xlabel('Breath holds');
xlim([5 9]);
xticks([5 6 7 8 9]);
xticklabels({'6','7','8','9','10'})
ylim([y_min y_max_ocm]);
ax = gca; 
ax.FontSize = 10;
set(gcf, 'Color', 'w');
grid on;
export_fig Dist_OCM.png -q101
export_fig Dist_OCM.pdf
export_fig Fig5.png