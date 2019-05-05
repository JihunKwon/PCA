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

% x_S = 46; %top to bottom
% y_S = 54; %left to right
% z_S = 20;

% x_L = 84; %top to bottom
% y_L = 110; %left to right
% z_L = 36;

x_L = 84; %anterior to posterior
y_L = 146; %left to right
z_L = 55; %Cranior Caudal

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
    data_x_new = reshape(data_x, [x_L,y_L,z_L,14]);
    data_y_new = reshape(data_y, [x_L,y_L,z_L,14]);
    data_z_new = reshape(data_z, [x_L,y_L,z_L,14]);
elseif strcmp(param_name,'r_c_r_c_d')
    data_x_new = reshape(data_x, [x_S,y_S,z_S,14]);
    data_y_new = reshape(data_y, [x_S,y_S,z_S,14]);
    data_z_new = reshape(data_z, [x_S,y_S,z_S,14]);
elseif (strcmp(param_name,'r_d_c'))
    data_x_raw = reshape(data_x, [x_init,y_init,z_init,4]); %First import to original (before cropping) size
    data_y_raw = reshape(data_y, [x_init,y_init,z_init,4]);
    data_z_raw = reshape(data_z, [x_init,y_init,z_init,4]);
    
    %Next crop the DVF
    center_L = get_ROIcenter(subject_name);
    
    for i = 1:size(data_x_raw,4)
        data_x_new(:,:,:,i) = data_x_raw(center_L(1)+x_init/2-x_L/2 : center_L(1)+x_init/2+x_L/2 -1, ...
                                            center_L(2)+y_init/2-y_L/2 : center_L(2)+y_init/2+y_L/2 -1, ...
                                            center_L(3)+z_init/2-z_L/2 : center_L(3)+z_init/2+z_L/2 -1, i);
                                        
        data_y_new(:,:,:,i) = data_y_raw(center_L(1)+x_init/2-x_L/2 : center_L(1)+x_init/2+x_L/2 -1, ...
                                            center_L(2)+y_init/2-y_L/2 : center_L(2)+y_init/2+y_L/2 -1, ...
                                            center_L(3)+z_init/2-z_L/2 : center_L(3)+z_init/2+z_L/2 -1, i);
                                        
        data_z_new(:,:,:,i) = data_z_raw(center_L(1)+x_init/2-x_L/2 : center_L(1)+x_init/2+x_L/2 -1, ...
                                            center_L(2)+y_init/2-y_L/2 : center_L(2)+y_init/2+y_L/2 -1, ...
                                            center_L(3)+z_init/2-z_L/2 : center_L(3)+z_init/2+z_L/2 -1, i);
    end
    
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