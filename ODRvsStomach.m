% this code draws correlation between outlier detection rate (ODR) and
% stomach width.


% run two scripts to get variables
%Plot_mri_stomach
%Plot_OutlierDetectionRate

odr_raw_dot = odr_raw';

%% Correlation between OCM0 and stomach width
figure
markers = {'o', 'd', 's', 'v', '^', 'p'};
set(gcf, 'Position', [0 0 450 450], 'Color', 'w')

for sub = 1:6
    if sub == 1
        scatter(mri_stomach_norm_bh1(1:9,sub), odr_raw_dot(1:9,num_ocm*(sub-1)+2), 60, 'filled',markers{sub}); hold on;
    elseif sub < 6
        scatter(mri_stomach_norm_bh1(1:10,sub), odr_raw_dot(1:10,num_ocm*(sub-1)+2), 60, 'filled',markers{sub}); hold on;
    else  % sub=6 ocm0 has no data in state 2
        scatter(mri_stomach_norm_bh1(1:5,sub), odr_raw_dot(1:5,num_ocm*(sub-1)+2), 60, 'filled',markers{sub}); hold on;
        
    end
end

xlabel('Relative stomach width');
ylabel('Outlier detection rate (%)');
title('OCM0');
box on;
pbaspect([1 1 1])

export_fig ODRvsMRI_OCM0.eps
export_fig ODRvsMRI_OCM0.png

%% Correlation between all OCM's average and stomach width
figure
set(gcf, 'Position', [0 0 450 450], 'Color', 'w')

odr_raw_dot(isnan(odr_raw_dot)) = 0;
ave_sub6 = zeros(10,1);
ave_sub6(:,1) = odr_raw_dot(:,17) + odr_raw_dot(:,18) + odr_raw_dot(:,19);
ave_sub6(1:5,1) = ave_sub6(1:5,1)/3;
ave_sub6(6:10,1) = ave_sub6(6:10,1)/2;

for sub = 1:6
    if sub == 1
        scatter(mri_stomach_norm_bh1(1:9,sub), (odr_raw_dot(1:9,num_ocm*(sub-1)+2)+odr_raw_dot(1:9,num_ocm*(sub-1)+3)+odr_raw_dot(1:9,num_ocm*(sub-1)+4))./num_ocm, 60, 'filled',markers{sub}); hold on;
    elseif sub < 6
        scatter(mri_stomach_norm_bh1(1:10,sub), (odr_raw_dot(1:10,num_ocm*(sub-1)+2)+odr_raw_dot(1:10,num_ocm*(sub-1)+3)+odr_raw_dot(1:10,num_ocm*(sub-1)+4))./num_ocm, 60, 'filled',markers{sub}); hold on;
    else  % sub=6 ocm0 has no data in state 2
        scatter(mri_stomach_norm_bh1(1:10,sub), (ave_sub6(1:10,1)), 60, 'filled',markers{sub}); hold on;       
    end
end


xlabel('Relative stomach width');
ylabel('Outlier detection rate (%)');
title('Average of three OCM');
box on;
pbaspect([1 1 1])

export_fig ODRvsMRI_OCMall.eps
export_fig ODRvsMRI_OCMall.png