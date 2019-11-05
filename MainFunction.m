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

close all;clc;clear all;
addpath('toolbox');

load Data

FitParam.ifshowimage = 1; % if show fitting result
FitParam.paramdir = [cd,filesep,'FittingResult']; % save directory
FitParam.name = 'PLOF_demon'; % save name

FitParam.WholeRange = [1,3];    % CEST peak parameters
FitParam.PeakOffset = 2;
FitParam.PeakRange = [1.6,2.4];

FitParam.Magfield = 42.58*11.7; % 11.7 T
FitParam.R1 = 1/1.9; % 1/T1value(second)
FitParam.satpwr = 2; % saturation power (uT)
FitParam.tsat =0.6; % saturation length (second)

[FitResult,FitParam] = PLOF(Freq,Z_spectrum,FitParam);