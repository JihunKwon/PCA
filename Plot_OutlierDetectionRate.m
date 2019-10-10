% Plot outlier detection rate
num_sub = 6;
num_ocm = 3;

cd('C:\Users\Kwon\PycharmProjects\PancOCM_ML')
odr = xlsread('mXsd_detection rate_matlab.xlsx',6);

cd('C:\Users\Kwon\Documents\MATLAB\PCA')

%initialize
odr_raw = zeros(1+num_ocm*num_sub,10);
odr_ave = zeros(1+num_sub,10);

odr_raw(1,:) = odr(1,:);

for sub = 1:num_sub
    for ocm = 1:num_ocm
        odr_raw(1+(sub-1)*num_ocm+ocm,:) = odr(3+(sub-1)*(num_ocm+3)+ocm,:);
    end
end

% Get average
for sub = 1:num_sub
    for bh = 1:10
        if sub == 6 && bh > 5
            odr_ave(1+sub,bh) = mean(odr_raw(1+(sub-1)*(num_ocm)+2 : 1+(sub-1)*(num_ocm)+3,bh));
        else
            odr_ave(1+sub,bh) = mean(odr_raw(1+(sub-1)*(num_ocm)+1 : 1+(sub-1)*(num_ocm)+3,bh));
        end
    end
end
    


%% Plot the result
i=1;
figure
set(gcf, 'Position', [0 0 550 450], 'Color', 'w')
i=i+1;
plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s1 exp1','LineStyle','-','Color',[0 0 1],'LineWidth',1.2,'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
i=i+1;
plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s1 exp2','LineStyle','--','Color',[0 0 1],'LineWidth',1.2,'Marker','o'); hold on;
i=i+1;
plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s2 exp1','LineStyle','-','Color',[1 0 0],'LineWidth',1.2,'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
i=i+1;
plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s2 exp2','LineStyle','--','Color',[1 0 0],'LineWidth',1.2,'Marker','s'); hold on;
i=i+1;
plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s3 exp1','LineStyle','-','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
i=i+1;
plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s3 exp2','LineStyle','--','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^'); hold on;

legend({'Subject1 exp1','Subject1 exp2','Subject2 exp1','Subject2 exp2','Subject3 exp1','Subject3 exp2'} ... 
    ,'Location','northwest','FontSize',12);

xlabel('Breath-holds');
ylabel('Outlier detection rate (%)');
ax = gca;
ax.FontSize = 12;
grid on;
xlim([1 10])
xticks(1:1:10);
yticks(0:10:100);

box on;
export_fig odr.eps
export_fig odr.png