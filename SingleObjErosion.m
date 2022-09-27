function Smallobj = SingleObjErosion(tempObjPix,ImGaussFilteredd)

%Call out imported object only
tempImSizeArray = zeros(size(ImGaussFilteredd));
rows = tempObjPix(:,1) ;
cols = tempObjPix(:,2) ;
for i = 1:length(tempObjPix)
   
   tempImSizeArray(rows(i),cols(i)) = 1;
end
tempImSizeArray = fliplr(imrotate(tempImSizeArray,-90));
tempImObj = ImGaussFilteredd.*tempImSizeArray;

ObjProps = regionprops(tempImSizeArray,'Area','BoundingBox');
%Set bounding box parameters of wanted ROI
Bcols=round(ObjProps.BoundingBox(1,1):sum(ObjProps.BoundingBox(1,[1 3])));
Brows=round(ObjProps.BoundingBox(1,2):sum(ObjProps.BoundingBox(1,[2 4])));
if (max(Bcols) > 256)
    Bcols(length(Bcols)) = 256;
elseif (max(Brows) > 256)
    Brows(length(Brows)) = 256;
end
    
Area = [ObjProps.Area];
i = 5;
wb = waitbar(0, 'converging image...');
while (max(Area) > 200)
    i = i + 1;
    se = offsetstrel('ball',i,i);
    ImEroseInt = imerode(tempImObj,se);
    ImEroseInt = mat2gray(ImEroseInt);
    ImEroseBW = zeros(size(ImEroseInt));
    ImEroseBW(ImEroseInt>0.3) = 1; 
    Objlabel = bwlabel(ImEroseBW);
    ObjProps = regionprops(Objlabel,'Area','BoundingBox');
    Area = [ObjProps.Area];
    if i > 100
        
        break
    end
    waitbar(200/max(Area),wb);
end
close(wb);

ImCrop = ImEroseInt(Brows,Bcols);
Smallobj = struct('Objects',ImCrop);


end