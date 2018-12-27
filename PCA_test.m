%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% Created on 12/26/2018 by Jihun Kwon
% Do PCA analysis for DIR data. Run after "Convert_DVF_h5toMatrix.m"
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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