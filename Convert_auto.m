
subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20180928');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
param_name = ('r_c_r_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)

subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_01_20181102');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
param_name = ('r_c_r_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)

subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181102');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
param_name = ('r_c_r_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)

subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_02_20181220');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)
param_name = ('r_c_r_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)

%% Subject 3
subject_name = ('C:\Users\jihun\Documents\MATLAB\PCA\Subject_03_20190228');
param_name = ('r_c_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)

param_name = ('r_c_r_d');
Convert_DVF_h5toMatrix(subject_name,param_name)
Crop_DVF(subject_name,param_name)

%% 
param_name = ('r_c_d');
vis_DVF_Difference(param_name)

param_name = ('r_c_r_d');
vis_DVF_Difference(param_name)