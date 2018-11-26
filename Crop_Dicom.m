% 2018/11/22 Jihun Kwon
% Crop nrrd and save nrrd.
% Step 0: (Slicer) Rigid registration of whole image
% Step 1: Crop with Large margin (loosely crop)
% Step 2: (Slicer) Rigid registration of cropped image
% Step 3: Crop with no margin (tightly crop)
% Step 4: (Slicer) DIR of tightly cropped image


%basefolder_r = 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928\Cropped\rigid';
basefolder_r = 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102\Cropped\rigid';
%basefolder_r = 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102\Cropped\rigid';

%% center of ROI. Change specifically for subject
if strcmp(basefolder_r,'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928\Cropped\rigid')
    %v1run1 (JB)
    center = [-26 -20 -10]; %Center for step1
    center2 = [0 0 3]; %Center for step3
elseif strcmp(basefolder_r, 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102\Cropped\rigid')
    %v1run2 (JB)
    center = [-26 -20 -6];
    center2 = [0 0 3];
elseif strcmp(basefolder_r, 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102\Cropped\rigid')
    %v2run1 (JK)
    center = [-16 -20 10];
    center2 = [-16 -6 -6];
else
    print('No such subject!');
end

%% 
%Length of x,y,z (very tight)
%"S" repreesnts Small
x_S = 34; %top to bottom
y_S = 50; %left to right
z_S = 16;

%Length of x,y,z (Large  margins)
%L" repreesnts Large
x_L = x_S+50; %top to bottom
y_L = y_S+50; %left to right
z_L = z_S+24;

%% Step1: Loosly crop

% for i=1:15
%     cd(basefolder_r);
%     fname = sprintf('Output volume_trans_1_%d.nrrd', i);
%     body = nrrdread2(fname);
%    
%     %Crop nrrd file with three types of sizes
%     body_seg_L = body(center(1)+size(body,1)/2-x_L/2 : center(1)+size(body,1)/2+x_L/2 -1, ...
%         center(2)+size(body,2)/2-y_L/2 : center(2)+size(body,2)/2+y_L/2 -1, ...
%         center(3)+size(body,3)/2-z_L/2 : center(3)+size(body,3)/2+z_L/2 -1);
%     
%     cd ..
%     cd rigid_crop
%     %Write cropped nrrd file
%     fname_L = sprintf('Output volume_trans_crop_L_%d.nrrd', i);
%     nrrdWriter(fname_L,body_seg_L,[1,1,2],[0,0,0],'raw');
% end

% for i=1:size(body_seg_L,3)
%     figure(1);
%     imshow(body_seg_L(:,:,i), []);
%     export_fig(sprintf('body_seg_L_%d.png', i));
% end

%% Step2: Rigid registration (Slicer)

%% Step3: Tightly crop

%basefolder_r_c_r = 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928\Cropped\rigid_crop_rigid';
%basefolder_r_c_r = 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102\Cropped\rigid_crop_rigid';
basefolder_r_c_r = 'C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102\Cropped\rigid_crop_rigid';
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
    body_seg_S = body(center2(1)+size(body,1)/2-x_S/2 : center2(1)+size(body,1)/2+x_S/2 -1, ...
        center2(2)+size(body,2)/2-y_S/2 : center2(2)+size(body,2)/2+y_S/2 -1, ...
        center2(3)+size(body,3)/2-z_S/2 : center2(3)+size(body,3)/2+z_S/2 -1);

    cd ..
    cd rigid_crop_rigid_crop
    %Write cropped nrrd file
    fname_S = sprintf('Output volume_trans2_crop2_S_%d.nrrd', i);
    nrrdWriter(fname_S,body_seg_S,[1,1,2],[0,0,0],'raw');
end

for i=1:size(body_seg_S,3)
    figure(1);
    imshow(body_seg_S(:,:,i), []);
    export_fig(sprintf('body_seg_S_%d.png', i));
end