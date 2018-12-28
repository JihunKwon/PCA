function []=Crop_DVF(subject_name,param_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.1
% Modified on 12/27/2018 by Jihun Kwon
% This code reshape x,y,z of DVF into 4D matrix. This allows us to handle 
% DVF as same matrix with MATLAB. Crop DVF with body-surface or user-specified 
% region save "DVF_ave.mat"
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Crop dicom before applying DIR.
%close all
%clear

x_S = 46; %top to bottom
y_S = 54; %left to right
z_S = 20;

x_L = 84; %top to bottom
y_L = 100; %left to right
z_L = 40;

%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181220');

%param_name = ('trans_subsamp111_maxiter200');
%param_name = ('trans_subsamp221_maxiter200');
%param_name = ('r_c_d');
%param_name = ('r_c_r_c_d');
%param_name = ('r_c_r_d');

dirname = strcat(subject_name,'\',param_name);
cd(dirname);

load('param_DVF_xyz.mat');

%% rearrange data 9984000*1 -> 260*320*120
n=1;
scale=1;

if strcmp(param_name,'r_c_d') || strcmp(param_name,'r_c_r_d')
    data_x_new = reshape(data_x, [x_L,y_L,z_L,14]);
    data_y_new = reshape(data_y, [x_L,y_L,z_L,14]);
    data_z_new = reshape(data_z, [x_L,y_L,z_L,14]);
elseif strcmp(param_name,'r_c_r_c_d')
    data_x_new = reshape(data_x, [x_S,y_S,z_S,14]);
    data_y_new = reshape(data_y, [x_S,y_S,z_S,14]);
    data_z_new = reshape(data_z, [x_S,y_S,z_S,14]);
else %No Cropping
    if strcmp(subject_name,'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102')
        data_x_new = reshape(data_x, [320,220,120,14]); %v2run1, V1R2:[320,220,120,14]
        data_y_new = reshape(data_y, [320,220,120,14]);
        data_z_new = reshape(data_z, [320,220,120,14]);
    else
        data_x_new = reshape(data_x, [320,260,120,14]); %V1R1:[320,260,120,14]
        data_y_new = reshape(data_y, [320,260,120,14]);
        data_z_new = reshape(data_z, [320,260,120,14]);
    end
end

%Swap 1st and 2nd dimensions
data_x_new = permute(data_x_new,[2,1,3,4]);
data_y_new = permute(data_y_new,[2,1,3,4]);
data_z_new = permute(data_z_new,[2,1,3,4]);

%% Apply DVF to body surface segmentation
%{
[seg_body] = nrrdread2('Output volume_deform_15-label.nrrd');

for time = 1:14
    data_x_new(:,:,:,time) = data_x_new(:,:,:,time).*seg_body(:,:,:);
    data_y_new(:,:,:,time) = data_y_new(:,:,:,time).*seg_body(:,:,:);
    data_z_new(:,:,:,time) = data_z_new(:,:,:,time).*seg_body(:,:,:);
%     data_x_seg(:,:,:,time) = data_x_new(:,:,:,time).*seg_body(:,:,:);
%     data_y_seg(:,:,:,time) = data_y_new(:,:,:,time).*seg_body(:,:,:);
%     data_z_seg(:,:,:,time) = data_z_new(:,:,:,time).*seg_body(:,:,:);
end
%}
%% Calculate Average
sum_x = zeros(14,1);
sum_y = zeros(14,1);
sum_z = zeros(14,1);

data_x_new = abs(data_x_new);
data_y_new = abs(data_y_new);
data_z_new = abs(data_z_new);

for i=1:14
    sum_x(i) = sum(sum(sum(data_x_new(:,:,:,i))));
    sum_y(i) = sum(sum(sum(data_y_new(:,:,:,i))));
    sum_z(i) = sum(sum(sum(data_z_new(:,:,:,i))));
end 

ave_x = sum_x / size(data_x,1);
ave_y = sum_y / size(data_x,1);
ave_z = sum_z / size(data_x,1);

ave_tot = (ave_x + ave_y + ave_z)/3;
ave_root = (ave_x.^2 + ave_y.^2 + ave_z.^2).^0.5;
save(strcat('DVF_ave.mat'),'ave_tot','ave_root');