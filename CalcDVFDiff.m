function CalcDVFDiff(data_x,data_y,data_z,dirname)

%Calculate scalar of xyz components

cd(dirname);

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
ave = (ave_x + ave_y + ave_z)/3;
save(strcat('DVF_diff.mat'),'ave','sum');


