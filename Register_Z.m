function [] = Register_Z(sub_run)
%Modify dicom info
%subject's (s3) position in Z direction was very different between before,
%after, and 10 min after. This function change dicominfo to register them.

%Adjust z position of after and 10min after to before.
adjustZ_bef_aft = -125.884;
adjustZ_bef_10m = -20.867;
adjustZ_bef_10m_14 = -20.867-3; %14th scan was not registered well. So manually adjust.

%sub_run = 's1r1';

if strcmp(sub_run,'s1r1')
    %s1r1
    offset_Z = [11 9 8 7 8 9 2 2 2 3 13 8 12 13 14];
    dir_name = ["C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN1_0027",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN1_0028",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN1_0030",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN1_0032",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN1_0034",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN2_0038",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN2_0039",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN2_0041",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN2_0043",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN2_0045",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN3_0047",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN3_0048",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN3_0050",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN3_0052",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20180928\AX_T1FS_3D_TR_3_23_GRAPPA_RUN3_0054"];
            
elseif strcmp(sub_run,'s1r2')
    %s1r2
    offset_Z = [13 13 13 12 14 15 12 14 15 14 16 15 18 15 17];
    dir_name = ["C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\2",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\3",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\5",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\7",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\9",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\12",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\13",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\15",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\17",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\19",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\21",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\22",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\24",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\26",
                "C:\Users\jihun\Documents\US_MRI\Subject_01_20181102\28"];
                
elseif strcmp(sub_run,'s2r1')
    %s2r1
    offset_Z = [7 8 8 7 6 11 13 11 12 11 9 11 10 12 11];
    dir_name = ["C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\3",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\4",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\6",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\8",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\10",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\13",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\14",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\16",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\18",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\20",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\22",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\23",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\25",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\27",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181102\29"];
elseif strcmp(sub_run,'s2r2')
    %s2r2
    offset_Z = [10 12 11 11 10 8 10 12 13 15 18 17 16 18 17];
    dir_name = ["C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 002 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 003 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 005 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 007 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 009 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 011 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 012 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 014 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 016 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 018 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 020 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 021 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 023 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 025 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",
                "C:\Users\jihun\Documents\US_MRI\Subject_02_20181220\Series 027 [MR - AX T1FS 3D TR 3 23 GRAPPA 20180927]",];
elseif strcmp(sub_run,'s3r2')
    %s2r2
    offset_Z = [0 0 0 0 0 11 11 11 11 11 11 11 11 11 11];
    dir_name = ["/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0005",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0006",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0008",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0010",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0012",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0015",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0016",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0018",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0020",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0022",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0025",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0026",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0028",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0030",
                "/Users/Kwon/Documents/Subject_03_20190320/AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0032",];
end
            
            
if strcmp(sub_run,'s3r1') == 0
    for tp = 1:15
        cd(dir_name(tp));
        mkdir dicom_new
        dicomlist = dir(fullfile(dir_name(tp),'*.IMA'));

        if strcmp(sub_run,'s2r2')
            dicomlist = dir(fullfile(dir_name(tp),'*.dcm'));
        end

        %clearvars -except tp offset_Z dir_name dicomlist
        for cnt = 1 : numel(dicomlist)
            meta = dicominfo(dicomlist(cnt).name);
            pri1015 = meta.Private_0019_1015;
            pos = meta.ImagePositionPatient;
            pos_new = [pos(1);pos(2);pos(3)+(offset_Z(1)-offset_Z(tp))*2];
            meta.ImagePositionPatient = pos_new;
            meta.Private_0019_1015 = pos_new;

            X = dicomread(dicomlist(cnt).name); 

            fname = strcat('MR_',num2str(cnt),'.dcm');
            cd dicom_new\
            dicomwrite(X, fname, meta);
            %dicomwrite(X, fname, meta, 'CreateMode', 'copy');
            cd ..
        end
    end
end




%% This part is for "S3r1". Special registration was needed.
if strcmp(sub_run,'s3r1')

    %{
    %% After1
    % Import DICOM
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0014';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end

    %% After2
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0015';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end


    %% After3
    % Import DICOM
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0017';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end

    %% After4
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0019';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end

    %% After5
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0021';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_aft];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end


    %% 10min 1
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0024';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end


    %% 10min 2
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0025';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end


    %% 10min 3
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0027';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end
    %}

    %% 10min 4
    dir_name = 'C:\Users\Kwon\Documents\Panc_OCM\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0029';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m_14];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end
    %{
    %% 10min 5
    dir_name = 'C:\Users\jihun\Documents\US_MRI\Subject_03_20190228\AX_T1FS_3D_TR_3_23_GRAPPA_20180927_0031';
    cd(dir_name);
    mkdir dicom_new
    dicomlist = dir(fullfile(dir_name,'*.IMA'));

    for cnt = 1 : numel(dicomlist)
        meta = dicominfo(dicomlist(cnt).name);
        pri1015 = meta.Private_0019_1015;
        pos = meta.ImagePositionPatient;
        pos_new = [pos(1);pos(2);pos(3)+adjustZ_bef_10m];
        meta.ImagePositionPatient = pos_new;
        meta.Private_0019_1015  = pos_new;

        X = dicomread(dicomlist(cnt).name); 

        fname = strcat('MR_',num2str(cnt),'.dcm');
        cd dicom_new\
        dicomwrite(X, fname, meta, 'CreateMode', 'copy');
        cd ..
    end
    %}
end
