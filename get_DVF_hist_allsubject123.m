% Draw histogram of the sum of all subjects and runs.
param_name = ('r_c_d');

%% Import data
%Subject 1 Run 1
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928');
sr_name = ('s1r1');
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size
%Import DVF
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('param_DVF_xyz.mat');

data_xyz_s1r1 = zeros(size(data_x));
%Calculate XYZ scalar for each pixel.
for tp = 1:size(data_x,2)
    for a = 1:size(data_x,1)
       data_xyz_s1r1(a,tp) = (data_x(a,tp).^2 + data_y(a,tp).^2 + data_z(a,tp).^2).^0.5; 
    end
end


%Subject 1 Run 2
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102');
sr_name = ('s1r2');
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size
%Import DVF
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('param_DVF_xyz.mat');

data_xyz_s1r2 = zeros(size(data_x));
%Calculate XYZ scalar for each pixel.
for tp = 1:size(data_x,2)
    for a = 1:size(data_x,1)
       data_xyz_s1r2(a,tp) = (data_x(a,tp).^2 + data_y(a,tp).^2 + data_z(a,tp).^2).^0.5; 
    end
end


%Subject 2 Run 1
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102');
sr_name = ('s2r1');
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size
%Import DVF
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('param_DVF_xyz.mat');

data_xyz_s2r1 = zeros(size(data_x));
%Calculate XYZ scalar for each pixel.
for tp = 1:size(data_x,2)
    for a = 1:size(data_x,1)
       data_xyz_s2r1(a,tp) = (data_x(a,tp).^2 + data_y(a,tp).^2 + data_z(a,tp).^2).^0.5; 
    end
end

%Subject 2 Run 2
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220');
sr_name = ('s2r2');
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size
%Import DVF
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('param_DVF_xyz.mat');

data_xyz_s2r2 = zeros(size(data_x));
%Calculate XYZ scalar for each pixel.
for tp = 1:size(data_x,2)
    for a = 1:size(data_x,1)
       data_xyz_s2r2(a,tp) = (data_x(a,tp).^2 + data_y(a,tp).^2 + data_z(a,tp).^2).^0.5; 
    end
end


%Subject 3 Run 1
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228');
sr_name = ('s3r1');
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size
%Import DVF
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('param_DVF_xyz.mat');

data_xyz_s3r1 = zeros(size(data_x));
%Calculate XYZ scalar for each pixel.
for tp = 1:size(data_x,2)
    for a = 1:size(data_x,1)
       data_xyz_s3r1(a,tp) = (data_x(a,tp).^2 + data_y(a,tp).^2 + data_z(a,tp).^2).^0.5; 
    end
end


%Subject 3 Run 2
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320');
sr_name = ('s3r2');
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size
%Import DVF
dirname = strcat(subject_name,'\',param_name);
cd(dirname);
load('param_DVF_xyz.mat');

data_xyz_s3r2 = zeros(size(data_x));
%Calculate XYZ scalar for each pixel.
for tp = 1:size(data_x,2)
    for a = 1:size(data_x,1)
       data_xyz_s3r2(a,tp) = (data_x(a,tp).^2 + data_y(a,tp).^2 + data_z(a,tp).^2).^0.5; 
    end
end


%% Vertically concatenate data
data_vert = vertcat(data_xyz_s1r1, data_xyz_s1r2, data_xyz_s2r1, data_xyz_s2r2, data_xyz_s3r1, data_xyz_s3r2);

%% Visualize Histogram total state 1,2,3
figure;
set(gcf,'Position',[0 0 500 600], 'Color', 'w')

%Before water
subaxis(3,1,1,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
b = [data_vert(:,1) data_vert(:,2) data_vert(:,3) data_vert(:,4)];
h1 = histogram(b); 
h1.FaceColor = 'b';
h1.BinWidth = h1.BinWidth*5;
hAx = gca;
hAx.YAxis.Exponent=0;
hAx.YAxis.TickLabelFormat='%d';
yl = ylim-30000;
xlim([0 15]); 
ylim([0, yl(2)]);
set(gca,'xticklabel',[])
title('Distribution of MRI DVF Magnitude','FontSize',12);
ylabel('Number of Voxels','FontSize',12);
txt = 'State 1';
text(12.5, 330000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
%plot(5, 0:yl(2), 'k') 
grid on

%After water
subaxis(3,1,2,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
b = [data_vert(:,5) data_vert(:,6) data_vert(:,7) data_vert(:,8) data_vert(:,9)];
h2 = histogram(b); 
h2.BinWidth = h1.BinWidth;
hAx = gca;
hAx.YAxis.Exponent=0;
hAx.YAxis.TickLabelFormat='%d';
h2.FaceColor = 'r';
xlim([0 15]);
ylim([0, yl(2)]);
set(gca,'xticklabel',[])
ylabel('Number of Voxels','FontSize',12);
txt = 'State 2';
text(12.5, 330000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
grid on

%10min After water
subaxis(3,1,3,'SpacingVert',0.0,'SpacingHoriz',0.5,'MarginLeft',.15,'MarginBottom',.1);
b = [data_vert(:,10) data_vert(:,11) data_vert(:,12) data_vert(:,13) data_vert(:,14)];
h3 = histogram(b); 
h3.BinWidth = h1.BinWidth;
hAx = gca;
hAx.YAxis.Exponent=0;
hAx.YAxis.TickLabelFormat='%d';
h3.FaceColor = 'g';
xlim([0 15]);
ylim([0, yl(2)]);
ylabel('Number of Voxels','FontSize',12);
xlabel('Magnitude of Deformation Vector (mm)','FontSize',12);
txt = 'State 3';
text(12.5, 330000, txt,'FontSize',12)
%line([5 5], [0 yl(2)], 'Color','black','LineStyle','--')
grid on

cd C:\Users\Kwon\Documents\MATLAB\PCA
savename = strcat('DVF_histogram_State123_AllSub.png');
export_fig(sprintf(savename), '-q101');
