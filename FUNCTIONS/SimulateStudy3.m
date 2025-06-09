function [simStudy3_B27,simStudy3_FCS] = SimulateStudy3(model,Study3_data,params,PersonSpecificParameters,initialvalues,sNames,pNames)

%% Experiment declaration

params(ismember(pNames,"Filets0"))      = params(ismember(pNames,"Filets0"))      * PersonSpecificParameters.Filets0(16);
params(ismember(pNames,"Fislets50"))    = params(ismember(pNames,"Fislets50"))    * PersonSpecificParameters.HepaRG_f50(2);  
params(ismember(pNames,"Fspheroids50")) = params(ismember(pNames,"Fspheroids50")) * PersonSpecificParameters.HepaRG_f50(2);
params(ismember(pNames,"Fspheroids0"))  = params(ismember(pNames,"Fspheroids0"))  * PersonSpecificParameters.HepaRG_f0(2);
params(ismember(pNames,"ISk"))          = params(ismember(pNames,"ISk"))          * PersonSpecificParameters.HepaRG_IS(2);

% Experiment decleration
params(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 20 liver cells
initialvalues(ismember(sNames,"PancreticCells")) = 20000;     % 10 pancretic spheroids x 2000 per islet
params(ismember(pNames,"V_m_medium"))            = 0.000605;  % media volume (L)
params(ismember(pNames,"EdU_boolean"))           = 0;

% NC
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,2);
% B27 + NC
[paramsB27] = MediaConditionScaling(params,pNames,PersonSpecificParameters,4);
% FCS + NC
[paramsFCS] = MediaConditionScaling(params,pNames,PersonSpecificParameters,3);

initialvaluesReset = initialvalues;
%% B27

%Day 0-1 GTT
[initialvalues] = SetInitialValues(10.31, 0, 0, 0,paramsB27,pNames,sNames,initialvaluesReset);
Sim1 = model(0:0.1:24,initialvalues,paramsB27);
%Day 1-3 GTT
[initialvalues] = SetInitialValues(10.7353267914772, 0, 0, 0,paramsB27,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model(24:0.1:32,initialvalues,paramsB27);
paramsB27(ismember(pNames,"V_m_medium"))     = paramsB27(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(32:0.1:48,Sim2.statevalues(end,:),paramsB27); 
paramsB27(ismember(pNames,"V_m_medium"))     = paramsB27(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),paramsB27); 
% Day 3-7
[initialvalues] = SetInitialValues(10.7353267914772, 2000, 0, 0,paramsB27,pNames,sNames,Sim4.statevalues(end,:));
paramsB27(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(72:0.1:120,initialvalues,paramsB27);
[initialvalues] = SetInitialValues(10.7353267914772, 2000, 0, 0,paramsB27,pNames,sNames,Sim5.statevalues(end,:));
paramsB27(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(120:0.1:168,initialvalues,paramsB27);
[initialvalues] = SetInitialValues(10.7353267914772, 2000, 0, 0,paramsB27,pNames,sNames,Sim6.statevalues(end,:));
paramsB27(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(168:0.1:216,initialvalues,paramsB27);
[initialvalues] = SetInitialValues(10.7353267914772, 2000, 0, 0,paramsB27,pNames,sNames,Sim7.statevalues(end,:));
paramsB27(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(216:0.1:264,initialvalues,paramsB27);
[initialvalues] = SetInitialValues(10.7353267914772, 2000, 0, 0,paramsB27,pNames,sNames,Sim8.statevalues(end,:));
paramsB27(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(264:0.1:312,initialvalues,paramsB27);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(10.7353267914772, 0, 0, 0,paramsB27,pNames,sNames,Sim9.statevalues(end,:));
paramsB27(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim10 = model(312:0.1:320,initialvalues,paramsB27);
paramsB27(ismember(pNames,"V_m_medium"))     = paramsB27(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(320:0.1:336,Sim10.statevalues(end,:),paramsB27);
paramsB27(ismember(pNames,"V_m_medium"))     = paramsB27(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(336:0.1:360,Sim11.statevalues(end,:),paramsB27);
paramsB27(ismember(pNames,"V_m_medium"))     = paramsB27(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(360:0.1:384,Sim12.statevalues(end,:),paramsB27);

simStudy3_B27.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end),         ];
simStudy3_B27.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy3_B27.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:);   Sim13.reactionvalues(1:end,:)];
simStudy3_B27.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:) ];
simStudy3_B27.variables      = [Sim1.variables];
simStudy3_B27.reactions      = [Sim1.reactions];
simStudy3_B27.states         = [Sim1.states];

%% FCS

%Day 0-1 GTT
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsFCS,pNames,sNames,initialvaluesReset);
Sim1 = model(0:0.1:24,initialvalues,paramsFCS);
%Day 1-3 GTT
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsFCS,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model(24:0.1:32,initialvalues,paramsFCS);
paramsFCS(ismember(pNames,"V_m_medium"))     = paramsFCS(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(32:0.1:48,Sim2.statevalues(end,:),paramsFCS); 
paramsFCS(ismember(pNames,"V_m_medium"))     = paramsFCS(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),paramsFCS); 
% Day 3-7
[initialvalues] = SetInitialValues(11, 2000, 0, 2,paramsFCS,pNames,sNames,Sim4.statevalues(end,:));
paramsFCS(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim5 = model(72:0.1:120,initialvalues,paramsFCS);
[initialvalues] = SetInitialValues(11, 2000, 0, 2,paramsFCS,pNames,sNames,Sim5.statevalues(end,:));
paramsFCS(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim6 = model(120:0.1:168,initialvalues,paramsFCS);
[initialvalues] = SetInitialValues(11, 2000, 0, 2,paramsFCS,pNames,sNames,Sim6.statevalues(end,:));
paramsFCS(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim7 = model(168:0.1:216,initialvalues,paramsFCS);
[initialvalues] = SetInitialValues(11, 2000, 0, 2,paramsFCS,pNames,sNames,Sim7.statevalues(end,:));
paramsFCS(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim8 = model(216:0.1:264,initialvalues,paramsFCS);
[initialvalues] = SetInitialValues(11, 2000, 0, 2,paramsFCS,pNames,sNames,Sim8.statevalues(end,:));
paramsFCS(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim9 = model(264:0.1:312,initialvalues,paramsFCS);
% Day 13-15 GTT
[initialvalues] = SetInitialValues(11, 0, 0, 2,paramsFCS,pNames,sNames,Sim9.statevalues(end,:));
paramsFCS(ismember(pNames,"V_m_medium"))            = 0.000605;    % media volume (L)
Sim10 = model(312:0.1:320,initialvalues,paramsFCS);
paramsFCS(ismember(pNames,"V_m_medium"))     = paramsFCS(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(320:0.1:336,Sim10.statevalues(end,:),paramsFCS);
paramsFCS(ismember(pNames,"V_m_medium"))     = paramsFCS(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(336:0.1:360,Sim11.statevalues(end,:),paramsFCS);
paramsFCS(ismember(pNames,"V_m_medium"))     = paramsFCS(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(360:0.1:384,Sim12.statevalues(end,:),paramsFCS);

simStudy3_FCS.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end),         ];
simStudy3_FCS.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy3_FCS.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:);   Sim13.reactionvalues(1:end,:)];
simStudy3_FCS.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:) ];
simStudy3_FCS.variables      = [Sim1.variables];
simStudy3_FCS.reactions      = [Sim1.reactions];
simStudy3_FCS.states         = [Sim1.states];
end

