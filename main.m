clear
clc
close all
format longG
LoadAll    % Prepare workspace, load all data, and load Module 1. Always run the main with this script active 

PlotStudy15o16 %(Fig. S3-S4)

%% Step 1: Describe exenatide effect on human cells(Fig. 2-5)

% [minCostPS] = EstimationData_Optimization(i,Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,modelName, model,ParametersInformation,  AmountParameterOpti,LiverSpecificParameters,[],options2)

 PlotInvitroSystems               % Step 1:(Figs. 2-3  and Fig. S1)
 PlotParameterEstimationAnalysis  % Step 1:(Primarely Fig. 4; Also used in various comparisons Figs. 5C ii, 7B, and Fig. S1)
 PlotInvitroPredictions           % Step 1:(Fig. 5)

%% Step 2: Pharmacokinetic translations (Fig. 6)
modelName = 'Module2';               % Load Module 2
model = IQMmodel([modelName '.txt']);
IQMmakeMEXmodel(model);
model = str2func(modelName);

%[minCostPS] = Pharmacokinetics_Optimization(i,MPSpk_data,GaoExenatideConcentrations_data,Sauter2020_data,GaoApe_data,modelName, model,[],options2)

 PlotStep2 %(Fig. 6)

%% Step 3: Pharmacodynamic translations (Fig. 7)
modelName = 'Module3B';               % Load Module 3, with the minimalistic change proposed in manuscript
model = IQMmodel([modelName '.txt']);
IQMmakeMEXmodel(model);
model = str2func(modelName);

% [minCostPS] = Gao_Optimization(i,Gao2011Rat_data,GaoExenatideConcentrations_data,modelName, model, AmountParameterOpti,[],options2);

 PlotStep3 %(Fig. 7)

%% Step 4: Human prediction (Fig 8)
modelName = 'Module3'; % Load Module 3
model = IQMmodel([modelName '.txt']);
IQMmakeMEXmodel(model);
model = str2func(modelName);

 PlotStep4 %(Fig. 8 and Fig. S2)

%%

delete(gcp('nocreate')) % stops parallel optimisation cluster