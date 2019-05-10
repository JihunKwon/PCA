subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr)

%% Subject 3
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr)

%run2
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr)


%% Crop_DICOM
%{
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928');
Crop_Dicom(subject_name)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102');
Crop_Dicom(subject_name)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102');
Crop_Dicom(subject_name)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220');
Crop_Dicom(subject_name)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228');
Crop_Dicom(subject_name)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320');
Crop_Dicom(subject_name)
%}

thr = 5;
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928');
param_name = ('r_c_d');
get_DVF_hist(subject_name,param_name,thr)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102');
get_DVF_hist(subject_name,param_name,thr)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102');
get_DVF_hist(subject_name,param_name,thr)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220');
get_DVF_hist(subject_name,param_name,thr)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228');
get_DVF_hist(subject_name,param_name,thr)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320');
get_DVF_hist(subject_name,param_name,thr)
