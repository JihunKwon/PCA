function [] = get_DVF_hist(subject_name,param_name,thr,sr_name)
%get_DVF_hist import DVF and show histogram of distribution.

[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size

%Import DVF
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('param_DVF_xyz.mat');

data_xyz = zeros(size(data_x));

%Calculate XYZ scalar for each pixel.
for tp = 1:size(data_x,2)
    for a = 1:size(data_x,1)
       data_xyz(a,tp) = (data_x(a,tp).^2 + data_y(a,tp).^2 + data_z(a,tp).^2).^0.5; 
    end
end

%% Visualize Histogram

figure;
set(gcf,'Position',[0 0 1500 900], 'Color', 'w')
%Before water
subaxis(5,3,1,'SpacingVert',0.04,'SpacingHoriz',0.04);
h1 = histogram(data_xyz(:,1),300); xlim([0 30]);
h1.BinWidth = h1.BinWidth*4;
title('Before water, 1');
subaxis(5,3,4,'SpacingVert',0.04,'SpacingHoriz',0.04);
h2 = histogram(data_xyz(:,2),300); xlim([0 30]);
h2.BinWidth = h1.BinWidth;
title('Before water, 2');
subaxis(5,3,7,'SpacingVert',0.04,'SpacingHoriz',0.04);
h3 = histogram(data_xyz(:,3),300); xlim([0 30]);
h3.BinWidth = h1.BinWidth;
title('Before water, 3');
subaxis(5,3,10,'SpacingVert',0.04,'SpacingHoriz',0.04);
h4 = histogram(data_xyz(:,4),300); xlim([0 30]);
h4.BinWidth = h1.BinWidth;
title('Before water, 4');

%After water
subaxis(5,3,2,'SpacingVert',0.04,'SpacingHoriz',0.04);
h5 = histogram(data_xyz(:,5),300); xlim([0 30]);
h5.BinWidth = h1.BinWidth;
title('After water, 1');
subaxis(5,3,5,'SpacingVert',0.04,'SpacingHoriz',0.04);
h6 = histogram(data_xyz(:,6),300); xlim([0 30]);
h6.BinWidth = h1.BinWidth;
title('After water, 2');
subaxis(5,3,8,'SpacingVert',0.04,'SpacingHoriz',0.04);
h7 = histogram(data_xyz(:,7),300); xlim([0 30]);
h7.BinWidth = h1.BinWidth;
title('After water, 3');
subaxis(5,3,11,'SpacingVert',0.04,'SpacingHoriz',0.04);
h8 = histogram(data_xyz(:,8),300); xlim([0 30]);
h8.BinWidth = h1.BinWidth;
title('After water, 4');
subaxis(5,3,14,'SpacingVert',0.04,'SpacingHoriz',0.04);
h9 = histogram(data_xyz(:,9),300); xlim([0 30]);
h9.BinWidth = h1.BinWidth;
title('After water, 5');

%10min After water
subaxis(5,3,3,'SpacingVert',0.04,'SpacingHoriz',0.04);
h10 = histogram(data_xyz(:,10),300); xlim([0 30]);
h10.BinWidth = h1.BinWidth;
title('10min after water, 1');
subaxis(5,3,6,'SpacingVert',0.04,'SpacingHoriz',0.04);
h11 = histogram(data_xyz(:,11),300); xlim([0 30]);
h11.BinWidth = h1.BinWidth;
title('10min after water, 2');
subaxis(5,3,9,'SpacingVert',0.04,'SpacingHoriz',0.04);
h12 = histogram(data_xyz(:,12),300); xlim([0 30]);
h12.BinWidth = h1.BinWidth;
title('10min after water, 3');
subaxis(5,3,12,'SpacingVert',0.04,'SpacingHoriz',0.04);
h13 = histogram(data_xyz(:,13),300); xlim([0 30]);
h13.BinWidth = h1.BinWidth;
title('10min after water, 4');
subaxis(5,3,15,'SpacingVert',0.04,'SpacingHoriz',0.04);
h14 = histogram(data_xyz(:,14),300); xlim([0 30]);
h14.BinWidth = h1.BinWidth;
title('10min after water, 5');
%title('DVF, Z component, filtered'); colorbar; colormap parula; 
cd ..

cd C:\Users\Kwon\Documents\MATLAB\PCA
savename = strcat('DVF_histogram_',sr_name,'.png');
export_fig(sprintf(savename), '-q101');
%export_fig DVF_histogram.png -q101

%% Calculate number of voxels higher than the threshold
data_xyz_thr = zeros(1,size(data_x,2)); %Correct number of voxels after thresholding
data_xyz_thr_per = zeros(1,size(data_x,2)); %Percentage of the voxels

%Count the number of voxel
for tp = 1:size(data_x,2)
    data_xyz_thr(tp) = sum(data_xyz(:,tp)>thr);
    data_xyz_thr_per(tp) = data_xyz_thr(tp)/size(data_xyz,1)*100;
end
% figure
% plot(1:14,data_xyz_thr_per(1:14))
cd(dirname);
save(strcat('DVF_hist_thr.mat'),'data_xyz_thr_per');
end

