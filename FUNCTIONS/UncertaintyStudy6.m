if j == 1
    
    % Glucose - Insulin group 0
    maxGlucose_Study6_0  = GI_sim_AverageResponse_0nM;
    minGlucose_Study6_0  = maxGlucose_Study6_0;
    simBestG_0nM         = GI_sim_AverageResponse_0nM;
    % 5
    maxGlucose_Study6_5 = GI_sim_AverageResponse_5nM;
    minGlucose_Study6_5 = maxGlucose_Study6_5;
    simBestG_5nM        = GI_sim_AverageResponse_5nM;
    % 10
    maxGlucose_Study6_10 = GI_sim_AverageResponse_10nM;
    minGlucose_Study6_10 = maxGlucose_Study6_10;
    simBestG_10nM        = GI_sim_AverageResponse_10nM;
    % 100
    maxGlucose_Study6_100 = GI_sim_AverageResponse_100nM;
    minGlucose_Study6_100 = maxGlucose_Study6_100;
    simBestG_100nM        = GI_sim_AverageResponse_100nM;
    
    % Glucose - Insulin group 0
    maxGlucose_Study6_0Relative = GI_sim_AverageResponse_0nM./GI_sim_AverageResponse_0nM;
    minGlucose_Study6_0Relative = maxGlucose_Study6_0Relative;
    simBestG_0nMRelative         = maxGlucose_Study6_0Relative;
    % 5
    maxGlucose_Study6_5Relative = GI_sim_AverageResponse_5nM./GI_sim_AverageResponse_0nM;
    minGlucose_Study6_5Relative = maxGlucose_Study6_5Relative;
    simBestG_5nMRelative        = maxGlucose_Study6_5Relative;
    % 10
    maxGlucose_Study6_10Relative = GI_sim_AverageResponse_10nM./GI_sim_AverageResponse_0nM;
    minGlucose_Study6_10Relative = maxGlucose_Study6_10Relative;
    simBestG_10nMRelative        = maxGlucose_Study6_10Relative;
    % 100
    maxGlucose_Study6_100Relative = GI_sim_AverageResponse_100nM./GI_sim_AverageResponse_0nM;
    minGlucose_Study6_100Relative = maxGlucose_Study6_100Relative;   
    simBestG_100nMRelative        = maxGlucose_Study6_100Relative;
    
    
    simBestG_Vehicle               = DC_sim_AverageResponse_Vehicle;
    simBestG_2xSpheroids           = DC_sim_AverageResponse_2xSpheroids;
    simBestG_0p5Volume             = DC_sim_AverageResponse_HalfVolume;
    simBestG_2xSpheroids0p5Volume  = DC_sim_AverageResponse_2xSpheroidsHalfVolume;
    % Glucose - Insulin group 0
    maxGlucose_Study6_Vehicle = DC_sim_AverageResponse_Vehicle;
    minGlucose_Study6_Vehicle = maxGlucose_Study6_Vehicle;
    % 5
    maxGlucose_Study6_2xSpheroids = DC_sim_AverageResponse_2xSpheroids;
    minGlucose_Study6_2xSpheroids = maxGlucose_Study6_2xSpheroids;
    % 10
    maxGlucose_Study6_HalfVolume = DC_sim_AverageResponse_HalfVolume;
    minGlucose_Study6_HalfVolume = maxGlucose_Study6_HalfVolume;
    % 100
    maxGlucose_Study6_2xSpheroidsHalfVolume = DC_sim_AverageResponse_2xSpheroidsHalfVolume;
    minGlucose_Study6_2xSpheroidsHalfVolume = maxGlucose_Study6_2xSpheroidsHalfVolume;
    
    
end

% Glucose - Insulin group 0
NewGlucose_Study6_0 = GI_sim_AverageResponse_0nM;
maxGlucose_Study6_0 = max(maxGlucose_Study6_0,NewGlucose_Study6_0);
minGlucose_Study6_0 = min(minGlucose_Study6_0,NewGlucose_Study6_0);
% 5
NewGlucose_Study6_5 = GI_sim_AverageResponse_5nM;
maxGlucose_Study6_5 = max(maxGlucose_Study6_5,NewGlucose_Study6_5);
minGlucose_Study6_5 = min(minGlucose_Study6_5,NewGlucose_Study6_5);
% 10
NewGlucose_Study6_10 = GI_sim_AverageResponse_10nM;
maxGlucose_Study6_10 = max(maxGlucose_Study6_10,NewGlucose_Study6_10);
minGlucose_Study6_10 = min(minGlucose_Study6_10,NewGlucose_Study6_10);
% 10
NewGlucose_Study6_100 = GI_sim_AverageResponse_100nM;
maxGlucose_Study6_100 = max(maxGlucose_Study6_100,NewGlucose_Study6_100);
minGlucose_Study6_100 = min(minGlucose_Study6_100,NewGlucose_Study6_100);

% Glucose - Insulin group 0
NewGlucose_Study6_0Relative = GI_sim_AverageResponse_0nM./GI_sim_AverageResponse_0nM;
maxGlucose_Study6_0Relative = max(maxGlucose_Study6_0Relative,NewGlucose_Study6_0Relative);
minGlucose_Study6_0Relative = min(minGlucose_Study6_0Relative,NewGlucose_Study6_0Relative);
% 5
NewGlucose_Study6_5Relative = GI_sim_AverageResponse_5nM./GI_sim_AverageResponse_0nM;
maxGlucose_Study6_5Relative = max(maxGlucose_Study6_5Relative,NewGlucose_Study6_5Relative);
minGlucose_Study6_5Relative = min(minGlucose_Study6_5Relative,NewGlucose_Study6_5Relative);
% 10
NewGlucose_Study6_10Relative = GI_sim_AverageResponse_10nM./GI_sim_AverageResponse_0nM;
maxGlucose_Study6_10Relative = max(maxGlucose_Study6_10Relative,NewGlucose_Study6_10Relative);
minGlucose_Study6_10Relative = min(minGlucose_Study6_10Relative,NewGlucose_Study6_10Relative);
% 10
NewGlucose_Study6_100Relative = GI_sim_AverageResponse_100nM./GI_sim_AverageResponse_0nM;
maxGlucose_Study6_100Relative = max(maxGlucose_Study6_100Relative,NewGlucose_Study6_100Relative);
minGlucose_Study6_100Relative = min(minGlucose_Study6_100Relative,NewGlucose_Study6_100Relative);


% Glucose - Insulin group 0
NewGlucose_Study6_Vehicle = DC_sim_AverageResponse_Vehicle;
maxGlucose_Study6_Vehicle = max(maxGlucose_Study6_Vehicle,NewGlucose_Study6_Vehicle);
minGlucose_Study6_Vehicle = min(minGlucose_Study6_Vehicle,NewGlucose_Study6_Vehicle);
% 5
NewGlucose_Study6_2xSpheroids = DC_sim_AverageResponse_2xSpheroids;
maxGlucose_Study6_2xSpheroids = max(maxGlucose_Study6_2xSpheroids,NewGlucose_Study6_2xSpheroids);
minGlucose_Study6_2xSpheroids = min(minGlucose_Study6_2xSpheroids,NewGlucose_Study6_2xSpheroids);
% 10
NewGlucose_Study6_HalfVolume = DC_sim_AverageResponse_HalfVolume;
maxGlucose_Study6_HalfVolume = max(maxGlucose_Study6_HalfVolume,NewGlucose_Study6_HalfVolume);
minGlucose_Study6_HalfVolume = min(minGlucose_Study6_HalfVolume,NewGlucose_Study6_HalfVolume);
% 10
NewGlucose_Study6_2xSpheroidsHalfVolume = DC_sim_AverageResponse_2xSpheroidsHalfVolume;
maxGlucose_Study6_2xSpheroidsHalfVolume = max(maxGlucose_Study6_2xSpheroidsHalfVolume,NewGlucose_Study6_2xSpheroidsHalfVolume);
minGlucose_Study6_2xSpheroidsHalfVolume = min(minGlucose_Study6_2xSpheroidsHalfVolume,NewGlucose_Study6_2xSpheroidsHalfVolume);


%% Model functions

% IR
IR_5nM  = 1 + mean([
    SimStudy6_Vehicle5.variablevalues(:,ismember(SimStudy6_Vehicle5.variables,'InsulinResponse'))';
    SimStudy6_Spheroids5.variablevalues(:,ismember(SimStudy6_Spheroids5.variables,'InsulinResponse'))';
    SimStudy6_Volume5.variablevalues(:,ismember(SimStudy6_Volume5.variables,'InsulinResponse'))';
    SimStudy6_VolumeSpheroids5.variablevalues(:,ismember(SimStudy6_VolumeSpheroids5.variables,'InsulinResponse'))']);
I_5nM  = mean([
    SimStudy6_Vehicle5.statevalues(:,ismember(SimStudy6_Vehicle5.states,'Insulin_Medium'))';
    SimStudy6_Spheroids5.statevalues(:,ismember(SimStudy6_Spheroids5.states,'Insulin_Medium'))';
    SimStudy6_Volume5.statevalues(:,ismember(SimStudy6_Volume5.states,'Insulin_Medium'))';
    SimStudy6_VolumeSpheroids5.statevalues(:,ismember(SimStudy6_VolumeSpheroids5.states,'Insulin_Medium'))']);

IR_10nM  = 1 + mean([
    SimStudy6_Vehicle10.variablevalues(:,ismember(SimStudy6_Vehicle10.variables,'InsulinResponse'))';
    SimStudy6_Spheroids10.variablevalues(:,ismember(SimStudy6_Spheroids10.variables,'InsulinResponse'))';
    SimStudy6_Volume10.variablevalues(:,ismember(SimStudy6_Volume10.variables,'InsulinResponse'))';
    SimStudy6_VolumeSpheroids10.variablevalues(:,ismember(SimStudy6_VolumeSpheroids10.variables,'InsulinResponse'))']);
I_10nM  = mean([
    SimStudy6_Vehicle10.statevalues(:,ismember(SimStudy6_Vehicle10.states,'Insulin_Medium'))';
    SimStudy6_Spheroids10.statevalues(:,ismember(SimStudy6_Spheroids10.states,'Insulin_Medium'))';
    SimStudy6_Volume10.statevalues(:,ismember(SimStudy6_Volume10.states,'Insulin_Medium'))';
    SimStudy6_VolumeSpheroids10.statevalues(:,ismember(SimStudy6_VolumeSpheroids10.states,'Insulin_Medium'))']);

IR_100nM  = 1 + mean([
    SimStudy6_Vehicle100.variablevalues(:,ismember(SimStudy6_Vehicle100.variables,'InsulinResponse'))';
    SimStudy6_Spheroids100.variablevalues(:,ismember(SimStudy6_Spheroids100.variables,'InsulinResponse'))';
    SimStudy6_Volume100.variablevalues(:,ismember(SimStudy6_Volume100.variables,'InsulinResponse'))';
    SimStudy6_VolumeSpheroids100.variablevalues(:,ismember(SimStudy6_VolumeSpheroids100.variables,'InsulinResponse'))']);
I_100nM  = mean([
    SimStudy6_Vehicle100.statevalues(:,ismember(SimStudy6_Vehicle100.states,'Insulin_Medium'))';
    SimStudy6_Spheroids100.statevalues(:,ismember(SimStudy6_Spheroids100.states,'Insulin_Medium'))';
    SimStudy6_Volume100.statevalues(:,ismember(SimStudy6_Volume100.states,'Insulin_Medium'))';
    SimStudy6_VolumeSpheroids100.statevalues(:,ismember(SimStudy6_VolumeSpheroids100.states,'Insulin_Medium'))']);

if j == 1
    
    simBestI_5nM     = I_5nM;
    simBestI_10nM    = I_10nM;
    simBestI_100nM   = I_100nM;
    
    simBestIR_5nM     = IR_5nM;
    simBestIR_10nM    = IR_10nM;
    simBestIR_100nM   = IR_100nM;
    % 5
    maxIR_Study6_5 = IR_5nM;
    minIR_Study6_5 = maxIR_Study6_5;
    % 10
    maxIR_Study6_10 = IR_10nM;
    minIR_Study6_10 = maxIR_Study6_10;
    % 100
    maxIR_Study6_100 = IR_100nM;
    minIR_Study6_100 = maxIR_Study6_100;
    
end
% 5
NewIR_Study6_5 = IR_5nM;
maxIR_Study6_5 = max(maxIR_Study6_5,NewIR_Study6_5);
minIR_Study6_5 = min(minIR_Study6_5,NewIR_Study6_5);
% 10
NewIR_Study6_10 = IR_10nM;
maxIR_Study6_10 = max(maxIR_Study6_10,NewIR_Study6_10);
minIR_Study6_10 = min(minIR_Study6_10,NewIR_Study6_10);
% 10
NewIR_Study6_100 = IR_100nM;
maxIR_Study6_100 = max(maxIR_Study6_100,NewIR_Study6_100);
minIR_Study6_100 = min(minIR_Study6_100,NewIR_Study6_100);

% Lactate Production
LP_0nM  = 1 + mean([
    SimStudy6_Vehicle0.variablevalues(:,ismember(SimStudy6_Vehicle0.variables,'LactateProduction'))';
    SimStudy6_Spheroids0.variablevalues(:,ismember(SimStudy6_Spheroids0.variables,'LactateProduction'))';
    SimStudy6_Volume0.variablevalues(:,ismember(SimStudy6_Volume0.variables,'LactateProduction'))';
    SimStudy6_VolumeSpheroids0.variablevalues(:,ismember(SimStudy6_VolumeSpheroids0.variables,'LactateProduction'))']);

LP_5nM  = 1 + mean([
    SimStudy6_Vehicle5.variablevalues(:,ismember(SimStudy6_Vehicle5.variables,'LactateProduction'))';
    SimStudy6_Spheroids5.variablevalues(:,ismember(SimStudy6_Spheroids5.variables,'LactateProduction'))';
    SimStudy6_Volume5.variablevalues(:,ismember(SimStudy6_Volume5.variables,'LactateProduction'))';
    SimStudy6_VolumeSpheroids5.variablevalues(:,ismember(SimStudy6_VolumeSpheroids5.variables,'LactateProduction'))']);

LP_10nM  = 1 + mean([
    SimStudy6_Vehicle10.variablevalues(:,ismember(SimStudy6_Vehicle10.variables,'LactateProduction'))';
    SimStudy6_Spheroids10.variablevalues(:,ismember(SimStudy6_Spheroids10.variables,'LactateProduction'))';
    SimStudy6_Volume10.variablevalues(:,ismember(SimStudy6_Volume10.variables,'LactateProduction'))';
    SimStudy6_VolumeSpheroids10.variablevalues(:,ismember(SimStudy6_VolumeSpheroids10.variables,'LactateProduction'))']);

LP_100nM  = 1 + mean([
    SimStudy6_Vehicle100.variablevalues(:,ismember(SimStudy6_Vehicle100.variables,'LactateProduction'))';
    SimStudy6_Spheroids100.variablevalues(:,ismember(SimStudy6_Spheroids100.variables,'LactateProduction'))';
    SimStudy6_Volume100.variablevalues(:,ismember(SimStudy6_Volume100.variables,'LactateProduction'))';
    SimStudy6_VolumeSpheroids100.variablevalues(:,ismember(SimStudy6_VolumeSpheroids100.variables,'LactateProduction'))']);

if j == 1
    
    simBestLP_0nM     = LP_0nM;
    simBestLP_5nM     = LP_5nM;
    simBestLP_10nM    = LP_10nM;
    simBestLP_100nM   = LP_100nM;
    
    % 0
    maxLP_Study6_0 = LP_0nM;
    minLP_Study6_0 = maxLP_Study6_0;
    % 5
    maxLP_Study6_5 = LP_5nM;
    minLP_Study6_5 = maxLP_Study6_5;
    % 10
    maxLP_Study6_10 = LP_10nM;
    minLP_Study6_10 = maxLP_Study6_10;
    % 100
    maxLP_Study6_100 = LP_100nM;
    minLP_Study6_100 = maxLP_Study6_100;
    
end

% 0
NewLP_Study6_0 = LP_0nM;
maxLP_Study6_0 = max(maxLP_Study6_0,NewLP_Study6_0);
minLP_Study6_0 = min(minLP_Study6_0,NewLP_Study6_0);
% 5
NewLP_Study6_5 = LP_5nM;
maxLP_Study6_5 = max(maxLP_Study6_5,NewLP_Study6_5);
minLP_Study6_5 = min(minLP_Study6_5,NewLP_Study6_5);
% 10
NewLP_Study6_10 = LP_10nM;
maxLP_Study6_10 = max(maxLP_Study6_10,NewLP_Study6_10);
minLP_Study6_10 = min(minLP_Study6_10,NewLP_Study6_10);
% 10
NewLP_Study6_100 = LP_100nM;
maxLP_Study6_100 = max(maxLP_Study6_100,NewLP_Study6_100);
minLP_Study6_100 = min(minLP_Study6_100,NewLP_Study6_100);

%%
        IS0 = params(ismember(pNames,"IS0")) * PersonSpecificParametersInSphero.IS0(1) * PersonSpecificParametersInSphero.IS0(3); % IS0 * HC * FCS
        
    if j == 1
        %IR
        hill = InsulinPlotVector.^params(ismember(pNames,"InsulinResponse_hill"));
        maxIR  = 1 + (params(ismember(pNames,"InsulinResponseMax")) * hill./(hill + (IS0+params(ismember(pNames,"InsulinResponse50")).^params(ismember(pNames,"InsulinResponse_hill")))));
        minIR  = maxIR;
        BestIR = maxIR;
    end
    %IR
    hill = InsulinPlotVector.^params(ismember(pNames,"InsulinResponse_hill"));
    NewIR = 1 + (params(ismember(pNames,"InsulinResponseMax")) * hill./(hill + (IS0+params(ismember(pNames,"InsulinResponse50")).^params(ismember(pNames,"InsulinResponse_hill")))));
    maxIR = max(maxIR,NewIR);
    minIR = min(minIR,NewIR);
    
    
    if j == 1
        %AllometricScalingK
        maxLiverFunctionality  = params(ismember(pNames,"Fspheroids0"))*(CountLiver/1000000).^params(ismember(pNames,"AllometricLiverScalingK"));
        minLiverFunctionality  = maxLiverFunctionality;
        BestLiverFunctionality = maxLiverFunctionality;
    end
    
    %IR
    NewLiverFunctionality  = params(ismember(pNames,"Fspheroids0"))*(CountLiver/1000000).^params(ismember(pNames,"AllometricLiverScalingK"));
    maxLiverFunctionality  = max(maxLiverFunctionality,NewLiverFunctionality);
    minLiverFunctionality  = min(minLiverFunctionality,NewLiverFunctionality);
    