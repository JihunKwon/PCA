function [x, y, z] = get_ROI_XYZ(subject_name)
%get_ROI_XYZ Define the x,y,z of cropped ROI here
%   Detailed explanation goes here

%% If use uniform x,y,z for entire subjects and runs:
% x = 84; %anterior to posterior
% y = 146; %left to right
% z = 55; %Cranior Caudal

%% If use subject and run dependent ROI, especially in Z direction:
x = 84;
y = 146;

if strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928')
    z = 82/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102')
    z = 60/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102')
    z = 110/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220')
    z = 78/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228')
    z = 62/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320')
    z = 58/2;
else
    z = 0;
end

end

