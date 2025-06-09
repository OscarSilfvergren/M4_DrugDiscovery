
%% Workplace - folders

addpath('COSTFUNCTIONS')
addpath('DATA')
addpath('FUNCTIONS')
addpath('InvivoData')
addpath('IQMtools')
addpath('MODULES')
addpath('OPTIMIZATION')
addpath('PARAMETERS')
addpath('PESTO')
addpath('PLOT')

%% Load data 

% In vivo data
load('Ducker2008_data')
load('Gao2011Rat_data')
load('GaoHuman_data')
load('GaoApe_data')
load('Sauter2020_data')
load('GaoExenatideConcentrations_data')

% human cell experimetns
load('Study1_data')
load('Study2_data')
load('Study3_data')
load('Study4_data')
load('Study5_data')
load('Study6_data')
load('Study7_data')
load('Study8_data')
load('Study9_data')
load('Study10_data')
load('Study11_data')
load('Study12_data')
load('Study13_data')
load('Study14_data')
load('Study15_data')
load('Study16_data')

load('InSpheroInsulinPhases_data')
load('MPSpk_data')
load('BH5ref_data') 
%
load('ParametersInformation') % structure for parameter matrix used in optimisation

%% Load IQM, options for optimisation and pre-declare id for paralell workers

% Optimisation options 
% options2 = optimoptions(@particleswarm,'InitialSwarmSpan',2000,'MaxStallIterations',50,'FunctionTolerance',1.0e-1);
% options2 = optimoptions(@particleswarm,'InitialSwarmSpan',2000,'MaxStallIterations',200,'FunctionTolerance',5.0e-2);
  options2 = optimoptions(@particleswarm,'InitialSwarmSpan',4000,'PlotFcn','pswplotbestf','MaxStallIterations',300,'FunctionTolerance',1.0e-5,'UseParallel', true,'UseVectorized', false);

  i = 1; %paralel-worker start count

if ~exist('IQMsimulate','file')
    fprintf('\n\nFor these scripts to work, the IQM tools toolbox have to be compiled.\n')
    disp('To do this, a valid C-compiler is necessary')
    disp('If the compilation of the toolbox does not, it is likely that a valid C-compiler is missing.')
    choice = input('press enter to continue and compile the toolbox.');
    run('./IQMtools/installIQMtoolsInitial.m')
end

%% Create mex and prepare ParametersInformation

PlotOptions          % Plot options

modelName = 'Module1';
model = IQMmodel([modelName '.txt']);
IQMmakeMEXmodel(model);
model = str2func(modelName);

[pNames, param] = IQMparameters(model);
[sNames, state] = IQMstates(model);

AmountParameterOpti     = 44;
LiverSpecificParameters = 17;

[row, column] = size(param);
ParametersInformation(row+1:end,:) = [];

ParametersInformation(1:row,1) = strcat(pNames);
ParametersInformation(1:row,4) = array2table(param);