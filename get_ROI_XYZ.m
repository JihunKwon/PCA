function [x, y, z] = get_ROI_XYZ(subject_name)
%get_ROI_XYZ Define the x,y,z of cropped ROI here
%   Detailed explanation goes here

%% If use uniform x,y,z for entire subjects and runs:
% x = 84; %anterior to posterior
% y = 146; %left to right
% z = 55; %Cranior Caudal

%% If use subject and run dependent ROI, especially in Z direction:
x = 74; %anterior to posterior
%y = 146; %left to right
y_margin = 20;

if strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928')
    y = 117 + y_margin;
    z = 82/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102')
    y = 97 + y_margin;
    z = 60/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102')
    y = 131 + y_margin;
    z = 110/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220')
    y = 100 + y_margin;
    z = 78/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228')
    y = 98 + y_margin;
    z = 62/2;
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320')
    y = 84 + y_margin;
    z = 58/2;
else
    y = 0;
    z = 0;
end

end

