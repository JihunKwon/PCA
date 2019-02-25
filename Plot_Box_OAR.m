%This script plots box plots for PTV and OARs.

num_sub = 2; %number of subjects

cd('C:\Users\jihun\Documents\US_MRI');
OAR_vol = xlsread('Planning Results_Escalation_vol.xlsx',1);
cd('C:\Users\jihun\Documents\MATLAB\PCA');

%Initialize parameters
PTV1 = zeros(1,num_sub*2*3); %num_subject*run(1&2)*timepoints
PTV2 = zeros(1,num_sub*2*3);
PTV3 = zeros(1,num_sub*2*3);

Duo_v30 = zeros(1,num_sub*2*3);
Duo_v35 = zeros(1,num_sub*2*3);
Duo_v40 = zeros(1,num_sub*2*3);

Stom_v30 = zeros(1,num_sub*2*3);
Stom_v35 = zeros(1,num_sub*2*3);
Stom_v40 = zeros(1,num_sub*2*3);

add=0;
%Put values to parameters
for tp = 1:3
    for sub = 1:num_sub
        for run = 1:2
            PTV1(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+1,(sub-1)*6+tp);
            PTV2(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+2,(sub-1)*6+tp);
            PTV3(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+3,(sub-1)*6+tp);
            Duo_v30(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+4,(sub-1)*6+tp);
            Duo_v35(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+5,(sub-1)*6+tp);
            Duo_v40(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+6,(sub-1)*6+tp);
            Stom_v30(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+7,(sub-1)*6+tp);
            Stom_v35(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+8,(sub-1)*6+tp);
            Stom_v40(1,(tp-1)*3+(sub-1)*num_sub+run+add) = OAR_vol((run-1)*14+9,(sub-1)*6+tp);
        end
    end
    add = add+1; %To adjust cell number, have to add one every loop of tp.
end

g = [zeros(1,num_sub*2), ones(1,num_sub*2), 2*ones(1,num_sub*2)];

%Plot Box plots.
%Plot PTVs
figure('Position', [391 100 1000 400]);
subaxis(1,3,1,'SpacingHoriz',0.1,'MR',0);
boxplot(PTV1, g);
ylabel('Coverage (%)');
title('PTV1, V33');
ylim([95 100]);
set(gcf, 'Color', 'w');
subaxis(1,3,2,'SpacingHoriz',0.1,'MR',0);
boxplot(PTV2, g);
ylabel('Coverage (%)');
title('PTV2, V50');
ylim([95 100]);
subaxis(1,3,3,'SpacingHoriz',0.1,'MR',0);
boxplot(PTV3, g);
ylabel('Coverage (%)');
title('PTV3, V60');
ylim([95 100]);
%saveas(gcf,'BoxPlots_PTV.tif');
export_fig BoxPlots_PTV.tif -q101
export_fig BoxPlots_PTV.pdf

%Plot Duodenum
figure('Position', [391 100 1000 400]);
subaxis(1,3,1,'SpacingHoriz',0.1,'MR',0);
boxplot(Duo_v30, g);
hold on;
xl = get(gca, 'XLim');
line( xl, [3 3],'Color','black','LineStyle','--');
ylabel('Volume (cc)');
title('Duodenum V30');

subaxis(1,3,2,'SpacingHoriz',0.1,'MR',0);
boxplot(Duo_v35, g);
hold on;
xl = get(gca, 'XLim');
line( xl, [1 1],'Color','black','LineStyle','--');
ylabel('Volume (cc)');
title('Duodenum V35');

subaxis(1,3,3,'SpacingHoriz',0.1,'MR',0);
boxplot(Duo_v40, g);
hold on;
xl = get(gca, 'XLim');
line( xl, [0.5 0.5],'Color','black','LineStyle','--');
ylabel('Volume (cc)');
title('Duodenum V40');
set(gcf, 'Color', 'w');
%saveas(gcf,'BoxPlots_PTV.tif');
export_fig BoxPlots_Duo.tif -q101
export_fig BoxPlots_Duo.pdf

%Plot Stomach
figure('Position', [391 100 1000 400]);
subaxis(1,3,1,'SpacingHoriz',0.1,'MR',0);
boxplot(Stom_v30, g); 
hold on;
xl = get(gca, 'XLim');
line( xl, [2 2],'Color','black','LineStyle','--');
ylabel('Volume (cc)');
title('Stomach V30');

subaxis(1,3,2,'SpacingHoriz',0.1,'MR',0);
boxplot(Stom_v35, g);
hold on;
xl = get(gca, 'XLim');
line( xl, [1 1],'Color','black','LineStyle','--');
ylabel('Volume (cc)');
title('Stomach V35');

subaxis(1,3,3,'SpacingHoriz',0.1,'MR',0);
boxplot(Stom_v40, g);
hold on;
xl = get(gca, 'XLim');
line( xl, [0.5 0.5],'Color','black','LineStyle','--');
ylabel('Volume (cc)');
title('Stomach V40');
set(gcf, 'Color', 'w');
%saveas(gcf,'BoxPlots_PTV.tif');
export_fig BoxPlots_Stom.tif -q101
export_fig BoxPlots_Stom.pdf