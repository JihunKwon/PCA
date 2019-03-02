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

%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102');
%subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181220');
subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_03_20190228');
cd(subject_name)

mkdir Cropped
cd Cropped
mkdir rigid 
mkdir rigid_crop 
%mkdir rigid_crop_rigid_crop

basefolder_r = strcat(subject_name,'\Cropped\rigid');
%basefolder_r_c_r = strcat(subject_name,'\Cropped\rigid_crop_rigid');

cd(basefolder_r)

%% center of ROI. Change specifically for subject
if strcmp(basefolder_r,'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928\Cropped\rigid')
    %v1run1 (JB)
    center_L = [-30 -20 -20]; %Center for step1
    center_S = [7 0 1]; %Center for step3
elseif strcmp(basefolder_r, 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102\Cropped\rigid')
    %v1run2 (JB)
    center_L = [-30 -20 -16];
    center_S = [8 3 0];
elseif strcmp(basefolder_r, 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102\Cropped\rigid')
    %v2run1 (JK)
    center_L = [-26 -20 4];
    center_S = [3 -12 -3];
elseif strcmp(basefolder_r, 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181220\Cropped\rigid')
    %v2run2 (JK)
    center_L = [-8 -16 4]; %X:Vertical, Y:Lateral
    center_S = [4 -9 -4];
elseif strcmp(basefolder_r, 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_03_20190228\Cropped\rigid')
    %v3run1 (NV)
    center_L = [-8 -16 7];
    center_S = [4 -9 0];
else
    print('No such subject!');
end

%%
%[Large margins] Length of x,y,z
%L" repreesnts Large
x_L = 84; %top to bottom
y_L = 100; %left to right
z_L = 40;

%[Very Tight] Length of x,y,z
%"S" repreesnts Small
x_S = 46; %top to bottom
y_S = 54; %left to right
z_S = 20;

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
    if i==6
        body_seg_L_6 = body_seg_L;
    end
    
    cd ..
    cd rigid_crop
    %Write cropped nrrd file
    fname_L = sprintf('Output volume_trans_crop_L_%d.nrrd', i);
    nrrdWriter(fname_L,body_seg_L,[1,1,2],[0,0,0],'raw');
end

for j=1:size(body_seg_L_6,3)
    figure(1);
    imshow(body_seg_L_6(:,:,j), []);
    export_fig(sprintf('body_seg_L_%d.png', j));
end

%% Step2: Rigid registration (Slicer)

%% Step3: Tightly crop
%{
cd(basefolder_r_c_r)

for i=1:15
    if i==1
        cd ..
        cd rigid_crop
        fname = sprintf('Output volume_trans_crop_L_%d.nrrd', i);
        body = nrrdread2(fname);
    else
        cd(basefolder_r_c_r)
        fname = sprintf('Output volume_trans2_crop_L_%d.nrrd', i);
        body = nrrdread2(fname);
    end
   
    %Crop nrrd file with three types of sizes
    body_seg_S = body(center_S(1)+size(body,1)/2-x_S/2 : center_S(1)+size(body,1)/2+x_S/2 -1, ...
        center_S(2)+size(body,2)/2-y_S/2 : center_S(2)+size(body,2)/2+y_S/2 -1, ...
        center_S(3)+size(body,3)/2-z_S/2 : center_S(3)+size(body,3)/2+z_S/2 -1);
    
    %Use 6th image for visualization
    if i==6
        body_seg_S_6 = body_seg_S;
    end

    cd ..
    cd rigid_crop_rigid_crop
    %Write cropped nrrd file
    fname_S = sprintf('Output volume_trans2_crop2_S_%d.nrrd', i);
    nrrdWriter(fname_S,body_seg_S,[1,1,2],[0,0,0],'raw');
end

for j=1:size(body_seg_S_6,3)
    figure(1);
    imshow(body_seg_S_6(:,:,j), []);
    export_fig(sprintf('body_seg_S_%d.png', j));
end
%}