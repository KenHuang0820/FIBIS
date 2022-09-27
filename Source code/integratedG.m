function [Phasor, ImLabel] = integratedG(ImMitoSized,G,S)

%% G phasor integration
mask = zeros(size(ImMitoSized));
mask(ImMitoSized > 0) = 1;
GfilterMask = G.*mask;
SfilterMask = S.*mask;
% set(0, 'DefaultFigureColor', 'white');
GA = GfilterMask.*100;
% figure; imagesc(GA); axis off; colormap (Gcolormap); caxis([35 70]); colorbar;
ImLabel = bwlabel(mask);
props = regionprops(ImLabel,'Area','Centroid','ConvexHull','PixelList');
PhasorG = [];
PhasorS = [];

for MitoLabel = 1:length(props)
   
    
   if props(MitoLabel).Area > 1     
        pixelLocation = round(props(MitoLabel).PixelList);
        row = pixelLocation(:,1); col = pixelLocation(:,2);
        Gsum = 0;
        Ssum = 0;
   
   

        for pixel = 1:length(pixelLocation)
            Gvalue = G(col(pixel),row(pixel)); 
            Svalue = S(col(pixel),row(pixel)); 
            Gsum = Gsum + Gvalue;
            Ssum = Ssum + Svalue;
        end
        Gaverage = Gsum/props(MitoLabel).Area;
        Saverage = Ssum/props(MitoLabel).Area;
        
   else
       Gaverage = 0;
       Saverage = 0; 
   end
   
   PhasorG(MitoLabel) = Gaverage;    
   PhasorS(MitoLabel) = Saverage;
end

PhasorG = PhasorG';
PhasorS = PhasorS';
Phasor = [PhasorG PhasorS];
PhasorCell = num2cell(Phasor);
[props.Phasor] = PhasorCell{:};


% figure; imagesc(ImLabel); axis off;
% hold on;
% x = [];
% for i = 1:length(props)
%     x = [x; round(props(i).Centroid)];
%     text(x(i,1)+1, x(i,2)+1, num2str(Phasor(i)), 'color', 'white', 'HorizontalAlignment', 'Center');
% end
% text(0,0,FileNames,'FontSize',14);

end