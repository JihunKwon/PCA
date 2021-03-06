% Plot outlier detection rate
num_sub = 6;
num_ocm = 3;

cd('C:\Users\Kwon\PycharmProjects\PancOCM_ML')
%odr = xlsread('mXsd_detection rate_matlab.xlsx',6);
odr = xlsread('mXsd_detection rate_matlab.xlsx',7); % Mahalanobis distance

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

% area plot
ha1 = area([1 5], [100 100], 'LineStyle','none'); hold on;
ha2 = area([6 10], [100 100], 'LineStyle','none'); hold on;
alpha(ha1,.15)
alpha(ha2,.15)

i=i+1;
p1 = plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s1 exp1','LineStyle','-','Color',[0 0 1],'LineWidth',1.2,'Marker','o','MarkerFaceColor',[0 0 1]); hold on;
i=i+1;
p2 = plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s1 exp2','LineStyle','--','Color',[0 0 1],'LineWidth',1.2,'Marker','o'); hold on;
i=i+1;
p3 = plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s2 exp1','LineStyle','-','Color',[1 0 0],'LineWidth',1.2,'Marker','s','MarkerFaceColor',[1 0 0]); hold on;
i=i+1;
p4 = plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s2 exp2','LineStyle','--','Color',[1 0 0],'LineWidth',1.2,'Marker','s'); hold on;
i=i+1;
p5 = plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s3 exp1','LineStyle','-','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^','MarkerFaceColor',[0 0.6 0]); hold on;
i=i+1;
p6 = plot(odr_raw(1,1:10),odr_ave(i,1:10),'DisplayName','s3 exp2','LineStyle','--','Color',[0 0.6 0],'LineWidth',1.2,'Marker','^'); hold on;

% average
p7 = plot(odr_raw(1,1:10), mean(odr_ave(2:7,1:10)),'DisplayName','Average','LineStyle','-','Color',[0 0 0],'LineWidth',1.2,'Marker','v','MarkerFaceColor',[0 0 0]); hold on;



legend([p1 p2 p3 p4 p5 p6 p7], {'Subject1 exp1','Subject1 exp2','Subject2 exp1','Subject2 exp2','Subject3 exp1','Subject3 exp20','Average'} ... 
    ,'Location','northwest','FontSize',12);

xlabel('Breath-holds');
ylabel({'Confidence that the anatomy has';'actually changed (ODR, %)'})
ax = gca;
ax.FontSize = 12;
grid on;
xlim([1 10])
xticks(1:1:10);
yticks(0:10:100);

box on;
export_fig odr_mahala.eps
export_fig odr_mahala.png
%export_fig odr_mean.eps
%export_fig odr_mean.png