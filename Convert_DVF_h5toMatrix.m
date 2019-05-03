function []=Convert_DVF_h5toMatrix(subject_name,param_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% Modified on 12/27/2018 by Jihun Kwon
% Import Diffusion Vector Field (DVF) .h5 files and convert to 4D matrix of
% DVF 'param_DVF_xyz.mat'
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181220');

if strcmp(subject_name,'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102')
    num_voxel = 25344000; %For v1run2 and v2run1
else
    num_voxel = 29952000; %For run1
end

%param_name = ('trans_subsamp111_maxiter200');
%param_name = ('trans_subsamp221_maxiter200');
%param_name = ('r_c_d');
%param_name = ('r_c_r_c_d');
%param_name = ('r_c_r_d');

if strcmp(param_name,'r_c_d') || strcmp(param_name,'r_c_r_d')
    num_voxel = 997920; % X*Y*Z*3(three dimension of vector field)
elseif strcmp(param_name,'r_c_r_c_d')
    num_voxel = 149040;
elseif strcmp(param_name,'r_d_c')
    num_voxel = 29952000; %776160;
    if (strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102') || ...
            strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228'))
        num_voxel = 25344000; %776160;
    end
end

dirname = strcat(subject_name,'\',param_name);
cd(dirname);

max_num=5;
data = zeros(num_voxel,max_num-1);
data_x = zeros(num_voxel/3,max_num-1);
data_y = zeros(num_voxel/3,max_num-1);
data_z = zeros(num_voxel/3,max_num-1);
data_new = zeros(num_voxel,1);

ave_x = zeros(max_num-1,1);
ave_y = zeros(max_num-1,1);
ave_z = zeros(max_num-1,1);

for i=2:max_num %Time points
    str = num2str(i);
    if strcmp(param_name,'r_c_d')
        filename = strcat('Output vector field (MRML)_trans_crop_L_deform_',str,'.h5');
    elseif strcmp(param_name,'r_c_r_c_d')
        filename = strcat('Output vector field (MRML)_trans2_crop2_S_deform_',str,'.h5');
    elseif strcmp(param_name,'r_c_r_d')
        filename = strcat('Output vector field (MRML)_trans2_crop_L_deform_',str,'.h5');
    else
        filename = strcat('Output vector field (MRML)_deform_',str,'.h5');
    end
    
    if strcmp(param_name,'r_d_c') %In case of "r_d_c", the DVF needs to be cropped
        filename = strcat('Output vector field (MRML)_trans_deform_',str,'.h5');
        
    end
    %h5disp(filename)
    data(:,i-1) = h5read(filename,'/TransformGroup/0/TranformParameters');
    
    count = 1;
    for j=1:num_voxel % 1:x,2:y,3:z,4:x,5:y,...
        if rem(j,3)==1
            data_x(count,i-1) = data(j,i-1);
        elseif rem(j,3)==2
            data_y(count,i-1) = data(j,i-1);
        else
            data_z(count,i-1) = data(j,i-1);
            count = count + 1;
        end
            
    end
end

save(strcat('param_DVF_xyz.mat'),'data_x','data_y','data_z');