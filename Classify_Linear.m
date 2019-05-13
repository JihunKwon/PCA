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
legend('Before water intake','Shortly after water intake','10min after water intake','Location','northwest');
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
h2 = fimplicit(f, [0 2 0 2]);
h2.Color = 'r';
h2.LineWidth = 2;
h2.DisplayName = 'Boundary between after and 10min after';


MdlLinear.ClassNames([1 2]);
K = MdlLinear.Coeffs(1,2).Const;
L = MdlLinear.Coeffs(1,2).Linear;

f = @(x1,x2)K + L(1)*x1 + L(2)*x2;
h3 = fimplicit(f);
h3.Color = 'g';
h3.LineWidth = 2;
h3.DisplayName = 'Boundary between before and 10min after';

