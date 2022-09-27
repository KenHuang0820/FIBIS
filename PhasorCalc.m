function Phasor = PhasorCalc(props,G)

for MitoLabel = 1:length(props)
   pixelLocation = round(props(MitoLabel).ConvexHull);
   row = pixelLocation(:,1); col = pixelLocation(:,2);
   
   for i = 1:length(row)
      if col(i) > 256
          col(i) = 256;
      end
   end
   
   Gsum = 0;

   for pixel = 1:length(pixelLocation)
       Gvalue = G(row(pixel),col(pixel)); 
       Gsum = Gsum + Gvalue;
   end
   Gaverage = Gsum/length(pixelLocation);
   Phasor(MitoLabel) = Gaverage;    
   
end
    Phasor = Phasor';

end

