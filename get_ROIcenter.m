function [center_L] = get_ROIcenter(subject_name)
%% center of ROI. Change specifically for subject
if strcmp(subject_name,'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20180928')
    %v1run1 (JB)
    center_L = [-32 0 -18]; %Center for step1 [+: Posterior, +:Right, +:Cranior]
    %center_S = [7 0 1]; %Center for step3
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_01_20181102')
    %v1run2 (JB)
    center_L = [-30 0 -17];
    %center_S = [8 3 0];
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181102')
    %v2run1 (JK)
    %center_L = [-24 0 2];
    center_L = [-24 0 -7];
    %center_S = [3 -12 -3];
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_02_20181220')
    %v2run2 (JK)
    center_L = [-1 10 -8]; %X:Vertical, Y:Lateral
    %center_S = [4 -9 -4];
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190228')
    %v3run1 (NV)
    center_L = [-12 -2 -9];
elseif strcmp(subject_name, 'C:\Users\Kwon\Documents\MATLAB\PCA\Subject_03_20190320')
    %v3run2 (NV)
    center_L = [-18 0 -15];
else
    print('No such subject!');
end
end

