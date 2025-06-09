function [Cost_predictions] = Study2o9o10predictions_costfunction(Study2_data,Study9_data,Study10_data,params,PersonSpecificParameters,modelName,sNames, pNames,Calibration,initialvalues)

params=exp(params);
model = str2func(modelName);

%% Seperate co-parameters and EndoC/InSphero specific parameters
[PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,[],params);

[simStudy2calibrated_LCHG,simStudy2calibrated_HCHG]  = SimulateStudy2(model,Study2_data   ,InSphero_params,PersonSpecificParametersInSphero,Calibration,initialvalues,sNames,pNames);

[simStudy9_control, simStudy9_0p1, simStudy9_10,simStudy10_GSIS] = SimulateStudy9o10(model,Study9_data,Study10_data,EndoC_params,PersonSpecificParametersEndoC,initialvalues,sNames,pNames,0);

%% Study 2 (dgf = 24)

DatapointsSampleFromSimulation = round(Study2_data.time(1:6)+0.1,2)*10;
DatapointWeightInsulin = mean([Study2_data.InsulinHCHGstdev(1:6);Study2_data.InsulinLCHGstdev(1:6)]);
DatapointWeightGlucose = mean([Study2_data.GlucoseHCHGstdev(1:6);Study2_data.GlucoseLCHGstdev(1:6)]);

% Glucose - HCHG
Glucose_Simulated    = simStudy2calibrated_HCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy2calibrated_HCHG.states,'Glucose_Medium'));
CostStudy2_Glucose   = ((Study2_data.GlucoseHCHG(1:6)    - Glucose_Simulated).^2) ./(max(Study2_data.GlucoseHCHGstdev(1:6),DatapointWeightGlucose,'omitnan').^2);
% Insulin
Insulin_Simulated    = simStudy2calibrated_HCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy2calibrated_HCHG.states,'Insulin_Medium'))/1000;
CostStudy2_Insulin   = ((Study2_data.InsulinHCHG(1:6)    - Insulin_Simulated).^2) ./(max(Study2_data.InsulinHCHGstdev(1:6),DatapointWeightInsulin,'omitnan').^2); 
CostStudy2_HCHG  = sum(CostStudy2_Glucose,"omitnan")+ sum(CostStudy2_Insulin,"omitnan");

% Glucose - LCHG
Glucose_Simulated    = simStudy2calibrated_LCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy2calibrated_LCHG.states,'Glucose_Medium'));
CostStudy2_Glucose   = ((Study2_data.GlucoseLCHG(1:6)    - Glucose_Simulated).^2) ./(max(Study2_data.GlucoseLCHGstdev(1:6),DatapointWeightGlucose,'omitnan').^2);
% Insulin
Insulin_Simulated    = simStudy2calibrated_LCHG.statevalues(DatapointsSampleFromSimulation,ismember(simStudy2calibrated_LCHG.states,'Insulin_Medium'))/1000;
CostStudy2_Insulin   = ((Study2_data.InsulinLCHG(1:6)    - Insulin_Simulated).^2) ./(max(Study2_data.InsulinLCHGstdev(1:6),DatapointWeightInsulin,'omitnan').^2);
CostStudy2_LCHG  = sum(CostStudy2_Glucose,"omitnan")+ sum(CostStudy2_Insulin,"omitnan");


CostStudy2 = CostStudy2_HCHG + CostStudy2_LCHG;

%% Study 9 o 10 (dgf = 39)

DatapointsSampleFromSimulation = round(Study9_data.GTTtime(1:12)+0.1,2)*10;
DatapointWeight = mean([Study9_data.Insulin0SEM(1:12); Study9_data.Insulin0p1SEM(1:12); Study9_data.Insulin10SEM(1:12)]);
% 0
Insulin_Simulated    = simStudy9_control.statevalues(DatapointsSampleFromSimulation,ismember(simStudy9_control.states,'Insulin_Medium'))/1000;
CostStudy9_0 = ((Study9_data.Insulin0(1:12)    - Insulin_Simulated).^2) ./(max(Study9_data.Insulin0SEM(1:12),DatapointWeight,'omitnan').^2);
% 0.1
Insulin_Simulated    = simStudy9_0p1.statevalues(DatapointsSampleFromSimulation,ismember(simStudy9_0p1.states,'Insulin_Medium'))/1000;
CostStudy9_0p1 = ((Study9_data.Insulin0p1(1:12)    - Insulin_Simulated).^2) ./(max(Study9_data.Insulin0p1SEM(1:12),DatapointWeight,'omitnan').^2);
% 10
Insulin_Simulated    = simStudy9_10.statevalues(DatapointsSampleFromSimulation,ismember(simStudy9_10.states,'Insulin_Medium'))/1000;
CostStudy9_10 = ((Study9_data.Insulin10(1:12)    - Insulin_Simulated).^2) ./(max(Study9_data.Insulin10SEM(1:12),DatapointWeight,'omitnan').^2);

Simulation(1) = simStudy10_GSIS.simULTd0_G0.statevalues(end,ismember(simStudy10_GSIS.simULTd0_G0.states,'Insulin_Medium'));
Simulation(2) = simStudy10_GSIS.simULTd0_G5p5E1.statevalues(end,ismember(simStudy10_GSIS.simULTd0_G5p5E1.states,'Insulin_Medium'));
Simulation(3) = simStudy10_GSIS.simULTd0_G20E1.statevalues(end,ismember(simStudy10_GSIS.simULTd0_G20E1.states,'Insulin_Medium'));
CostStudy10_GSIS  = (((Study10_data.DGRInsulinMean(1:3)) - Simulation').^2) ./(Study10_data.DGRInsulinSE(1:3).^2);

%% Cost

Cost_predictions = CostStudy2 + sum(CostStudy10_GSIS,"omitnan") + sum(CostStudy9_0,"omitnan") + sum(CostStudy9_0p1,"omitnan") +sum(CostStudy9_10,"omitnan");

end
