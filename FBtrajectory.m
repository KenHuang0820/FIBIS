function [fraction]=FBtrajectory(Phasor,G1,S1,G2,S2)

G = Phasor(:,1);
S = Phasor(:,2);
FreePhasor = [0.9611 0.1933]; %for tau = 0.4nsec
BoundPhasor = [0.3231 0.4677]; %for tau = 3.5nsec
fraction = [];
%% Calculate point projected on free bound trajectory line
NormDistance = sqrt(sum((FreePhasor - BoundPhasor).^2));
%Formula of FB trajectory line => 0.2744G + 0.638S -0.3871 = 0

Distance = sqrt((G1-G2)^2+(S1-S2)^2);
c = -G1*(S1-S2)-S1*(G1-G2);

for mitoFB = 1:length(Phasor)

Gproj = G(mitoFB) - (S1-S2)*(c + (S1-S2)*G(mitoFB) + (G1-G2)*S(mitoFB))/((S1-S2)^2+(G1-G2)^2);
Sproj = S(mitoFB) - (G1-G2)*(c + (S1-S2)*G(mitoFB) + (G1-G2)*S(mitoFB))/((S1-S2)^2+(G1-G2)^2);

%Distance to FreePhasor
Dist = sqrt(sum(([Gproj Sproj] - [G1 S1]).^2));
%Fraction of bound NADH
MitoFraction = Dist/Distance;
fraction = [fraction MitoFraction;]; 

end


end