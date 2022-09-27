function [FLIMdata,FileNames,PathName]=refread(pathorstruc)
% Can be called without an argument to manually select the file(s).
% If called with a string it is interpreted as the absolute path to the
% folder where all ref/r64 need to be read.
% Can also be called with a struct of files obtained from dir([path /*.ref'])
%
% Outputs cell FLIMdata with each component being a stack of 5 images NxNx5
% where each of them are
%   1 - Intensity
%   2 - Harmonic 1 Phase (degrees)
%   3 - Harmonic 1 Modulation
%   4 - Harmonic 2 Phase (degrees)
%   5 - Harmonic 2 Modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LFD crew %%%%%%%%%%%

if(nargin==0)
[FileNames,PathName] = uigetfile({'*.R64;*.ref'},'MultiSelect','On');
else
    if(ischar(pathorstruc))
    PathName=pathorstruc;
    if((strcmpi(PathName(end-2:end),'ref'))||(strcmpi(PathName(end-2:end),'r64')))%its path to a file
       files=dir(PathName); 
       PathName=[files(1).folder filesep];
    else%path to a folder
    if((PathName(end)~='/')&&(PathName(end)~='\')),PathName(end+1)=filesep;end
    files=[dir([PathName '*.ref']);dir([PathName '*.R64'])];
    end
    else
        if(isstruct(pathorstruc))
        PathName=pathorstruc(1).folder;
        if((PathName(end)~='/')&&(PathName(end)~='\')),PathName(end+1)=filesep;end
        files=pathorstruc;
        else
           error('****************** Cant interpret input argument'); 
        end
    end
    for ii=1:length(files)
       FileNames{ii}=files(ii).name; 
    end
end
if((exist('FileNames','var')==0)||(isempty(FileNames))),error('****************** No .ref or .R64 files.');end
% read binary file
if ischar(FileNames)
    tmp=FileNames;
    FileNames=cell(1);
    FileNames{1}=tmp;
end
L=length(FileNames);
FLIMdata=cell(1,L);

for ii=1:L
    type=0;
    fileID = fopen([PathName FileNames{ii}]);
    if(strcmpi(FileNames{ii}(end-2:end),'ref')),input = fread(fileID,inf,'single');type=1;end
    if(strcmpi(FileNames{ii}(end-2:end),'r64')),input = fread(fileID);type=2;end
    fclose(fileID);
    if(type==1)% old refs
        sizes=sqrt(length(input)/5);
        images = reshape(input,sizes,sizes,5);
        FLIMdata{ii}=double(images);
    end
    if(type==2) % for R64 
        % decompress file content
        buffer = java.io.ByteArrayOutputStream();
        zlib = java.util.zip.InflaterOutputStream(buffer);
        zlib.write(input, 0, numel(input));
        zlib.close();
        buffer = buffer.toByteArray();
        % read image dimension, number of images, and image data from
        % decompressed buffer
        nimages = 5;
        img=typecast(buffer(5:end), 'single');
        sizes=sqrt(length(img)/nimages);
        images = reshape(img, sizes, sizes, nimages);
        FLIMdata{ii}=double(images);
    end
end

end
