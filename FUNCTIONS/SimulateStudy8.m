function  [simStudy8_GSIS] = SimulateStudy8(model,params,Study8_data,PersonSpecificParameters,initialvalues,sNames,pNames,ExtraPlotResolution);

%% Experiment declaration
params(ismember(pNames,"Fspheroids50")) = params(ismember(pNames,"Fspheroids50")) * PersonSpecificParameters.HepaRG_f50(3);
params(ismember(pNames,"Fspheroids0"))  = params(ismember(pNames,"Fspheroids0"))  * PersonSpecificParameters.HepaRG_f0(3);
params(ismember(pNames,"ISk"))          = params(ismember(pNames,"ISk"))          * PersonSpecificParameters.HepaRG_IS(3);

WashingUncertainty        = PersonSpecificParameters.EndoCWashing_Uncertainty;
ExperimentalInducedStress = PersonSpecificParameters.ExperimentalInducedStress(3);

% Batch Variability
params(ismember(pNames,"ExenatideInsulinMax"))                = params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(17);
params(ismember(pNames,"ExenatideInsulinDecayMax"))           = params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(17);
params(ismember(pNames,"ExenatideInsulin50"))                 = params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(17);
params(ismember(pNames,"ExenatideInsulinDecay50"))            = params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(17);
params(ismember(pNames,"Filets0"))                            = params(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(20);
params(ismember(pNames,"EdU_boolean"))                        = 0;

% ULT
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,7);

% system settings
params(ismember(pNames,"CountLiver"))            = 1000000;  % 25000 * 20 liver cells
initialvalues(ismember(sNames,"PancreticCells")) = 20000;    % 1 pancretic spheroid x 2000 per islet
initialvalues(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)

ParamsReset = params;
initialvaluesReset = initialvalues;

    %% GSIS simulation
params        = ParamsReset;

% system settings
params(ismember(pNames,"CountLiver"))                 = 1e-5;        % no liver
initialvaluesReset(ismember(sNames,"PancreticCells")) = 2000;     % 1 pancretic spheroid x 2000 per islet
params(ismember(pNames,"V_m_medium"))                 = 0.00005;  % media volume (L)


Glucose = [0,2.8,5.5,8,11.1,16.8,20.1];

if ExtraPlotResolution == 1
Glucose   = 0:0.1:25;
end

% d0
for k = 1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(k), 0, 0,0,params,pNames,sNames,initialvaluesReset);
    initialvalues(ismember(sNames,"Glucose_islets")) = Glucose(k)*WashingUncertainty;
    simResponseCurve = model(0:2/3:2/3,initialvalues,params);
    SaveInsulinSecretionGlucose(k) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

Exenatide = [0,0.01,0.1,1,10,100];
initialvaluesReset(ismember(sNames,"TimeState"))      = ExperimentalInducedStress;
% d8
for k = 1:length(Exenatide)
    [initialvalues] = SetInitialValues(11.1, 0, Exenatide(k),0,params,pNames,sNames,initialvaluesReset);
    initialvalues(ismember(sNames,"Glucose_islets")) = 11.1*WashingUncertainty;
   simResponseCurve = model(0:2/3:2/3,initialvalues,params);
    SaveInsulinSecretionExenatide(k) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

simStudy8_GSIS.SaveInsulinSecretionGlucose = SaveInsulinSecretionGlucose;
simStudy8_GSIS.SaveInsulinSecretionExenatide = SaveInsulinSecretionExenatide;
end

