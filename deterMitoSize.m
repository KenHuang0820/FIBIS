function ImMaskMitoSize = deterMitoSize(pxsize,ImMask,ImGaussFilteredd,MaxArea,MinArea)

MaskLabel = bwlabel(ImMask);
MaskProps = regionprops(MaskLabel,'Area','Centroid','ConvexHull','PixelList','BoundingBox');
IntMask = ImGaussFilteredd.*ImMask;
IntMaskSized = IntMask;

for i = 1:length(MaskProps)
    
    mitoArea = pxsize * MaskProps(i).Area;
    if mitoArea < MinArea 
       Bcols=round(MaskProps(i).BoundingBox(1,1):sum(MaskProps(i).BoundingBox(1,[1 3])));
       Brows=round(MaskProps(i).BoundingBox(1,2):sum(MaskProps(i).BoundingBox(1,[2 4])));
        if (max(Bcols) > 256)
            Bcols(length(Bcols)) = 256;
        elseif (max(Brows) > 256)
            Brows(length(Brows)) = 256;
        end
       IntMaskSized(Brows,Bcols) = 0;
    elseif mitoArea > MaxArea
       tempObjPix = MaskProps(i).PixelList;
       Smallobj = SingleObjErosion(tempObjPix,ImGaussFilteredd);
       Bcols=round(MaskProps(i).BoundingBox(1,1):sum(MaskProps(i).BoundingBox(1,[1 3])));
       Brows=round(MaskProps(i).BoundingBox(1,2):sum(MaskProps(i).BoundingBox(1,[2 4])));
       if (max(Bcols) > 256)
            Bcols(length(Bcols)) = 256;
        elseif (max(Brows) > 256)
            Brows(length(Brows)) = 256;
        end
       IntMaskSized(Brows,Bcols) = Smallobj.Objects;
    end
    %show bounding box on original image
    %figure; imagesc(ImGaussFilteredd); axs off; hold on; rectangle('Position',props(1).BoundingBox)
    
    
    
end

ImMaskMitoSize = IntMaskSized;

end

