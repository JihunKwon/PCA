clear;
close all;
%% Calculate average of vector scolar 
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run1');
cd(dirname);
load('DVF_ave.mat');
ave_A(1:4) = ave_tot(1:4); %A is before drink water
ave_B(1:5) = ave_tot(5:9); %B is shortly before drink water
ave_C(1:5) = ave_tot(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
cd(dirname);
load('DVF_ave.mat');
ave_A(5:8) = ave_tot(1:4); %A is before drink water
ave_B(6:10) = ave_tot(5:9); %B is shortly before drink water
ave_C(6:10) = ave_tot(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');
cd(dirname);
load('DVF_ave.mat');
ave_A(9:12) = ave_tot(1:4); %A is before drink water
ave_B(11:15) = ave_tot(5:9); %B is shortly before drink water
ave_C(11:15) = ave_tot(10:14); %C is shortly before drink water

ave_all = [ave_A ave_B ave_C];
g = [zeros(1,length(ave_A)), ones(1,length(ave_B)), 2*ones(1,length(ave_C))];
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
cd ..
saveas(gcf,strcat('Ave_DVF.pdf'));

%% Draw distribution of averages
x_A=1:12;
x_BC=1:15;
y_min = 0;
y_max = 5;

figure('Position', [391 1 700 400]);
subplot(1,3,1);
plot(x_A(1:4),ave_A(1:4),'-o'); hold on;
plot(x_A(1:4),ave_A(5:8),'-*'); hold on;
plot(x_A(1:4),ave_A(9:12),'-s');
title('Before Water');
xlabel('Timepoints');
ylabel('Average of Vector Scalar');
legend({'V1 Run1','V2 Run1','V1 Run2'},'Location','northeast','FontSize',8);
xlim([1 4]);
xticks([1 2 3 4]);
ylim([y_min y_max]);

subplot(1,3,2);
plot(x_BC(5:9),ave_B(1:5),'-o'); hold on;
plot(x_BC(5:9),ave_B(6:10),'-*'); hold on;
plot(x_BC(5:9),ave_B(11:15),'-s');
title('Shortly After Water');
xlabel('Timepoints');
xlim([5 9]);
xticks([5 6 7 8 9]);
ylim([y_min y_max]);

subplot(1,3,3);
plot(x_BC(10:14),ave_C(1:5),'-o'); hold on;
plot(x_BC(10:14),ave_C(6:10),'-*'); hold on;
plot(x_BC(10:14),ave_C(11:15),'-s');
title('10 min After Water');
xlabel('Timepoints');
xlim([10 14]);
xticks([10 11 12 13 14]);
ylim([y_min y_max]);

saveas(gcf,strcat('Ave_DVF_Dist.pdf'));

%% When R1V1 removed
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
cd(dirname);
load('DVF_ave.mat');
ave_A(1:4) = ave_tot(1:4); %A is before drink water
ave_B(1:5) = ave_tot(5:9); %B is shortly before drink water
ave_C(1:5) = ave_tot(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');
cd(dirname);
load('DVF_ave.mat');
ave_A(5:8) = ave_tot(1:4); %A is before drink water
ave_B(6:10) = ave_tot(5:9); %B is shortly before drink water
ave_C(6:10) = ave_tot(10:14); %C is shortly before drink water

ave_all = [ave_A ave_B ave_C];
g = [zeros(1,length(ave_A)), ones(1,length(ave_B)), 2*ones(1,length(ave_C))];
figure;
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
title('V1 Run1 Removed');
cd ..
saveas(gcf,strcat('Ave_DVF_nov1r1.pdf'));


%{
clear;
close all;
%% Calculate average of vector scolar 
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run1');
cd(dirname);
load('DVF_diff.mat');
ave_A(1:4) = ave(1:4); %A is before drink water
ave_B(1:5) = ave(5:9); %B is shortly before drink water
ave_C(1:5) = ave(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
cd(dirname);
load('DVF_diff.mat');
ave_A(5:8) = ave(1:4); %A is before drink water
ave_B(6:10) = ave(5:9); %B is shortly before drink water
ave_C(6:10) = ave(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');
cd(dirname);
load('DVF_diff.mat');
ave_A(9:12) = ave(1:4); %A is before drink water
ave_B(11:15) = ave(5:9); %B is shortly before drink water
ave_C(11:15) = ave(10:14); %C is shortly before drink water

ave_all = [ave_A ave_B ave_C];
g = [zeros(1,length(ave_A)), ones(1,length(ave_B)), 2*ones(1,length(ave_C))];
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
cd ..
saveas(gcf,strcat('Ave_DVF_totalbody.pdf'));

%% Draw distribution of averages
x_A=1:12;
x_BC=1:15;
y_min = 0;
y_max = 7;

figure('Position', [391 1 700 400]);
subplot(1,3,1);
plot(x_A(1:4),ave_A(1:4),'-o'); hold on;
plot(x_A(1:4),ave_A(5:8),'-*'); hold on;
plot(x_A(1:4),ave_A(9:12),'-s');
title('Before Water');
xlabel('Timepoints');
ylabel('Average of Vector Scalar');
legend({'V1 Run1','V2 Run1','V1 Run2'},'Location','northeast','FontSize',8);
xlim([1 4]);
xticks([1 2 3 4]);
ylim([y_min y_max]);

subplot(1,3,2);
plot(x_BC(5:9),ave_B(1:5),'-o'); hold on;
plot(x_BC(5:9),ave_B(6:10),'-*'); hold on;
plot(x_BC(5:9),ave_B(11:15),'-s');
title('Shortly After Water');
xlabel('Timepoints');
xlim([5 9]);
xticks([5 6 7 8 9]);
ylim([y_min y_max]);

subplot(1,3,3);
plot(x_BC(10:14),ave_C(1:5),'-o'); hold on;
plot(x_BC(10:14),ave_C(6:10),'-*'); hold on;
plot(x_BC(10:14),ave_C(11:15),'-s');
title('10 min After Water');
xlabel('Timepoints');
xlim([10 14]);
xticks([10 11 12 13 14]);
ylim([y_min y_max]);

saveas(gcf,strcat('Ave_DVF_Dist_totalbody.pdf'));

%% When R1V1 removed
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
cd(dirname);
load('DVF_diff.mat');
ave_A(1:4) = ave(1:4); %A is before drink water
ave_B(1:5) = ave(5:9); %B is shortly before drink water
ave_C(1:5) = ave(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');
cd(dirname);
load('DVF_diff.mat');
ave_A(5:8) = ave(1:4); %A is before drink water
ave_B(6:10) = ave(5:9); %B is shortly before drink water
ave_C(6:10) = ave(10:14); %C is shortly before drink water

ave_all = [ave_A ave_B ave_C];
g = [zeros(1,length(ave_A)), ones(1,length(ave_B)), 2*ones(1,length(ave_C))];
figure;
boxplot(ave_all, g,'Labels',{'Befor Water','Shortly After Water','10 min After Water'});
ylabel('Average of Vector Scalar');
title('V1 Run1 Removed');
cd ..
saveas(gcf,strcat('Ave_DVF_nov1r1_totalbody.pdf'));
%}

