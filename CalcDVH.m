%Calculate DVH
clear

dirname = 'C:\Users\jihun\Documents\MATLAB\PCA\DVH';
cd(dirname);

filename = 'DVH_s1_run1_Lv1_pre.txt';
delimiterIn = ' ';
headerlinesIn = 1;
%filename = 'test.txt';
A = importdata(filename);