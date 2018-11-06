%Crop dicom before applying DIR.

dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run1');
% dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v1_run2');
% dirname = ('C:\Users\jihun\Documents\MATLAB\PCA\v2_run1');

% %load('param_DVF_xyz.mat');
% data_x_1 = data_x(:,14);
% data_y_1 = data_y(:,14);
% data_z_1 = data_z(:,14);

% init=1;
% max=700;
% figure;
% x=init:init+max;
% subplot(3,1,1);
% plot(x,data_x_1(init:init+max),'-o');
% subplot(3,1,2);
% plot(x,data_y_1(init:init+max),'-o');
% subplot(3,1,3);
% plot(x,data_z_1(init:init+max),'-o');


% figure;
% [X,Y,Z] = meshgrid(5:10:315,1,5:10:315);
% quiver3(X,Y,Z,data_x_1(X),data_y_1(Y),data_z_1(Z));
% xlabel('x');
% ylabel('y');
% zlabel('z');

figure;
[X,Y] = meshgrid(1:5:320,1:5:320);
quiver(X,Y,data_x_1(X),data_y_1(Y));
xlabel('x');
ylabel('y');