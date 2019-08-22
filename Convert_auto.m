thr = 5;

%Subject 1
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928');
sr_name = ('s1r1');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr,sr_name)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102');
sr_name = ('s1r2');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr,sr_name)
get_DVF_hist_state12(subject_name,param_name,sr_name)

%Subject 2
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102');
sr_name = ('s2r1');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr,sr_name)

subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220');
sr_name = ('s2r2');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr,sr_name)

%Subject 3
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228');
sr_name = ('s3r1');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr,sr_name)

%run2
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320');
sr_name = ('s3r2');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
get_DVF_hist(subject_name,param_name,thr,sr_name)


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

%% DVF_Histogram
thr = 5; 
param_name = ('r_c_d');
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928');
sr_name = ('s1r1');
get_DVF_hist(subject_name,param_name,thr,sr_name)
get_DVF_hist_state12(subject_name,param_name,sr_name)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102');
sr_name = ('s1r2');
get_DVF_hist(subject_name,param_name,thr,sr_name)
get_DVF_hist_state12(subject_name,param_name,sr_name)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102');
sr_name = ('s2r1');
get_DVF_hist(subject_name,param_name,thr,sr_name)
get_DVF_hist_state12(subject_name,param_name,sr_name)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220');
sr_name = ('s2r2');
get_DVF_hist(subject_name,param_name,thr,sr_name)
get_DVF_hist_state12(subject_name,param_name,sr_name)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228');
sr_name = ('s3r1');
get_DVF_hist(subject_name,param_name,thr,sr_name)
get_DVF_hist_state12(subject_name,param_name,sr_name)
subject_name = ('C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320');
sr_name = ('s3r2');
get_DVF_hist(subject_name,param_name,thr,sr_name)
get_DVF_hist_state12(subject_name,param_name,sr_name)

get_DVF_hist_allsubject123
