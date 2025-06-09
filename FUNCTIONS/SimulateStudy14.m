function  [simStudy14_GSIS] = SimulateStudy14(model,params,Study14_data,PersonSpecificParameters,initialvalues,sNames,pNames)

%% Experiment declaration

% system settings
params(ismember(pNames,"CountLiver"))               = 1e-5;        % no liver
initialvalues(ismember(sNames,"PancreticCells"))    = 2000;     % 1 pancretic spheroid x 2000 per islet
params(ismember(pNames,"V_m_medium"))               = 0.00005;  % media volume (L)
params(ismember(pNames,"EdU_boolean"))              = 1;
params(ismember(pNames,"ExenatideDegradiationK"))   = 0;

% SM
[SM_params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,6);
% FCS + HC
[CM1_FCSparams] = MediaConditionScaling(params       ,pNames,PersonSpecificParameters,1);
[CM1_FCSparams] = MediaConditionScaling(CM1_FCSparams,pNames,PersonSpecificParameters,3);
% FCS + LC
[CM2_FCSparams] = MediaConditionScaling(params       ,pNames,PersonSpecificParameters,2);
[CM2_FCSparams] = MediaConditionScaling(CM2_FCSparams,pNames,PersonSpecificParameters,3);
% B27 + LC
[B27_params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,2);
[B27_params] = MediaConditionScaling(B27_params,pNames,PersonSpecificParameters,4);

%% GSIS simulation

% SM
[initialvaluesSM] = SetInitialValues(5.5, 0, 0, 0,SM_params,pNames,sNames,initialvalues);
simSM_D0toD7 = model(0:384:384,initialvaluesSM,SM_params);
simStudy14_GSIS.SM(1) = simSM_D0toD7.statevalues(end,ismember(simSM_D0toD7.states,'PancreticCells'));
simStudy14_GSIS.SM(2) = simSM_D0toD7.statevalues(end,ismember(simSM_D0toD7.states,'PancreticCells_EdU'));

% HCHG
[initialvaluesCM1_FCS] = SetInitialValues(11, 0, 0, 2,CM1_FCSparams,pNames,sNames,initialvalues);
simHCHG_D0toD7 = model(0:384:384,initialvaluesCM1_FCS,CM1_FCSparams);
simStudy14_GSIS.HCHG(1) = simHCHG_D0toD7.statevalues(end,ismember(simHCHG_D0toD7.states,'PancreticCells'));
simStudy14_GSIS.HCHG(2) = simHCHG_D0toD7.statevalues(end,ismember(simHCHG_D0toD7.states,'PancreticCells_EdU'));
% HCLG
[initialvaluesCM1_FCS] = SetInitialValues(5.5, 0, 0, 2,CM1_FCSparams,pNames,sNames,initialvalues);
simHCLG_D0toD7 = model(0:384:384,initialvaluesCM1_FCS,CM1_FCSparams);
simStudy14_GSIS.HCLG(1) = simHCLG_D0toD7.statevalues(end,ismember(simHCLG_D0toD7.states,'PancreticCells'));
simStudy14_GSIS.HCLG(2) = simHCLG_D0toD7.statevalues(end,ismember(simHCLG_D0toD7.states,'PancreticCells_EdU'));

% HCHG + 0.1 exenatide
[initialvaluesCM1_FCS] = SetInitialValues(11, 0, 0.1, 2,CM1_FCSparams,pNames,sNames,initialvalues);
simHCHG_E0p1 = model(0:384:384,initialvaluesCM1_FCS,CM1_FCSparams);
simStudy14_GSIS.HCHG_E0p1(1) = simHCHG_E0p1.statevalues(end,ismember(simHCHG_E0p1.states,'PancreticCells'));
simStudy14_GSIS.HCHG_E0p1(2) = simHCHG_E0p1.statevalues(end,ismember(simHCHG_E0p1.states,'PancreticCells_EdU'));
% HCHG + 10 exenatide
[initialvaluesCM1_FCS] = SetInitialValues(11, 0, 10, 2,CM1_FCSparams,pNames,sNames,initialvalues);
simHCHG_E10 = model(0:384:384,initialvaluesCM1_FCS,CM1_FCSparams);
simStudy14_GSIS.HCHG_E10(1) = simHCHG_E10.statevalues(end,ismember(simHCHG_E10.states,'PancreticCells'));
simStudy14_GSIS.HCHG_E10(2) = simHCHG_E10.statevalues(end,ismember(simHCHG_E10.states,'PancreticCells_EdU'));
% HCHG + 1000 exenatide
[initialvaluesCM1_FCS] = SetInitialValues(11, 0, 1000, 2,CM1_FCSparams,pNames,sNames,initialvalues);
simHCHG_E1000 = model(0:384:384,initialvaluesCM1_FCS,CM1_FCSparams);
simStudy14_GSIS.HCHG_E1000(1) = simHCHG_E1000.statevalues(end,ismember(simHCHG_E1000.states,'PancreticCells'));
simStudy14_GSIS.HCHG_E1000(2) = simHCHG_E1000.statevalues(end,ismember(simHCHG_E1000.states,'PancreticCells_EdU'));

% LCHG
[initialvaluesCM2_FCS] = SetInitialValues(11, 0, 0, 2,CM2_FCSparams,pNames,sNames,initialvalues);
simLCHG_D0toD7 = model(0:384:384,initialvaluesCM2_FCS,CM2_FCSparams);
simStudy14_GSIS.LCHG(1) = simLCHG_D0toD7.statevalues(end,ismember(simLCHG_D0toD7.states,'PancreticCells'));
simStudy14_GSIS.LCHG(2) = simLCHG_D0toD7.statevalues(end,ismember(simLCHG_D0toD7.states,'PancreticCells_EdU'));
% LCLG
[initialvaluesCM2_FCS] = SetInitialValues(5.5, 0, 0, 2,CM2_FCSparams,pNames,sNames,initialvalues);
simLCLG_D0toD7 = model(0:384:384,initialvaluesCM2_FCS,CM2_FCSparams);
simStudy14_GSIS.LCLG(1) = simLCLG_D0toD7.statevalues(end,ismember(simLCLG_D0toD7.states,'PancreticCells'));
simStudy14_GSIS.LCLG(2) = simLCLG_D0toD7.statevalues(end,ismember(simLCLG_D0toD7.states,'PancreticCells_EdU'));

% B27
[initialvaluesB27] = SetInitialValues(5.5, 0, 0, 2,B27_params,pNames,sNames,initialvalues);
simB27_D0toD7 = model(0:384:384,initialvaluesB27,B27_params);
simStudy14_GSIS.B27(1) = simB27_D0toD7.statevalues(end,ismember(simB27_D0toD7.states,'PancreticCells'));
simStudy14_GSIS.B27(2) = simB27_D0toD7.statevalues(end,ismember(simB27_D0toD7.states,'PancreticCells_EdU'));

end

