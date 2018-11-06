%Calculate scalar of xyz components


%dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run1');
%dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');


sum_x = zeros(14,1);
sum_y = zeros(14,1);
sum_z = zeros(14,1);

data_x = abs(data_x);
data_y = abs(data_y);
data_z = abs(data_z);

for i=1:14
    sum_x(i) = sum(data_x(:,i));
    sum_y(i) = sum(data_y(:,i));
    sum_z(i) = sum(data_z(:,i));
end 

ave_x = sum_x / size(data_x,1);
ave_y = sum_y / size(data_x,1);
ave_z = sum_z / size(data_x,1);

sum = sum_x + sum_y + sum_z;
ave = (sum_x + sum_y + sum_z)/3;
save(strcat('DVF_diff.mat'),'ave','sum');


