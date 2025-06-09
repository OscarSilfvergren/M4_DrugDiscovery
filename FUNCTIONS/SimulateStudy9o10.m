function [simStudy9_control, simStudy9_0p1, simStudy9_10,simStudy10_GSIS] = SimulateStudy9o10(model,Study9_data,Study10_data,params,PersonSpecificParameters,initialvalues,sNames,pNames,ExtraPlotResolution)

%% Experiment declaration
WashingUncertainty = PersonSpecificParameters.EndoCWashing_Uncertainty;

params(ismember(pNames,"Fspheroids50")) = params(ismember(pNames,"Fspheroids50")) * PersonSpecificParameters.HepaRG_f50(4);
params(ismember(pNames,"Fspheroids0"))  = params(ismember(pNames,"Fspheroids0"))  * PersonSpecificParameters.HepaRG_f0(4);
params(ismember(pNames,"ISk"))          = params(ismember(pNames,"ISk"))          * PersonSpecificParameters.HepaRG_IS(4);

params(ismember(pNames,"ExenatideInsulinMax"))                = params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(16);
params(ismember(pNames,"ExenatideInsulinDecayMax"))           = params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(16);
params(ismember(pNames,"ExenatideInsulin50"))                 = params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(16);
params(ismember(pNames,"ExenatideInsulinDecay50"))            = params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(16);
params(ismember(pNames,"Filets0"))                            = params(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(19);
params(ismember(pNames,"EdU_boolean"))                        = 0;

% ULT
[params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,7);

% system
params(ismember(pNames,"CountLiver"))            = 1e-5;      % no liver
initialvalues(ismember(sNames,"PancreticCells")) = 20000;     % 10 pancretic spheroids x 2000 per islet
initialvalues(ismember(sNames,"Insulin_islets")) = PersonSpecificParameters.EndoCStoredInsulin;    % 375000
params(ismember(pNames,"V_m_medium"))            = 0.000405;    % media volume (L)
initialvalues(ismember(sNames,"Glucose_islets")) = 0*WashingUncertainty; % washing

ParamsReset = params;
initialvaluesReset = initialvalues;

%% control
params = ParamsReset;

% Pre-culture
[initialvalues] = SetInitialValues(0, 252, 0, 0,params,pNames,sNames,initialvaluesReset);
Sim1 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(5.5, 252, 0, 0,params,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model(24+0:0.1:24+1,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(24+1:0.1:24+4,Sim2.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(24+4:0.1:24+24,Sim3.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim5 = model(24+24:0.1:24+48,Sim4.statevalues(end,:),params); %48h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim6 = model(24+48:0.1:24+72,Sim5.statevalues(end,:),params); %72h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(11, 1100, 0, 0,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000405;
Sim7 = model(24+72:0.1:24+72+1,initialvalues,params); %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(24+72+1:0.1:24+72+4,Sim7.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(24+72+4:0.1:24+72+24,Sim8.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim10 = model(24+72+24:0.1:24+72+48,Sim9.statevalues(end,:),params); %48h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(24+72+48:0.1:24+72+72,Sim10.statevalues(end,:),params); %72h
simStudy9_control.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end)];
simStudy9_control.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
simStudy9_control.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
simStudy9_control.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:)];
simStudy9_control.variables      = [Sim2.variables];
simStudy9_control.reactions      = [Sim2.reactions];
simStudy9_control.states         = [Sim2.states];

%% 0.1 nM
params = ParamsReset;

% Pre-culture
[initialvalues] = SetInitialValues(0, 252, 0.1, 0,params,pNames,sNames,initialvaluesReset);
Sim1 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(5.5, 252, 0.1, 0,params,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model(24+0:0.1:24+1,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(24+1:0.1:24+4,Sim2.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(24+4:0.1:24+24,Sim3.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim5 = model(24+24:0.1:24+48,Sim4.statevalues(end,:),params); %48h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim6 = model(24+48:0.1:24+72,Sim5.statevalues(end,:),params); %72h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(11, 1100, 0.1, 0,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000405;
Sim7 = model(24+72:0.1:24+72+1,initialvalues,params); %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(24+72+1:0.1:24+72+4,Sim7.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(24+72+4:0.1:24+72+24,Sim8.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim10 = model(24+72+24:0.1:24+72+48,Sim9.statevalues(end,:),params); %48h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(24+72+48:0.1:24+72+72,Sim10.statevalues(end,:),params); %72h
simStudy9_0p1.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end)];
simStudy9_0p1.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
simStudy9_0p1.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
simStudy9_0p1.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:)];
simStudy9_0p1.variables      = [Sim2.variables];
simStudy9_0p1.reactions      = [Sim2.reactions];
simStudy9_0p1.states         = [Sim2.states];

%% 10 nM
params = ParamsReset;

% Pre-culture
[initialvalues] = SetInitialValues(0, 252, 10, 0,params,pNames,sNames,initialvaluesReset);
Sim1 = model(0:0.1:24,initialvalues,params);
[initialvalues] = SetInitialValues(5.5, 252, 10, 0,params,pNames,sNames,Sim1.statevalues(end,:));
Sim2 = model(24+0:0.1:24+1,initialvalues,params);           %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim3 = model(24+1:0.1:24+4,Sim2.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim4 = model(24+4:0.1:24+24,Sim3.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim5 = model(24+24:0.1:24+48,Sim4.statevalues(end,:),params); %48h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim6 = model(24+48:0.1:24+72,Sim5.statevalues(end,:),params); %72h
% ---- Media change ----- %
[initialvalues] = SetInitialValues(11.1 , 1100, 10, 0,params,pNames,sNames,Sim6.statevalues(end,:));
params(ismember(pNames,"V_m_medium"))     = 0.000405;
Sim7 = model(24+72:0.1:24+72+1,initialvalues,params); %1h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim8 = model(24+72+1:0.1:24+72+4,Sim7.statevalues(end,:),params); %4h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim9 = model(24+72+4:0.1:24+72+24,Sim8.statevalues(end,:),params); %24h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim10 = model(24+72+24:0.1:24+72+48,Sim9.statevalues(end,:),params); %48h
params(ismember(pNames,"V_m_medium"))     = params(ismember(pNames,"V_m_medium")) - 0.00003;
Sim11 = model(24+72+48:0.1:24+72+72,Sim10.statevalues(end,:),params); %72h
simStudy9_10.time           = [Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),             Sim8.time(1:end-1),             Sim9.time(1:end-1),             Sim10.time(1:end-1),             Sim11.time(1:end)];
simStudy9_10.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:); Sim8.variablevalues(1:end-1,:); Sim9.variablevalues(1:end-1,:); Sim10.variablevalues(1:end-1,:); Sim11.variablevalues(1:end,:)];
simStudy9_10.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:); Sim8.reactionvalues(1:end-1,:); Sim9.reactionvalues(1:end-1,:); Sim10.reactionvalues(1:end-1,:); Sim11.reactionvalues(1:end,:)];
simStudy9_10.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);    Sim8.statevalues(1:end-1,:);    Sim9.statevalues(1:end-1,:);    Sim10.statevalues(1:end-1,:);    Sim11.statevalues(1:end,:)];
simStudy9_10.variables      = [Sim2.variables];
simStudy9_10.reactions      = [Sim2.reactions];
simStudy9_10.states         = [Sim2.states];

%% GSIS response curves
params        = ParamsReset;

% system settings
params(ismember(pNames,"CountLiver"))                 = 1e-5;        % no liver
initialvaluesReset(ismember(sNames,"PancreticCells")) = 2000;     % 1 pancretic spheroid x 2000 per islet
params(ismember(pNames,"V_m_medium"))                 = 0.00005;  % media volume (L)

Glucose   = [0,5.5,11.1,20.1];
if ExtraPlotResolution == 1
Glucose   = 0:0.1:25;
end

 for i =1:length(Glucose)
    [initialvaluesGR] = SetInitialValues(Glucose(i), 0, 0,0,params,pNames,sNames,initialvaluesReset);
    initialvaluesGR(ismember(sNames,"Glucose_islets")) = Glucose(i)*WashingUncertainty;
    simResponseCurve = model(0:2/3:2/3,initialvaluesGR,params);
    SaveInsulinSecretionGR(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
 end
simStudy10_GSIS.GR = SaveInsulinSecretionGR;
 
 Exenatide   = [0,0.01,0.1,1,10,100];
 for i =1:length(Exenatide)
    [initialvaluesER] = SetInitialValues(11.1, 0, Exenatide(i),0,params,pNames,sNames,initialvaluesReset);
   initialvaluesER(ismember(sNames,"Glucose_islets")) = 11.1*WashingUncertainty;
    simResponseCurve = model(0:2/3:2/3,initialvaluesER,params);
    SaveInsulinSecretionER(i) = simResponseCurve.statevalues(end,ismember(simResponseCurve.states,'Insulin_Medium'));
 end

simStudy10_GSIS.ER = SaveInsulinSecretionER;

%% GSIS

% G0E0
[initialvaluesG0] = SetInitialValues(0, 0, 0, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG0(ismember(sNames,"Glucose_islets")) = 0;
simStudy10_GSIS.simULTd0_G0     = model((0:1:40)/60,initialvaluesG0,params);
% G5p5E1
[initialvaluesG5p5E1] = SetInitialValues(5.5, 0, 1, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG5p5E1(ismember(sNames,"Glucose_islets")) = 5.5*WashingUncertainty;
simStudy10_GSIS.simULTd0_G5p5E1 = model((0:1:40)/60,initialvaluesG5p5E1,params);
% G20E1
[initialvaluesG20E1] = SetInitialValues(20.1, 0, 1, 0,params,pNames,sNames,initialvaluesReset);
initialvaluesG20E1(ismember(sNames,"Glucose_islets")) = 20*WashingUncertainty;
simStudy10_GSIS.simULTd0_G20E1     = model((0:1:40)/60,initialvaluesG20E1,params);

end

