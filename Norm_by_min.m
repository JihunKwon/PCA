%function [m_A_norm_min, o_A_norm_min] = Norm_by_min(num_subject, num_A, m_A, o_A)
function [m_A_norm_min] = Norm_by_min(num_subject, num_A, m_A, o_A)
%Normalize each subject by its minimum OCM and MRI values.

% num_subject: number of subjects
% num_A: Because the number of datapoints may different between each subjects (because outlier is removed),
% the number ofthe  datapoints has to be defined for each subject. 
% m_A: raw MRI values of all subjects at run A
% o_A: raw OCM values of all subjects at run A
% m_A_norm_min: normalized MRI values of all subjects at run A

min_mri = zeros(1,num_subject);
min_ocm = zeros(1,num_subject);
numA_tot = 0;

for sub = 1:num_subject
    %% Find max of each subject
    min_mri_temp = 1000;
    min_ocm_temp = 1000000000000000000;
    
    %RunA (before water)
    if min_mri_temp > min(m_A(numA_tot+1:numA_tot+num_A(sub))) %min, MRI
        min_mri_temp = min(m_A(numA_tot+1:numA_tot+num_A(sub)));
    end
%     if min_ocm_temp > min(o_A(numA_tot+1:numA_tot+num_A(sub))) %min, OCM
%         min_ocm_temp = min(o_A(numA_tot+1:numA_tot+num_A(sub)));
%     end
    
    min_mri(sub) = min_mri_temp;
    min_ocm(sub) = min_ocm_temp;
    
    %% Normalize min to 0
    m_A_norm_min(numA_tot+1:numA_tot+num_A(sub)) = (m_A(numA_tot+1:numA_tot+num_A(sub)) ./ min_mri(sub));
    o_A_norm_min(numA_tot+1:numA_tot+num_A(sub)) = (o_A(numA_tot+1:numA_tot+num_A(sub)) ./ min_ocm(sub));
    
    numA_tot = numA_tot+num_A(sub);
end

end