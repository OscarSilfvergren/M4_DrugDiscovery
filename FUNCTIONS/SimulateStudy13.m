function [simStudy13_GSIS] = SimulateStudy13(model,Study13_data,params,PersonSpecificParameters,initialvalues,sNames,pNames)

%% Experiment declaration
% SM
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,6);

% system settings
params(ismember(pNames,"CountLiver"))            = 1e-5;        % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 2000;     % 1 pancretic spheroid x 2000 per islet
params(ismember(pNames,"V_m_medium"))            = 0.00005;  % media volume (L)
params(ismember(pNames,"EdU_boolean"))           = 0;

%Donor 4
paramsDonor1 = params;
paramsDonor1(ismember(pNames,"ExenatideInsulinMax"))                = paramsDonor1(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(11);
paramsDonor1(ismember(pNames,"ExenatideInsulinDecayMax"))           = paramsDonor1(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(11);
paramsDonor1(ismember(pNames,"ExenatideInsulin50"))                 = paramsDonor1(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(11);
paramsDonor1(ismember(pNames,"ExenatideInsulinDecay50"))            = paramsDonor1(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(11);
paramsDonor1(ismember(pNames,"Filets0"))                            = paramsDonor1(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(11);
%Donor 5
paramsDonor2 = params;
paramsDonor2(ismember(pNames,"ExenatideInsulinMax"))                = paramsDonor2(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(12);
paramsDonor2(ismember(pNames,"ExenatideInsulinDecayMax"))           = paramsDonor2(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(12);
paramsDonor2(ismember(pNames,"ExenatideInsulin50"))                 = paramsDonor2(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(12);
paramsDonor2(ismember(pNames,"ExenatideInsulinDecay50"))            = paramsDonor2(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(12);
paramsDonor2(ismember(pNames,"Filets0"))                            = paramsDonor2(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(12);
%Donor 6
paramsDonor3 = params;
paramsDonor3(ismember(pNames,"ExenatideInsulinMax"))                = paramsDonor3(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(13);
paramsDonor3(ismember(pNames,"ExenatideInsulinDecayMax"))           = paramsDonor3(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(13);
paramsDonor3(ismember(pNames,"ExenatideInsulin50"))                 = paramsDonor3(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(13);
paramsDonor3(ismember(pNames,"ExenatideInsulinDecay50"))            = paramsDonor3(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(13);
paramsDonor3(ismember(pNames,"Filets0"))                            = paramsDonor3(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(13);
%Donor 7
paramsDonor4 = params;
paramsDonor4(ismember(pNames,"ExenatideInsulinMax"))                = paramsDonor4(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(14);
paramsDonor4(ismember(pNames,"ExenatideInsulinDecayMax"))           = paramsDonor4(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(14);
paramsDonor4(ismember(pNames,"ExenatideInsulin50"))                 = paramsDonor4(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(14);
paramsDonor4(ismember(pNames,"ExenatideInsulinDecay50"))            = paramsDonor4(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(14);
paramsDonor4(ismember(pNames,"Filets0"))                            = paramsDonor4(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(14);

%% GSIS response curve

Exenatide = [0,0.01,0.1,1,10,100,1000];

% Donor 1
for k = 1:length(Exenatide)
[initialvaluesER] = SetInitialValues(11, 0, Exenatide(k),0,paramsDonor1,pNames,sNames,initialvalues);
initialvaluesER(ismember(sNames,"Glucose_islets")) = 11;
simResponseCurve = model(0:2:2,initialvaluesER,paramsDonor1);
simStudy13_GSIS.Donor1(k) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

% Donor 2
for k = 1:length(Exenatide)
[initialvaluesER] = SetInitialValues(11, 0, Exenatide(k),0,paramsDonor2,pNames,sNames,initialvalues);
initialvaluesER(ismember(sNames,"Glucose_islets")) = 11;
simResponseCurve = model(0:2:2,initialvaluesER,paramsDonor2);
simStudy13_GSIS.Donor2(k) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

% Donor 3
for k = 1:length(Exenatide)
[initialvaluesER] = SetInitialValues(11, 0, Exenatide(k),0,paramsDonor3,pNames,sNames,initialvalues);
initialvaluesER(ismember(sNames,"Glucose_islets")) = 11;
simResponseCurve = model(0:2:2,initialvaluesER,paramsDonor3);
simStudy13_GSIS.Donor3(k) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

% Donor 4
for k = 1:length(Exenatide)
[initialvaluesER] = SetInitialValues(11, 0, Exenatide(k),0,paramsDonor4,pNames,sNames,initialvalues);
initialvaluesER(ismember(sNames,"Glucose_islets")) = 11;
simResponseCurve = model(0:2:2,initialvaluesER,paramsDonor4);
simStudy13_GSIS.Donor4(k) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
end

end

