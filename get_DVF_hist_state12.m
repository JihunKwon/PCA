function [] = get_DVF_hist_state12(subject_name,param_name,thr)

%get_DVF_hist import DVF and show histogram of distribution. Compare state
%1 and 2 for visualization

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
set(gcf,'Position',[0 0 500 500], 'Color', 'w')

%Before water
subaxis(2,1,1,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
h1 = histogram(data_xyz(:,1)); 
xlim([0 15]); 
h1.FaceColor = 'b';
h1.BinWidth = h1.BinWidth*4;
yl = ylim-1000;
ylim([0, yl(2)]);
set(gca,'xticklabel',[])
title('Distribution of MRI DVF Magnitude','FontSize',12);
ylabel('Number of Voxels','FontSize',12);
txt = 'State 1';
text(12.5, 17000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
%plot(5, 0:yl(2), 'k') 
grid on

%After water
subaxis(2,1,2,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
h2 = histogram(data_xyz(:,5)); 
h2.BinWidth = h1.BinWidth;
h2.FaceColor = 'r';
xlim([0 15]);
ylim([0, yl(2)]);
ylabel('Number of Voxels','FontSize',12);
xlabel('Magnitude of Deformation Vector (mm)','FontSize',12);
txt = 'State 2';
text(12.5, 17000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
grid on

cd C:\Users\Kwon\Documents\MATLAB\PCA
export_fig DVF_histogram_State12.png -q101

%% state 1,2,3
figure;
set(gcf,'Position',[0 0 500 600], 'Color', 'w')

%Before water
subaxis(3,1,1,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
h1 = histogram(data_xyz(:,1)); 
h1.FaceColor = 'b';
h1.BinWidth = h1.BinWidth*4;
yl = ylim-1000;
xlim([0 15]); 
ylim([0, yl(2)]);
set(gca,'xticklabel',[])
title('Distribution of MRI DVF Magnitude','FontSize',12);
ylabel('Number of Voxels','FontSize',12);
txt = 'State 1';
text(12.5, 17000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
%plot(5, 0:yl(2), 'k') 
grid on

%After water
subaxis(3,1,2,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
h2 = histogram(data_xyz(:,5)); 
h2.BinWidth = h1.BinWidth;
h2.FaceColor = 'r';
xlim([0 15]);
ylim([0, yl(2)]);
set(gca,'xticklabel',[])
ylabel('Number of Voxels','FontSize',12);
txt = 'State 2';
text(12.5, 17000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
grid on

%10min After water
subaxis(3,1,3,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
h2 = histogram(data_xyz(:,10)); 
h2.BinWidth = h1.BinWidth;
h2.FaceColor = 'g';
xlim([0 15]);
ylim([0, yl(2)]);
ylabel('Number of Voxels','FontSize',12);
xlabel('Magnitude of Deformation Vector (mm)','FontSize',12);
txt = 'State 3';
text(12.5, 17000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
grid on

cd C:\Users\Kwon\Documents\MATLAB\PCA
export_fig DVF_histogram_State123.png -q101
end

