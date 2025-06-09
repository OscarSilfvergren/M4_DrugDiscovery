function [simStudy11_Hcontrol, simStudy11_H0p1, simStudy11_H10,simStudy11_Dcontrol, simStudy11_D0p1, simStudy11_D10,simStudy12_GSIS] = SimulateStudy11o12(model,Study11_data,Study12_data,params,PersonSpecificParameters,initialvalues,sNames,pNames)

%% Experiment declaration
WashingUncertainty = PersonSpecificParameters.EndoCWashing_Uncertainty;

params(ismember(pNames,"Fspheroids50")) = params(ismember(pNames,"Fspheroids50")) * PersonSpecificParameters.HepaRG_f50(5);
params(ismember(pNames,"Fspheroids0"))  = params(ismember(pNames,"Fspheroids0"))  * PersonSpecificParameters.HepaRG_f0(5);
params(ismember(pNames,"ISk"))          = params(ismember(pNames,"ISk"))          * PersonSpecificParameters.HepaRG_IS(5);

params(ismember(pNames,"ExenatideInsulinMax"))                = params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(18);
params(ismember(pNames,"ExenatideInsulinDecayMax"))           = params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(18);
params(ismember(pNames,"ExenatideInsulin50"))                 = params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(18);
params(ismember(pNames,"ExenatideInsulinDecay50"))            = params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(18);
params(ismember(pNames,"Filets0"))                            = params(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(21);
params(ismember(pNames,"EdU_boolean"))                        = 0;

% system
params(ismember(pNames,"CountLiver"))            = 100000;  % 2500 hepatic spheroids x 20
initialvalues(ismember(sNames,"PancreticCells")) = 20000;   % 10 pancretic spheroids x 2000 per islet
initialvalues(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;
params(ismember(pNames,"V_m_medium"))            = 0.000305;  % Media volume (L)

% ULT 
[ParamsULT] = MediaConditionScaling(params,pNames,PersonSpecificParameters,7);

% B27 + HC
[paramsDiseased] = MediaConditionScaling(params        ,pNames,PersonSpecificParameters,1);
[paramsDiseased] = MediaConditionScaling(paramsDiseased,pNames,PersonSpecificParameters,4);

% B27 + NC
[paramsHealthy] = MediaConditionScaling(params       ,pNames,PersonSpecificParameters,2);
[paramsHealthy] = MediaConditionScaling(paramsHealthy,pNames,PersonSpecificParameters,4);

ParamsResetHealthy  = paramsHealthy;
ParamsResetDiseased = paramsDiseased;
initialvaluesReset  = initialvalues;
        
    %% simStudy11_Hcontrol
    params = ParamsResetHealthy;

% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(5.5, 500, 0,0,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim0 = model(0:0.1:24,initialvalues,params);           %1h
[initialvalues] = SetInitialValues(5, Study11_data.hInsulin0(1)*1000, 0,0,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:25,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(25:0.1:28,Sim1.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(28:0.1:48,Sim2.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),params); %48h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(5.2, 500, 0,0,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim5 = model(72:0.1:120,initialvalues,params);
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(5.3, Study11_data.hInsulin0(6)*1000, 0,0,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim6 = model(120:0.1:121,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(121:0.1:124,Sim6.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(124:0.1:144,Sim7.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(144:0.1:168,Sim8.statevalues(end,:),params); %48h
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.8, Study11_data.hInsulin0(11)*1000, 0,0,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim10 = model(168:0.1:169,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(169:0.1:172,Sim10.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(172:0.1:192,Sim11.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(192:0.1:216,Sim12.statevalues(end,:),params); %48h

simStudy11_Hcontrol.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end)            ];
simStudy11_Hcontrol.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy11_Hcontrol.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:); Sim13.reactionvalues(1:end,:)];
simStudy11_Hcontrol.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:)   ; Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:)   ; Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:)   ];
simStudy11_Hcontrol.variables      = [Sim1.variables];
simStudy11_Hcontrol.reactions      = [Sim1.reactions];
simStudy11_Hcontrol.states         = [Sim1.states];

    %% simStudy11_H0p1
    params = ParamsResetHealthy;
 
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(5.5, 500, 0.1,0,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim0 = model(0:0.1:24,initialvalues,params);           %1h
[initialvalues] = SetInitialValues(5, Study11_data.hInsulin0p1(1)*1000, 0.1,0,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:25,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(25:0.1:28,Sim1.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(28:0.1:48,Sim2.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),params); %48h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(5.2, 500, Study11_data.hE0p1(3),0,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim5 = model(72:0.1:120,initialvalues,params);
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(5.3, Study11_data.hInsulin0p1(6)*1000,  Study11_data.hE0p1(5),0,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim6 = model(120:0.1:121,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(121:0.1:124,Sim6.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(124:0.1:144,Sim7.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(144:0.1:168,Sim8.statevalues(end,:),params); %48h
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.5, Study11_data.hInsulin0p1(11)*1000,  Study11_data.dE0p1(7),0,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim10 = model(168:0.1:169,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(169:0.1:172,Sim10.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(172:0.1:192,Sim11.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(192:0.1:216,Sim12.statevalues(end,:),params); %48h

simStudy11_H0p1.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end)            ];
simStudy11_H0p1.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy11_H0p1.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:); Sim13.reactionvalues(1:end,:)];
simStudy11_H0p1.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:)   ; Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:)   ; Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:)   ];
simStudy11_H0p1.variables      = [Sim1.variables];
simStudy11_H0p1.reactions      = [Sim1.reactions];
simStudy11_H0p1.states         = [Sim1.states];

    %% simStudy11_H10
    params = ParamsResetHealthy;
 
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(5.5, 500, 10,0,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim0 = model(0:0.1:24,initialvalues,params);           %1h
[initialvalues] = SetInitialValues(5, Study11_data.hInsulin10(1)*1000, 10,0,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:25,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(25:0.1:28,Sim1.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(28:0.1:48,Sim2.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),params); %48h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(5.2, 500, Study11_data.hE10(3),0,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim5 = model(72:0.1:120,initialvalues,params);
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(5.3, Study11_data.hInsulin10(6)*1000, Study11_data.hE10(5),0,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim6 = model(120:0.1:121,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(121:0.1:124,Sim6.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(124:0.1:144,Sim7.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(144:0.1:168,Sim8.statevalues(end,:),params); %48h
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.5, Study11_data.hInsulin10(11)*1000, Study11_data.hE10(7),0,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim10 = model(168:0.1:169,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(169:0.1:172,Sim10.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(172:0.1:192,Sim11.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(192:0.1:216,Sim12.statevalues(end,:),params); %48h

simStudy11_H10.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end)            ];
simStudy11_H10.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy11_H10.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:); Sim13.reactionvalues(1:end,:)];
simStudy11_H10.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:)   ; Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:)   ; Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:)   ];
simStudy11_H10.variables      = [Sim1.variables];
simStudy11_H10.reactions      = [Sim1.reactions];
simStudy11_H10.states         = [Sim1.states];

%% Diseased
    %% simStudy11_Dcontrol
params = ParamsResetDiseased;
 
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.1, 500, 0,0,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim0 = model(0:0.1:24,initialvalues,params);           %1h
[initialvalues] = SetInitialValues(9.66, Study11_data.dInsulin0(1)*1000, 0,0,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:25,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(25:0.1:28,Sim1.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(28:0.1:48,Sim2.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),params); %48h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(10, 500, 0,0,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim5 = model(72:0.1:120,initialvalues,params);
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(9.6, Study11_data.dInsulin0(6)*1000, 0,0,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim6 = model(120:0.1:121,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(121:0.1:124,Sim6.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(124:0.1:144,Sim7.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(144:0.1:168,Sim8.statevalues(end,:),params); %48h
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.5, Study11_data.dInsulin0(11)*1000, 0,0,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim10 = model(168:0.1:169,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(169:0.1:172,Sim10.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(172:0.1:192,Sim11.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(192:0.1:216,Sim12.statevalues(end,:),params); %48h

simStudy11_Dcontrol.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end)            ];
simStudy11_Dcontrol.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy11_Dcontrol.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:); Sim13.reactionvalues(1:end,:)];
simStudy11_Dcontrol.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:)   ; Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:)   ; Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:)   ];
simStudy11_Dcontrol.variables      = [Sim1.variables];
simStudy11_Dcontrol.reactions      = [Sim1.reactions];
simStudy11_Dcontrol.states         = [Sim1.states];

    %% simStudy11_D0p1
    params = ParamsResetDiseased;
 
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.1, 500, 0.1,0,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim0 = model(0:0.1:24,initialvalues,params);           %1h
[initialvalues] = SetInitialValues(9.66, Study11_data.dInsulin0p1(1)*1000, 0.1,0,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:25,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(25:0.1:28,Sim1.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(28:0.1:48,Sim2.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),params); %48h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(10, 500, 0.1,0,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim5 = model(72:0.1:120,initialvalues,params);
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(9.6, Study11_data.dInsulin0p1(6)*1000, Study11_data.dE0p1(5),0,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim6 = model(120:0.1:121,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(121:0.1:124,Sim6.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(124:0.1:144,Sim7.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(144:0.1:168,Sim8.statevalues(end,:),params); %48h
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.3, Study11_data.dInsulin0p1(11)*1000, Study11_data.dE0p1(7),0,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim10 = model(168:0.1:169,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(169:0.1:172,Sim10.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(172:0.1:192,Sim11.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(192:0.1:216,Sim12.statevalues(end,:),params); %48h

simStudy11_D0p1.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end)            ];
simStudy11_D0p1.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy11_D0p1.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:); Sim13.reactionvalues(1:end,:)];
simStudy11_D0p1.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:)   ; Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:)   ; Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:)   ];
simStudy11_D0p1.variables      = [Sim1.variables];
simStudy11_D0p1.reactions      = [Sim1.reactions];
simStudy11_D0p1.states         = [Sim1.states];

    %% simStudy11_D10
    params = ParamsResetDiseased;
 
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.1, 500, 10,0,params,pNames,sNames,initialvaluesReset);
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim0 = model(0:0.1:24,initialvalues,params);           %1h
[initialvalues] = SetInitialValues(9.8, Study11_data.dInsulin10(1)*1000, 10,0,params,pNames,sNames,Sim0.statevalues(end,:));
Sim1 = model(24:0.1:25,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim2 = model(25:0.1:28,Sim1.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(28:0.1:48,Sim2.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(48:0.1:72,Sim3.statevalues(end,:),params); %48h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(10, 500, 10,0,params,pNames,sNames,Sim4.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim5 = model(72:0.1:120,initialvalues,params);
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(9.9, Study11_data.dInsulin10(6)*1000, Study11_data.dE10(5),0,params,pNames,sNames,Sim5.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim6 = model(120:0.1:121,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim7 = model(121:0.1:124,Sim6.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(124:0.1:144,Sim7.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(144:0.1:168,Sim8.statevalues(end,:),params); %48h
% ---- Media change ----- % GTT
[initialvalues] = SetInitialValues(11.21, Study11_data.dInsulin10(11)*1000, Study11_data.dE10(7),0,params,pNames,sNames,Sim9.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000305;
Sim10 = model(168:0.1:169,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(169:0.1:172,Sim10.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim12 = model(172:0.1:192,Sim11.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim13 = model(192:0.1:216,Sim12.statevalues(end,:),params); %48h

simStudy11_D10.time           = [Sim0.time(1:end-1),             Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end-1),             Sim12.time(1:end-1),             Sim13.time(1:end)            ];
simStudy11_D10.variablevalues = [Sim0.variablevalues(1:end-1,:); Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end-1,:); Sim12.variablevalues(1:end-1,:); Sim13.variablevalues(1:end,:)];
simStudy11_D10.reactionvalues = [Sim0.reactionvalues(1:end-1,:); Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end-1,:); Sim12.reactionvalues(1:end-1,:); Sim13.reactionvalues(1:end,:)];
simStudy11_D10.statevalues    = [Sim0.statevalues(1:end-1,:);    Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:)   ; Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:)   ; Sim11.statevalues(1:end-1,:);    Sim12.statevalues(1:end-1,:);    Sim13.statevalues(1:end,:)   ];
simStudy11_D10.variables      = [Sim1.variables];
simStudy11_D10.reactions      = [Sim1.reactions];
simStudy11_D10.states         = [Sim1.states];

%% GSIS response curves
params        = ParamsULT;

% system settings
params(ismember(pNames,"CountLiver"))                 = 1e-5;        % no liver
initialvaluesReset(ismember(sNames,"PancreticCells")) = 2000;     % 1 pancretic spheroid x 2000 per islet
params(ismember(pNames,"V_m_medium"))                 = 0.00005;  % media volume (L)

% ULT d0
[initialvaluesG0] = SetInitialValues(0, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simULTd0_G0     = model(0:2/3:2/3,initialvaluesG0,params);
[initialvaluesG20] = SetInitialValues(20, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG20(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty;
simULTd0_G20     = model(0:2/3:2/3,initialvaluesG20,params);
[initialvaluesG20E1] = SetInitialValues(20, 0, 1, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty;
simULTd0_G20E1     = model(0:2/3:2/3,initialvaluesG20E1,params);
simStudy12_GSIS.ULTd0(1) = simULTd0_G0.statevalues(end,ismember(simULTd0_G0.states,'Insulin_Medium'));
simStudy12_GSIS.ULTd0(2) = simULTd0_G20.statevalues(end,ismember(simULTd0_G20.states,'Insulin_Medium'));
simStudy12_GSIS.ULTd0(3) = simULTd0_G20E1.statevalues(end,ismember(simULTd0_G20E1.states,'Insulin_Medium'));

end