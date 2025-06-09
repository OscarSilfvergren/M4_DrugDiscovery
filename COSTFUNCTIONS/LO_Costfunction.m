function [Cost_LO,Cost_LO_statistical] = LO_Costfunction (Study6_data ,params,PersonSpecificParameters,modelName,sNames, pNames,initialvalues,AmountParameterOpti)

model = str2func(modelName);

%% Simulate

[SimStudy6_Vehicle0,SimStudy6_Vehicle5,SimStudy6_Vehicle10,SimStudy6_Vehicle100,SimStudy6_Spheroids0,SimStudy6_Spheroids5,SimStudy6_Spheroids10,SimStudy6_Spheroids100,SimStudy6_Volume0,SimStudy6_Volume5,SimStudy6_Volume10,SimStudy6_Volume100,SimStudy6_VolumeSpheroids0,SimStudy6_VolumeSpheroids5,SimStudy6_VolumeSpheroids10,SimStudy6_VolumeSpheroids100] = SimulateStudy6(model,Study6_data,params,PersonSpecificParameters,initialvalues,sNames,pNames);
 CalcAverageResponseStudy6

%% Study 6 (dgf = 64)

DatapointsSampleFromSimulation        = round(Study6_data.timeGlucose(1:8)+0.1,2)*10;

% Glucose GI (Glucose Insulin) - 1st half
Glucose_Simulated = GI_sim_AverageResponse_0nM(DatapointsSampleFromSimulation(1:4));
CostStudy6_GI0    = ((Study6_data.G_0nM(1:4)    - Glucose_Simulated').^2) ./((Study6_data.G_0nMstdev(1:4)).^2);
Glucose_Simulated = GI_sim_AverageResponse_5nM(DatapointsSampleFromSimulation(1:4));
CostStudy6_GI5    = ((Study6_data.G_5nM(1:4)    - Glucose_Simulated').^2) ./((Study6_data.G_5nMstdev(1:4)).^2);
Glucose_Simulated = GI_sim_AverageResponse_10nM(DatapointsSampleFromSimulation(1:4));
CostStudy6_GI10   = ((Study6_data.G_10nM(1:4)    - Glucose_Simulated').^2) ./((Study6_data.G_10nMstdev(1:4)).^2);
Glucose_Simulated = GI_sim_AverageResponse_100nM(DatapointsSampleFromSimulation(1:4));
CostStudy6_GI100  = ((Study6_data.G_100nM(1:4)    - Glucose_Simulated').^2) ./((Study6_data.G_100nMstdev(1:4)).^2);
CostStudy6_GI     = sum(CostStudy6_GI0,"omitnan")+ sum(CostStudy6_GI5,"omitnan") + sum(CostStudy6_GI10,"omitnan") + sum(CostStudy6_GI100,"omitnan");
% Glucose DC (Glucose Condition) - 2nd half
Glucose_Simulated = DC_sim_AverageResponse_Vehicle(DatapointsSampleFromSimulation(5:8));
CostStudy6_DC0    = ((Study6_data.G_vehicle(5:8)    - Glucose_Simulated').^2) ./((Study6_data.G_vehiclestdev(5:8)).^2);
Glucose_Simulated = DC_sim_AverageResponse_2xSpheroids(DatapointsSampleFromSimulation(5:8));
CostStudy6_DC5    = ((Study6_data.G_2Spheroids(5:8)    - Glucose_Simulated').^2) ./((Study6_data.G_2Spheroidsstdev(5:8)).^2);
Glucose_Simulated = DC_sim_AverageResponse_HalfVolume(DatapointsSampleFromSimulation(5:8));
CostStudy6_DC10   = ((Study6_data.G_0p5Volume(5:8)    - Glucose_Simulated').^2) ./((Study6_data.G_0p5Volumestdev(5:8)).^2);
Glucose_Simulated = DC_sim_AverageResponse_2xSpheroidsHalfVolume(DatapointsSampleFromSimulation(5:8));
CostStudy6_DC100  = ((Study6_data.G_VoS(5:8)    - Glucose_Simulated').^2) ./((Study6_data.G_VoSstdev(5:8)).^2);
CostStudy6_DC     = sum(CostStudy6_DC0,"omitnan")+ sum(CostStudy6_DC5,"omitnan") + sum(CostStudy6_DC10,"omitnan") + sum(CostStudy6_DC100,"omitnan");

% Glucose InsulinResistance (IR)
Glucose_Simulated0 = GI_sim_AverageResponse_0nM(DatapointsSampleFromSimulation);
CostStudy6_GI0     = ((Study6_data.IR_0nM'    - Glucose_Simulated0./Glucose_Simulated0).^2) ./((Study6_data.IR_0nMstdev').^2);
Glucose_Simulated  = GI_sim_AverageResponse_5nM(DatapointsSampleFromSimulation);
CostStudy6_GI5     = ((Study6_data.IR_5nM'    - Glucose_Simulated./Glucose_Simulated0).^2) ./((Study6_data.IR_5nMstdev').^2);
Glucose_Simulated  = GI_sim_AverageResponse_10nM(DatapointsSampleFromSimulation);
CostStudy6_GI10    = ((Study6_data.IR_10nM'    - Glucose_Simulated./Glucose_Simulated0).^2) ./((Study6_data.IR_10nMstdev').^2);
Glucose_Simulated  = GI_sim_AverageResponse_100nM(DatapointsSampleFromSimulation);
CostStudy6_GI100   = ((Study6_data.IR_100nM'    - Glucose_Simulated./Glucose_Simulated0).^2) ./((Study6_data.IR_100nMstdev').^2);
CostStudy6_RelativeChange = sum(CostStudy6_GI0,"omitnan")+ sum(CostStudy6_GI5,"omitnan") + sum(CostStudy6_GI10,"omitnan") + sum(CostStudy6_GI100,"omitnan");

Cost_LO_statistical = sum(CostStudy6_GI,"omitnan")+ sum(CostStudy6_RelativeChange,"omitnan") + sum(CostStudy6_DC,"omitnan");
Cost_LO             = 2*(sum(CostStudy6_GI,"omitnan")+ sum(CostStudy6_RelativeChange,"omitnan") + sum(CostStudy6_DC,"omitnan"));

end
