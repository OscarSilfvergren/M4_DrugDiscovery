function [Cost_InSphero,Cost_InSpheroStatistical] = InSphero_Costfunction(Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,params, PersonSpecificParameters,modelName,sNames, pNames,initialvalues,AmountParameterOpti)

model = str2func(modelName);

%% Simulate the studies with human islets

    [simStudy1_LCHG,simStudy1_HCHG]                                                 = SimulateStudy1(model,Study1_data,params,PersonSpecificParameters,initialvalues,sNames,pNames);
    [simStudy3_B27,simStudy3_FCS]                                                   = SimulateStudy3(model,Study3_data,params,PersonSpecificParameters,initialvalues,sNames,pNames);
    [SimStudy4_vehicle, SimStudy4_0p1, SimStudy4_10, SimStudy4_1000,simStudy5_GSIS] = SimulateStudy4o5(model,Study4_data,params,PersonSpecificParameters,initialvalues,sNames,pNames);
    [simStudy14_GSIS]                                                               = SimulateStudy14(model,params,Study14_data,PersonSpecificParameters,initialvalues,sNames,pNames);
    [simInsulinPhases_flow0,simInsulinPhases_flow100,simInsulinPhases_static0,simInsulinPhases_static100,simInsulinPhases_Article2,simInsulinPhases_GSIS] = SimulateInsulinPhases(model,InSpheroInsulinPhases_data,params,PersonSpecificParameters,initialvalues,sNames,pNames,0);
    [simStudy13_GSIS]                                                               = SimulateStudy13(model,Study13_data,params,PersonSpecificParameters,initialvalues,sNames,pNames);
    
%% Study1 (dgf = 32)

DatapointsSampleFromSimulation = round(Study1_data.time(1:8)+0.1,2)*10;

% Glucose - HCHG
Glucose_Simulated    = simStudy1_HCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy1_HCHG.states,'Glucose_Medium'));
CostStudy1_Glucose   = ((Study1_data.GlucoseHCHG(1:8)    - Glucose_Simulated).^2) ./(max(Study1_data.GlucoseHCHGstdev(1:8),mean(Study1_data.GlucoseHCHGstdev(1:8),'omitnan')).^2);
CostStudy1_Glucose(1) = 0;
CostStudy1_Glucose(5) = 0;
% Insulin
Insulin_Simulated    = simStudy1_HCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy1_HCHG.states,'Insulin_Medium'))/1000;
CostStudy1_Insulin   = ((Study1_data.InsulinHCHG(1:8)    - Insulin_Simulated).^2) ./(max(Study1_data.InsulinHCHGstdev(1:8),mean(Study1_data.InsulinHCHGstdev(1:8),'omitnan')).^2); 
CostStudy1_Insulin(1) = 0;
CostStudy1_Insulin(5) = 0;
CostStudy1_HCHG_statistical  = sum(CostStudy1_Glucose,"omitnan")+ sum(CostStudy1_Insulin,"omitnan");
CostStudy1_Glucose(8) = CostStudy1_Glucose(8)*2;
CostStudy1_Glucose(4) = CostStudy1_Glucose(4)*2;
CostStudy1_HCHG  = sum(CostStudy1_Glucose,"omitnan")+ sum(CostStudy1_Insulin,"omitnan");

% Glucose - LCHG
Glucose_Simulated    = simStudy1_LCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy1_LCHG.states,'Glucose_Medium'));
CostStudy1_Glucose   = ((Study1_data.GlucoseLCHG(1:8)    - Glucose_Simulated).^2) ./(max(Study1_data.GlucoseLCHGstdev(1:8),mean(Study1_data.GlucoseLCHGstdev(1:8),'omitnan')).^2);
CostStudy1_Glucose(1) = 0;
CostStudy1_Glucose(5) = 0;
% Insulin
Insulin_Simulated    = simStudy1_LCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy1_LCHG.states,'Insulin_Medium'))/1000;
CostStudy1_Insulin   = ((Study1_data.InsulinLCHG(1:8)    - Insulin_Simulated).^2) ./(max(Study1_data.InsulinLCHGstdev(1:8),mean(Study1_data.InsulinLCHGstdev(1:8),'omitnan')).^2);
CostStudy1_Insulin(1) = 0;
CostStudy1_Insulin(5) = 0;
CostStudy1_LCHG  = sum(CostStudy1_Glucose,"omitnan")+ sum(CostStudy1_Insulin,"omitnan");

CostStudy1_statistical  = CostStudy1_HCHG_statistical + CostStudy1_LCHG;
CostStudy1_Glucose(8) = CostStudy1_Glucose(8)*2;
CostStudy1_Glucose(4) = CostStudy1_Glucose(4)*2;
CostStudy1            = CostStudy1_HCHG + sum(CostStudy1_Glucose,"omitnan")+ sum(CostStudy1_Insulin,"omitnan");
%% Study3 (dgf = 44)

Lactateweight = mean([Study3_data.LactateB27stdev(1:8), Study3_data.LactateFCSstdev(1:8)]');
Lactateweight = max(Lactateweight,mean(Lactateweight,'omitnan'))';

% Glucose B27
DatapointsSampleFromSimulation = round(Study3_data.time(1:7)+0.1,2)*10;
Glucose_Simulated    = simStudy3_B27.statevalues(DatapointsSampleFromSimulation,ismember(simStudy3_B27.states,'Glucose_Medium'));
CostStudy3_Glucose   = ((Study3_data.GlucoseB27(1:7)    - Glucose_Simulated).^2) ./(max(Study3_data.GlucoseB27stdev(1:7),mean(Study3_data.GlucoseB27stdev(1:7),'omitnan')).^2);
% Insulin
Insulin_Simulated    = simStudy3_B27.statevalues(DatapointsSampleFromSimulation,ismember(simStudy3_B27.states,'Insulin_Medium'))/1000;
CostStudy3_Insulin   = ((Study3_data.InsulinB27(1:7)    - Insulin_Simulated).^2) ./(max(Study3_data.InsulinB27stdev(1:7),mean(Study3_data.InsulinB27stdev(1:7),'omitnan')).^2); 
% Lactate
DatapointsSampleFromSimulation = round(Study3_data.timeLactate(1:8)+0.1,2)*10;
Lactate_Simulated    = simStudy3_B27.statevalues(DatapointsSampleFromSimulation,ismember(simStudy3_B27.states,'Lactate_Medium'));
CostStudy3_Lactate   = ((Study3_data.LactateB27(1:8)    - Lactate_Simulated).^2) ./(Lactateweight.^2);
CostStudy3B27_statistical  = sum(CostStudy3_Glucose,"omitnan")+ sum(CostStudy3_Insulin,"omitnan") + sum(CostStudy3_Lactate,"omitnan");
CostStudy3_Insulin(3) = CostStudy3_Insulin(3)*2;
CostStudy3_Insulin(7) = CostStudy3_Insulin(7)*2;
CostStudy3_Glucose(3) = CostStudy3_Glucose(3)*2;
CostStudy3_Glucose(6) = CostStudy3_Glucose(6)*2;
CostStudy3B27  = sum(CostStudy3_Glucose,"omitnan")+ sum(CostStudy3_Insulin,"omitnan") + sum(CostStudy3_Lactate,"omitnan");

% Glucose FCS
DatapointsSampleFromSimulation = round(Study3_data.time(1:7)+0.1,2)*10;
Glucose_Simulated    = simStudy3_FCS.statevalues(DatapointsSampleFromSimulation,ismember(simStudy3_FCS.states,'Glucose_Medium'));
CostStudy3_Glucose   = ((Study3_data.GlucoseFCS(1:7)    - Glucose_Simulated).^2) ./(max(Study3_data.GlucoseFCSstdev(1:7),mean(Study3_data.GlucoseFCSstdev(1:7),'omitnan')).^2);
% Insulin
Insulin_Simulated    = simStudy3_FCS.statevalues(DatapointsSampleFromSimulation,ismember(simStudy3_FCS.states,'Insulin_Medium'))/1000;
CostStudy3_Insulin   = ((Study3_data.InsulinFCS(1:7)    - Insulin_Simulated).^2) ./(max(Study3_data.InsulinFCSstdev(1:7),mean(Study3_data.InsulinFCSstdev(1:7),'omitnan')).^2);
% Lactate
DatapointsSampleFromSimulation = round(Study3_data.timeLactate(1:8)+0.1,2)*10;
Lactate_Simulated    = simStudy3_FCS.statevalues(DatapointsSampleFromSimulation,ismember(simStudy3_FCS.states,'Lactate_Medium'));
CostStudy3_Lactate   = ((Study3_data.LactateFCS(1:8)    - Lactate_Simulated).^2) ./(Lactateweight.^2);
CostStudy3FCS_statistical  = sum(CostStudy3_Glucose,"omitnan")+ sum(CostStudy3_Insulin,"omitnan") + sum(CostStudy3_Lactate,"omitnan");
CostStudy3_Insulin(3) = CostStudy3_Insulin(3)*2;
CostStudy3_Insulin(7) = CostStudy3_Insulin(7)*2;
CostStudy3_Glucose(3) = CostStudy3_Glucose(3)*2;
CostStudy3_Glucose(6) = CostStudy3_Glucose(6)*2;
CostStudy3FCS  = sum(CostStudy3_Glucose,"omitnan")+ sum(CostStudy3_Insulin,"omitnan") + sum(CostStudy3_Lactate,"omitnan");

CostStudy3_statistical = CostStudy3B27_statistical + CostStudy3FCS_statistical;
CostStudy3 = CostStudy3B27 + CostStudy3FCS;
%% Study4 (dgf = 160)

DatapointsSampleFromSimulation        = round(Study4_data.time(1:12)+0.1,2)*10;
DatapointsSampleFromSimulationLactate = round(Study4_data.timeLactate(1:8)+0.1,2)*10;
DatapointsSampleFromExenatide         = round(Study4_data.timeExenatide(1:4)+0.1,2)*10;

% Vehicle Glucose
Glucose_Simulated            = SimStudy4_vehicle.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_vehicle.states,'Glucose_Medium'));
CostStudy4_GlucoseVehicle    = ((Study4_data.Glucose_Vehicle(1:12)    - Glucose_Simulated).^2) ./(max(Study4_data.GlucoseSEM_Vehicle(1:12),mean(Study4_data.GlucoseSEM_Vehicle(1:12),'omitnan')).^2);
CostStudy4_GlucoseVehicle(1) = 0;
CostStudy4_GlucoseVehicle(5) = 0;
CostStudy4_GlucoseVehicle(9) = 0;
% Insulin
Insulin_Simulated              = SimStudy4_vehicle.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_vehicle.states,'Insulin_Medium'))/1000;
CostStudy4_InsulinVehicle      = ((Study4_data.Insulin_Vehicle(1:12)    - Insulin_Simulated).^2) ./(max(Study4_data.InsulinSEM_Vehicle(1:12),mean(Study4_data.InsulinSEM_Vehicle(1:12),'omitnan')).^2);
CostStudy4_InsulinVehicle(6:7) = CostStudy4_InsulinVehicle(6:7)*0.1; % Low trust after discussion with experimentalists
% Lactate
Lactate_Simulated              = SimStudy4_vehicle.statevalues(DatapointsSampleFromSimulationLactate,ismember(SimStudy4_vehicle.states,'Lactate_Medium'));
CostStudy4_LactateVehicle      = ((Study4_data.Lactate_Vehicle(1:8)    - Lactate_Simulated).^2) ./(max(Study4_data.LactateSEM_Vehicle(1:8),mean(Study4_data.LactateSEM_Vehicle(1:8),'omitnan')).^2);
CostStudy4Vehicle_statistical  = sum(CostStudy4_GlucoseVehicle,"omitnan")+ sum(CostStudy4_InsulinVehicle,"omitnan") + sum(CostStudy4_LactateVehicle,"omitnan");
CostStudy4_GlucoseVehicle(8)   = CostStudy4_GlucoseVehicle(8)*2;
CostStudy4Vehicle  = sum(CostStudy4_GlucoseVehicle,"omitnan")+ sum(CostStudy4_InsulinVehicle,"omitnan") + sum(CostStudy4_LactateVehicle,"omitnan");

% 0.1 Glucose
Glucose_Simulated        = SimStudy4_0p1.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_0p1.states,'Glucose_Medium'));
CostStudy4_Glucose0p1    = ((Study4_data.Glucose_0p1nM(1:12)    - Glucose_Simulated).^2) ./(max(Study4_data.GlucoseSEM_Vehicle(1:12),mean(Study4_data.GlucoseSEM_Vehicle(1:12),'omitnan')).^2); 
CostStudy4_Glucose0p1(1) = 0;
CostStudy4_Glucose0p1(5) = 0;
CostStudy4_Glucose0p1(9) = 0;
% Insulin
Insulin_Simulated          = SimStudy4_0p1.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_0p1.states,'Insulin_Medium'))/1000;
CostStudy4_Insulin0p1      = ((Study4_data.Insulin_0p1nM(1:12)    - Insulin_Simulated).^2) ./(max(Study4_data.InsulinSEM_0p1nM(1:12),mean(Study4_data.InsulinSEM_0p1nM(1:12),'omitnan')).^2); 
CostStudy4_Insulin0p1(6:7) = CostStudy4_Insulin0p1(6:7)*0.1; % Low trust after discussion with experimentalists
% Lactate
Lactate_Simulated           = SimStudy4_0p1.statevalues(DatapointsSampleFromSimulationLactate,ismember(SimStudy4_0p1.states,'Lactate_Medium'));
CostStudy4_Lactate0p1       = ((Study4_data.Lactate_0p1nM(1:8)    - Lactate_Simulated).^2) ./(max(Study4_data.LactateSEM_Vehicle(1:8),mean(Study4_data.LactateSEM_Vehicle(1:8),'omitnan')).^2);
CostStudy4_0p1_statistical  = sum(CostStudy4_Glucose0p1,"omitnan")+ sum(CostStudy4_Insulin0p1,"omitnan") + sum(CostStudy4_Lactate0p1,"omitnan");
CostStudy4_Glucose0p1(8)    = CostStudy4_Glucose0p1(8)*2;
CostStudy4_Insulin0p1(8)    = CostStudy4_Insulin0p1(8)*2; % Extra weight to exenatide effect
CostStudy4_0p1     = sum(CostStudy4_Glucose0p1,"omitnan")+ sum(CostStudy4_Insulin0p1,"omitnan") + sum(CostStudy4_Lactate0p1,"omitnan");

% 10 Glucose
Glucose_Simulated       = SimStudy4_10.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_10.states,'Glucose_Medium'));
CostStudy4_Glucose10    = ((Study4_data.Glucose_10nM(1:12)    - Glucose_Simulated).^2) ./(max(Study4_data.GlucoseSEM_10nM(1:12),mean(Study4_data.GlucoseSEM_10nM(1:12),'omitnan')).^2);
CostStudy4_Glucose10(1) = 0;
CostStudy4_Glucose10(5) = 0;
CostStudy4_Glucose10(9) = 0;
% Insulin
Insulin_Simulated         = SimStudy4_10.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_10.states,'Insulin_Medium'))/1000;
CostStudy4_Insulin10      = ((Study4_data.Insulin_10nM(1:12)    - Insulin_Simulated).^2) ./(max(Study4_data.InsulinSEM_10nM(1:12),mean(Study4_data.InsulinSEM_10nM(1:12),'omitnan')).^2);
CostStudy4_Insulin10(6:7) = CostStudy4_Insulin10(6:7)*0.1; % Low trust after discussion with experimentalists
% Lactate
Lactate_Simulated          = SimStudy4_10.statevalues(DatapointsSampleFromSimulationLactate,ismember(SimStudy4_10.states,'Lactate_Medium'));
CostStudy4_Lactate10       = ((Study4_data.Lactate_10nM(1:8)    - Lactate_Simulated).^2) ./(max(Study4_data.LactateSEM_Vehicle(1:8),mean(Study4_data.LactateSEM_Vehicle(1:8),'omitnan')).^2);
CostStudy4_10_statistical  = sum(CostStudy4_Glucose10,"omitnan")+ sum(CostStudy4_Insulin10,"omitnan") + sum(CostStudy4_Lactate10,"omitnan");
CostStudy4_Glucose10(8)    = CostStudy4_Glucose10(8)*2;
CostStudy4_Insulin10(8)    = CostStudy4_Insulin10(8)*2; % Extra weight to exenatide effect
CostStudy4_10  = sum(CostStudy4_Glucose10,"omitnan")+ sum(CostStudy4_Insulin10,"omitnan") + sum(CostStudy4_Lactate10,"omitnan");

% 1000 Glucose
Glucose_Simulated         = SimStudy4_1000.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_1000.states,'Glucose_Medium'));
CostStudy4_Glucose1000    = ((Study4_data.Glucose_1uM(1:12)    - Glucose_Simulated).^2) ./(max(Study4_data.GlucoseSEM_1uM(1:12),mean(Study4_data.GlucoseSEM_1uM(1:12),'omitnan')).^2);
CostStudy4_Glucose1000(1) = 0;
CostStudy4_Glucose1000(5) = 0;
CostStudy4_Glucose1000(9) = 0;
% Insulin
Insulin_Simulated           = SimStudy4_1000.statevalues(DatapointsSampleFromSimulation,ismember(SimStudy4_1000.states,'Insulin_Medium'))/1000;
CostStudy4_Insulin1000      = ((Study4_data.Insulin_1uM(1:12)    - Insulin_Simulated).^2) ./(max(Study4_data.InsulinSEM_1uM(1:12),mean(Study4_data.InsulinSEM_1uM(1:12),'omitnan')).^2);
CostStudy4_Insulin1000(6:7) = CostStudy4_Insulin1000(6:7)*0.1; % Low trust after discussion with experimentalists
% Lactate
Lactate_Simulated            = SimStudy4_1000.statevalues(DatapointsSampleFromSimulationLactate,ismember(SimStudy4_1000.states,'Lactate_Medium'));
CostStudy4_Lactate1000       = ((Study4_data.Lactate_1uM(1:8)    - Lactate_Simulated).^2) ./(max(Study4_data.LactateSEM_Vehicle(1:8),mean(Study4_data.LactateSEM_Vehicle(1:8),'omitnan')).^2);
CostStudy4_1000_statistical  = sum(CostStudy4_Glucose1000,"omitnan")+ sum(CostStudy4_Insulin1000,"omitnan") + sum(CostStudy4_Lactate1000,"omitnan");
CostStudy4_Glucose1000(8)    = CostStudy4_Glucose1000(8)*2;
CostStudy4_Insulin1000(8)    = CostStudy4_Insulin1000(8)*2; % Extra weight to exenatide effect
CostStudy4_1000  = sum(CostStudy4_Glucose1000,"omitnan")+ sum(CostStudy4_Insulin1000,"omitnan") + sum(CostStudy4_Lactate1000,"omitnan");

% Exenatide
Exenatide_Simulated     = SimStudy4_0p1.statevalues(DatapointsSampleFromExenatide,ismember(SimStudy4_0p1.states,'Exenatide_Medium'));
CostStudy4_Exenatide0p1 = ((Study4_data.Exenatide_0p1(1:4)    - Exenatide_Simulated).^2) ./(max(Study4_data.ExenatideSEM_0p1(1:4),mean(Study4_data.ExenatideSEM_0p1(1:4),'omitnan')).^2);
% Exenatide
Exenatide_Simulated    = SimStudy4_10.statevalues(DatapointsSampleFromExenatide,ismember(SimStudy4_10.states,'Exenatide_Medium'));
CostStudy4_Exenatide10 = ((Study4_data.Exenatide_10nM(1:4)    - Exenatide_Simulated).^2) ./(max(Study4_data.ExenatideSEM_10nM(1:4),mean(Study4_data.ExenatideSEM_10nM(1:4),'omitnan')).^2);
% Exenatide
Exenatide_Simulated      = SimStudy4_1000.statevalues(DatapointsSampleFromExenatide,ismember(SimStudy4_1000.states,'Exenatide_Medium'));
CostStudy4_Exenatide1000 = ((Study4_data.Exenatide_1uM(1:4)    - Exenatide_Simulated).^2) ./(max(Study4_data.ExenatideSEM_1uM(1:4),mean(Study4_data.ExenatideSEM_1uM(1:4),'omitnan')).^2);
CostStudy4_E =  sum(CostStudy4_Exenatide0p1,"omitnan") +  sum(CostStudy4_Exenatide10,"omitnan") +  sum(CostStudy4_Exenatide1000,"omitnan");

% GSIS
CostStudy5_GSIS_G3d0    = ((Study5_data.LG_D0(1:6)  - simStudy5_GSIS.SaveInsulinSecretionD0(:,1)).^2) ./(max(Study5_data.LG_D0stdev(1:6),mean(Study5_data.LG_D0stdev(1:6),'omitnan')).^2);
CostStudy5_GSIS_G16d0   = ((Study5_data.HG_D0(1:6)  - simStudy5_GSIS.SaveInsulinSecretionD0(:,2)).^2) ./(max(Study5_data.HG_D0stdev(1:6),mean(Study5_data.HG_D0stdev(1:6),'omitnan')).^2);

G2p8       = [simStudy5_GSIS.SaveInsulinSecretionD15vehicle(1), simStudy5_GSIS.SaveInsulinSecretionD15_0p1(1), simStudy5_GSIS.SaveInsulinSecretionD15_10(1), simStudy5_GSIS.SaveInsulinSecretionD15_1000(1)];
data    = [Study5_data.LG_D15(1)     ,Study5_data.LG_D15(2)     , Study5_data.LG_D15(4)     , Study5_data.LG_D15(6)];
stdev   = [Study5_data.LG_D15stdev(1),Study5_data.LG_D15stdev(2), Study5_data.LG_D15stdev(4), Study5_data.LG_D15stdev(6)];
CostStudy5_GSIS_G3d15    = ((data   - G2p8).^2) ./(max(stdev,mean(stdev,'omitnan')).^2);

G16p8  = [simStudy5_GSIS.SaveInsulinSecretionD15vehicle(2), simStudy5_GSIS.SaveInsulinSecretionD15_0p1(2), simStudy5_GSIS.SaveInsulinSecretionD15_10(2), simStudy5_GSIS.SaveInsulinSecretionD15_1000(2)];
data   = [Study5_data.HG_D15(1)     ,Study5_data.HG_D15(2)     , Study5_data.HG_D15(4)     , Study5_data.HG_D15(6)];
stdev  = [Study5_data.HG_D15stdev(1),Study5_data.HG_D15stdev(2), Study5_data.HG_D15stdev(4), Study5_data.HG_D15stdev(6)];
CostStudy5_GSIS_G16d15   = ((data    - G16p8).^2)./(max(stdev,mean(stdev,'omitnan')).^2);
CostStudy5_GSIS =  sum(CostStudy5_GSIS_G3d0,"omitnan") + sum(CostStudy5_GSIS_G16d0,"omitnan") + sum(CostStudy5_GSIS_G3d15,"omitnan") + sum(CostStudy5_GSIS_G16d15,"omitnan");

CostStudy4o5             = CostStudy4Vehicle             + CostStudy4_0p1             + CostStudy4_10             + CostStudy4_1000              + CostStudy4_E  + CostStudy5_GSIS;
CostStudy4o5_statistical = CostStudy4Vehicle_statistical + CostStudy4_0p1_statistical + CostStudy4_10_statistical + CostStudy4_1000_statistical  + CostStudy4_E  + CostStudy5_GSIS;

%% Study 14 (dgf = 10)

EduPositiveSM   = FindEdU(simStudy14_GSIS.SM(1),simStudy14_GSIS.SM(2));
EduPositiveB27  = FindEdU(simStudy14_GSIS.B27(1),simStudy14_GSIS.B27(2));
EduPositiveLCLG = FindEdU(simStudy14_GSIS.LCLG(1),simStudy14_GSIS.LCLG(2));
EduPositiveLCHG = FindEdU(simStudy14_GSIS.LCHG(1),simStudy14_GSIS.LCHG(2));
EduPositiveHCLG = FindEdU(simStudy14_GSIS.HCLG(1),simStudy14_GSIS.HCLG(2));
EduPositiveHCHG = FindEdU(simStudy14_GSIS.HCHG(1),simStudy14_GSIS.HCHG(2));
EduPositive0p1  = FindEdU(simStudy14_GSIS.HCHG_E0p1(1),simStudy14_GSIS.HCHG_E0p1(2));
EduPositive10   = FindEdU(simStudy14_GSIS.HCHG_E10(1),simStudy14_GSIS.HCHG_E10(2));
EduPositive1000 = FindEdU(simStudy14_GSIS.HCHG_E1000(1),simStudy14_GSIS.HCHG_E1000(2));

CostExpEdU_GSIS_SM    = ((Study14_data.Control(1)   - EduPositiveSM).^2)     ./(Study14_data.Control(2).^2);
CostExpEdU_GSIS_B27   = ((Study14_data.B27(1)       - EduPositiveB27).^2)        ./(Study14_data.B27(2).^2);
CostExpEdU_GSIS_LCLG  = ((Study14_data.LC_FCS_NG(1) - EduPositiveLCLG).^2) ./(Study14_data.LC_FCS_NG(2).^2);
CostExpEdU_GSIS_LCHG  = ((Study14_data.LC_FCS_HG(1) - EduPositiveLCHG).^2) ./(Study14_data.LC_FCS_HG(2).^2);
CostExpEdU_GSIS_HCNG  = ((Study14_data.HC_FCS_NG(1) - EduPositiveHCLG).^2) ./(Study14_data.HC_FCS_NG(2).^2);
CostExpEdU_GSIS_HCHG  = ((Study14_data.HC_FCS_HG(1) - EduPositiveHCHG).^2) ./(Study14_data.HC_FCS_HG(2).^2);

CostExpEdU_GSIS_Vehicle  = ((Study14_data.EdU_E0(1)     - EduPositiveHCHG).^2)./(Study14_data.EdU_E0(2).^2);
CostExpEdU_GSIS_0p1      = ((Study14_data.EdU_E0p1nM(1) - EduPositive0p1).^2) ./(Study14_data.EdU_E0p1nM(2).^2);
CostExpEdU_GSIS_10       = ((Study14_data.EdU_E10nM(1)  - EduPositive10).^2)  ./(Study14_data.EdU_E10nM(2).^2);
CostExpEdU_GSIS_1000     = ((Study14_data.EdU_E1uM(1)   - EduPositive1000).^2)./(Study14_data.EdU_E1uM(2).^2);

CostExpEdU  = sum(CostExpEdU_GSIS_SM,"omitnan") + sum(CostExpEdU_GSIS_B27,"omitnan") + sum(CostExpEdU_GSIS_HCHG,"omitnan") + sum(CostExpEdU_GSIS_HCNG,"omitnan") + sum(CostExpEdU_GSIS_LCLG,"omitnan") + sum(CostExpEdU_GSIS_LCHG,"omitnan") + sum(CostExpEdU_GSIS_Vehicle,"omitnan") + sum(CostExpEdU_GSIS_0p1,"omitnan") + sum(CostExpEdU_GSIS_10,"omitnan") + sum(CostExpEdU_GSIS_1000,"omitnan");

%% Reported data Misun et al. (2020) and Jin et al. (2021)(dgf = 10)

basalSecretion = 0.04;
% Regular S A1
DatapointsSampleFromSimulation = round((InSpheroInsulinPhases_data.timeA1(1:147)-56)*10,0);
S_Simulated      = simInsulinPhases_flow0.variablevalues(DatapointsSampleFromSimulation,ismember(simInsulinPhases_flow0.variables,'S'));
S_SimulatedBasal = simInsulinPhases_flow0.variablevalues(2,ismember(simInsulinPhases_flow0.variables,'S'));
CostExpS_A1      = ((InSpheroInsulinPhases_data.IsletsA1(1:147)./mean(InSpheroInsulinPhases_data.IsletsA1(1:12))    - (S_Simulated./S_SimulatedBasal)).^2) ./(8.^2);

% Regular S A2
DatapointsSampleFromSimulation = round((InSpheroInsulinPhases_data.timep1(1:112)+52)*10,0);
S_Simulated      = simInsulinPhases_Article2.variablevalues(DatapointsSampleFromSimulation,ismember(simInsulinPhases_Article2.variables,'S'));
S_SimulatedBasal = simInsulinPhases_Article2.variablevalues(2,ismember(simInsulinPhases_Article2.variables,'S'));
CostExpS_A2p1    = ((InSpheroInsulinPhases_data.Isletp1(1:112)./basalSecretion    - (S_Simulated./S_SimulatedBasal)).^2) ./(10.^2);
DatapointsSampleFromSimulation = round((InSpheroInsulinPhases_data.timep2(1:112)+52)*10,0);
S_Simulated     = simInsulinPhases_Article2.variablevalues(DatapointsSampleFromSimulation,ismember(simInsulinPhases_Article2.variables,'S'));
CostExpS_A2p2   = ((InSpheroInsulinPhases_data.Isletp2(1:112)./basalSecretion    - (S_Simulated./S_SimulatedBasal)).^2) ./(10.^2);
DatapointsSampleFromSimulation = round((InSpheroInsulinPhases_data.timep3(1:110)+52)*10,0);
S_Simulated     = simInsulinPhases_Article2.variablevalues(DatapointsSampleFromSimulation,ismember(simInsulinPhases_Article2.variables,'S'));
CostExpS_A2p3   = ((InSpheroInsulinPhases_data.Isletp3(1:110)./basalSecretion    - (S_Simulated./S_SimulatedBasal)).^2) ./(10.^2);
DatapointsSampleFromSimulation = round((InSpheroInsulinPhases_data.timep4(1:108)+52)*10,0);
S_Simulated     = simInsulinPhases_Article2.variablevalues(DatapointsSampleFromSimulation,ismember(simInsulinPhases_Article2.variables,'S'));
CostExpS_A2p4   = ((InSpheroInsulinPhases_data.Islet4(1:108)./basalSecretion    - (S_Simulated./S_SimulatedBasal)).^2) ./(10.^2);

basalSecretion = 0.18;
% flow S A1
DatapointsSampleFromSimulation = round((InSpheroInsulinPhases_data.timeflowVehicle(1:125)-39)*10,0);
S_Simulated      = simInsulinPhases_flow0.variablevalues(DatapointsSampleFromSimulation,ismember(simInsulinPhases_flow0.variables,'S'));
S_SimulatedBasal = simInsulinPhases_flow0.variablevalues(2,ismember(simInsulinPhases_flow0.variables,'S'));
CostExpS_flow0   = ((InSpheroInsulinPhases_data.flowVehicle(1:125)./basalSecretion    - (S_Simulated./S_SimulatedBasal)).^2) ./(8.^2);
DatapointsSampleFromSimulation = round((InSpheroInsulinPhases_data.timeflowExenatide(1:151)-39)*10,0);
S_Simulated      = simInsulinPhases_flow100.variablevalues(DatapointsSampleFromSimulation,ismember(simInsulinPhases_flow100.variables,'S'));
S_SimulatedBasal = simInsulinPhases_flow100.variablevalues(2,ismember(simInsulinPhases_flow100.variables,'S'));
CostExpS_flow100 = ((InSpheroInsulinPhases_data.flowExenatide(1:151)./basalSecretion    - (S_Simulated./S_SimulatedBasal)).^2) ./(8.^2);

InSpheroInsulinPhases_data.staticGSISVehicle(1)   = InSpheroInsulinPhases_data.staticGSISVehicle(1)   * simInsulinPhases_GSIS.Data;
InSpheroInsulinPhases_data.staticGSISExenatide(1) = InSpheroInsulinPhases_data.staticGSISExenatide(1) * simInsulinPhases_GSIS.Data;
data       = InSpheroInsulinPhases_data.staticGSISVehicle(1:5)     ./InSpheroInsulinPhases_data.staticGSISVehicle(1);
weight     = InSpheroInsulinPhases_data.staticGSISVehicleSEM(1:5)  ./InSpheroInsulinPhases_data.staticGSISVehicle(1);
simulation = simInsulinPhases_GSIS.Simulation(1,:)'./simInsulinPhases_GSIS.Simulation(1,1);
CostExpS_0    = ((data   - simulation).^2)./(weight.^2);
data       = InSpheroInsulinPhases_data.staticGSISExenatide(1:5)     ./InSpheroInsulinPhases_data.staticGSISExenatide(1);
weight     = InSpheroInsulinPhases_data.staticGSISExenatideSEM(1:5)  ./InSpheroInsulinPhases_data.staticGSISExenatide(1);
simulation = simInsulinPhases_GSIS.Simulation(2,:)'./simInsulinPhases_GSIS.Simulation(2,1);
CostExpS_100    = ((data   - simulation).^2)./(weight.^2);

CostExpS    =  sum(CostExpS_flow0,"omitnan") + sum(CostExpS_flow100,"omitnan") + sum(CostExpS_A1,"omitnan") + (sum(CostExpS_A2p1,"omitnan") + sum(CostExpS_A2p2,"omitnan") + sum(CostExpS_A2p3,"omitnan") + sum(CostExpS_A2p4,"omitnan"))*0.5; %these have no stdev and is used to estimate variables but not counted in chiv2-test
CostExpS_SE =  sum(CostExpS_0,"omitnan")     + sum(CostExpS_100,"omitnan");

%% Study 13 (dgf = 25)

CostExpInSphero_Donor1  = ((Study13_data.Meanp1(1:7) - simStudy13_GSIS.Donor1(1:7)'*(5808*0.00005/1000)).^2) ./(Study13_data.Stdevp1(1:7).^2);
CostExpInSphero_Donor2  = ((Study13_data.Meanp2(1:6) - simStudy13_GSIS.Donor2(1:6)'*(5808*0.00005/1000)).^2) ./(Study13_data.Stdevp2(1:6).^2);
CostExpInSphero_Donor3  = ((Study13_data.Meanp3(1:6) - simStudy13_GSIS.Donor3(1:6)'*(5808*0.00005/1000)).^2) ./(Study13_data.Stdevp3(1:6).^2);
CostExpInSphero_Donor4  = ((Study13_data.Meanp4(1:6) - simStudy13_GSIS.Donor4(1:6)'*(5808*0.00005/1000)).^2) ./(Study13_data.Stdevp4(1:6).^2);

CostExpInSphero  = sum(CostExpInSphero_Donor1,"omitnan")+ sum(CostExpInSphero_Donor2,"omitnan") + sum(CostExpInSphero_Donor3,"omitnan") + sum(CostExpInSphero_Donor4,"omitnan");

%% Sum all cost (dgf = 281)

Cost_InSphero              = CostStudy1             + CostStudy3             + CostStudy4o5             + CostExpEdU  + CostExpS_SE*10 + CostExpInSphero + CostExpS;
Cost_InSpheroStatistical   = CostStudy1_statistical + CostStudy3_statistical + CostStudy4o5_statistical + CostExpEdU  + CostExpS_SE    + CostExpInSphero;

function EduPositiveValue = FindEdU(NoEdU,EdU)
EduPositiveValue = 100*(EdU/(NoEdU+EdU));
end

end
