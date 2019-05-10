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
% x_L = 84; %anterior to posterior
% y_L = 146; %left to right
% z_L = 55; %Cranior Caudal
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size

if strcmp(param_name, 'r_d_c')
    x_L = 84; %top to bottom
    y_L = 110; %left to right
    z_L = 28;
    
    x_init = 260;
    y_init = 320;
    z_init = 120;
    if (strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102') || ...
            strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228'))
        x_init = 220;
        y_init = 320;
        z_init = 120;
    end
end

dirname = strcat(subject_name,'\',param_name);
cd(dirname);

load('param_DVF_xyz.mat');

%% rearrange data 9984000*1 -> 260*320*120
n=1;
scale=1;

if strcmp(param_name,'r_c_d') || strcmp(param_name,'r_c_r_d')
    data_x_new = reshape(data_x, [y_L,x_L,z_L,14]); %Notice X and Y is swapped here
    data_y_new = reshape(data_y, [y_L,x_L,z_L,14]);
    data_z_new = reshape(data_z, [y_L,x_L,z_L,14]);
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

%Swap 1st and 2nd dimensions (Why do I need to do this?)
data_x_new = permute(data_x_new,[2,1,3,4]); %new order: [LR(146), AP(84), SI(55), time(14)] 
data_y_new = permute(data_y_new,[2,1,3,4]);
data_z_new = permute(data_z_new,[2,1,3,4]);

%[data_x_new_g,data_y_new_g,data_z_new_g] = filt_DVF_XYZ(data_x_new,data_y_new,data_z_new);

%% Calculate Average
sum_x = zeros(14,1);
sum_y = zeros(14,1);
sum_z = zeros(14,1);

data_x_new = abs(data_x_new);
data_y_new = abs(data_y_new);
data_z_new = abs(data_z_new);

%Filtered data
% data_x_new = abs(data_x_new_g);
% data_y_new = abs(data_y_new_g);
% data_z_new = abs(data_z_new_g);

for i=1:14
    sum_x(i) = sum(sum(sum(data_x_new(:,:,:,i))));
    sum_y(i) = sum(sum(sum(data_y_new(:,:,:,i))));
    sum_z(i) = sum(sum(sum(data_z_new(:,:,:,i))));
end 

ave_x = sum_x / size(data_x,1); %Devide by the number of voxel in the entire ROI
ave_y = sum_y / size(data_x,1);
ave_z = sum_z / size(data_x,1);

ave_tot = (ave_x + ave_y + ave_z)/3;
ave_root = (ave_x.^2 + ave_y.^2 + ave_z.^2).^0.5;
save(strcat('DVF_ave.mat'),'ave_tot','ave_root');