function [Glife Slife] = singleLifetime(tao)

omega = 2*3.1416*8e7;
mod = 1/sqrt((tao*omega*1e-9)^2+1);

Glife = mod^2;
Slife = sqrt(mod^2-Glife^2);


end