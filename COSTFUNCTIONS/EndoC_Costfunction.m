function [Cost_EndoC,Cost_EndoCStatistical] = EndoC_Costfunction(Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,params, PersonSpecificParameters,modelName,sNames, pNames,initialvalues,AmountParameterOpti,fid)

model = str2func(modelName);

%% Simulate studies with EndoC-BH5 cultures
  
[simStudy7_GSIS]                                                 = SimulateStudy7   (model,params,Study7_data             ,PersonSpecificParameters,initialvalues,sNames,pNames);
[simStudy8_GSIS]                                                 = SimulateStudy8   (model,params,Study8_data             ,PersonSpecificParameters,initialvalues,sNames,pNames,0);
[simStudy9_control, simStudy9_0p1, simStudy9_10,simStudy10_GSIS] = SimulateStudy9o10(model,Study9_data,Study10_data,params,PersonSpecificParameters,initialvalues,sNames,pNames,0);
[simBH5ref_GSIS]                                                 = SimulateBH5ref   (model,BH5ref_data,params             ,PersonSpecificParameters,initialvalues,sNames,pNames,0);
[simStudy11_Hcontrol, simStudy11_H0p1, simStudy11_H10,simStudy11_Dcontrol, simStudy11_D0p1, simStudy11_D10,simStudy12_GSIS] = SimulateStudy11o12(model,Study11_data,Study12_data,params,PersonSpecificParameters,initialvalues,sNames,pNames);

%% Study 7 (dgf = 13)

%d7
CostStudy7_GSIS_CM2BSAd7    = ((Study7_data.ChipGSISmean(1:3) - simStudy7_GSIS.CM2_BSAd7(1:3)').^2) ./(Study7_data.ChipGSISstdev(1:3).^2);
CostStudy7_GSIS_CM3d7       = ((Study7_data.ChipGSISmean(4:6) - simStudy7_GSIS.CM3d7(1:3)').^2)     ./(Study7_data.ChipGSISstdev(4:6).^2);
CostStudy7_GSIS_ULTd7       = ((Study7_data.ChipGSISmean(7:9) - simStudy7_GSIS.ULTd7(1:3)').^2)     ./(Study7_data.ChipGSISstdev(7:9).^2);
%d10
CostStudy7_GSIS_CM1FCSd10   = ((Study7_data.ChipGSISmean2(1:2)  - simStudy7_GSIS.CM1_FCSd10).^2) ./(Study7_data.ChipGSISstdev2(1:2).^2);
CostStudy7_GSIS_CM2FCSd10   = ((Study7_data.ChipGSISmean2(3:4)  - simStudy7_GSIS.CM2_FCSd10).^2) ./(Study7_data.ChipGSISstdev2(3:4).^2);

CostStudy7 = sum(CostStudy7_GSIS_CM2BSAd7,"omitnan")+ sum(CostStudy7_GSIS_CM3d7,"omitnan") + sum(CostStudy7_GSIS_ULTd7,"omitnan") + sum(CostStudy7_GSIS_CM1FCSd10,"omitnan") + sum(CostStudy7_GSIS_CM2FCSd10,"omitnan");%+ sum(CostStudy7_GSIS_CM2ULTd10,"omitnan");

%% Study 8(dgf = 13)

CostStudy8_GR    = ((Study8_data.Insulin       - simStudy8_GSIS.SaveInsulinSecretionGlucose').^2)   ./(Study8_data.InsulinSEM.^2);
CostStudy8_ER    = ((Study8_data.Insulin1(1:6) - simStudy8_GSIS.SaveInsulinSecretionExenatide').^2) ./(Study8_data.InsulinSEM1(1:6).^2);

CostStudy8_statistical = sum(CostStudy8_GR,"omitnan")   + sum(CostStudy8_ER,"omitnan");
CostStudy8             = sum(CostStudy8_GR,"omitnan")*2 + sum(CostStudy8_ER,"omitnan")*2;

%% Study 10 (dgf = 10)

CostStudy10_GR    = ((Study10_data.RInsulinMean(1:4)  - simStudy10_GSIS.GR').^2) ./(Study10_data.RInsulinSEM(1:4).^2);
CostStudy10_ER    = ((Study10_data.DRInsulinMean(1:6) - simStudy10_GSIS.ER').^2) ./(Study10_data.DRInsulinSEM(1:6).^2);

CostStudy10_statistical = sum(CostStudy10_GR,"omitnan")  + sum(CostStudy10_ER,"omitnan");
CostStudy10             = sum(CostStudy10_GR,"omitnan")*2+ sum(CostStudy10_ER,"omitnan")*2;

%% Study 11 (dgf = 254)

DatapointsSampleFromSimulation = round(Study11_data.timeInsulin(1:15)+0.1,2)*10;

% Healthy control
Insulin_Simulated             = simStudy11_Hcontrol.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_Hcontrol.states,'Insulin_Medium'))/1000;
CostStudy11_InsulinHcontrol   = ((Study11_data.hInsulin0(1:15)    - Insulin_Simulated).^2) ./(max(Study11_data.hInsulin0SEM(1:15),mean(Study11_data.hInsulin0SEM(1:15),'omitnan')).^2);
% Healthy 0.1nM
Insulin_Simulated             = simStudy11_H0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H0p1.states,'Insulin_Medium'))/1000;
CostStudy11_InsulinH0p1       = ((Study11_data.hInsulin0p1(1:15)    - Insulin_Simulated).^2) ./(max(Study11_data.hInsulin0p1SEM(1:15),mean(Study11_data.hInsulin0p1SEM(1:15),'omitnan')).^2);
% Healthy 10nM
Insulin_Simulated             = simStudy11_H10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H10.states,'Insulin_Medium'))/1000;
CostStudy11_InsulinH10        = ((Study11_data.hInsulin10(1:15)    - Insulin_Simulated).^2) ./(max(Study11_data.hInsulin10SEM(1:15),mean(Study11_data.hInsulin10SEM(1:15),'omitnan')).^2);
% Diseased control
Insulin_Simulated             = simStudy11_Dcontrol.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_Dcontrol.states,'Insulin_Medium'))/1000;
CostStudy11_InsulinDcontrol   = ((Study11_data.dInsulin0(1:15)    - Insulin_Simulated).^2) ./(max(Study11_data.dInsulin0SEM(1:15),mean(Study11_data.dInsulin0SEM(1:15),'omitnan')).^2);
% Diseased 0.1nM
Insulin_Simulated             = simStudy11_D0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D0p1.states,'Insulin_Medium'))/1000;
CostStudy11_InsulinD0p1       = ((Study11_data.dInsulin0p1(1:15)    - Insulin_Simulated).^2) ./(max(Study11_data.dInsulin0p1SEM(1:15),mean(Study11_data.dInsulin0p1SEM(1:15),'omitnan')).^2);
% Diseased 10nM
Insulin_Simulated             = simStudy11_D10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D10.states,'Insulin_Medium'))/1000;
CostStudy11_InsulinD10        = ((Study11_data.dInsulin10(1:15)    - Insulin_Simulated).^2) ./(max(Study11_data.dInsulin10SEM(1:15),mean(Study11_data.dInsulin10SEM(1:15),'omitnan')).^2);
CostStudy11_insulin  = sum(CostStudy11_InsulinHcontrol,"omitnan") + sum(CostStudy11_InsulinH0p1,"omitnan") + sum(CostStudy11_InsulinH10,"omitnan") + sum(CostStudy11_InsulinDcontrol,"omitnan") + sum(CostStudy11_InsulinD0p1,"omitnan") + sum(CostStudy11_InsulinD10,"omitnan");

DatapointsSampleFromSimulation = round(Study11_data.timeGlucose(1:17)+0.1,2)*10;

% Healthy control
Glucose_Simulated                  = simStudy11_Hcontrol.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_Hcontrol.states,'Glucose_Medium'));
CostStudy11_GlucoseHcontrol        = ((Study11_data.hGlucose0(1:17)    - Glucose_Simulated).^2) ./(max(Study11_data.hGlucose0SEM(1:17),mean(Study11_data.hGlucose0SEM(1:17),'omitnan')).^2);
CostStudy11_GlucoseHcontrol(2:3)   = 0; % 0 because initial value
CostStudy11_GlucoseHcontrol(8:9)   = 0; % 0 because initial value
CostStudy11_GlucoseHcontrol(13:14) = 0; % 0 because initial value
% Healthy 0.1nM
Glucose_Simulated              = simStudy11_H0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H0p1.states,'Glucose_Medium'));
CostStudy11_GlucoseH0p1        = ((Study11_data.hGlucose0p1(1:17)    - Glucose_Simulated).^2) ./(max(Study11_data.hGlucose0p1SEM(1:17),mean(Study11_data.hGlucose0p1SEM(1:17),'omitnan')).^2);
CostStudy11_GlucoseH0p1(2:3)   = 0; % 0 because initial value
CostStudy11_GlucoseH0p1(8:9)   = 0; % 0 because initial value
CostStudy11_GlucoseH0p1(13:14) = 0; % 0 because initial value
% Healthy 10nM
Glucose_Simulated             = simStudy11_H10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H10.states,'Glucose_Medium'));
CostStudy11_GlucoseH10        = ((Study11_data.hGlucose10(1:17)    - Glucose_Simulated).^2) ./(max(Study11_data.hGlucose10SEM(1:17),mean(Study11_data.hGlucose10SEM(1:17),'omitnan')).^2);
CostStudy11_GlucoseH10(2:3)   = 0; % 0 because initial value
CostStudy11_GlucoseH10(8:9)   = 0; % 0 because initial value
CostStudy11_GlucoseH10(13:14) = 0; % 0 because initial value
% Diseased control
Glucose_Simulated                  = simStudy11_Dcontrol.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_Dcontrol.states,'Glucose_Medium'));
CostStudy11_GlucoseDcontrol        = ((Study11_data.dGlucose0(1:17)    - Glucose_Simulated).^2) ./(max(Study11_data.dGlucose0SEM(1:17),mean(Study11_data.dGlucose0SEM(1:17),'omitnan')).^2);
CostStudy11_GlucoseDcontrol(2:3)   = 0; % 0 because initial value
CostStudy11_GlucoseDcontrol(8:9)   = 0; % 0 because initial value
CostStudy11_GlucoseDcontrol(13:14) = 0; % 0 because initial value
% Diseased 0.1nM
Glucose_Simulated              = simStudy11_D0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D0p1.states,'Glucose_Medium'));
CostStudy11_GlucoseD0p1        = ((Study11_data.dGlucose0p1(1:17)    - Glucose_Simulated).^2) ./(max(Study11_data.dGlucose0p1SEM(1:17),mean(Study11_data.dGlucose0p1SEM(1:17),'omitnan')).^2);
CostStudy11_GlucoseD0p1(2:3)   = 0; % 0 because initial value
CostStudy11_GlucoseD0p1(8:9)   = 0; % 0 because initial value
CostStudy11_GlucoseD0p1(13:14) = 0; % 0 because initial value
% Diseased 10nM
Glucose_Simulated             = simStudy11_D10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D10.states,'Glucose_Medium'));
CostStudy11_GlucoseD10        = ((Study11_data.dGlucose10(1:17)    - Glucose_Simulated).^2) ./(max(Study11_data.dGlucose10SEM(1:17),mean(Study11_data.dGlucose10SEM(1:17),'omitnan')).^2);
CostStudy11_GlucoseD10(2:3)   = 0; % 0 because initial value
CostStudy11_GlucoseD10(8:9)   = 0; % 0 because initial value
CostStudy11_GlucoseD10(13:14) = 0; % 0 because initial value
CostStudy11_glucose = sum(CostStudy11_GlucoseHcontrol,"omitnan") + sum(CostStudy11_GlucoseH0p1,"omitnan") + sum(CostStudy11_GlucoseH10,"omitnan") + sum(CostStudy11_GlucoseDcontrol,"omitnan") + sum(CostStudy11_GlucoseD0p1,"omitnan") + sum(CostStudy11_GlucoseD10,"omitnan");

DatapointsSampleFromSimulation = round(Study11_data.timeLactate(1:5)+0.1,2)*10;

% Healthy control
Lactate_Simulated             = simStudy11_Hcontrol.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_Hcontrol.states,'Lactate_Medium'));
CostStudy11_LactateHcontrol   = ((Study11_data.hLactate0(1:5)    - Lactate_Simulated).^2) ./(max(Study11_data.hLactate0SEM(1:5),mean(Study11_data.hLactate0SEM(1:5),'omitnan')).^2);
% Healthy 0.1nM
Lactate_Simulated             = simStudy11_H0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H0p1.states,'Lactate_Medium'));
CostStudy11_LactateH0p1       = ((Study11_data.hLactate0p1(1:5)    - Lactate_Simulated).^2) ./(max(Study11_data.hLactate0p1SEM(1:5),mean(Study11_data.hLactate0p1SEM(1:5),'omitnan')).^2);
% Healthy 10nM
Lactate_Simulated             = simStudy11_H10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H10.states,'Lactate_Medium'));
CostStudy11_LactateH10        = ((Study11_data.hLactate10(1:5)    - Lactate_Simulated).^2) ./(max(Study11_data.hLactate10SEM(1:5),mean(Study11_data.hLactate10SEM(1:5),'omitnan')).^2);
% Diseased control
Lactate_Simulated             = simStudy11_Dcontrol.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_Dcontrol.states,'Lactate_Medium'));
CostStudy11_LactateDcontrol   = ((Study11_data.dLactate0(1:5)    - Lactate_Simulated).^2) ./(max(Study11_data.dLactate0SEM(1:5),mean(Study11_data.dLactate0SEM(1:5),'omitnan')).^2);
% Diseased 0.1nM
Lactate_Simulated             = simStudy11_D0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D0p1.states,'Lactate_Medium'));
CostStudy11_LactateD0p1       = ((Study11_data.dLactate0p1(1:5)    - Lactate_Simulated).^2) ./(max(Study11_data.dLactate0p1SEM(1:5),mean(Study11_data.dLactate0p1SEM(1:5),'omitnan')).^2);
% Diseased 10nM
Lactate_Simulated             = simStudy11_D10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D10.states,'Lactate_Medium'));
CostStudy11_LactateD10        = ((Study11_data.dLactate10(1:5)    - Lactate_Simulated).^2) ./(max(Study11_data.dLactate10SEM(1:5),mean(Study11_data.dLactate10SEM(1:5),'omitnan')).^2);
CostStudy11_lactate  = sum(CostStudy11_LactateHcontrol,"omitnan") + sum(CostStudy11_LactateH0p1,"omitnan") + sum(CostStudy11_LactateH10,"omitnan") + sum(CostStudy11_LactateDcontrol,"omitnan") + sum(CostStudy11_LactateD0p1,"omitnan") + sum(CostStudy11_LactateD10,"omitnan");
 
DatapointsSampleFromSimulation = round(Study11_data.ETime(1:8)+0.1,2)*10;

% Healthy 0.1nM
Exenatide_Simulated          = simStudy11_H0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H0p1.states,'Exenatide_Medium'));
CostStudy11_ExenatideH0p1    = ((Study11_data.hE0p1(1:8)    - Exenatide_Simulated).^2) ./(max(Study11_data.hE0p1SEM(1:8),mean(Study11_data.hE0p1SEM(1:8),'omitnan')).^2);
CostStudy11_ExenatideH0p1(1) = 0; % 0 because initial value
CostStudy11_ExenatideH0p1(3) = 0; % 0 because initial value
CostStudy11_ExenatideH0p1(5) = 0; % 0 because initial value
CostStudy11_ExenatideH0p1(7) = 0; % 0 because initial value
% Healthy 10nM
Exenatide_Simulated         = simStudy11_H10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_H10.states,'Exenatide_Medium'));
CostStudy11_ExenatideH10    = ((Study11_data.hE10(1:8)    - Exenatide_Simulated).^2) ./(max(Study11_data.hE10SEM(1:8),mean(Study11_data.hE10SEM(1:8),'omitnan')).^2);
CostStudy11_ExenatideH10(1) = 0; % 0 because initial value
CostStudy11_ExenatideH10(3) = 0; % 0 because initial value
CostStudy11_ExenatideH10(5) = 0; % 0 because initial value
CostStudy11_ExenatideH10(7) = 0; % 0 because initial value
% Diseased 0.1nM
Exenatide_Simulated          = simStudy11_D0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D0p1.states,'Exenatide_Medium'));
CostStudy11_ExenatideD0p1    = ((Study11_data.dE0p1(1:8)    - Exenatide_Simulated).^2) ./(max(Study11_data.dE0p1SEM(1:8),mean(Study11_data.dE0p1SEM(1:8),'omitnan')).^2);
CostStudy11_ExenatideD0p1(1) = 0; % 0 because initial value
CostStudy11_ExenatideD0p1(3) = 0; % 0 because initial value
CostStudy11_ExenatideD0p1(5) = 0; % 0 because initial value
CostStudy11_ExenatideD0p1(7) = 0; % 0 because initial value
% Diseased 10nM
Exenatide_Simulated         = simStudy11_D10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy11_D10.states,'Exenatide_Medium'));
CostStudy11_ExenatideD10    = ((Study11_data.dE10(1:8)    - Exenatide_Simulated).^2) ./(max(Study11_data.dE10SEM(1:8),mean(Study11_data.dE10SEM(1:8),'omitnan')).^2);
CostStudy11_ExenatideD10(1) = 0; % 0 because initial value
CostStudy11_ExenatideD10(3) = 0; % 0 because initial value
CostStudy11_ExenatideD10(5) = 0; % 0 because initial value
CostStudy11_ExenatideD10(7) = 0; % 0 because initial value
CostStudy11_exenatide = sum(CostStudy11_ExenatideH0p1,"omitnan") + sum(CostStudy11_ExenatideH10,"omitnan") + sum(CostStudy11_ExenatideD0p1,"omitnan") + sum(CostStudy11_ExenatideD10,"omitnan");
 
CostStudy11  = CostStudy11_insulin + CostStudy11_glucose + CostStudy11_lactate + CostStudy11_exenatide;

%% Study 12 (dgf = 3)

CostStudy12_GSIS   = ((Study12_data.Mean - simStudy12_GSIS.ULTd0').^2) ./(Study12_data.Stdev.^2);
CostStudy12        = sum(CostStudy12_GSIS,"omitnan");

%% Reference data Blanchi et al. (2023)(dgf = 33)

Normalisedmean   = BH5ref_data.InsulinGR(1:6)./BH5ref_data.InsulinGR(1);
NormalisedWeight = Normalisedmean.*(BH5ref_data.InsulinGRstdev(1:6)./BH5ref_data.InsulinGR(1:6));
NormalisedSim    = simBH5ref_GSIS.GR'./simBH5ref_GSIS.GR(1);
CostExpEndoC_GR  = ((Normalisedmean  - NormalisedSim).^2) ./(NormalisedWeight.^2);
Normalisedmean   = BH5ref_data.InsulinER(1:15)./BH5ref_data.InsulinER(1);
NormalisedWeight = Normalisedmean.*(BH5ref_data.InsulinERstdev(1:15)./BH5ref_data.InsulinER(1:15));
NormalisedSim    = simBH5ref_GSIS.ER'./simBH5ref_GSIS.ER(1);
CostExpEndoC_ER  = ((Normalisedmean - NormalisedSim).^2) ./(NormalisedWeight.^2);

BH5ref_data.G0(1:4)   = BH5ref_data.G0(1:4)   * simBH5ref_GSIS.Uncertainty;
Normalisedmean        = [BH5ref_data.G0(1),BH5ref_data.G20(1),BH5ref_data.G20e1(1)]./BH5ref_data.G0(1);
NormalisedWeight      = Normalisedmean.*([BH5ref_data.G0stdev(1),BH5ref_data.G20stdev(1),BH5ref_data.G20e1stdev(1)]./[BH5ref_data.G0(1),BH5ref_data.G20(1),BH5ref_data.G20e1(1)]);
NormalisedSim         = simBH5ref_GSIS.ULTD0 ./simBH5ref_GSIS.ULTD0(1);
CostExpEndoC_GSISD0   = ((Normalisedmean  - NormalisedSim).^2) ./(max(NormalisedWeight,mean(NormalisedWeight,'omitnan')).^2);
Normalisedmean        = [BH5ref_data.G0(2),BH5ref_data.G20(2),BH5ref_data.G20e1(2)]./BH5ref_data.G0(1);
NormalisedWeight      = Normalisedmean.*([BH5ref_data.G0stdev(2),BH5ref_data.G20stdev(2),BH5ref_data.G20e1stdev(2)]./[BH5ref_data.G0(2),BH5ref_data.G20(2),BH5ref_data.G20e1(2)]);
NormalisedSim         = simBH5ref_GSIS.ULTD7 ./simBH5ref_GSIS.ULTD0(1);
CostExpEndoC_GSISD14  = ((Normalisedmean  - NormalisedSim).^2) ./(max(NormalisedWeight,mean(NormalisedWeight,'omitnan')).^2);
Normalisedmean        = [BH5ref_data.G0(3),BH5ref_data.G20(3),BH5ref_data.G20e1(3)]./BH5ref_data.G0(1);
NormalisedWeight      = Normalisedmean.*([BH5ref_data.G0stdev(3),BH5ref_data.G20stdev(3),BH5ref_data.G20e1stdev(3)]./[BH5ref_data.G0(3),BH5ref_data.G20(3),BH5ref_data.G20e1(3)]);
NormalisedSim         = simBH5ref_GSIS.ULTD14./simBH5ref_GSIS.ULTD0(1);
CostExpEndoC_GSISD21  = ((Normalisedmean  - NormalisedSim).^2) ./(max(NormalisedWeight,mean(NormalisedWeight,'omitnan')).^2);
Normalisedmean        = [BH5ref_data.G0(4),BH5ref_data.G20(4),BH5ref_data.G20e1(4)]./BH5ref_data.G0(1);
NormalisedWeight      = Normalisedmean.*([BH5ref_data.G0stdev(4),BH5ref_data.G20stdev(4),BH5ref_data.G20e1stdev(4)]./[BH5ref_data.G0(4),BH5ref_data.G20(4),BH5ref_data.G20e1(4)]);
NormalisedSim         = simBH5ref_GSIS.ULTD21 ./simBH5ref_GSIS.ULTD0(1);
CostExpEndoC_GSISD28  = ((Normalisedmean  - NormalisedSim).^2) ./(max(NormalisedWeight,mean(NormalisedWeight,'omitnan')).^2);

CostExpEndoC_statistical  = sum(CostExpEndoC_GR,"omitnan")   + sum(CostExpEndoC_ER,"omitnan")   + sum(CostExpEndoC_GSISD0,"omitnan") + sum(CostExpEndoC_GSISD14,"omitnan") + sum(CostExpEndoC_GSISD21,"omitnan")+ sum(CostExpEndoC_GSISD28,"omitnan");
CostExpEndoC              = sum(CostExpEndoC_GR,"omitnan")   + sum(CostExpEndoC_ER,"omitnan")   + sum(CostExpEndoC_GSISD0,"omitnan") + sum(CostExpEndoC_GSISD14,"omitnan") + sum(CostExpEndoC_GSISD21,"omitnan")+ sum(CostExpEndoC_GSISD28,"omitnan");

%% Sum all cost (dgf = 326)

Cost_EndoC             = CostStudy7 + CostStudy8             + CostStudy10             + CostStudy11 + CostStudy12 + CostExpEndoC;
Cost_EndoCStatistical  = CostStudy7 + CostStudy8_statistical + CostStudy10_statistical + CostStudy11 + CostStudy12 + CostExpEndoC_statistical;

end
