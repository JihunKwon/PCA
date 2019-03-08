function [m_A_norm_sub, m_B_norm_sub, m_C_norm_sub, o_A_norm_sub, o_B_norm_sub, o_C_norm_sub] ...
        = Norm_subject_aapm(num_subject, num_A, num_B, num_C, m_A, m_B, m_C, o_A, o_B, o_C)
%Norm_subject Normalize each subject by its maximum OCM and MRI values.
% num_subject: number of subjects
% num_A,B,C: Because the number of datapoints may different between each subjects (because outlier is removed),
% the number ofthe  datapoints has to be defined for each subject. 
% m_A: raw MRI values of all subjects at run A
% o_A: raw OCM values of all subjects at run A
% m_A_norm_sub: normalized MRI values of all subjects at run A


max_mri = zeros(1,num_subject);
max_ocm = zeros(1,num_subject);
min_mri = zeros(1,num_subject);
min_ocm = zeros(1,num_subject);
numA_tot = 0;
numB_tot = 0;
numC_tot = 0;

for sub = 1:num_subject
    %% Find max of each subject
    max_mri_temp = 0;
    max_ocm_temp = 0;
    min_mri_temp = 1000;
    min_ocm_temp = 1000000000000000000;
    
    %RunA (before water)
    if max_mri_temp < max(m_A(numA_tot+1:numA_tot+num_A(sub))) %max, MRI
        max_mri_temp = max(m_A(numA_tot+1:numA_tot+num_A(sub)));
    end
    if max_ocm_temp < max(o_A(numA_tot+1:numA_tot+num_A(sub))) %max, OCM
        max_ocm_temp = max(o_A(numA_tot+1:numA_tot+num_A(sub)));
    end
    if min_mri_temp > min(m_A(numA_tot+1:numA_tot+num_A(sub))) %min, MRI
        min_mri_temp = min(m_A(numA_tot+1:numA_tot+num_A(sub)));
    end
    if min_ocm_temp > min(o_A(numA_tot+1:numA_tot+num_A(sub))) %min, OCM
        min_ocm_temp = min(o_A(numA_tot+1:numA_tot+num_A(sub)));
    end
    
    %RunB (shortly after water)
    if max_mri_temp < max(m_B(numB_tot+1:numB_tot+num_B(sub))) %max, MRI
        max_mri_temp = max(m_B(numB_tot+1:numB_tot+num_B(sub)));
    end
    if max_ocm_temp < max(o_B(numB_tot+1:numB_tot+num_B(sub))) %max, OCM
        max_ocm_temp = max(o_B(numB_tot+1:numB_tot+num_B(sub)));
    end
    if min_mri_temp > min(m_B(numB_tot+1:numB_tot+num_B(sub))) %min, MRI
        min_mri_temp = min(m_B(numB_tot+1:numB_tot+num_B(sub)));
    end
    if min_ocm_temp > min(o_B(numB_tot+1:numB_tot+num_B(sub))) %min, OCM
        min_ocm_temp = min(o_B(numB_tot+1:numB_tot+num_B(sub)));
    end
    
    %RunC (10min after water)
    if max_mri_temp < max(m_C(numC_tot+1:numC_tot+num_C(sub))) %max, MRI
        max_mri_temp = max(m_C(numC_tot+1:numC_tot+num_C(sub)));
    end
    if max_ocm_temp < max(o_C(numC_tot+1:numC_tot+num_C(sub))) %max, OCM
        max_ocm_temp = max(o_C(numC_tot+1:numC_tot+num_C(sub)));
    end
    if min_mri_temp > min(m_C(numC_tot+1:numC_tot+num_C(sub))) %min, MRI
        min_mri_temp = min(m_C(numC_tot+1:numC_tot+num_C(sub)));
    end
    if min_ocm_temp > min(o_C(numC_tot+1:numC_tot+num_C(sub))) %min, OCM
        min_ocm_temp = min(o_C(numC_tot+1:numC_tot+num_C(sub)));
    end
    
    
    max_mri(sub) = max_mri_temp;
    max_ocm(sub) = max_ocm_temp;
    
    min_mri(sub) = min_mri_temp;
    min_ocm(sub) = min_ocm_temp;
    
    %% Normalize max to 1
    %{
    m_A_norm_sub((sub-1)*4+1:sub*4) = m_A((sub-1)*4+1:sub*4) ./ max_mri(sub);
    m_B_norm_sub((sub-1)*5+1:sub*5) = m_B((sub-1)*5+1:sub*5) ./ max_mri(sub);
    m_C_norm_sub((sub-1)*5+1:sub*5) = m_C((sub-1)*5+1:sub*5) ./ max_mri(sub);
    
    o_A_norm_sub((sub-1)*5+1:sub*5) = o_A((sub-1)*5+1:sub*5) ./ max_ocm(sub);
    o_B_norm_sub((sub-1)*5+1:sub*5) = o_B((sub-1)*5+1:sub*5) ./ max_ocm(sub);
    o_C_norm_sub((sub-1)*5+1:sub*5) = o_C((sub-1)*5+1:sub*5) ./ max_ocm(sub);
    %}
    
    %% Normalize max to 1 and min to 0
    m_A_norm_sub(numA_tot+1:numA_tot+num_A(sub)) = (m_A(numA_tot+1:numA_tot+num_A(sub)) - min_mri(sub)) ./ (max_mri(sub) - min_mri(sub));
    m_B_norm_sub(numB_tot+1:numB_tot+num_B(sub)) = (m_B(numB_tot+1:numB_tot+num_B(sub)) - min_mri(sub)) ./ (max_mri(sub) - min_mri(sub));
    m_C_norm_sub(numC_tot+1:numC_tot+num_C(sub)) = (m_C(numC_tot+1:numC_tot+num_C(sub)) - min_mri(sub)) ./ (max_mri(sub) - min_mri(sub));
    
    o_A_norm_sub(numA_tot+1:numA_tot+num_A(sub)) = (o_A(numA_tot+1:numA_tot+num_A(sub)) - min_ocm(sub)) ./ (max_ocm(sub) - min_ocm(sub));
    o_B_norm_sub(numB_tot+1:numB_tot+num_B(sub)) = (o_B(numB_tot+1:numB_tot+num_B(sub)) - min_ocm(sub)) ./ (max_ocm(sub) - min_ocm(sub));
    o_C_norm_sub(numC_tot+1:numC_tot+num_C(sub)) = (o_C(numC_tot+1:numC_tot+num_C(sub)) - min_ocm(sub)) ./ (max_ocm(sub) - min_ocm(sub));
    
    
    numA_tot = numA_tot+num_A(sub);
    numB_tot = numB_tot+num_B(sub);
    numC_tot = numC_tot+num_C(sub);
end

end