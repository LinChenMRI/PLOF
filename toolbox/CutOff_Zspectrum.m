function [Offset,Saturation] = CutOff_Zspectrum(Offset,Saturation,Range)
% this function is used to cut off the Zspectum within specific range

[temp,index1] = min(abs(Offset - min(Range)));
[temp,index2] = min(abs(Offset - max(Range)));
index = [index1,index2];
Offset(min(index):max(index)) = [];
Saturation(min(index):max(index)) = [];

end