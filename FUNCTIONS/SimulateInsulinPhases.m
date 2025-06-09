function [simInsulinPhases_flow0,simInsulinPhases_flow100,simInsulinPhases_static0,simInsulinPhases_static100,simInsulinPhases_Article2,simInsulinPhases_GSIS] = SimulateInsulinPhases(model,InSpheroInsulinPhases_data,params,PersonSpecificParameters,initialvalues,sNames,pNames,ExtraPlotResolution)

%% Experiment declaration

% SM
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,6);

% system
params(ismember(pNames,"CountLiver"))            = 1e-5;      % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 20000;     % 10 pancretic spheroids x 2000 per islet
params(ismember(pNames,"V_m_medium"))            = 0.0006;    % media volume (L)
params(ismember(pNames,"EdU_boolean"))                        = 0;

%Donor 2 : Static test
Donor4 = params;
Donor4(ismember(pNames,"ExenatideInsulinMax"))                = Donor4(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(9);
Donor4(ismember(pNames,"ExenatideInsulinDecayMax"))           = Donor4(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(9);
Donor4(ismember(pNames,"ExenatideInsulin50"))                 = Donor4(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(9);
Donor4(ismember(pNames,"ExenatideInsulinDecay50"))            = Donor4(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(9);
Donor4(ismember(pNames,"Filets0"))                            = Donor4(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(9);

%Donor 3: Flow test with exenatide
Donor5 = params;
Donor5(ismember(pNames,"ExenatideInsulinMax"))                = Donor5(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(10);
Donor5(ismember(pNames,"ExenatideInsulinDecayMax"))           = Donor5(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(10);
Donor5(ismember(pNames,"ExenatideInsulin50"))                 = Donor5(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(10);
Donor5(ismember(pNames,"ExenatideInsulinDecay50"))            = Donor5(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(10);
Donor5(ismember(pNames,"IP_basalK"))                          = Donor5(ismember(pNames,"IP_basalK"))                      * PersonSpecificParameters.FlowGSISBasalS;
Donor5(ismember(pNames,"Filets0"))                            = Donor5(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(10);

%Donor 10: Flow test
Donor6 = params;
Donor6(ismember(pNames,"Filets0"))                            = Donor6(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(17);
Donor6(ismember(pNames,"IP_basalK"))                          = Donor6(ismember(pNames,"IP_basalK"))                      * PersonSpecificParameters.FlowGSISBasalS;

initialvaluesReset = initialvalues;
%% simInsulinPhases_flow0

[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor5,pNames,sNames,initialvaluesReset);
initialvalues(ismember(sNames,"Glucose_islets")) = 2.8;
Sim1   = model((0:0.1:60)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(16.8, 0, 0,0,Donor5,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model((60:0.1:120)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor5,pNames,sNames,Sim2.statevalues(end,:));
Sim3 = model((120:0.1:180)/60,initialvalues,Donor5);

simInsulinPhases_flow0.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end),           ];
simInsulinPhases_flow0.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end,:)];
simInsulinPhases_flow0.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end,:)];
simInsulinPhases_flow0.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end,:)   ];
simInsulinPhases_flow0.variables      = [Sim1.variables];
simInsulinPhases_flow0.reactions      = [Sim1.reactions];
simInsulinPhases_flow0.states         = [Sim1.states];

%% Exenatide flow
initialvalues = initialvaluesReset;

[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor5,pNames,sNames,initialvaluesReset);
initialvalues(ismember(sNames,"Glucose_islets")) = 2.8;
Sim1   = model((0:0.1:60)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(16.8, 0, 100,0,Donor5,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model((60:0.1:120)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(2.8, 0, 100,0,Donor5,pNames,sNames,Sim2.statevalues(end,:));
Sim3 = model((120:0.1:180)/60,initialvalues,Donor5);

simInsulinPhases_flow100.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end),           ];
simInsulinPhases_flow100.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end,:)];
simInsulinPhases_flow100.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end,:)];
simInsulinPhases_flow100.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end,:)   ];
simInsulinPhases_flow100.variables      = [Sim1.variables];
simInsulinPhases_flow100.reactions      = [Sim1.reactions];
simInsulinPhases_flow100.states         = [Sim1.states];


%% simInsulinPhases_Static0
initialvalues = initialvaluesReset;

[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor5,pNames,sNames,initialvaluesReset);
initialvalues(ismember(sNames,"Glucose_islets")) = 2.8;
Sim1   = model((0:0.1:60)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(16.8, 0, 0,0,Donor5,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model((60:0.1:120)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor5,pNames,sNames,Sim2.statevalues(end,:));
Sim3 = model((120:0.1:180)/60,initialvalues,Donor5);

simInsulinPhases_static0.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end),           ];
simInsulinPhases_static0.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end,:)];
simInsulinPhases_static0.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end,:)];
simInsulinPhases_static0.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end,:)   ];
simInsulinPhases_static0.variables      = [Sim1.variables];
simInsulinPhases_static0.reactions      = [Sim1.reactions];
simInsulinPhases_static0.states         = [Sim1.states];

%% Exenatide static
initialvalues = initialvaluesReset;

[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor5,pNames,sNames,initialvaluesReset);
initialvalues(ismember(sNames,"Glucose_islets")) = 2.8;
Sim1   = model((0:0.1:60)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(16.8, 0, 100,0,Donor5,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model((60:0.1:120)/60,initialvalues,Donor5);
[initialvalues] = SetInitialValues(2.8, 0, 100,0,Donor5,pNames,sNames,Sim2.statevalues(end,:));
Sim3 = model((120:0.1:180)/60,initialvalues,Donor5);

simInsulinPhases_static100.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end),           ];
simInsulinPhases_static100.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end,:)];
simInsulinPhases_static100.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end,:)];
simInsulinPhases_static100.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end,:)   ];
simInsulinPhases_static100.variables      = [Sim1.variables];
simInsulinPhases_static100.reactions      = [Sim1.reactions];
simInsulinPhases_static100.states         = [Sim1.states];

%% Article 2
initialvalues = initialvaluesReset;

[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor6,pNames,sNames,initialvaluesReset);
initialvalues(ismember(sNames,"Glucose_islets")) = 2.8;
Sim1   = model((0:0.1:60)/60,initialvalues,Donor6);
[initialvalues] = SetInitialValues(16.8, 0, 0,0,Donor6,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model((60:0.1:94)/60,initialvalues,Donor6);
[initialvalues] = SetInitialValues(2.8, 0, 0,0,Donor6,pNames,sNames,Sim2.statevalues(end,:));
Sim3 = model((94:0.1:180)/60,initialvalues,Donor6);

simInsulinPhases_Article2.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end),           ];
simInsulinPhases_Article2.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end,:)];
simInsulinPhases_Article2.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end,:)];
simInsulinPhases_Article2.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end,:)   ];
simInsulinPhases_Article2.variables      = [Sim1.variables];
simInsulinPhases_Article2.reactions      = [Sim1.reactions];
simInsulinPhases_Article2.states         = [Sim1.states];
 
%% Static GSIS
initialvalues = initialvaluesReset;

% system settings
Donor4(ismember(pNames,"CountLiver"))            = 1e-5;        % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 2000;     % 1 pancretic spheroid x 2000 per islet
Donor4(ismember(pNames,"V_m_medium"))            = 0.00005;  % media volume (L)

Glucose   = [2.8,5.5,8,11,16.7];
Exenatide = [0,100];

if ExtraPlotResolution == 1
Glucose   = 2.8:0.1:16.7;
end

 for k = 1:length(Exenatide)
  for i =1:length(Glucose)
    [initialvaluesGR] = SetInitialValues(Glucose(i), 0, Exenatide(k),0,Donor4,pNames,sNames,initialvalues);
    initialvaluesGR(ismember(sNames,"Glucose_islets")) = Glucose(i);
    simResponseCurve = model(0:2:2,initialvaluesGR,Donor4);
    simInsulinPhases_GSIS.Simulation(k,i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));

  end
 end
 simInsulinPhases_GSIS.Data = PersonSpecificParameters.InSpheroInsulinPhases_Uncertainty;
 
end

