function y = CurveFunction(x,xdata,FitParam)


RPCr = x(1)*x(2)^2./( x(2)^2 + 4*(xdata - x(3)).^2 );


peakoffset = FitParam.PeakOffset;

 Rbak=x(4)*x(5)^2./( x(5)^2 + 4*(xdata ).^2 )+x(6) + x(7)*0.001*(xdata - peakoffset);
 satHz = FitParam.satpwr*42.58;
cos2thet=1-satHz^2./(satHz^2+ (FitParam.Magfield*xdata).^2);
Rall = Rbak+ RPCr;
y = (1-cos2thet*FitParam.R1./Rall).*exp(-Rall*FitParam.tsat)+cos2thet*FitParam.R1./Rall;

end