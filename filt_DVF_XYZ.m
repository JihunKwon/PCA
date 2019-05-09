function [X_g,Y_g,Z_g] = filt_DVF_XYZ(X,Y,Z)
%vis_DVF_XYZ Analyze DVF pixel-by-pixel.
%   Visuzlize each direction of DVF and smooth it.  

%% Visualize raw DVF
figure
set(gcf,'Position',[200 200 500 700], 'Color', 'w')
subaxis(3,1,1,'SpacingVert',0.03,'SpacingHoriz',0.005);
imshow(X(:,:,27,5),'DisplayRange',[-4 4]);
title('DVF X component'); colorbar
subaxis(3,1,2,'SpacingVert',0.03,'SpacingHoriz',0.005);
imshow(Y(:,:,27,5),'DisplayRange',[-4 4]);
title('DVF, Y component'); colorbar
subaxis(3,1,3,'SpacingVert',0.03,'SpacingHoriz',0.005);
imshow(Z(:,:,27,5),'DisplayRange',[-4 4]);
title('DVF, Z component'); colorbar; colormap parula; 
%export_fig DVF_XYZ_components.png -q101

%% Smoothing and Visualize
sigma = 1;
X_g = zeros(size(X));
Y_g = zeros(size(X));
Z_g = zeros(size(X));

for tp = 1:size(X,4)
    for z = 1:size(X,3) %number of Z slice
        X_g(:,:,z,tp) = imgaussfilt(X(:,:,z,tp),sigma);
        Y_g(:,:,z,tp) = imgaussfilt(Y(:,:,z,tp),sigma);
        Z_g(:,:,z,tp) = imgaussfilt(Z(:,:,z,tp),sigma);
    end
end

figure
set(gcf,'Position',[200 200 500 700], 'Color', 'w')
subaxis(3,1,1,'SpacingVert',0.03,'SpacingHoriz',0.005);
imshow(X_g(:,:,27,5),'DisplayRange',[-4 4]);
title('DVF X component, filtered'); colorbar
subaxis(3,1,2,'SpacingVert',0.03,'SpacingHoriz',0.005);
imshow(Y_g(:,:,27,5),'DisplayRange',[-4 4]);
title('DVF, Y component, filtered'); colorbar
subaxis(3,1,3,'SpacingVert',0.03,'SpacingHoriz',0.005);
imshow(Z_g(:,:,27,5),'DisplayRange',[-4 4]);
title('DVF, Z component, filtered'); colorbar; colormap parula; 
%export_fig DVF_XYZ_components_filtered.png -q101

end

