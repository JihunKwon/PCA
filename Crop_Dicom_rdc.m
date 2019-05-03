%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Crop nrrd to user-specified region and save.
% Different with "Crop_Dicom.m", this function assumes you did
% transformation and deformation already, and then crop the image.
% Step 0: (Slicer) Rigid registration of whole image
% Step 1: (Slicer) DIR of whole image
% Step 2: Crop the deformed image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928'); subject = 's1r1';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102'); subject = 's1r2';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102'); subject = 's2r1';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220'); subject = 's2r2';
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228'); subject = 's3r1';
%subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320'); subject = 's3r2';
cd(subject_name)

mkdir Cropped
cd Cropped
mkdir rigid_deform
mkdir rigid_deform_crop 

basefolder_r = strcat(subject_name,'\Cropped\rigid_deform');
cd(basefolder_r)

%% Get center of ROI
center_L = get_ROIcenter(subject_name);

%%
%[Large margins] Length of x,y,z
%L" repreesnts Large
x_L = 84; %top to bottom
y_L = 110; %left to right
z_L = 28;

%% Step0: Rigid registration of whole image (Slicer)
%% Step1: DIR of whold image (Slicer)
%% Step2: crop

for i=1:5
    cd(basefolder_r);
    
    %README!!
    % manually copy raw 1st tp image from somewhere like 
    % "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220"
    % and paste to basefolder as 'Output volume_trans_1_1.nrrd'
    
    fname = sprintf('Output volume_trans_deform_%d.nrrd', i);
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
    cd rigid_deform_crop
    %Write cropped nrrd file
    fname_L = sprintf('Output volume_trans_deform_crop_%d.nrrd', i);
    nrrdWriter(fname_L,body_seg_L,[1,1,2],[0,0,0],'raw');
end

cd(subject_name)
cd Cropped/rigid_deform_crop
for j=1:size(body_seg_L_1,3)
    figure(1);
    imshow(body_seg_L_1(:,:,j), []);
    export_fig(sprintf('body_seg_trans_deform_%d.png', j));
end