function [SimStudy6_Vehicle0,SimStudy6_Vehicle5,SimStudy6_Vehicle10,SimStudy6_Vehicle100,SimStudy6_Spheroids0,SimStudy6_Spheroids5,SimStudy6_Spheroids10,SimStudy6_Spheroids100,SimStudy6_Volume0,SimStudy6_Volume5,SimStudy6_Volume10,SimStudy6_Volume100,SimStudy6_VolumeSpheroids0,SimStudy6_VolumeSpheroids5,SimStudy6_VolumeSpheroids10,SimStudy6_VolumeSpheroids100] = SimulateStudy6(model,Study6_data,params,PersonSpecificParameters,initialvalues,sNames,pNames)

%% Experiment declaration

params(ismember(pNames,"Fspheroids50")) = params(ismember(pNames,"Fspheroids50")) * PersonSpecificParameters.HepaRG_f50(4);
params(ismember(pNames,"Fspheroids0"))  = params(ismember(pNames,"Fspheroids0"))  * PersonSpecificParameters.HepaRG_f0(4);
params(ismember(pNames,"ISk"))          = params(ismember(pNames,"ISk"))          * PersonSpecificParameters.HepaRG_IS(4);

params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
initialvalues(ismember(sNames,"PancreticCells")) = 1e-5;  % 10 pancretic spheroids x 2000 per islet
params(ismember(pNames,"EdU_boolean"))           = 0;

% FCS + HC
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,3);
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,1);

ParamsReset = params;
initialvaluesReset = initialvalues;

%% Vehicle

params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 0nM
Insulin = 0;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.67, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.57, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Vehicle0.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Vehicle0.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Vehicle0.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Vehicle0.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Vehicle0.variables      = [Sim1.variables];
SimStudy6_Vehicle0.reactions      = [Sim1.reactions];
SimStudy6_Vehicle0.states         = [Sim1.states];

params = ParamsReset;

params(ismember(pNames,"V_m_medium"))            = 0.000605;  % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 5nM
Insulin = 5000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.53, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.57, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Vehicle5.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Vehicle5.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Vehicle5.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Vehicle5.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Vehicle5.variables      = [Sim1.variables];
SimStudy6_Vehicle5.reactions      = [Sim1.reactions];
SimStudy6_Vehicle5.states         = [Sim1.states];

params = ParamsReset;

params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 10nM
Insulin = 10000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.51, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Vehicle10.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Vehicle10.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Vehicle10.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Vehicle10.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Vehicle10.variables      = [Sim1.variables];
SimStudy6_Vehicle10.reactions      = [Sim1.reactions];
SimStudy6_Vehicle10.states         = [Sim1.states];

params = ParamsReset;

params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 100nM
Insulin = 100000;
[initialvalues] = SetInitialValues(11, Insulin, 0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.6, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Vehicle100.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Vehicle100.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Vehicle100.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Vehicle100.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Vehicle100.variables      = [Sim1.variables];
SimStudy6_Vehicle100.reactions      = [Sim1.reactions];
SimStudy6_Vehicle100.states         = [Sim1.states];

params = ParamsReset;

%% Spheroidsx2

params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 0nM
Insulin = 0;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.91, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.45, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Spheroids0.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Spheroids0.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Spheroids0.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Spheroids0.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Spheroids0.variables      = [Sim1.variables];
SimStudy6_Spheroids0.reactions      = [Sim1.reactions];
SimStudy6_Spheroids0.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 5nM
Insulin = 5000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.75, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.47, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Spheroids5.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Spheroids5.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Spheroids5.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Spheroids5.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Spheroids5.variables      = [Sim1.variables];
SimStudy6_Spheroids5.reactions      = [Sim1.reactions];
SimStudy6_Spheroids5.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 10nM
Insulin = 10000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.78, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.46, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Spheroids10.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Spheroids10.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Spheroids10.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Spheroids10.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Spheroids10.variables      = [Sim1.variables];
SimStudy6_Spheroids10.reactions      = [Sim1.reactions];
SimStudy6_Spheroids10.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 100nM
Insulin = 100000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(12.45, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.35, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Spheroids100.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Spheroids100.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Spheroids100.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Spheroids100.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Spheroids100.variables      = [Sim1.variables];
SimStudy6_Spheroids100.reactions      = [Sim1.reactions];
SimStudy6_Spheroids100.states         = [Sim1.states];

params = ParamsReset;

%% Volumex0.5

params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 0nM
Insulin = 0;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.88, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.16, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Volume0.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Volume0.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Volume0.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Volume0.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Volume0.variables      = [Sim1.variables];
SimStudy6_Volume0.reactions      = [Sim1.reactions];
SimStudy6_Volume0.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 5nM
Insulin = 5000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.71, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.52, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Volume5.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Volume5.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Volume5.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Volume5.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Volume5.variables      = [Sim1.variables];
SimStudy6_Volume5.reactions      = [Sim1.reactions];
SimStudy6_Volume5.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 10nM
Insulin = 10000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.24, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.16, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Volume10.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Volume10.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Volume10.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Volume10.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Volume10.variables      = [Sim1.variables];
SimStudy6_Volume10.reactions      = [Sim1.reactions];
SimStudy6_Volume10.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 40 liver cells

% 100nM
Insulin = 100000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.43, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.42, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_Volume100.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_Volume100.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_Volume100.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_Volume100.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_Volume100.variables      = [Sim1.variables];
SimStudy6_Volume100.reactions      = [Sim1.reactions];
SimStudy6_Volume100.states         = [Sim1.states];

params = ParamsReset;

%% VolumeSpheroids

params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 0nM
Insulin = 0;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.43, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.42, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_VolumeSpheroids0.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_VolumeSpheroids0.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_VolumeSpheroids0.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_VolumeSpheroids0.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_VolumeSpheroids0.variables      = [Sim1.variables];
SimStudy6_VolumeSpheroids0.reactions      = [Sim1.reactions];
SimStudy6_VolumeSpheroids0.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 5nM
Insulin = 5000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.42, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.02, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_VolumeSpheroids5.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_VolumeSpheroids5.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_VolumeSpheroids5.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_VolumeSpheroids5.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_VolumeSpheroids5.variables      = [Sim1.variables];
SimStudy6_VolumeSpheroids5.reactions      = [Sim1.reactions];
SimStudy6_VolumeSpheroids5.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 10nM
Insulin = 10000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(11.34, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.65, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_VolumeSpheroids10.time           =  [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_VolumeSpheroids10.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_VolumeSpheroids10.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_VolumeSpheroids10.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_VolumeSpheroids10.variables      = [Sim1.variables];
SimStudy6_VolumeSpheroids10.reactions      = [Sim1.reactions];
SimStudy6_VolumeSpheroids10.states         = [Sim1.states];

params = ParamsReset;
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
params(ismember(pNames,"CountLiver"))            = 2000000;   % 25000 * 80 liver cells

% 100nM
Insulin = 100000;
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))            = 0.000305;    % media volume (L)
Sim0 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(10.81, Insulin,0 , 2,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:28,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim2 = model(28:0.1:48,Sim1.statevalues(end,:),params); 
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),params); 
% Day 3-13
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim3.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,params);
[initialvalues] = SetInitialValues(11, Insulin,0 , 2,params,pNames,sNames,Sim7.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,params);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(9.87, Insulin,0 , 2,params,pNames,sNames,Sim8.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))            = 0.000305        ;    % media volume (L)
Sim9 = model(312:0.1:316,initialvalues,params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim10 = model(316:0.1:336,Sim9.statevalues(end,:),params);
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00002;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),params);

SimStudy6_VolumeSpheroids100.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end),           ];
SimStudy6_VolumeSpheroids100.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
SimStudy6_VolumeSpheroids100.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
SimStudy6_VolumeSpheroids100.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:);  ];
SimStudy6_VolumeSpheroids100.variables      = [Sim1.variables];
SimStudy6_VolumeSpheroids100.reactions      = [Sim1.reactions];
SimStudy6_VolumeSpheroids100.states         = [Sim1.states];
end

