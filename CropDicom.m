%Crop dicom before applying DIR.
close all
clear
%dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run1');
%dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');
cd(dirname);

load('param_DVF_xyz.mat');


%% rearrange data 9984000*1 -> 260*320*120
n=1;
scale=1;
data_x_new = reshape(data_x, [320,260,120,14]); %V1R1:[320,260,120,14], V1R2:[320,220,120,14]
data_y_new = reshape(data_y, [320,260,120,14]);
data_z_new = reshape(data_z, [320,260,120,14]);

%Original
% n=1, scale = 2;
% [X,Y] = meshgrid(1:n:260,1:n:260);
% figure;
% quiver(X,Y,data_x_new(1:n:260,1:n:260,1,1),data_y_new(1:n:260,1:n:260,1,1),scale);
% xlabel('x');
% ylabel('y');
% title('original')

%Try simple way. Swap 1st and 2nd dimensions
data_x_new = permute(data_x_new,[2,1,3,4]);
data_y_new = permute(data_y_new,[2,1,3,4]);
data_z_new = permute(data_z_new,[2,1,3,4]);

% figure;
% quiver(X,-Y,data_x_new(1:n:260,1:n:260,1,1),data_y_new(1:n:260,1:n:260,1,1),scale);
% xlabel('x');
% ylabel('y');
% title('simple');

%% Apply DVF to body surface segmentation
[seg_body] = nrrdread2('Output volume_deform_15-label.nrrd');

for time = 1:14
    data_x_new(:,:,:,time) = data_x_new(:,:,:,time).*seg_body(:,:,:);
    data_y_new(:,:,:,time) = data_y_new(:,:,:,time).*seg_body(:,:,:);
    data_z_new(:,:,:,time) = data_z_new(:,:,:,time).*seg_body(:,:,:);
%     data_x_seg(:,:,:,time) = data_x_new(:,:,:,time).*seg_body(:,:,:);
%     data_y_seg(:,:,:,time) = data_y_new(:,:,:,time).*seg_body(:,:,:);
%     data_z_seg(:,:,:,time) = data_z_new(:,:,:,time).*seg_body(:,:,:);
end

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
save(strcat('DVF_ave.mat'),'ave_tot');












