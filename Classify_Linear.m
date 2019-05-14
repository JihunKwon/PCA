cd('C:\Users\Kwon\Documents\MATLAB\PCA\OCM_Analysis')
load Scatter_Standard_each %'stdz_mriA_sub','stdz_mriB_sub','stdz_mriC_sub','stdz_ocmA_sub','stdz_ocmB_sub','stdz_ocmC_sub'
numofsubject = 5;

data_mri = [stdz_mriA_sub stdz_mriB_sub stdz_mriC_sub]';
data_ocm = [stdz_ocmA_sub stdz_ocmB_sub stdz_ocmC_sub]';

for i = 1:numofsubject*(4+5+5)
    if i<= numofsubject*4
        phase{i,1} = 'Before water intake';
    elseif (numofsubject*4 < i) && (i <= numofsubject*(4+5))
        phase{i,1} = 'Shortly after water intake';
    else %10min
        phase{i,1} = '10min after water intake';
    end
end
figure
h1 = gscatter(data_mri,data_ocm,phase,'brg','os^',[],'off');
h1(1).LineWidth = 2;
h1(2).LineWidth = 2;
hl(3).LineWidth = 2;
xlabel('MRI, DVF');
ylabel('OCM, Mean Square Difference');
hold on;

X = [data_mri,data_ocm];
MdlLinear = fitcdiscr(X,phase);%1:10min, 2:Before, 3:Shortly after
%After and 10min
MdlLinear.ClassNames([1 3]);
K = MdlLinear.Coeffs(1,3).Const;
L = MdlLinear.Coeffs(1,3).Linear;

f = @(x1,x2)K + L(1)*x1 + L(2)*x2;
%f = K + L(1)*x1 + L(2)*x2;
h2 = fimplicit(f);
h2.Color = 'k';
h2.LineWidth = 2;
%h2.DisplayName = 'Boundary between after and 10min after';

legend('Before water intake','Shortly after water intake','10min after water intake','Boundary','Location','southeast','FontSize',8);
xlim([-2.4 2.4]); ylim([-2.4 2.4]);
box on;
set(gcf, 'Color', 'w');
pbaspect([1 1 1])

%%Calculate ROC here
Line_X = h2.XData;
Line_Y = h2.YData;
y = fit(Line_X',Line_Y','linearinterp'); %Get equation of the boundary
output = [];
%Create output
for a = (size(stdz_mriA_sub,2)+size(stdz_mriB_sub,2))+1:size(data_mri) %Scan "10min"
    temp = [data_mri(a) data_ocm(a)];
    if temp <= y(data_mri(a)) %If below boundary
        output{a} = 'True';
    else
        output{a} = 'False';
    end    
end

%Remove "before" and "shortly after" phases
output = output((size(stdz_mriA_sub,2)+size(stdz_mriB_sub,2))+1:size(data_mri));

%Calculate ROC
[X,Y,T,AUC] = perfcurve(phase,score(:,1),'virginica');