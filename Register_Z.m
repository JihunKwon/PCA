%Modify dicom info
%subject's (s3) position in Z direction was very different between before,
%after, and 10 min after. This function change dicominfo to register them.

%Adjust z position of after and 10min after to before.
adjustZ_bef_aft = -125.884;
adjustZ_bef_10m = -20.867;

%% After1

% Import DICOM
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0014';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end

%% After2
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0015';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end


%% After3
% Import DICOM
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0017';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end

%% After4
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0019';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end

%% After5
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0021';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end


%% 10min 1
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0024';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end


%% 10min 2
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0025';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end


%% 10min 3
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0027';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end


%% 10min 4
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0029';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end

%% 10min 5
dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0031';
cd(dir_name);
mkdir dicom_new
dicomlist = dir(fullfile(dir_name,'*.IMA'));

for cnt = 1 : numel(dicomlist)
    meta = dicominfo(dicomlist(cnt).name);
    pri1015 = meta.Private_0019_1015;
    pos = meta.ImagePositionPatient;
    pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
    meta.ImagePositionPatient = pos_new;
    meta.Private_0019_1015  = pos_new;
    
    X = dicomread(dicomlist(cnt).name); 

    fname = strcat('MR_',num2str(cnt),'.dcm');
    cd dicom_new\
    dicomwrite(X, fname, meta, 'CreateMode', 'copy');
    cd ..
end