function [y,Rbak] = CruveFunction_background(x,xdata,FitParam)

peakoffset = FitParam.PeakOffset;

Rbak =x(1) + x(2)*(xdata - peakoffset) + x(3)*0.1*(xdata-peakoffset).^2+ x(4)*0.01*(xdata-peakoffset).^3; % ploy3 + x(5)*0.01*(xdata-FitParam.peakoffset).^4*0; % poly4

satHz = FitParam.satpwr*42.58;
cos2thet=1-satHz^2./(satHz^2+ (FitParam.Magfield*xdata).^2);
Rall = Rbak;
y = (1-cos2thet*FitParam.R1./Rall).*exp(-Rall*FitParam.tsat)+cos2thet*FitParam.R1./Rall;

end