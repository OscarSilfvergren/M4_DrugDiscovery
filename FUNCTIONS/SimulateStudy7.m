function  [simStudy7_GSIS] = SimulateStudy7(model,params,Study7_data,PersonSpecificParameters,initialvalues,sNames,pNames)

%% Experiment declaration
WashingUncertainty   = PersonSpecificParameters.EndoCWashing_Uncertainty;
params(ismember(pNames,"EdU_boolean"))  = 0;

% system settings
params(ismember(pNames,"CountLiver"))            = 1e-5;        % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 2000;     % 1 pancretic spheroid x 2000 per islet
initialvalues(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
params(ismember(pNames,"V_m_medium"))            = 0.00005;  % media volume (L)

 % EndoC D7
paramsD7 = params;
paramsD7(ismember(pNames,"ExenatideInsulinMax"))                = paramsD7(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(15);
paramsD7(ismember(pNames,"ExenatideInsulinDecayMax"))           = paramsD7(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(15);
paramsD7(ismember(pNames,"ExenatideInsulin50"))                 = paramsD7(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(15);
paramsD7(ismember(pNames,"ExenatideInsulinDecay50"))            = paramsD7(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(15);
paramsD7(ismember(pNames,"Filets0"))                            = paramsD7(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(18);

% BSA + LC
[CM2_BSAparams] = MediaConditionScaling(paramsD7     ,pNames,PersonSpecificParameters,2);
[CM2_BSAparams] = MediaConditionScaling(CM2_BSAparams,pNames,PersonSpecificParameters,5);

% B27 + LC
[CM3_params] = MediaConditionScaling(paramsD7  ,pNames,PersonSpecificParameters,2);
[CM3_params] = MediaConditionScaling(CM3_params,pNames,PersonSpecificParameters,4);

% ULT
[ULT_paramsD7] = MediaConditionScaling(paramsD7,pNames,PersonSpecificParameters,7);

 % EndoC D10
paramsD10 = params;
paramsD10(ismember(pNames,"ExenatideInsulinMax"))                = paramsD10(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(16);
paramsD10(ismember(pNames,"ExenatideInsulinDecayMax"))           = paramsD10(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(16);
paramsD10(ismember(pNames,"ExenatideInsulin50"))                 = paramsD10(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(16);
paramsD10(ismember(pNames,"ExenatideInsulinDecay50"))            = paramsD10(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(16);
paramsD10(ismember(pNames,"Filets0"))                            = paramsD10(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(19);

% FCS + HC
[CM1_FCSparams] = MediaConditionScaling(paramsD10       ,pNames,PersonSpecificParameters,1);
[CM1_FCSparams] = MediaConditionScaling(CM1_FCSparams,pNames,PersonSpecificParameters,3);

% FCS + LC
[CM2_FCSparams] = MediaConditionScaling(paramsD10       ,pNames,PersonSpecificParameters,2);
[CM2_FCSparams] = MediaConditionScaling(CM2_FCSparams,pNames,PersonSpecificParameters,3);

% ULT
[ULT_paramsD10] = MediaConditionScaling(paramsD10,pNames,PersonSpecificParameters,7);

initialvaluesReset = initialvalues;
%% GSIS simulation

% ULT media d7 
[initialvalues] = SetInitialValues(5.5, 0, 0, 0,ULT_paramsD7,pNames,sNames,initialvaluesReset);
simULT_D0toD7 = model(0:168:168,initialvalues,ULT_paramsD7);
simULT_D0toD7.statevalues(end,ismember(simULT_D0toD7.states,'Insulin_islets')) = simULT_D0toD7.statevalues(end,ismember(simULT_D0toD7.states,'Insulin_islets')) + PersonSpecificParameters.EndoCStoredInsulin;
[initialvaluesG0] = SetInitialValues(0, 0, 0, 0,ULT_paramsD7,pNames,sNames,simULT_D0toD7.statevalues(end,:));
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simULTD7_G0     = model(0:2/3:2/3,initialvaluesG0,ULT_paramsD7);
[initialvaluesG20] = SetInitialValues(20, 0, 0, 0,ULT_paramsD7,pNames,sNames,simULT_D0toD7.statevalues(end,:));
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty; 
simULTD7_G20     = model(0:2/3:2/3,initialvaluesG20,ULT_paramsD7);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,ULT_paramsD7,pNames,sNames,simULT_D0toD7.statevalues(end,:));
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty; 
simULTD7D7_G20E1     = model(0:2/3:2/3,initialvaluesG20E1,ULT_paramsD7);
simStudy7_GSIS.ULTd7(1) = simULTD7_G0.statevalues(end,ismember(simULTD7_G0.states,'Insulin_Medium'));
simStudy7_GSIS.ULTd7(2) = simULTD7_G20.statevalues(end,ismember(simULTD7_G20.states,'Insulin_Medium'));
simStudy7_GSIS.ULTd7(3) = simULTD7D7_G20E1.statevalues(end,ismember(simULTD7D7_G20E1.states,'Insulin_Medium'));

% CM2_BSA d7
[initialvalues] = SetInitialValues(5.5, 0, 0, 0,CM2_BSAparams,pNames,sNames,initialvaluesReset);
simCM2_BSAD0toD7 = model(0:168:168,initialvalues,CM2_BSAparams);
simCM2_BSAD0toD7.statevalues(end,ismember(simCM2_BSAD0toD7.states,'Insulin_islets')) = simCM2_BSAD0toD7.statevalues(end,ismember(simCM2_BSAD0toD7.states,'Insulin_islets')) + PersonSpecificParameters.EndoCStoredInsulin;
[initialvaluesG0] = SetInitialValues(0, 0, 0, 0,CM2_BSAparams,pNames,sNames,simCM2_BSAD0toD7.statevalues(end,:));
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simCM2_BSAD7_G0     = model(0:2/3:2/3,initialvaluesG0,CM2_BSAparams);
[initialvaluesG20] = SetInitialValues(20, 0, 0, 0,CM2_BSAparams,pNames,sNames,simCM2_BSAD0toD7.statevalues(end,:));
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty; 
simCM2_BSAD7_G20     = model(0:2/3:2/3,initialvaluesG20,CM2_BSAparams);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,CM2_BSAparams,pNames,sNames,simCM2_BSAD0toD7.statevalues(end,:));
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty; 
simCM2_BSAD7_G20E1     = model(0:2/3:2/3,initialvaluesG20E1,CM2_BSAparams);
simStudy7_GSIS.CM2_BSAd7(1) = simCM2_BSAD7_G0.statevalues(end,ismember(simCM2_BSAD7_G0.states,'Insulin_Medium'));
simStudy7_GSIS.CM2_BSAd7(2) = simCM2_BSAD7_G20.statevalues(end,ismember(simCM2_BSAD7_G20.states,'Insulin_Medium'));
simStudy7_GSIS.CM2_BSAd7(3) = simCM2_BSAD7_G20E1.statevalues(end,ismember(simCM2_BSAD7_G20E1.states,'Insulin_Medium'));

% CM3 d7
[initialvalues] = SetInitialValues(5.5, 0, 0, 0,CM3_params,pNames,sNames,initialvaluesReset);
simCM3D0toD7 = model(0:168:168,initialvalues,CM3_params);
simCM3D0toD7.statevalues(end,ismember(simCM3D0toD7.states,'Insulin_islets')) = simCM3D0toD7.statevalues(end,ismember(simCM3D0toD7.states,'Insulin_islets')) + PersonSpecificParameters.EndoCStoredInsulin;
[initialvaluesG0] = SetInitialValues(0, 0, 0, 0,CM3_params,pNames,sNames,simCM3D0toD7.statevalues(end,:));
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simCM3D7_G0     = model(0:2/3:2/3,initialvaluesG0,CM3_params);
[initialvaluesG20] = SetInitialValues(20, 0, 0, 0,CM3_params,pNames,sNames,simCM3D0toD7.statevalues(end,:));
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty; 
simCM3D7_G20     = model(0:2/3:2/3,initialvaluesG20,CM3_params);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,CM3_params,pNames,sNames,simCM3D0toD7.statevalues(end,:));
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty; 
simCM3D7_G20E1     = model(0:2/3:2/3,initialvaluesG20E1,CM3_params);
simStudy7_GSIS.CM3d7(1) = simCM3D7_G0.statevalues(end,ismember(simCM3D7_G0.states,'Insulin_Medium'));
simStudy7_GSIS.CM3d7(2) = simCM3D7_G20.statevalues(end,ismember(simCM3D7_G20.states,'Insulin_Medium'));
simStudy7_GSIS.CM3d7(3) = simCM3D7_G20E1.statevalues(end,ismember(simCM3D7_G20E1.states,'Insulin_Medium'));

%% D10
Exenatide = [0,1];
Glucose   = [16.8];

% CM1_FCS d10
[initialvalues] = SetInitialValues(11, 0, 0, 0,CM1_FCSparams,pNames,sNames,initialvaluesReset);
simCM1_FCSD0toD10 = model(0:240:240,initialvalues,CM1_FCSparams);
simCM1_FCSD0toD10.statevalues(end,ismember(simCM1_FCSD0toD10.states,'Insulin_islets')) = simCM1_FCSD0toD10.statevalues(end,ismember(simCM1_FCSD0toD10.states,'Insulin_islets')) + PersonSpecificParameters.EndoCStoredInsulin;
for k = 1:length(Exenatide)
     for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, Exenatide(k),0,CM1_FCSparams,pNames,sNames,simCM1_FCSD0toD10.statevalues(end,:));
initialvalues(ismember(sNames,"Glucose_islets")) = 16.8*WashingUncertainty;   
simResponseCurve = model(0:2/3:2/3,initialvalues,CM1_FCSparams);
    SaveInsulinSecretion_CM1_FCSd10(k,i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
     end
end
simStudy7_GSIS.CM1_FCSd10 = SaveInsulinSecretion_CM1_FCSd10;


% CM2_FCS d10
[initialvalues] = SetInitialValues(5.5, 0, 0, 0,CM2_FCSparams,pNames,sNames,initialvaluesReset);
simCM2_FCSD0toD10 = model(0:240:240,initialvalues,CM2_FCSparams);
simCM2_FCSD0toD10.statevalues(end,ismember(simCM2_FCSD0toD10.states,'Insulin_islets')) = simCM2_FCSD0toD10.statevalues(end,ismember(simCM2_FCSD0toD10.states,'Insulin_islets')) + PersonSpecificParameters.EndoCStoredInsulin;
for k = 1:length(Exenatide)
         for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, Exenatide(k),0,CM2_FCSparams,pNames,sNames,simCM2_FCSD0toD10.statevalues(end,:));
    initialvalues(ismember(sNames,"Glucose_islets")) = 16.8*WashingUncertainty;   
    simResponseCurve = model(0:2/3:2/3,initialvalues,CM2_FCSparams);
    SaveInsulinSecretion_CM2_FCSd10(k,i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
         end
end
simStudy7_GSIS.CM2_FCSd10 = SaveInsulinSecretion_CM2_FCSd10;

% ULT media d10
[initialvalues] = SetInitialValues(5.5, 0, 0, 0,ULT_paramsD10,pNames,sNames,initialvaluesReset);
simULT_D0toD10 = model(0:240:240,initialvalues,ULT_paramsD10);
simULT_D0toD10.statevalues(end,ismember(simULT_D0toD10.states,'Insulin_islets')) = simULT_D0toD10.statevalues(end,ismember(simULT_D0toD10.states,'Insulin_islets')) + PersonSpecificParameters.EndoCStoredInsulin;
for k = 1:length(Exenatide)
 for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, Exenatide(k),0,ULT_paramsD10,pNames,sNames,simULT_D0toD10.statevalues(end,:));
    initialvalues(ismember(sNames,"Glucose_islets")) = Glucose(i)*WashingUncertainty;   
    simResponseCurve = model(0:2/3:2/3,initialvalues,ULT_paramsD10);
    SaveInsulinSecretion_ULTd10(k,i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
 end
end
simStudy7_GSIS.ULTd10 = SaveInsulinSecretion_ULTd10;
end

