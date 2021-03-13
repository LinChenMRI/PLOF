function [y,Rbak] = CruveFunction_background(x,xdata,FitParam)

peakoffset = FitParam.PeakOffset;


Rbak=x(1)*x(2)^2./( x(2)^2 + 4*(xdata ).^2 )+x(3) + x(4)*0.001*(xdata - peakoffset);
satHz = FitParam.satpwr*42.58;
cos2thet=1-satHz^2./(satHz^2+ (FitParam.Magfield*xdata).^2);
Rall = Rbak;
y = (1-cos2thet*FitParam.R1./Rall).*exp(-Rall*FitParam.tsat)+cos2thet*FitParam.R1./Rall;

end