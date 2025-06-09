function [simStudy2_LCHG,simStudy2_HCHG] = SimulateStudy2(model,Study2_data,params,PersonSpecificParameters,Calibration,initialvalues,sNames,pNames)

%% Experiment declaration

params(ismember(pNames,"Filets0"))      = params(ismember(pNames,"Filets0"))      * Calibration.Filets0;
params(ismember(pNames,"Fspheroids0"))  = params(ismember(pNames,"Fspheroids0"))  * Calibration.Fspheroids0;

% Experiment decleration
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 20 liver cells
initialvalues(ismember(sNames,"PancreticCells")) = 20000;     % 10 pancretic spheroids x 2000 per islet
params(ismember(pNames,"V_m_medium"))            = 0.000605;  % media volume (L)
params(ismember(pNames,"EdU_boolean"))           = 0;

% FCS
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,3);
% FCS + LC
[paramsLC] = MediaConditionScaling(params,pNames,PersonSpecificParameters,2);
% FCS + HC
[paramsHC] = MediaConditionScaling(params,pNames,PersonSpecificParameters,1);

initialvaluesReset = initialvalues;
%% LC + HG

%Day 0-1 GTT
[initialvalues] = SetInitialValues(11.2, 0, 0,2,paramsLC,pNames,sNames,initialvaluesReset);
Sim0 = model(0:0.1:24,initialvalues,paramsLC);
%Day 0-2 GTT
[initialvalues] = SetInitialValues(11.2, 0, 0,2,paramsLC,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:32,initialvalues,paramsLC);
paramsLC(ismember(pNames,"V_m_medium"))     = paramsLC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(32:0.1:48,Sim1.statevalues(end,:),paramsLC);
paramsLC(ismember(pNames,"V_m_medium"))     = paramsLC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),paramsLC); 
% Day 3-13
[initialvalues] = SetInitialValues(11.2, 0, 0, 2,paramsLC,pNames,sNames,Sim3.statevalues(end,:));
paramsLC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,paramsLC);
[initialvalues] = SetInitialValues(11.2, 0, 0, 2,paramsLC,pNames,sNames,Sim4.statevalues(end,:));
paramsLC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,paramsLC);
[initialvalues] = SetInitialValues(11.2, 0, 0, 2,paramsLC,pNames,sNames,Sim5.statevalues(end,:));
paramsLC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,paramsLC);
[initialvalues] = SetInitialValues(11.2, 0, 0, 2,paramsLC,pNames,sNames,Sim6.statevalues(end,:));
paramsLC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,paramsLC);
[initialvalues] = SetInitialValues(11.2, 0, 0, 2,paramsLC,pNames,sNames,Sim7.statevalues(end,:));
paramsLC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,paramsLC);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(11.2, 0, 0, 2,paramsLC,pNames,sNames,Sim8.statevalues(end,:));
paramsLC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:320,initialvalues,paramsLC);
paramsLC(ismember(pNames,"V_m_medium"))     = paramsLC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim10 = model(320:0.1:336,Sim9.statevalues(end,:),paramsLC);
paramsLC(ismember(pNames,"V_m_medium"))     = paramsLC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),paramsLC);
paramsLC(ismember(pNames,"V_m_medium"))     = paramsLC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(360:0.1:408,Sim11.statevalues(end,:),paramsLC);

simStudy2_LCHG.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end)            ];
simStudy2_LCHG.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end,:)];
simStudy2_LCHG.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end,:)];
simStudy2_LCHG.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end,:)   ];
simStudy2_LCHG.variables      = [Sim1.variables];
simStudy2_LCHG.reactions      = [Sim1.reactions];
simStudy2_LCHG.states         = [Sim1.states];

%% HC + HG

%Day 0-1 GTT
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,initialvaluesReset);
Sim0 = model(0:0.1:24,initialvalues,paramsLC);
%Day 0-2 GTT
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:32,initialvalues,paramsHC);
paramsHC(ismember(pNames,"V_m_medium"))     = paramsHC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(32:0.1:48,Sim1.statevalues(end,:),paramsHC);
paramsHC(ismember(pNames,"V_m_medium"))     = paramsHC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(48:0.1:72,Sim2.statevalues(end,:),paramsHC); 
% Day 3-13
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,Sim3.statevalues(end,:));
paramsHC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim4 = model(72:0.1:120,initialvalues,paramsHC);
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,Sim4.statevalues(end,:));
paramsHC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(120:0.1:168,initialvalues,paramsHC);
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,Sim5.statevalues(end,:));
paramsHC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(168:0.1:216,initialvalues,paramsHC);
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,Sim6.statevalues(end,:));
paramsHC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(216:0.1:264,initialvalues,paramsHC);
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,Sim7.statevalues(end,:));
paramsHC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(264:0.1:312,initialvalues,paramsHC);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsHC,pNames,sNames,Sim8.statevalues(end,:));
paramsHC(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(312:0.1:320,initialvalues,paramsHC);
paramsHC(ismember(pNames,"V_m_medium"))     = paramsHC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim10 = model(320:0.1:336,Sim9.statevalues(end,:),paramsHC);
paramsHC(ismember(pNames,"V_m_medium"))     = paramsHC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(336:0.1:360,Sim10.statevalues(end,:),paramsHC);
paramsHC(ismember(pNames,"V_m_medium"))     = paramsHC(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(360:0.1:408,Sim11.statevalues(end,:),paramsHC);

simStudy2_HCHG.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end)            ];
simStudy2_HCHG.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end,:)];
simStudy2_HCHG.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end,:)];
simStudy2_HCHG.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end,:)   ];
simStudy2_HCHG.variables      = [Sim1.variables];
simStudy2_HCHG.reactions      = [Sim1.reactions];
simStudy2_HCHG.states         = [Sim1.states];

end

