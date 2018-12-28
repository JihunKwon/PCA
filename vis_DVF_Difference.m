function []=vis_DVF_Difference(param_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% Modified on 12/27/2018 by Jihun Kwon
% Visualize Box plot and DVF distribution
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

base_name = ('C:\Users\jihun\Documents\MATLAB\PCA');
cd(base_name);
numofsubject = 4;
%param_name = ('trans_subsamp111_maxiter200');
%param_name = ('trans_subsamp221_maxiter200');
%param_name = ('r_c_d');
%param_name = ('r_c_r_c_d');
%param_name = ('r_c_r_d');

%% Calculate average of vector scolar 

for i=1:numofsubject
    if i==1
        subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928'); %Jeremy run1
    elseif i==2
        subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102'); %Jeremy run2
    elseif i==3
        subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102'); %Jihun run1
    elseif i==4
        subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181220'); %Jihun run1
    end
    
    dirname = strcat(subject_name,'\',param_name);
    cd(dirname);
    load('DVF_ave.mat');
    
    %Normal Average
    ave_runA(4*(i-1)+1:4*i) = ave_tot(1:4); %A is before drink water
    ave_runB(5*(i-1)+1:5*i) = ave_tot(5:9); %B is shortly before drink water
    ave_runC(5*(i-1)+1:5*i) = ave_tot(10:14); %C is shortly before drink water
    
    %Root (Absolute scalar)
    ave_runA_root(4*(i-1)+1:4*i) = ave_root(1:4); %A is before drink water
    ave_runB_root(5*(i-1)+1:5*i) = ave_root(5:9); %B is shortly before drink water
    ave_runC_root(5*(i-1)+1:5*i) = ave_root(10:14); %C is shortly before drink water
end

y_min = 0;
y_max = 7;
y_max_root = 7;

%Average
cd(base_name);
figure
ave_all = [ave_runA ave_runB ave_runC];
g = [zeros(1,length(ave_runA)), ones(1,length(ave_runB)), 2*ones(1,length(ave_runC))];
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
set(gcf, 'Color', 'w');
ylim([y_min y_max]);
savename = strcat('Ave_DVF_',param_name,'.tif');
saveas(gcf,savename);
export_fig((savename), '-q101')

%Scalar
figure
ave_all_root = [ave_runA_root ave_runB_root ave_runC_root];
g = [zeros(1,length(ave_runA_root)), ones(1,length(ave_runB_root)), 2*ones(1,length(ave_runC_root))];
boxplot(ave_all_root, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
set(gcf, 'Color', 'w');
ylim([y_min y_max_root]);
savename = strcat('Ave_DVF_root_',param_name,'.tif');
saveas(gcf,savename);
export_fig((savename), '-q101')

%% Draw distribution of averages
x_A=1:4*numofsubject;
x_BC=1:5*numofsubject;

%% Average
figure('Position', [391 1 700 400]);
subplot(1,3,1);
plot(x_A(1:4),ave_runA(1:4),'b-o'); hold on;
plot(x_A(1:4),ave_runA(5:8),'b--o'); hold on;
plot(x_A(1:4),ave_runA(9:12),'r-*');hold on;
plot(x_A(1:4),ave_runA(13:16),'r--*');
title('Before Water');
xlabel('Timepoints');
ylabel('Average of Vector Scalar');
legend({'V1 Run1','V1 Run2','V2 Run1','V2 Run2'},'Location','northeast','FontSize',8);
xlim([1 4]);
xticks([1 2 3 4]);
ylim([y_min y_max]);

subplot(1,3,2);
plot(x_BC(5:9),ave_runB(1:5),'b-o'); hold on;
plot(x_BC(5:9),ave_runB(6:10),'b--o'); hold on;
plot(x_BC(5:9),ave_runB(11:15),'r-*');hold on;
plot(x_BC(5:9),ave_runB(16:20),'r--*');
title('Shortly After Water');
xlabel('Timepoints');
xlim([5 9]);
xticks([5 6 7 8 9]);
ylim([y_min y_max]);

subplot(1,3,3);
plot(x_BC(10:14),ave_runC(1:5),'b-o'); hold on;
plot(x_BC(10:14),ave_runC(6:10),'b--o'); hold on;
plot(x_BC(10:14),ave_runC(11:15),'r-*');hold on;
plot(x_BC(10:14),ave_runC(16:20),'r--*');
title('10 min After Water');
xlabel('Timepoints');
xlim([10 14]);
xticks([10 11 12 13 14]);
ylim([y_min y_max]);
set(gcf, 'Color', 'w');
savename = strcat('Ave_DVF_Dist_',param_name,'.tif');
saveas(gcf,savename);
export_fig((savename), '-q101')

%% Root average (scalar)
figure('Position', [391 1 700 400]);
subplot(1,3,1);
plot(x_A(1:4),ave_runA_root(1:4),'b-o'); hold on;
plot(x_A(1:4),ave_runA_root(5:8),'b--o'); hold on;
plot(x_A(1:4),ave_runA_root(9:12),'r-*');hold on;
plot(x_A(1:4),ave_runA_root(13:16),'r--*');
title('Before Water');
xlabel('Timepoints');
ylabel('Average of Vector Scalar');
legend({'V1 Run1','V1 Run2','V2 Run1','V2 Run2'},'Location','northeast','FontSize',8);
xlim([1 4]);
xticks([1 2 3 4]);
ylim([y_min y_max_root]);

subplot(1,3,2);
plot(x_BC(5:9),ave_runB_root(1:5),'b-o'); hold on;
plot(x_BC(5:9),ave_runB_root(6:10),'b--o'); hold on;
plot(x_BC(5:9),ave_runB_root(11:15),'r-*');hold on;
plot(x_BC(5:9),ave_runB_root(16:20),'r--*');
title('Shortly After Water');
xlabel('Timepoints');
xlim([5 9]);
xticks([5 6 7 8 9]);
ylim([y_min y_max_root]);

subplot(1,3,3);
plot(x_BC(10:14),ave_runC_root(1:5),'b-o'); hold on;
plot(x_BC(10:14),ave_runC_root(6:10),'b--o'); hold on;
plot(x_BC(10:14),ave_runC_root(11:15),'r-*');hold on;
plot(x_BC(10:14),ave_runC_root(16:20),'r--*');
title('10 min After Water');
xlabel('Timepoints');
xlim([10 14]);
xticks([10 11 12 13 14]);
ylim([y_min y_max_root]);
set(gcf, 'Color', 'w');
savename = strcat('Ave_DVF_Dist_root_',param_name,'.tif');
saveas(gcf,savename);
export_fig((savename), '-q101')