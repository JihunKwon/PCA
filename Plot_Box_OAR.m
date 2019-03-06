%This script plots box plots for PTV and OARs.
close all
num_sub = 3; %number of subjects

cd('C:\Users\jihun\Documents\US_MRI');
OAR_vol = xlsread('Planning Results_Escalation_vol.xlsx',1);
%OAR_vol = xlsread('Planning Results_Escalation_vol2.xlsx',1);
cd('C:\Users\jihun\Documents\MATLAB\PCA');

%Initialize parameters
xtl_time = {{'Before';'water intake'} {'Shortly after';'water intake'} {'10 min after';'water intake'}};
xtl_Constrains = {'V30'; 'V35'; 'V40'};
PTV1 = zeros(1,15); %num_subject*run(1&2)*timepoints
PTV2 = zeros(1,15);
PTV3 = zeros(1,15);

Duo_v30 = zeros(1,15);
Duo_v35 = zeros(1,15);
Duo_v40 = zeros(1,15);

Stom_v30 = zeros(1,15);
Stom_v35 = zeros(1,15);
Stom_v40 = zeros(1,15);

add=0;
cnt=1;
%Put values to parameters
for tp = 1:3
    for sub = 1:num_sub
        for run = 1:2
            PTV1(1,cnt) = OAR_vol((run-1)*14+1,(sub-1)*6+tp);
            PTV2(1,cnt) = OAR_vol((run-1)*14+2,(sub-1)*6+tp);
            PTV3(1,cnt) = OAR_vol((run-1)*14+3,(sub-1)*6+tp);
            Duo_v30(1,cnt) = OAR_vol((run-1)*14+4,(sub-1)*6+tp);
            Duo_v35(1,cnt) = OAR_vol((run-1)*14+5,(sub-1)*6+tp);
            Duo_v40(1,cnt) = OAR_vol((run-1)*14+6,(sub-1)*6+tp);
            Stom_v30(1,cnt) = OAR_vol((run-1)*14+7,(sub-1)*6+tp);
            Stom_v35(1,cnt) = OAR_vol((run-1)*14+8,(sub-1)*6+tp);
            Stom_v40(1,cnt) = OAR_vol((run-1)*14+9,(sub-1)*6+tp);
            cnt = cnt+1;
        end
    end
    add = add+1; %To adjust cell number, have to add one every loop of tp.
end

%Remove nan
PTV1 = PTV1(~isnan(PTV1));
PTV2 = PTV2(~isnan(PTV2));
PTV3 = PTV3(~isnan(PTV3));
Duo_v30 = Duo_v30(~isnan(Duo_v30));
Duo_v35 = Duo_v35(~isnan(Duo_v30));
Duo_v40 = Duo_v40(~isnan(Duo_v40));
Stom_v30 = Stom_v30(~isnan(Stom_v30));
Stom_v35 = Stom_v35(~isnan(Stom_v35));
Stom_v40 = Stom_v40(~isnan(Stom_v40));

g = [zeros(1,num_sub*2), ones(1,num_sub*2), 2*ones(1,num_sub*2)];

%Re-ordering 1*12 array to 4*3. This is necessarily for scatter plot.
PTV1_re = Reorder(PTV1);
PTV2_re = Reorder(PTV2);
PTV3_re = Reorder(PTV3);
Duo_v30_re = Reorder(Duo_v30);
Duo_v35_re = Reorder(Duo_v35);
Duo_v40_re = Reorder(Duo_v40);
Stom_v30_re = Reorder(Stom_v30);
Stom_v35_re = Reorder(Stom_v35);
Stom_v40_re = Reorder(Stom_v40);

[r,c] = size(PTV1_re);
xdata = repmat(1:c, r, 1);

%% Plotting Starts. Plot Box plots.
%{
%Plot PTVs
figure('Position', [391 100 1000 300]);
subaxis(1,3,1,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(PTV1, g);
title('PTV1, V33'); ylabel('Coverage (%)'); ylim([91 100]);

subaxis(1,3,2,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(PTV2, g);
title('PTV2, V50'); ylabel('Coverage (%)'); ylim([91 100]);

subaxis(1,3,3,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(PTV3, g);
title('PTV3, V60'); ylabel('Coverage (%)'); ylim([91 100]);

set(gcf, 'Color', 'w');
export_fig BoxPlots_PTV.tif -q101
export_fig BoxPlots_PTV.pdf

%Plot Duodenum
figure('Position', [391 100 1000 300]);
subaxis(1,3,1,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(Duo_v30, g); hold on;
xl = get(gca, 'XLim'); line( xl, [3 3],'Color','black','LineStyle','--');
title('Duodenum, V30'); ylabel('Volume (cc)');
subaxis(1,3,2,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);

boxplot(Duo_v35, g); hold on;
xl = get(gca, 'XLim'); line( xl, [1 1],'Color','black','LineStyle','--');
title('Duodenum, V35'); ylabel('Volume (cc)');

subaxis(1,3,3,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(Duo_v40, g); hold on;
xl = get(gca, 'XLim'); line( xl, [0.5 0.5],'Color','black','LineStyle','--');
title('Duodenum, V40'); ylabel('Volume (cc)');  
set(gcf, 'Color', 'w');
export_fig BoxPlots_Duo.tif -q101
export_fig BoxPlots_Duo.pdf

%Plot Stomach
figure('Position', [391 100 1000 300]);
subaxis(1,3,1,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(Stom_v30, g); hold on;
xl = get(gca, 'XLim'); line( xl, [2 2],'Color','black','LineStyle','--');
title('Stomach, V30'); ylabel('Volume (cc)');  

subaxis(1,3,2,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(Stom_v35, g); hold on;
xl = get(gca, 'XLim'); line( xl, [1 1],'Color','black','LineStyle','--');
title('Stomach, V35'); ylabel('Volume (cc)');  

subaxis(1,3,3,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
boxplot(Stom_v40, g); hold on;
xl = get(gca, 'XLim'); line( xl, [0.5 0.5],'Color','black','LineStyle','--');
title('Stomach, V40'); ylabel('Volume (cc)');
set(gcf, 'Color', 'w');  
export_fig BoxPlots_Stom.tif -q101
export_fig BoxPlots_Stom.pdf
%}

%% Plot Scatter plots.
%Plot PTVs
figure('Position', [391 100 1000 300]);
subaxis(1,3,1,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = PTV1_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [95 95],'Color','black','LineStyle','--');
ylim([91 max(ydata(:)+0.5)])
title('PTV1, V33'); ylabel('Coverage (%)'); ylim([91 100.5])
h = my_xticklabels(gca,[1 2 3],xtl_time);

subaxis(1,3,2,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = PTV2_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [95 95],'Color','black','LineStyle','--');
ylim([91 max(ydata(:)+0.5)])
title('PTV2, V50'); ylabel('Coverage (%)'); ylim([91 100.5]);
h = my_xticklabels(gca,[1 2 3],xtl_time);
set(gcf, 'Color', 'w');

subaxis(1,3,3,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = PTV3_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [95 95],'Color','black','LineStyle','--');
ylim([91 max(ydata(:)+0.5)])
title('PTV3, V60'); ylabel('Coverage (%)'); ylim([91 100.5]);
h = my_xticklabels(gca,[1 2 3],xtl_time);

set(gcf, 'Color', 'w');
export_fig ScatPlots_PTV.tif -q101
export_fig ScatPlots_PTV.pdf

%Plot Duodenum
figure('Position', [391 100 1000 300]);
subaxis(1,3,1,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Duo_v30_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [3 3],'Color','black','LineStyle','--');
title('Duodenum, V30'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 3.5]);

subaxis(1,3,2,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Duo_v35_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [1 1],'Color','black','LineStyle','--');
title('Duodenum, V35'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 3.5]);

subaxis(1,3,3,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Duo_v40_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [0.5 0.5],'Color','black','LineStyle','--');
title('Duodenum, V40'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 3.5]);

set(gcf, 'Color', 'w');
export_fig ScatPlots_Duo.tif -q101
export_fig ScatPlots_Duo.pdf

%Plot Stomach
figure('Position', [391 100 1000 300]);
subaxis(1,3,1,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Stom_v30_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [2 2],'Color','black','LineStyle','--');
title('Stomach, V30'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 9]);

subaxis(1,3,2,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Stom_v35_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [1 1],'Color','black','LineStyle','--');
title('Stomach, V35'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 9]);

subaxis(1,3,3,'SpacingHoriz',0.08,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Stom_v40_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-');
hold on;
xl = get(gca, 'XLim'); line( xl, [0.5 0.5],'Color','black','LineStyle','--');
title('Stomach, V40'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 9]);

set(gcf, 'Color', 'w');
export_fig ScatPlots_Stom.tif -q101
export_fig ScatPlots_Stom.pdf

%% Plot summary (PTV1, StomachV30, DuodenumV30)
%Plot Stomach
figure('Position', [391 100 1050 330]);
subaxis(1,3,1,'SpacingHoriz',0.05,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Stom_v30_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-','LineWidth',1);
hold on;
xl = get(gca, 'XLim'); line( xl, [2 2],'Color','black','LineStyle','--');
title('Stomach, V30'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 9]);

%Plot Duodenum
subaxis(1,3,2,'SpacingHoriz',0.05,'MR',0.06,'ML',0.1,'MT',0.15);
ydata = Duo_v30_re; %Here define PTV or OAR
scatter(xdata(:), ydata(:),400, 'b.','jitter','on','jitterAmount', 0.05);
hold on; box on;
plot([xdata(1,:)-0.15; xdata(1,:)+0.15], repmat(mean(ydata, 1), 2, 1), 'r-','LineWidth',1);
hold on;
xl = get(gca, 'XLim'); line( xl, [3 3],'Color','black','LineStyle','--');
title('Duodenum, V30'); ylabel('Volume (cc)');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 3.5]);

%Plot OCM
ave_all_ocm_sub = [o_runA_norm_sub o_runB_norm_sub o_runC_norm_sub];
subaxis(1,3,3,'SpacingHoriz',0.05,'MR',0.06,'ML',0.1,'MT',0.17);
boxplot(ave_all_ocm_sub, g_ocm);
ylabel('Mean Square Difference');
title('OCM');
h = my_xticklabels(gca,[1 2 3],xtl_time);
ylim([0 1.1]);

set(gcf, 'Color', 'w');
export_fig ScatPlots_Summary.tif -q101
export_fig ScatPlots_Summary.pdf
