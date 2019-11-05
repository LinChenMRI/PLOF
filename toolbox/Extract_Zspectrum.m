function [Extract_Offset,Extract_Saturation] = Extract_Zspectrum(Offset,Saturation,Range)
% this function is used to extract the Zspectum within specific range

[temp,index1] = min(abs(Offset - min(Range)));
[temp,index2] = min(abs(Offset - max(Range)));
index = [index1,index2];
Extract_Offset = Offset(min(index):max(index));
Extract_Saturation = Saturation(min(index):max(index));

end