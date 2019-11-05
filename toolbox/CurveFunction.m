function y = CurveFunction(x,xdata,FitParam)


RPCr = x(1)*x(2)^2./( x(2)^2 + 4*(xdata - x(3)).^2 );


peakoffset = FitParam.PeakOffset;

Rbak =x(4) + x(5)*(xdata - peakoffset) + x(6)*0.1*(xdata-peakoffset).^2+ x(7)*0.01*(xdata-peakoffset).^3;% ploy3 + x(8)*0.01*(xdata-FitParam.peakoffset).^4*0; % poly4

satHz = FitParam.satpwr*42.58;
cos2thet=1-satHz^2./(satHz^2+ (FitParam.Magfield*xdata).^2);
Rall = Rbak+ RPCr;
y = (1-cos2thet*FitParam.R1./Rall).*exp(-Rall*FitParam.tsat)+cos2thet*FitParam.R1./Rall;

end