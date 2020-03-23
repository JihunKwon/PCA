%% This code import bin file
clear
for i = 5:6
    fprintf('Subject %d starting\n', i)
    % Chose directory
    if i == 1
        path = 'C:\Users\Kwon\Documents\Panc_OCM\Subject_01_20180928\';
    elseif i == 2
        path = 'C:\Users\Kwon\Documents\Panc_OCM\Subject_01_20181102\';
    elseif i == 3
        path = 'C:\Users\Kwon\Documents\Panc_OCM\Subject_02_20181102\';
    elseif i == 4
        path = 'C:\Users\Kwon\Documents\Panc_OCM\Subject_02_20181220\';
    elseif i == 5
        path = 'C:\Users\Kwon\Documents\Panc_OCM\Subject_03_20190228\';
    elseif i == 6
        path = 'C:\Users\Kwon\Documents\Panc_OCM\Subject_03_20190320\';
    end
    
    % Start converting
    for j = 1:3
        fprintf('OCM %d converting...\n', j)
        num = num2str(j);
        filename = strcat('run', num);

        binname = '.bin';

        totalname = strcat(path, filename, binname);

        fileID = fopen(totalname, 'rb', 'ieee-le');
        if fileID == -1, error('Cannot open file: %s', totalname); end
        format = 'int16';
        Data = fread(fileID, Inf, format);
        fclose(fileID);

        cd(path)
        matname = '.mat';
        savename = strcat(filename, matname);
        save(savename, 'Data', '-v7.3')
    end
end