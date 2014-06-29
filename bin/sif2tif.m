function sif2tif
[FileNames,PathName] = uigetfile('*.sif','Select the SIF File','MultiSelect','on');
% If no sif file selected, return
if isnumeric(FileNames)
    return
end

% Make temporary folder to store tiff image stack, workaround imwrite loop problem
mkdir(PathName,'tempTIFF');

% If single file is selected
if ischar(FileNames)
    temp = FileNames;
    FileNames = {temp};
end

h = waitbar(0,'Converting SIF to TIFF');
N = length(FileNames);
for k = 1:N
    FileName = FileNames{k};
    SIFFile = strcat(PathName,FileName);
    rc = atsif_readfromfile(SIFFile);
    if (rc ~= 22002)
        error('Could not load file.\n Return Code: %d',rc)
    end
    Signal = 0;
    [~,present]=atsif_isdatasourcepresent(Signal);
    [~,no_frames]=atsif_getnumberframes(Signal);
    if ~(present&&no_frames)
        error('No signal data in sif file!')
    end
    
    [~,~,~,right,top,~,~]=atsif_getsubimageinfo(Signal,0);
    [~,Size]=atsif_getframesize(Signal);
        
    % Convert sif file to TIFF image
    tifName = FileName;
    tifName(end-2) = 't';
    tifFile = fullfile(PathName,'tempTIFF',filesep,tifName);
    for i = 1:no_frames
        [~,data] = atsif_getframe(Signal,i-1,Size);
        % Rearrange the data array to normal image matrix format
        imageData = uint16(flipud(reshape(data,right,top)'));
        imwrite(imageData,tifFile,'WriteMode','append');
    end
    atsif_closefile;
    movefile(tifFile,PathName);
    waitbar(k/N)
end

rmdir(strcat(PathName,'tempTIFF'));
close(h)
clc