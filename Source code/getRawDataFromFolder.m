function [int G] = getRawDataFromFolder(FLIM)

int=FLIM{1}(:,:,1);
pha=FLIM{1}(:,:,2)*3.1416/180;
mod=FLIM{1}(:,:,3);
G=mod.*cos(pha);
S=mod.*sin(pha);



end