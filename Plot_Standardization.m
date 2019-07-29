%% Standaridization of data
%1. Standardize each subject separately (after normalize to 1)
%2. Standardize entire data together (from raw data)
%3. Standardize entire data together (after normalize to 1)

%% 1. Standardize each subject separately (after normalize to 1)
%Get subject-specific SD and mean
for sub = 1:num_subject
    meanABC_mri_sub(sub,:) = mean([mri_runA_norm((sub-1)*4+1:sub*4) mri_runB_norm((sub-1)*5+1:sub*5) mri_runC_norm((sub-1)*5+1:sub*5)]);
    meanABC_ocm_sub(sub,:) = mean([ocm_runA_norm((sub-1)*4+1:sub*4) ocm_runB_norm((sub-1)*5+1:sub*5) ocm_runC_norm((sub-1)*5+1:sub*5)]);
    sdABC_mri_sub(sub,:) = std([mri_runA_norm((sub-1)*4+1:sub*4) mri_runB_norm((sub-1)*5+1:sub*5) mri_runC_norm((sub-1)*5+1:sub*5)]);
    sdABC_ocm_sub(sub,:) = std([ocm_runA_norm((sub-1)*4+1:sub*4) ocm_runB_norm((sub-1)*5+1:sub*5) ocm_runC_norm((sub-1)*5+1:sub*5)]);
end

%Standardization (subject specific)
numA_cnt = 0;
numB_cnt = 0;
numC_cnt = 0;
for sub = 1:num_subject
    stdz_mriA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)) = (mri_runA_norm((sub-1)*4+1:sub*4) - meanABC_mri_sub(sub,:)) ./ sdABC_mri_sub(sub,:);
    stdz_mriB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)) = (mri_runB_norm((sub-1)*5+1:sub*5) - meanABC_mri_sub(sub,:)) ./ sdABC_mri_sub(sub,:);
    stdz_mriC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)) = (mri_runC_norm((sub-1)*5+1:sub*5) - meanABC_mri_sub(sub,:)) ./ sdABC_mri_sub(sub,:);
    
    stdz_ocmA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)) = (ocm_runA_norm((sub-1)*4+1:sub*4) - meanABC_ocm_sub(sub,:)) ./ sdABC_ocm_sub(sub,:);
    stdz_ocmB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)) = (ocm_runB_norm((sub-1)*5+1:sub*5) - meanABC_ocm_sub(sub,:)) ./ sdABC_ocm_sub(sub,:);
    stdz_ocmC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)) = (ocm_runC_norm((sub-1)*5+1:sub*5) - meanABC_ocm_sub(sub,:)) ./ sdABC_ocm_sub(sub,:);
    
    numA_cnt = numA_cnt+num_array_A(sub);
    numB_cnt = numB_cnt+num_array_B(sub);
    numC_cnt = numC_cnt+num_array_C(sub);
end

%Visualize
figure('Position', [391 1 700 1000]);
numA_cnt = 0;
numB_cnt = 0;
numC_cnt = 0;

%Plot Subject specific standardization
for sub = 1:num_subject
    subaxis(3,2,sub,'SpacingVert',0.065,'SpacingHoriz',0.04);
    scatter(stdz_mriA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)),stdz_ocmA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)),stdz_ocmB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)),stdz_ocmC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    
    numA_cnt = numA_cnt+num_array_A(sub);
    numB_cnt = numB_cnt+num_array_B(sub);
    numC_cnt = numC_cnt+num_array_C(sub);
    
    %xlim([0 1.0]); ylim([0 1.0]);
    xlabel('MRI, DVF');
    ylabel('OCM, Mean Square Difference');
    
    if sub==1
        title('S1, run1');
    elseif sub==2
        title('S1, run2');
    elseif sub==3
        title('S2, run1');
    elseif sub==4
        title('S2, run2');
    elseif sub==5
        title('S3, run1');
    end
    %legend({'State 1','State 2','State 3'},'Location','northwest','FontSize',8);
    box on;
    set(gcf, 'Color', 'w');
    pbaspect([1 1 1])
end

%Plot all together
subaxis(3,2,6,'SpacingVert',0.07,'SpacingHoriz',0.04);

numA_cnt = 0;
numB_cnt = 0;
numC_cnt = 0;
for sub = 1:num_subject
%     scatter(stdz_mri_A(numA_cnt+1:numA_cnt+num_array_A(sub)),stdz_ocm_A(numA_cnt+1:numA_cnt+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
%     scatter(stdz_mri_B(numB_cnt+1:numB_cnt+num_array_B(sub)),stdz_ocm_B(numB_cnt+1:numB_cnt+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
%     scatter(stdz_mri_C(numC_cnt+1:numC_cnt+num_array_C(sub)),stdz_ocm_C(numC_cnt+1:numC_cnt+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)),stdz_ocmA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)),stdz_ocmB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)),stdz_ocmC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
          
    numA_cnt = numA_cnt+num_array_A(sub);
    numB_cnt = numB_cnt+num_array_B(sub);
    numC_cnt = numC_cnt+num_array_C(sub);
end

xlabel('MRI, DVF');
ylabel('OCM, Mean Square Difference');
title('All data');
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
export_fig Scatter_Standard_EachSubject.png -q101

%Plot only alltogether
figure('Position', [391 1 450 400]);
subaxis(1,1,1,'SpacingVert',0.07,'SpacingHoriz',0.04);

numA_cnt = 0;
numB_cnt = 0;
numC_cnt = 0;
for sub = 1:num_subject
%     scatter(stdz_mri_A(numA_cnt+1:numA_cnt+num_array_A(sub)),stdz_ocm_A(numA_cnt+1:numA_cnt+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
%     scatter(stdz_mri_B(numB_cnt+1:numB_cnt+num_array_B(sub)),stdz_ocm_B(numB_cnt+1:numB_cnt+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
%     scatter(stdz_mri_C(numC_cnt+1:numC_cnt+num_array_C(sub)),stdz_ocm_C(numC_cnt+1:numC_cnt+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)),stdz_ocmA_sub(numA_cnt+1:numA_cnt+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)),stdz_ocmB_sub(numB_cnt+1:numB_cnt+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mriC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)),stdz_ocmC_sub(numC_cnt+1:numC_cnt+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
          
    numA_cnt = numA_cnt+num_array_A(sub);
    numB_cnt = numB_cnt+num_array_B(sub);
    numC_cnt = numC_cnt+num_array_C(sub);
end

xlabel('MRI, DVF');
ylabel('OCM, Mean Square Difference');
title('Standardized each subject separately');
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
legend({'State 1','State 2','State 3'},'Location','northwest','FontSize',8);
export_fig Scatter_Standard_EachSubject_OnlyAll.png -q101

save(strcat('Scatter_Standard_each.mat'),'stdz_mriA_sub','stdz_mriB_sub','stdz_mriC_sub','stdz_ocmA_sub','stdz_ocmB_sub','stdz_ocmC_sub');

%% 2. Standardize entire data together (from raw data)
%Get entire SD and mean
meanABC_mri = mean([mri_runA mri_runB mri_runC]);
meanABC_ocm = mean([ocm_runA ocm_runB ocm_runC]);
sdABC_mri = std([mri_runA mri_runB mri_runC]);
sdABC_ocm = std([ocm_runA ocm_runB ocm_runC]);

%Standardization of the entire data
stdz_mri = ([mri_runA mri_runB mri_runC] - meanABC_mri) / sdABC_mri;
stdz_ocm = ([ocm_runA ocm_runB ocm_runC] - meanABC_ocm) / sdABC_ocm;

%Separate to runA, B, and C
stdz_mri_A = stdz_mri(1:4*numofsubject);
stdz_mri_B = stdz_mri(4*numofsubject+1:4*numofsubject+5*numofsubject);
stdz_mri_C = stdz_mri(4*numofsubject+5*numofsubject+1:4*numofsubject+5*numofsubject+5*numofsubject);

stdz_ocm_A = stdz_ocm(1:4*numofsubject);
stdz_ocm_B = stdz_ocm(4*numofsubject+1:4*numofsubject+5*numofsubject);
stdz_ocm_C = stdz_ocm(4*numofsubject+5*numofsubject+1:4*numofsubject+5*numofsubject+5*numofsubject);

%Visualize
figure('Position', [391 1 450 400]);
subaxis(1,1,1,'SpacingVert',0.07,'SpacingHoriz',0.04);

numA_cnt = 0;
numB_cnt = 0;
numC_cnt = 0;
for sub = 1:num_subject
    scatter(stdz_mri_A(numA_cnt+1:numA_cnt+num_array_A(sub)),stdz_ocm_A(numA_cnt+1:numA_cnt+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mri_B(numB_cnt+1:numB_cnt+num_array_B(sub)),stdz_ocm_B(numB_cnt+1:numB_cnt+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mri_C(numC_cnt+1:numC_cnt+num_array_C(sub)),stdz_ocm_C(numC_cnt+1:numC_cnt+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    
    numA_cnt = numA_cnt+num_array_A(sub);
    numB_cnt = numB_cnt+num_array_B(sub);
    numC_cnt = numC_cnt+num_array_C(sub);
end

xlabel('MRI, DVF');
ylabel('OCM, Mean Square Difference');
title('Standardize from raw');
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
export_fig Scatter_Standard_Alltogether_FromRaw.png -q101

%% 3. Standardize entire data together (after normalize to 1)
%Get entire SD and mean
meanABC_mri = mean([mri_runA_norm mri_runB_norm mri_runC_norm]);
meanABC_ocm = mean([ocm_runA_norm ocm_runB_norm ocm_runC_norm]);
sdABC_mri = std([mri_runA_norm mri_runB_norm mri_runC_norm]);
sdABC_ocm = std([ocm_runA_norm ocm_runB_norm ocm_runC_norm]);

%Standardization of the entire data
stdz_mri = ([mri_runA_norm mri_runB_norm mri_runC_norm] - meanABC_mri) / sdABC_mri;
stdz_ocm = ([ocm_runA_norm ocm_runB_norm ocm_runC_norm] - meanABC_ocm) / sdABC_ocm;

%Separate to runA, B, and C
stdz_mri_A = stdz_mri(1:4*numofsubject);
stdz_mri_B = stdz_mri(4*numofsubject+1:4*numofsubject+5*numofsubject);
stdz_mri_C = stdz_mri(4*numofsubject+5*numofsubject+1:4*numofsubject+5*numofsubject+5*numofsubject);

stdz_ocm_A = stdz_ocm(1:4*numofsubject);
stdz_ocm_B = stdz_ocm(4*numofsubject+1:4*numofsubject+5*numofsubject);
stdz_ocm_C = stdz_ocm(4*numofsubject+5*numofsubject+1:4*numofsubject+5*numofsubject+5*numofsubject);

%Visualize
figure('Position', [391 1 450 400]);
subaxis(1,1,1,'SpacingVert',0.07,'SpacingHoriz',0.04);

numA_cnt = 0;
numB_cnt = 0;
numC_cnt = 0;
for sub = 1:num_subject
    scatter(stdz_mri_A(numA_cnt+1:numA_cnt+num_array_A(sub)),stdz_ocm_A(numA_cnt+1:numA_cnt+num_array_A(sub)),60,C(2,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mri_B(numB_cnt+1:numB_cnt+num_array_B(sub)),stdz_ocm_B(numB_cnt+1:numB_cnt+num_array_B(sub)),60,C(1,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    scatter(stdz_mri_C(numC_cnt+1:numC_cnt+num_array_C(sub)),stdz_ocm_C(numC_cnt+1:numC_cnt+num_array_C(sub)),60,C(3,1:3),'filled',markers{sub},'LineWidth',1.3); hold on;
    
    numA_cnt = numA_cnt+num_array_A(sub);
    numB_cnt = numB_cnt+num_array_B(sub);
    numC_cnt = numC_cnt+num_array_C(sub);
end

xlabel('MRI, DVF');
ylabel('OCM, Mean Square Difference');
title('Normalize to 1 and then standardize');
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])
export_fig Scatter_Standard_Alltogether_FromNorm.png -q101