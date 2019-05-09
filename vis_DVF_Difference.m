%function []=vis_DVF_Difference(param_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% Modified on 12/27/2018 by Jihun Kwon
% Visualize Box plot and DVF distribution
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

base_name = ('C:\Users\Kwon\Documents\MATLAB\PCA');
cd(base_name);
numofsubject = 5;
%param_name = ('trans_subsamp111_maxiter200');
%param_name = ('trans_subsamp221_maxiter200');
param_name = ('r_c_d');
%param_name = ('r_c_r_d');
%param_name = ('r_c_r_c_d');
%param_name = ('r_d_c');
%% Calculate average of vector scolar 

for i=1:numofsubject
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
    
    %{
    %Normal Average
    mri_runA(4*(i-1)+1:4*i) = ave_tot(1:4); %A is before drink water
    mri_runB(5*(i-1)+1:5*i) = ave_tot(5:9); %B is shortly before drink water
    mri_runC(5*(i-1)+1:5*i) = ave_tot(10:14); %C is shortly before drink water
    %}
    
    %Root (Absolute scalar)
    mri_runA(4*(i-1)+1:4*i) = ave_root(1:4); %A is before drink water
    mri_runB(5*(i-1)+1:5*i) = ave_root(5:9); %B is shortly before drink water
    mri_runC(5*(i-1)+1:5*i) = ave_root(10:14); %C is shortly before drink water
end

A = zeros(3,5*numofsubject);
A(1,1:4*(numofsubject)) = mri_runA;
A(2,:) = mri_runB;
A(3,:) = mri_runC;
filename = 'MRI_DVF_matlab.xlsx';
xlswrite(filename,A,1)

y_min = 0;
y_max = 7;
y_max_root = 10;

%{
%Average
cd(base_name);
figure
ave_all = [mri_runA mri_runB mri_runC];
g = [zeros(1,length(mri_runA)), ones(1,length(mri_runB)), 2*ones(1,length(mri_runC))];
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
set(gcf, 'Color', 'w');
ylim([y_min y_max]);
savename = strcat('Ave_DVF_',param_name,'.png');
saveas(gcf,savename);
export_fig((savename), '-q101')
%}

cd(base_name)

%Scalar
figure
ave_all_root = [mri_runA mri_runB mri_runC];
g = [zeros(1,length(mri_runA)), ones(1,length(mri_runB)), 2*ones(1,length(mri_runC))];
boxplot(ave_all_root, g,'Labels',{'Befor water intake','Shortly after water intake','10 min after water intake'});
ylabel('Average of Vector Scalar');
set(gcf, 'Color', 'w');
ylim([y_min y_max_root]);
savename = strcat('Ave_DVF_root_',param_name,'.png');
saveas(gcf,savename);
export_fig((savename), '-q101')

%% Draw distribution of averages
x_A=1:4*numofsubject;
x_BC=1:5*numofsubject;

%% Root average (scalar)
figure('Position', [391 1 700 400]);
subplot(1,3,1);
plot(x_A(1:4),mri_runA(1:4),'b-o'); hold on;
plot(x_A(1:4),mri_runA(5:8),'b--o'); hold on;
plot(x_A(1:4),mri_runA(9:12),'r-*');hold on;
plot(x_A(1:4),mri_runA(13:16),'r--*'); hold on;
plot(x_A(1:4),mri_runA(17:20),'g-s'); hold on;
plot(x_A(1:4),mri_runA(21:24),'g--s');
title('Before Water Intake');
xlabel('Timepoints');
ylabel('Average of Vector Scalar');
legend({'S1 Run1','S1 Run2','S2 Run1','S2 Run2','S3 Run1','S3 Run2'},'Location','northeast','FontSize',8);
xlim([1 4]);
xticks([1 2 3 4]);
ylim([y_min y_max_root]);

subplot(1,3,2);
plot(x_BC(5:9),mri_runB(1:5),'b-o'); hold on;
plot(x_BC(5:9),mri_runB(6:10),'b--o'); hold on;
plot(x_BC(5:9),mri_runB(11:15),'r-*');hold on;
plot(x_BC(5:9),mri_runB(16:20),'r--*'); hold on;
plot(x_BC(5:9),mri_runB(21:25),'g-s'); hold on;
plot(x_BC(5:9),mri_runB(26:30),'g--s');
title('Shortly After Water Intake');
xlabel('Timepoints');
xlim([5 9]);
xticks([5 6 7 8 9]);
ylim([y_min y_max_root]);

subplot(1,3,3);
plot(x_BC(10:14),mri_runC(1:5),'b-o'); hold on;
plot(x_BC(10:14),mri_runC(6:10),'b--o'); hold on;
plot(x_BC(10:14),mri_runC(11:15),'r-*');hold on;
plot(x_BC(10:14),mri_runC(16:20),'r--*');hold on;
plot(x_BC(10:14),mri_runC(21:25),'g-s');hold on;
plot(x_BC(10:14),mri_runC(26:30),'g--s');
title('10 min After Water Intake');
xlabel('Timepoints');
xlim([10 14]);
xticks([10 11 12 13 14]);
ylim([y_min y_max_root]);
set(gcf, 'Color', 'w');
savename = strcat('Ave_DVF_Dist_root_',param_name,'.png');
saveas(gcf,savename);
export_fig((savename), '-q101')