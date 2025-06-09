function [simBH5ref_GSIS] = SimulateBH5ref(model,BH5ref_data,params,PersonSpecificParameters,initialvalues,sNames,pNames,ExtraPlotResolution)

%% Experiment declaration
PersonSpecificParameters.EndoCStoredInsulin = 0;

 % Batch Variability
params(ismember(pNames,"ExenatideInsulinMax"))                = params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(19);
params(ismember(pNames,"ExenatideInsulinDecayMax"))           = params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(19);
params(ismember(pNames,"ExenatideInsulin50"))                 = params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(19);
params(ismember(pNames,"ExenatideInsulinDecay50"))            = params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(19);
params(ismember(pNames,"EdU_boolean"))                        = 0;

% ULT
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,7);

initialvalues(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
initialvaluesReset = initialvalues;
%% simInsulinPhases_Static0

% system
params(ismember(pNames,"CountLiver"))            = 1e-5;      % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 375000;    % 375000
params(ismember(pNames,"V_m_medium"))            = 0.001;    % media volume (L)

Glucose   = [0,2.8,5.5,8,11.1,16.8];
if ExtraPlotResolution == 1
Glucose   = 0:0.1:25;
end

for i =1:length(Glucose)
    [initialvaluesGR] = SetInitialValues(Glucose(i), 0, 0,0,params,pNames,sNames,initialvalues);
    initialvaluesGR(ismember(sNames,"Glucose_islets")) = Glucose(i);
    initialvaluesGR(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
    simResponseCurve = model(0:2/3:2/3,initialvaluesGR,params);
    simBH5ref_GSIS.GR(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

initialvalues = initialvaluesReset;
params(ismember(pNames,"CountLiver"))            = 1e-5;      % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 100000;    % 100000 
params(ismember(pNames,"V_m_medium"))            = 0.0001;    % media volume (100 uL)

Exenatide   = [0,1e-06,3.3e-05,0.0001,0.00033,0.001,0.0033,0.01,0.033,0.1,0.33,1,3.3,10,33] ;
for i =1:length(Exenatide)
    [initialvaluesER] = SetInitialValues(11.1, 0, Exenatide(i),0,params,pNames,sNames,initialvalues);
    initialvaluesER(ismember(sNames,"Glucose_islets")) = 11.1;
    initialvaluesGR(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
    simResponseCurve = model(0:2/3:2/3,initialvaluesER,params);
    simBH5ref_GSIS.ER(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

%% Change over time
params(ismember(pNames,"CountLiver"))            = 1e-5;      % no liver
initialvaluesReset(ismember(sNames,"PancreticCells")) = 100000;    % 100000
initialvaluesReset(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
params(ismember(pNames,"V_m_medium"))            = 0.0001;    % media volume (100 uL)


% ULT d0
[initialvaluesG0]    = SetInitialValues(0, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simULTD0_G0          = model(0:2/3:2/3,initialvaluesG0,params);
[initialvaluesG20]   = SetInitialValues(20, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20;
simULTD0_G20         = model(0:2/3:2/3,initialvaluesG20,params);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20;
simULTD0_G20E1       = model(0:2/3:2/3,initialvaluesG20E1,params);
simBH5ref_GSIS.ULTD0(1) = simULTD0_G0.statevalues(end,ismember(simULTD0_G0.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD0(2) = simULTD0_G20.statevalues(end,ismember(simULTD0_G20.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD0(3) = simULTD0_G20E1.statevalues(end,ismember(simULTD0_G20E1.states,'Insulin_Medium'));

% ULT d7
[initialvaluesULT]    = SetInitialValues(5.5, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
simULT_D0D7          = model(0:168:168,initialvaluesULT,params);
initialvaluesd7 = simULT_D0D7.statevalues(end,:);
initialvaluesd7(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
[initialvaluesG0]    = SetInitialValues(0, 0, 0, 0,params,pNames,sNames,initialvaluesd7);
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simULTD7_G0          = model(0:2/3:2/3,initialvaluesG0,params);
[initialvaluesG20]   = SetInitialValues(20, 0, 0, 0,params,pNames,sNames,initialvaluesd7);
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20;
simULTD7_G20         = model(0:2/3:2/3,initialvaluesG20,params);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,params,pNames,sNames,initialvaluesd7);
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20;
simULTD7_G20E1       = model(0:2/3:2/3,initialvaluesG20E1,params);
simBH5ref_GSIS.ULTD7(1) = simULTD7_G0.statevalues(end,ismember(simULTD7_G0.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD7(2) = simULTD7_G20.statevalues(end,ismember(simULTD7_G20.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD7(3) = simULTD7_G20E1.statevalues(end,ismember(simULTD7_G20E1.states,'Insulin_Medium'));

% ULT d14
[initialvaluesULT]    = SetInitialValues(5.5, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
simULT_D0D14          = model(0:336:336,initialvaluesULT,params);
initialvaluesd14 = simULT_D0D14.statevalues(end,:);
initialvaluesd14(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
[initialvaluesG0]    = SetInitialValues(0, 0, 0, 0,params,pNames,sNames,initialvaluesd14);
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simULTD14_G0          = model(0:2/3:2/3,initialvaluesG0,params);
[initialvaluesG20]   = SetInitialValues(20, 0, 0, 0,params,pNames,sNames,initialvaluesd14);
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20;
simULTD14_G20         = model(0:2/3:2/3,initialvaluesG20,params);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,params,pNames,sNames,initialvaluesd14);
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20;
simULTD14_G20E1       = model(0:2/3:2/3,initialvaluesG20E1,params);
simBH5ref_GSIS.ULTD14(1) = simULTD14_G0.statevalues(end,ismember(simULTD14_G0.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD14(2) = simULTD14_G20.statevalues(end,ismember(simULTD14_G20.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD14(3) = simULTD14_G20E1.statevalues(end,ismember(simULTD14_G20E1.states,'Insulin_Medium'));

% ULT d21
[initialvaluesULT]    = SetInitialValues(5.5, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
simULT_D0D21          = model(0:504:504,initialvaluesULT,params);
initialvaluesd21 = simULT_D0D21.statevalues(end,:);
initialvaluesd21(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
[initialvaluesG0]    = SetInitialValues(0, 0, 0, 0,params,pNames,sNames,initialvaluesd21);
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simULTD21_G0          = model(0:2/3:2/3,initialvaluesG0,params);
[initialvaluesG20]   = SetInitialValues(20, 0, 0, 0,params,pNames,sNames,initialvaluesd21);
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20;
simULTD21_G20         = model(0:2/3:2/3,initialvaluesG20,params);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,params,pNames,sNames,initialvaluesd21);
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20;
simULTD21_G20E1       = model(0:2/3:2/3,initialvaluesG20E1,params);
simBH5ref_GSIS.ULTD21(1) = simULTD21_G0.statevalues(end,ismember(simULTD21_G0.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD21(2) = simULTD21_G20.statevalues(end,ismember(simULTD21_G20.states,'Insulin_Medium'));
simBH5ref_GSIS.ULTD21(3) = simULTD21_G20E1.statevalues(end,ismember(simULTD21_G20E1.states,'Insulin_Medium'));

simBH5ref_GSIS.Uncertainty = PersonSpecificParameters.EndoCBasal_Uncertainty;

end

