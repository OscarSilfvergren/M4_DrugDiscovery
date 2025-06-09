function [SimStudy4_vehicle, SimStudy4_0p1, SimStudy4_10, SimStudy4_1000,simStudy5_GSIS] = SimulateStudy4o5(model,Study4_data,params,PersonSpecificParameters,initialvalues,sNames,pNames)

%% Experiment declaration
ExperimentalInducedStress = PersonSpecificParameters.ExperimentalInducedStress(1); % Experimental induced stess

params(ismember(pNames,"Fspheroids50")) = params(ismember(pNames,"Fspheroids50")) * PersonSpecificParameters.HepaRG_f50(3);
params(ismember(pNames,"Fspheroids0"))  = params(ismember(pNames,"Fspheroids0"))  * PersonSpecificParameters.HepaRG_f0(3);
params(ismember(pNames,"ISk"))          = params(ismember(pNames,"ISk"))          * PersonSpecificParameters.HepaRG_IS(3);

%Donor 1
params(ismember(pNames,"ExenatideInsulinMax"))                = params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(8);
params(ismember(pNames,"ExenatideInsulinDecayMax"))           = params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(8);
params(ismember(pNames,"ExenatideInsulin50"))                 = params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(8);
params(ismember(pNames,"ExenatideInsulinDecay50"))            = params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(8);
params(ismember(pNames,"Filets0"))                            = params(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(8);

params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells
initialvalues(ismember(sNames,"PancreticCells")) = 20000;     % 10 pancretic spheroids x 2000 per islet
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"EdU_boolean"))           = 1;

% FCS
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,3);
% FCS + HC
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,1);

ParamsReset = params;
initialvaluesReset = initialvalues;
%% SimStudy4_vehicle

%Day 1-3 GTT
Exenatide = 0;
[initialvalues] = SetInitialValues(10.0000163672559, 0, 0, 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.2, Study4_data.Insulin_Vehicle(1), 0, 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-7
[initialvalues] = SetInitialValues(10.0000163672559, 150, 0, 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, 0, 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
% Day 7-9 GTT
[initialvalues] = SetInitialValues(10.2, Study4_data.Insulin_Vehicle(5)*1000, Exenatide, 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:172,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(172:0.1:176,Sim6.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(176:0.1:216,Sim7.statevalues(end,:),params);
% Day 9-13
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim10 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(9.6, Study4_data.Insulin_Vehicle(9)*1000, Exenatide, 2,params,pNames,sNames,Sim10.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim11 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(316:0.1:336,Sim11.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(336:0.1:360,Sim12.statevalues(end,:),params);

SimStudy4_vehicle.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end),         ];
SimStudy4_vehicle.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
SimStudy4_vehicle.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end,:);   Sim13.reactionvalues(1:end,:)];
SimStudy4_vehicle.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:) ];
SimStudy4_vehicle.variables      = [Sim1.variables];
SimStudy4_vehicle.reactions      = [Sim1.reactions];
SimStudy4_vehicle.states         = [Sim1.states];

%% SimStudy4_0p1
params        = ParamsReset;              % Reset parameters between studies

%Day 1-3 GTT
Exenatide = 0.1;
[initialvalues] = SetInitialValues(10.0000163672559, 0, 0, 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.4, Study4_data.Insulin_0p1nM(1)*1000, 0, 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-7
[initialvalues] = SetInitialValues(9.63330242327774, 150, 0, 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, 0, 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
% Day 7-9 GTT
[initialvalues] = SetInitialValues(10.2, Study4_data.Insulin_0p1nM(5)*1000, Study4_data.Exenatide_0p1(1), 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:172,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(172:0.1:176,Sim6.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(176:0.1:216,Sim7.statevalues(end,:),params);
% Day 9-13
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim10 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(9.8, Study4_data.Insulin_0p1nM(9)*1000, Study4_data.Exenatide_0p1(3), 2,params,pNames,sNames,Sim10.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim11 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(316:0.1:336,Sim11.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(336:0.1:360,Sim12.statevalues(end,:),params);

SimStudy4_0p1.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end),         ];
SimStudy4_0p1.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
SimStudy4_0p1.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end,:);   Sim13.reactionvalues(1:end,:)];
SimStudy4_0p1.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:) ];
SimStudy4_0p1.variables      = [Sim1.variables];
SimStudy4_0p1.reactions      = [Sim1.reactions];
SimStudy4_0p1.states         = [Sim1.states];

%% SimStudy4_10
params        = ParamsReset;              % Reset parameters between studies

%Day 1-3 GTT
Exenatide = 10;
[initialvalues] = SetInitialValues(10.0000163672559, 0, 0, 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.2, Study4_data.Insulin_10nM(1)*1000, 0, 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-7
[initialvalues] = SetInitialValues(10.0000163672559, 150, 0, 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, 0, 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
% Day 7-9 GTT
[initialvalues] = SetInitialValues(10.2, Study4_data.Insulin_10nM(5)*1000, Study4_data.Exenatide_10nM(1), 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:172,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(172:0.1:176,Sim6.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(176:0.1:216,Sim7.statevalues(end,:),params);
% Day 9-13
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim10 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(9.6, Study4_data.Insulin_10nM(9)*1000, Study4_data.Exenatide_10nM(3), 2,params,pNames,sNames,Sim10.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim11 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(316:0.1:336,Sim11.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(336:0.1:360,Sim12.statevalues(end,:),params);

SimStudy4_10.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end),         ];
SimStudy4_10.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
SimStudy4_10.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end,:);   Sim13.reactionvalues(1:end,:)];
SimStudy4_10.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:) ];
SimStudy4_10.variables      = [Sim1.variables];
SimStudy4_10.reactions      = [Sim1.reactions];
SimStudy4_10.states         = [Sim1.states];

%% SimStudy4_1000
params        = ParamsReset;              % Reset parameters between studies

%Day 1-3 GTT
Exenatide = 1000;
[initialvalues] = SetInitialValues(10.0000163672559, 0, 0, 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.1, Study4_data.Insulin_1uM(1)*1000, 0, 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-7
[initialvalues] = SetInitialValues(10.0000163672559, 150, 0, 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, 0, 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
% Day 7-9 GTT
[initialvalues] = SetInitialValues(10, Study4_data.Insulin_1uM(5)*1000, Study4_data.Exenatide_1uM(1), 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:172,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(172:0.1:176,Sim6.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(176:0.1:216,Sim7.statevalues(end,:),params);
% Day 9-13
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(10.0000163672559, 150, Exenatide, 2,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim10 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(9.6, Study4_data.Insulin_1uM(9)*1000, Study4_data.Exenatide_1uM(3), 2,params,pNames,sNames,Sim10.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim11 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(316:0.1:336,Sim11.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(336:0.1:360,Sim12.statevalues(end,:),params);

SimStudy4_1000.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end),         ];
SimStudy4_1000.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
SimStudy4_1000.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end,:);   Sim13.reactionvalues(1:end,:)];
SimStudy4_1000.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:) ];
SimStudy4_1000.variables      = [Sim1.variables];
SimStudy4_1000.reactions      = [Sim1.reactions];
SimStudy4_1000.states         = [Sim1.states];

%% GSIS response curve
params        = ParamsReset;              % Reset parameters between studies
initialvalues = initialvaluesReset;

params(ismember(pNames,"CountLiver"))          = 1e-5;        % no liver
params(ismember(pNames,"V_m_medium"))          = 0.00005;  % media volume (L)
initialvalues(ismember(sNames,"PancreticCells")) = 2000;     % 1 pancretic spheroid x 2000 per islet
initialvalues(ismember(sNames,"Insulin_islets")) = 0;
initialvaluesReset = initialvalues;

Glucose   = [2.8,16.8];
Exenatide = [0,0.1,1,10,1000,10000];

% d0
for k = 1:length(Exenatide)
 for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, Exenatide(k),0,params,pNames,sNames,initialvaluesReset);
initialvalues(ismember(sNames,"Glucose_islets")) = Glucose(i);
    simResponseCurve = model(0:2:2,initialvalues,params);
    simStudy5_GSIS.SaveInsulinSecretionD0(k,i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'))/1000;
 end
end

initialvalues = SimStudy4_vehicle.statevalues(end,:);
% d15 vehicle
 for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, 0,0,params,pNames,sNames,initialvalues);
    initialvalues(ismember(sNames,"Glucose_islets")) = Glucose(i);
    initialvalues(ismember(sNames,"TimeState")) = initialvalues(ismember(sNames,"TimeState")) + ExperimentalInducedStress;
    simResponseCurve = model(0:2:2,initialvalues,params);
    simStudy5_GSIS.SaveInsulinSecretionD15vehicle(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'))/1000;
 end
 
 initialvalues = SimStudy4_0p1.statevalues(end,:);
 % d15 0.1nM
 for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, 0.1,0,params,pNames,sNames,initialvalues);
    initialvalues(ismember(sNames,"Glucose_islets")) = Glucose(i);  
    initialvalues(ismember(sNames,"TimeState")) = initialvalues(ismember(sNames,"TimeState")) + ExperimentalInducedStress;
    simResponseCurve = model(0:2:2,initialvalues,params);
    simStudy5_GSIS.SaveInsulinSecretionD15_0p1(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'))/1000;
 end
 
 initialvalues = SimStudy4_10.statevalues(end,:);
 % d15 10nM
 for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, 10,0,params,pNames,sNames,initialvalues);
    initialvalues(ismember(sNames,"Glucose_islets")) = Glucose(i);  
    initialvalues(ismember(sNames,"TimeState")) = initialvalues(ismember(sNames,"TimeState")) + ExperimentalInducedStress;
    simResponseCurve = model(0:2:2,initialvalues,params);
    simStudy5_GSIS.SaveInsulinSecretionD15_10(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'))/1000;
 end
 
 initialvalues = SimStudy4_1000.statevalues(end,:);
 % d15 1000nM
 for i =1:length(Glucose)
    [initialvalues] = SetInitialValues(Glucose(i), 0, 1000,0,params,pNames,sNames,initialvalues);
    initialvalues(ismember(sNames,"Glucose_islets")) = Glucose(i);   
    initialvalues(ismember(sNames,"TimeState")) = initialvalues(ismember(sNames,"TimeState")) + ExperimentalInducedStress;
    simResponseCurve = model(0:2:2,initialvalues,params);
    simStudy5_GSIS.SaveInsulinSecretionD15_1000(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'))/1000;
 end

end


