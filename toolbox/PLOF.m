function [FitResult,FitParam] = PLOF(Offset,Saturation,FitParam)
% Fit the Z-spectrum using polynomial and Lorentzian line-shape fitting (PLOF) method
%
% If you have used this function in a scientific publication,we would
% appreciate citations to the following papers:

% [1]	Chen L, Wei Z, Cai S, Li Y, Liu G, Lu H, Weiss RG, van Zijl PCM, Xu
% J. High-resolution creatine mapping of mouse brain at 11.7 T using
% non-steady-state chemical exchange saturation transfer. NMR Biomed
% 2019:e4168. 
% [2]	Chen L, Barker PB, Weiss RG, van Zijl PCM, Xu J.
% Creatine and phosphocreatine mapping of mouse skeletal muscle by a
% polynomial and Lorentzian line-shape fitting CEST method. Magn Reson Med
% 2019;81(1):69-78. 
% [3]	Chen L, Zeng H, Xu X, Yadav NN, Cai S, Puts NA,
% Barker PB, Li T, Weiss RG, van Zijl PCM, Xu J. Investigation of the
% contribution of total creatine to the CEST Z-spectrum of brain using a
% knockout mouse model. NMR Biomed 2017;30(12):e3834.
%
% Please contact Lin Chen at chenlin@jhu.edu or  chenlin0430@gmail.com if you have any questions about the code. 

warning off
if size(Offset,1) == 1
    Offset = Offset';
end

if size(Saturation,1) == 1
    Saturation = Saturation';
end


[Offset,Saturation] = Extract_Zspectrum(Offset,Saturation,FitParam.WholeRange);
[Offset_background,Saturation_background] = CutOff_Zspectrum(Offset,Saturation,FitParam.PeakRange);

%-----------------------------------------------%
%-------------- Two-step fitting ---------------%
%-----------------------------------------------%
FitResult.xindex = linspace(min(Offset),max(Offset),100);
%-------------background fitting --------------%
x0_background = [0.5, 0, 0, 0];
lb=[-inf, -inf, -inf,-inf];
ub=[+inf, +inf, +inf,+inf];
options=optimset('MaxFunEvals',1e6,'TolFun',1e-6,'TolX',1e-6, 'Display',  'off' );
[FitResult.Coefficents,resnorm]=lsqcurvefit(@CruveFunction_background,x0_background,Offset_background,Saturation_background,lb,ub,options,FitParam);
FitResult.Background = CruveFunction_background(FitResult.Coefficents,FitResult.xindex,FitParam);
%-------------CEST peak fitting --------------%
lb(1) = 1e-4;
ub(1) = 1;
lb(2) = 0.1;
ub(2) = 5;
lb(3) = min(FitParam.PeakRange);
ub(3) = max(FitParam.PeakRange);

lb(4:7)=FitResult.Coefficents - 0*abs(FitResult.Coefficents*0.02); % fix the background parameters
ub(4:7)=FitResult.Coefficents + 0*abs(FitResult.Coefficents*0.02);
x0 = [0.5, 0, 0, 0,0,0,0];

[FitResult.Coefficents,resnorm]=lsqcurvefit(@CurveFunction,x0,Offset,Saturation,lb,ub,options,FitParam);
FitResult.Curve = CurveFunction(FitResult.Coefficents,FitResult.xindex,FitParam);

FitResult.Offset = Offset;
FitResult.Saturation = Saturation;
FitResult.Offset_background = Offset_background;
FitResult.Saturation_background = Saturation_background;
%------------ Calculate deltaZ and assign the Coefficents ---------------%
FitResult.Rpeak = FitResult.Coefficents(1);
FitResult.FitPeakOffset = FitResult.Coefficents(3);

[temp,index1] = min(abs(FitResult.xindex - FitResult.FitPeakOffset));
FitResult.DeltaZpeak = FitResult.Background(index1) - FitResult.Curve(index1);

FitResult.MT = FitResult.Coefficents(4);
FitResult.Rsquare = goodnessOfFit(CurveFunction(FitResult.Coefficents,Offset,FitParam),Saturation,'NMSE');

if FitParam.ifshowimage == 1
    PlotFitResult(FitResult,FitParam);
    
    SaveEps(FitParam.paramdir,['PLOF_',FitParam.name]);
%------------ save fitting results and parameters ---------------%
    mymkdir(FitParam.paramdir);
    save([FitParam.paramdir,filesep,'PLOF_FitParam_',FitParam.name,'.mat'],'FitParam');
    save([FitParam.paramdir,filesep,'PLOF_FitResult_',FitParam.name,'.mat'],'FitResult');

    xlsname = [FitParam.paramdir,filesep,'PLOF_FitResult_',FitParam.name,'.xls'];
    xlswrite(xlsname,{'Offset'},1,'A1');
    xlswrite(xlsname,FitResult.Offset,1,'A2');

    xlswrite(xlsname,{'Saturation'},1,'B1');
    xlswrite(xlsname,FitResult.Saturation,1,'B2');

    xlswrite(xlsname,{'Offset_interpolated'},1,'C1');
    xlswrite(xlsname,FitResult.xindex',1,'C2');

    xlswrite(xlsname,{'Background'},1,'D1');
    xlswrite(xlsname,FitResult.Background',1,'D2');

    xlswrite(xlsname,{'Curve'},1,'E1');
    xlswrite(xlsname,FitResult.Curve',1,'E2');

    xlswrite(xlsname,{'Coefficents'},1,'F1');
    xlswrite(xlsname,FitResult.Coefficents',1,'F2');

end
end