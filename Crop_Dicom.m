function []=Crop_Dicom(subject_name)
% 2018/11/22 Jihun Kwon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.1
% Modified on 12/27/2018 by Jihun Kwon
% Crop nrrd to user-specified region and save.
% Step 0: (Slicer) Rigid registration of whole image
% Step 1: Crop with Large margin (loosely crop)
% (Step 2): (Slicer) Rigid registration of cropped image
% Step 3: Crop with no margin (tightly crop)
% Step 4: (Slicer) DIR of tightly cropped image
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928'); subject = 's1r1';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102'); subject = 's1r2';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102'); subject = 's2r1';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220'); subject = 's2r2';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228'); subject = 's3r1';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320'); subject = 's3r2';
cd(subject_name)

mkdir Cropped
cd Cropped
mkdir rigid 
mkdir rigid_crop 
%mkdir rigid_crop_rigid_crop

basefolder_r = strcat(subject_name,'\Cropped\rigid');
%basefolder_r_c_r = strcat(subject_name,'\Cropped\rigid_crop_rigid');

cd(basefolder_r)

%% set center of ROI. Change specifically for subject
center_L = get_ROIcenter(subject_name);

%% set size of ROI.
[x_L, y_L, z_L] = get_ROI_XYZ(subject_name); %Subject specific ROI size

%% Step0: Rigid registration (Slicer)

%% Step1: Loosly crop

for i=1:15
    cd(basefolder_r);
    %README!!
    % manually copy raw 1st tp image from somewhere like 
    % "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220"
    % and paste to basefolder as 'Output volume_trans_1_1.nrrd'
    
    fname = sprintf('Output volume_trans_1_%d.nrrd', i);
    body = nrrdread2(fname);
   
    %Crop nrrd file with three types of sizes
    body_seg_L = body(center_L(1)+size(body,1)/2-x_L/2 : center_L(1)+size(body,1)/2+x_L/2 -1, ...
        center_L(2)+size(body,2)/2-y_L/2 : center_L(2)+size(body,2)/2+y_L/2 -1, ...
        center_L(3)+size(body,3)/2-z_L/2 : center_L(3)+size(body,3)/2+z_L/2 -1);
    
    %Use 6th image for visualization
    if i==1
        body_seg_L_1 = body_seg_L;
    elseif i==11
        body_seg_L_6 = body_seg_L;
    else
        body_seg_L_15 = body_seg_L;
    end
    
    cd ..
    cd rigid_crop
    %Write cropped nrrd file
    fname_L = sprintf('Output volume_trans_crop_L_%d.nrrd', i);
    nrrdWriter(fname_L,body_seg_L,[1,1,2],[0,0,0],'raw');
end

cd(subject_name)
cd Cropped
for j=1:size(body_seg_L_1,3)
    figure(1);
    imshow(body_seg_L_1(:,:,j), []);
    %imshow(body_seg_L_1(:,:,j), []);
    export_fig(sprintf('body_seg_L_1_%d.png', j));
end
%{
for j=1:size(body_seg_L_1,3)
    figure(1);
    imshow(body_seg_L_6(:,:,j), []);
    export_fig(sprintf('body_seg_L_5_%d.png', j));
end
for j=1:size(body_seg_L_1,3)
    figure(1);
    imshow(body_seg_L_15(:,:,j), []);
    export_fig(sprintf('body_seg_L_15_%d.png', j));
end
%}

%% Step2: Rigid registration (Slicer)