
%This script calculates 'param_DVF_xyz.mat', which is 4D matrix of DVF

%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102');
subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102');

if strcmp(subject_name,'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102')
    num_voxel = 25344000; %For v1run2 and v2run1
else
    num_voxel = 29952000; %For run1
end

%param_name = ('trans_subsamp111_maxiter200');
%param_name = ('trans_subsamp221_maxiter200');
%param_name = ('r_c_d');
param_name = ('r_c_r_c_d');

if strcmp(param_name,'r_c_d')
    num_voxel = 1008000;
elseif strcmp(param_name,'r_c_r_c_d')
    num_voxel = 81600;
end

dirname = strcat(subject_name,'\',param_name);
cd(dirname);

max_num=15;
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


save(strcat('param_DVF_xyz_',param_name,'.mat'),'data_x','data_y','data_z');


[coeff_x,score_x,latent_x,~,explained_x] = pca(data_x);
[coeff_y,score_y,latent_y,~,explained_y] = pca(data_y);
[coeff_z,score_z,latent_z,~,explained_z] = pca(data_z);

for k=1:max_num-1
    ave_x(k,1) = sum(data_x(:,k))/(num_voxel/3);
    ave_y(k,1) = sum(data_y(:,k))/(num_voxel/3);
    ave_z(k,1) = sum(data_z(:,k))/(num_voxel/3);
end

figure;
x=1:14;
plot(x,explained_x,'-o'); hold on;
plot(x,explained_y,'-*'); hold on;
plot(x,explained_z,'-s');
xlabel('Eigenvector');
ylabel('Information');
legend('x','y','z');
title('Subject 2, Run 1')
saveas(gcf,strcat('EVvsInfo.pdf'));


%% Get first component of score and form new vector field.
count = 1;
for l=1:num_voxel
    if rem(l,3)==1
        data_new(l,1) = score_x(count,1);
    elseif rem(l,3)==2
        data_new(l,1) = score_y(count,1);
    else
        data_new(l,1) = score_z(count,1);
        count = count + 1;
    end
end
% h5create('DVF_1st_component.h5','/',[1000 2000],'Datatype','single', ...
%           'ChunkSize',[50 80],'Deflate',9)
% h5create('DVF_1st_component.h5','/HDFVersion',1,'Datatype','H5S_ALL');
% H5D.write (dataset_id, memtype, 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT', wdata .');
% h5create('DVF_1st_component.h5','/TransformGroup/0/TranformFixedParameters',18);
% h5create('DVF_1st_component.h5','/TransformGroup/0/TranformParameters',num_voxel);
% h5write('DVF_1st_component.h5','/TransformGroup/0/TranformParameters',data_new);

data_new_inverse = data_new .* (-1);

%Write data_new to .h5 file  
srcfile = 'Output vector field (MRML)_deform_1_2.h5';
copyfile(srcfile,'DVF_FirstComp.h5');
fileattrib('DVF_FirstComp.h5','+w');
plist = 'H5P_DEFAULT';
fid = H5F.open('DVF_FirstComp.h5','H5F_ACC_RDWR',plist);
dset_id = H5D.open(fid,'/TransformGroup/0/TranformParameters');
H5D.write(dset_id,'H5ML_DEFAULT','H5S_ALL','H5S_ALL',plist,data_new);
H5D.close(dset_id);
H5F.close(fid);

%Write data_new_inverse to .h5 file  
srcfile = 'Output vector field (MRML)_deform_1_2.h5';
copyfile(srcfile,'DVF_FirstComp_inv.h5');
fileattrib('DVF_FirstComp_inv.h5','+w');
plist = 'H5P_DEFAULT';
fid = H5F.open('DVF_FirstComp_inv.h5','H5F_ACC_RDWR',plist);
dset_id = H5D.open(fid,'/TransformGroup/0/TranformParameters');
H5D.write(dset_id,'H5ML_DEFAULT','H5S_ALL','H5S_ALL',plist,data_new_inverse);
H5D.close(dset_id);
H5F.close(fid);

%read .h5 file
fid = H5F.open('Output vector field (MRML)_deform_1_2.h5'); 
gid = H5G.open(fid,'/TransformGroup/0'); 
dataset_id = H5D.open(gid,'TranformParameters');
data = H5D.read(dataset_id);
H5D.close(dataset_id);
H5F.close(fid);


toc