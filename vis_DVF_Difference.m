clear;
close all;

param_name = ('trans_subsamp111_maxiter200');
%param_name = ('trans_subsamp221_maxiter200');
%param_name = ('r_c_d');
%param_name = ('r_c_r_c_d');

%% Calculate average of vector scolar 
subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928'); %Jeremy run1
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('DVF_ave.mat');
ave_runA(1:4) = ave_tot(1:4); %A is before drink water
ave_runB(1:5) = ave_tot(5:9); %B is shortly before drink water
ave_runC(1:5) = ave_tot(10:14); %C is shortly before drink water

subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102'); %Jeremy run2
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('DVF_ave.mat');
ave_runA(5:8) = ave_tot(1:4); %A is before drink water
ave_runB(6:10) = ave_tot(5:9); %B is shortly before drink water
ave_runC(6:10) = ave_tot(10:14); %C is shortly before drink water

subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102'); %Jihun run1
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('DVF_ave.mat');
ave_runA(9:12) = ave_tot(1:4); %A is before drink water
ave_runB(11:15) = ave_tot(5:9); %B is shortly before drink water
ave_runC(11:15) = ave_tot(10:14); %C is shortly before drink water

ave_all = [ave_runA ave_runB ave_runC];
g = [zeros(1,length(ave_runA)), ones(1,length(ave_runB)), 2*ones(1,length(ave_runC))];
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
set(gcf, 'Color', 'w');
cd ..
cd ..
saveas(gcf,strcat('Ave_DVF.pdf'));
export_fig Ave_DVF.tif -q101

%% Draw distribution of averages
x_A=1:12;
x_BC=1:15;
y_min = 0;
y_max = 5;

figure('Position', [391 1 700 400]);
subplot(1,3,1);
plot(x_A(1:4),ave_runA(1:4),'-o'); hold on;
plot(x_A(1:4),ave_runA(5:8),'-*'); hold on;
plot(x_A(1:4),ave_runA(9:12),'-s');
title('Before Water');
xlabel('Timepoints');
ylabel('Average of Vector Scalar');
legend({'V1 Run1','V1 Run2','V2 Run1'},'Location','northeast','FontSize',8);
xlim([1 4]);
xticks([1 2 3 4]);
ylim([y_min y_max]);

subplot(1,3,2);
plot(x_BC(5:9),ave_runB(1:5),'-o'); hold on;
plot(x_BC(5:9),ave_runB(6:10),'-*'); hold on;
plot(x_BC(5:9),ave_runB(11:15),'-s');
title('Shortly After Water');
xlabel('Timepoints');
xlim([5 9]);
xticks([5 6 7 8 9]);
ylim([y_min y_max]);

subplot(1,3,3);
plot(x_BC(10:14),ave_runC(1:5),'-o'); hold on;
plot(x_BC(10:14),ave_runC(6:10),'-*'); hold on;
plot(x_BC(10:14),ave_runC(11:15),'-s');
title('10 min After Water');
xlabel('Timepoints');
xlim([10 14]);
xticks([10 11 12 13 14]);
ylim([y_min y_max]);
set(gcf, 'Color', 'w');
saveas(gcf,strcat('Ave_DVF_Dist.pdf'));
export_fig Ave_DVF_Dist.tif -q101

%{
%% When R1V1 removed
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102');
cd(dirname);
load('DVF_ave.mat');
ave_run1(1:4) = ave_tot(1:4); %A is before drink water
ave_run2(1:5) = ave_tot(5:9); %B is shortly before drink water
ave_run3(1:5) = ave_tot(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102');
cd(dirname);
load('DVF_ave.mat');
ave_run1(5:8) = ave_tot(1:4); %A is before drink water
ave_run2(6:10) = ave_tot(5:9); %B is shortly before drink water
ave_run3(6:10) = ave_tot(10:14); %C is shortly before drink water

ave_all = [ave_run1 ave_run2 ave_run3];
g = [zeros(1,length(ave_run1)), ones(1,length(ave_run2)), 2*ones(1,length(ave_run3))];
figure;
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
title('V1 Run1 Removed');
set(gcf, 'Color', 'w');
cd ..
saveas(gcf,strcat('Ave_DVF_nov1r1.pdf'));
export_fig Ave_DVF_nov1r1.pdf -q101
saveas(gcf,strcat('Ave_DVF_nov1r1.eps'));
%export_fig Ave_DVF_nov1r1.eps -q101
%}