%% Insulin
GI_sim_AverageResponse_0nM  = mean([  
SimStudy6_Vehicle0.statevalues(:,ismember(SimStudy6_Vehicle0.states,'Glucose_Medium'))';
SimStudy6_Spheroids0.statevalues(:,ismember(SimStudy6_Spheroids0.states,'Glucose_Medium'))';
SimStudy6_Volume0.statevalues(:,ismember(SimStudy6_Volume0.states,'Glucose_Medium'))';
SimStudy6_VolumeSpheroids0.statevalues(:,ismember(SimStudy6_VolumeSpheroids0.states,'Glucose_Medium'))']);

GI_sim_AverageResponse_5nM  = mean([  
SimStudy6_Vehicle5.statevalues(:,ismember(SimStudy6_Vehicle5.states,'Glucose_Medium'))';
SimStudy6_Spheroids5.statevalues(:,ismember(SimStudy6_Spheroids5.states,'Glucose_Medium'))';
SimStudy6_Volume5.statevalues(:,ismember(SimStudy6_Volume5.states,'Glucose_Medium'))';
SimStudy6_VolumeSpheroids5.statevalues(:,ismember(SimStudy6_VolumeSpheroids5.states,'Glucose_Medium'))']);

GI_sim_AverageResponse_10nM  = mean([  
SimStudy6_Vehicle10.statevalues(:,ismember(SimStudy6_Vehicle10.states,'Glucose_Medium'))';
SimStudy6_Spheroids10.statevalues(:,ismember(SimStudy6_Spheroids10.states,'Glucose_Medium'))';
SimStudy6_Volume10.statevalues(:,ismember(SimStudy6_Volume10.states,'Glucose_Medium'))';
SimStudy6_VolumeSpheroids10.statevalues(:,ismember(SimStudy6_VolumeSpheroids10.states,'Glucose_Medium'))']);

GI_sim_AverageResponse_100nM  = mean([  
SimStudy6_Vehicle100.statevalues(:,ismember(SimStudy6_Vehicle100.states,'Glucose_Medium'))';
SimStudy6_Spheroids100.statevalues(:,ismember(SimStudy6_Spheroids100.states,'Glucose_Medium'))';
SimStudy6_Volume100.statevalues(:,ismember(SimStudy6_Volume100.states,'Glucose_Medium'))';
SimStudy6_VolumeSpheroids100.statevalues(:,ismember(SimStudy6_VolumeSpheroids100.states,'Glucose_Medium'))']);

%% Different conditions

DC_sim_AverageResponse_Vehicle  = mean([  
SimStudy6_Vehicle0.statevalues(:,ismember(SimStudy6_Vehicle0.states,'Glucose_Medium'))';
SimStudy6_Vehicle5.statevalues(:,ismember(SimStudy6_Vehicle5.states,'Glucose_Medium'))';
SimStudy6_Vehicle10.statevalues(:,ismember(SimStudy6_Vehicle10.states,'Glucose_Medium'))';
SimStudy6_Vehicle100.statevalues(:,ismember(SimStudy6_Vehicle100.states,'Glucose_Medium'))']);

DC_sim_AverageResponse_2xSpheroids  = mean([  
SimStudy6_Spheroids0.statevalues(:,ismember(SimStudy6_Spheroids0.states,'Glucose_Medium'))';
SimStudy6_Spheroids5.statevalues(:,ismember(SimStudy6_Spheroids5.states,'Glucose_Medium'))';
SimStudy6_Spheroids10.statevalues(:,ismember(SimStudy6_Spheroids10.states,'Glucose_Medium'))';
SimStudy6_Spheroids100.statevalues(:,ismember(SimStudy6_Spheroids100.states,'Glucose_Medium'))']);

DC_sim_AverageResponse_HalfVolume  = mean([  
SimStudy6_Volume0.statevalues(:,ismember(SimStudy6_Volume0.states,'Glucose_Medium'))';
SimStudy6_Volume5.statevalues(:,ismember(SimStudy6_Volume5.states,'Glucose_Medium'))';
SimStudy6_Volume10.statevalues(:,ismember(SimStudy6_Volume10.states,'Glucose_Medium'))';
SimStudy6_Volume100.statevalues(:,ismember(SimStudy6_Volume100.states,'Glucose_Medium'))']);

DC_sim_AverageResponse_2xSpheroidsHalfVolume  = mean([  
SimStudy6_VolumeSpheroids0.statevalues(:,ismember(SimStudy6_VolumeSpheroids0.states,'Glucose_Medium'))';
SimStudy6_VolumeSpheroids5.statevalues(:,ismember(SimStudy6_VolumeSpheroids5.states,'Glucose_Medium'))';
SimStudy6_VolumeSpheroids10.statevalues(:,ismember(SimStudy6_VolumeSpheroids10.states,'Glucose_Medium'))';
SimStudy6_VolumeSpheroids100.statevalues(:,ismember(SimStudy6_VolumeSpheroids100.states,'Glucose_Medium'))']);