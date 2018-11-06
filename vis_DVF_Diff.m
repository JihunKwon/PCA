
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run1');
load('DVF_diff.mat');
ave_A(1:4) = ave_x(1:4); %A is before drink water
ave_B(1:5) = ave_x(5:9); %B is shortly before drink water
ave_C(1:5) = ave_x(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
ave_A(5:8) = ave_x(1:4); %A is before drink water
ave_B(6:10) = ave_x(5:9); %B is shortly before drink water
ave_C(6:10) = ave_x(10:14); %C is shortly before drink water

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');
ave_A(9:12) = ave_x(1:4); %A is before drink water
ave_B(11:15) = ave_x(5:9); %B is shortly before drink water
ave_C(11:15) = ave_x(10:14); %C is shortly before drink water

%boxplot([ave_A,ave_B,ave_C]);

ave_all = [ave_A ave_B ave_C];
g = [zeros(1,length(ave_A)), ones(1,length(ave_B)), 2*ones(1,length(ave_C))];
boxplot(ave_all, g,'Labels',{'A','B','C'});
xlabel('Time Points');
ylabel('Average of Vector Scalar');
cd ..
saveas(gcf,strcat('Ave_DCF_Diff.pdf'));