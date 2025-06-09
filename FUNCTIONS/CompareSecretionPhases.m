function [simExp8p3_H10,SimExp6p2_10] = CompareSecretionPhases(model,params,initialvalues,sNames,pNames)

[PersonSpecificParameters] = AssignInitialUniqueParameters();
[PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,[],params);
  
initialvaluesReset  = initialvalues;
%% Experiment declaration

 % EndoC
EndoC_params(ismember(pNames,"ExenatideInsulinMax"))                = EndoC_params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParametersEndoC.ExenatideResponse(16);
EndoC_params(ismember(pNames,"ExenatideInsulinDecayMax"))           = EndoC_params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParametersEndoC.ExenatideResponse(16);
EndoC_params(ismember(pNames,"ExenatideInsulin50"))                 = EndoC_params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParametersEndoC.ExenatideResponse50(16);
EndoC_params(ismember(pNames,"ExenatideInsulinDecay50"))            = EndoC_params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParametersEndoC.ExenatideResponse50(16);
EndoC_params(ismember(pNames,"Filets0"))                            = EndoC_params(ismember(pNames,"Filets0"))                        * PersonSpecificParametersEndoC.Filets0(19);

EndoC_params(ismember(pNames,"CountLiver"))      = 1e-5;  % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 20000;   % 10 pancretic spheroids x 2000 per islet
EndoC_params(ismember(pNames,"V_m_medium"))      = 0.000605;    % media volume (L)
EndoC_params(ismember(pNames,"EdU_boolean"))                        = 0;

% FCS + HC
[EndoC_paramsHealthy] = MediaConditionScaling(EndoC_params       ,pNames,PersonSpecificParametersEndoC,3);
[EndoC_paramsHealthy] = MediaConditionScaling(EndoC_paramsHealthy,pNames,PersonSpecificParametersEndoC,1);

EndoC_params = EndoC_paramsHealthy;
[initialvalues] = SetInitialValues(2.8, 0, 10,0,EndoC_params,pNames,sNames,initialvalues);
EndoC_params(ismember(pNames,"V_m_medium"))     = 0.0003;
Sim0 = model(0:0.1:24,initialvalues,EndoC_params);           %1h
[initialvalues] = SetInitialValues(16, 0, 10,0,EndoC_params,pNames,sNames,Sim0.statevalues(end,:));
simExp8p3_H10 = model(0:0.01:24,initialvalues,EndoC_params);           %1h

%% Insphero

initialvalues = initialvaluesReset;

%Donor 3
InSphero_params(ismember(pNames,"ExenatideInsulinMax"))                = InSphero_params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParametersInSphero.ExenatideResponse(8);
InSphero_params(ismember(pNames,"ExenatideInsulinDecayMax"))           = InSphero_params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParametersInSphero.ExenatideResponse(8);
InSphero_params(ismember(pNames,"ExenatideInsulin50"))                 = InSphero_params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParametersInSphero.ExenatideResponse50(8);
InSphero_params(ismember(pNames,"ExenatideInsulinDecay50"))            = InSphero_params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParametersInSphero.ExenatideResponse50(8);
InSphero_params(ismember(pNames,"Filets0"))                            = InSphero_params(ismember(pNames,"Filets0"))                        * PersonSpecificParametersInSphero.Filets0(8);

InSphero_params(ismember(pNames,"CountLiver"))   = 1e-5;   % 25000 * 40 liver cells
initialvalues(ismember(sNames,"PancreticCells")) = 20000;     % 10 pancretic spheroids x 2000 per islet
InSphero_params(ismember(pNames,"V_m_medium"))   = 0.000605;    % media volume (L)
InSphero_params(ismember(pNames,"EdU_boolean"))   = 0;

% FCS + HC
[InSphero_params] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,3);
[InSphero_params] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,1);

%Day 1-3 GTT
[initialvalues] = SetInitialValues(2.8, 0, 10, 0,InSphero_params,pNames,sNames,initialvalues);
InSphero_params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,InSphero_params);
[initialvalues] = SetInitialValues(16, 0, 10, 0,InSphero_params,pNames,sNames,Sim0.statevalues(end,:));
SimExp6p2_10 = model(0:0.01:24,initialvalues,InSphero_params);

end