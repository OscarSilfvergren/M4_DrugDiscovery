%% Clear all, reset and declare format
clear
clc
close all
format longG
addpath('IQMtools')
addpath('Non-main')
load('Gao2011Rat_data')
load('GaoExenatideConcentrations_data')
% options2 = optimoptions(@particleswarm,'InitialSwarmSpan',2000,'MaxStallIterations',100,'FunctionTolerance',1.0e-3);
  options2 = optimoptions(@particleswarm,'InitialSwarmSpan',4000,'PlotFcn','pswplotbestf','MaxStallIterations',700,'FunctionTolerance',1.0e-5,'UseParallel', true,'UseVectorized', false);
i = 1;
PlotOptions          % Plot options
if ~exist('IQMsimulate','file')
    fprintf('\n\nFor these scripts to work, the IQM tools toolbox have to be compiled.\n')
    disp('To do this, a valid C-compiler is necessary')
    disp('If the compilation of the toolbox does not, it is likely that a valid C-compiler is missing.')
    choice = input('press enter to continue and compile the toolbox.');
    run('./IQMtools/installIQMtoolsInitial.m')
end

modelName = 'Module3';
model = IQMmodel([modelName '.txt']);
IQMmakeMEXmodel(model);
model = str2func(modelName);