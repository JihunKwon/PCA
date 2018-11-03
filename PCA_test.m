% 
% filename = 'Output vector field (MRML)_deform_1_2.h5';
% fileinfo=h5info(filename);
% data_fix = h5read(filename,'/TransformGroup/0/TranformParameters');

tic
max_num=15;
data = zeros(29952000,max_num-1);
data_x = zeros(29952000/3,max_num-1);
data_y = zeros(29952000/3,max_num-1);
data_z = zeros(29952000/3,max_num-1);
ave_x = zeros(max_num-1,1);
ave_y = zeros(max_num-1,1);
ave_z = zeros(max_num-1,1);

for i=2:max_num %Time points
    str = num2str(i);
    filename = strcat('Output vector field (MRML)_deform_1_',str,'.h5');
    %h5disp(filename)
    data(:,i-1) = h5read(filename,'/TransformGroup/0/TranformParameters');
    
    count = 1;
    for j=1:29952000 % 1:x,2:y,3:z,4:x,5:y,...
        if rem(j,3)==1
            data_x(count,i-1) = data(j,i-1);
        elseif rem(j,3)==2
            data_y(count,i-1) = data(j,i-1);
        else
            data_z(count,i-1) = data(j,i-1);
            count = count + 1;
        end
            
    end
end

[coeff_x,score_x,latent_x,~,explained_x] = pca(data_x);
[coeff_y,score_y,latent_y,~,explained_y] = pca(data_y);
[coeff_z,score_z,latent_z,~,explained_z] = pca(data_z);

for k=1:max_num-1
    ave_x(k,1) = sum(data_x(:,k))/(29952000/3);
    ave_y(k,1) = sum(data_y(:,k))/(29952000/3);
    ave_z(k,1) = sum(data_z(:,k))/(29952000/3);
end

% figure;
% x=1:14;
% plot(x,explained_x,'-o'); hold on;
% plot(x,explained_y,'-*'); hold on;
% plot(x,explained_z,'-s');
% xlabel('Eigenvector');
% ylabel('Information');
% legend('x','y','z');
% aveas(gcf,strcat('EVvsInfo.pdf'));

%Get first component of score
score_x_FirstComp = score_x(:,1);
score_y_FirstComp = score_y(:,1);
score_z_FirstComp = score_z(:,1);


toc