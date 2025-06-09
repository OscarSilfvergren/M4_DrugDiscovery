function  [SimEndoC,SimHuman,SimHepaRG] = SimulateMediaFunctionality(model,params,PersonSpecificParameters,initialvalues,sNames,pNames,AmountParameterOpti,resolution)

[PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,AmountParameterOpti,params);

initialvalues(ismember(sNames,"PancreticCells"))      = 2000;     % 10 pancretic spheroids x 2000 per islet

EndoC_params(ismember(pNames,"CountLiver"))              = 1000000;         % no liver
EndoC_params(ismember(pNames,"V_m_medium"))              = 0.003;    % media volume (L)
EndoC_params(ismember(pNames,"EdU_boolean"))             = 0;

InSphero_params(ismember(pNames,"CountLiver"))              = 1000000;         % no liver
InSphero_params(ismember(pNames,"V_m_medium"))              = 0.003;    % media volume (L)
InSphero_params(ismember(pNames,"EdU_boolean"))             = 0;

initialvaluesReset = initialvalues;
%% EndoC
[initialvalues] = SetInitialValues(5.5, 0, 0,0,EndoC_params,pNames,sNames,initialvaluesReset);

% EndoC
[paramEndoHC] = MediaConditionScaling(EndoC_params,pNames,PersonSpecificParametersEndoC,1);
SimEndoC.HC     = model(0: resolution :672,initialvalues,paramEndoHC);
[paramEndoLC] = MediaConditionScaling(EndoC_params,pNames,PersonSpecificParametersEndoC,2);
SimEndoC.LC     = model(0: resolution :672,initialvalues,paramEndoLC);
[paramEndoFCS] = MediaConditionScaling(EndoC_params,pNames,PersonSpecificParametersEndoC,3);
SimEndoC.FCS     = model(0: resolution :672,initialvalues,paramEndoFCS);
[paramEndoB27] = MediaConditionScaling(EndoC_params,pNames,PersonSpecificParametersEndoC,4);
SimEndoC.B27     = model(0: resolution :672,initialvalues,paramEndoB27);
[paramEndoBSA] = MediaConditionScaling(EndoC_params,pNames,PersonSpecificParametersEndoC,5);
SimEndoC.BSA     = model(0: resolution :672,initialvalues,paramEndoBSA);
[paramEndoULT] = MediaConditionScaling(EndoC_params,pNames,PersonSpecificParametersEndoC,7);
SimEndoC.ULT     = model(0: resolution :672,initialvalues,paramEndoULT);

%% InSphero
[initialvalues] = SetInitialValues(5.5, 0, 0,0,InSphero_params,pNames,sNames,initialvaluesReset);

% InSphero
[paramHumanHC] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,1);
SimHuman.HC     = model(0: resolution :672,initialvalues,paramHumanHC);
[paramHumanLC] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,2);
SimHuman.LC     = model(0: resolution :672,initialvalues,paramHumanLC);
[paramHumanFCS] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,3);
SimHuman.FCS     = model(0: resolution :672,initialvalues,paramHumanFCS);
[paramHumanB27] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,4);
SimHuman.B27     = model(0: resolution :672,initialvalues,paramHumanB27);
[paramHumanBSA] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,5);
SimHuman.BSA     = model(0: resolution :672,initialvalues,paramHumanBSA);
[paramHumanULT] = MediaConditionScaling(InSphero_params,pNames,PersonSpecificParametersInSphero,6);
SimHuman.SM     = model(0: resolution :672,initialvalues,paramHumanULT);

%% HepaRG
if resolution == 1
HepaRG_params = InSphero_params;

[initialvaluesReset] = SetInitialValues(11, 0, 0,0,HepaRG_params,pNames,sNames,initialvaluesReset);
HepaRG_params(ismember(pNames,"CountLiver"))         = 1000000;         % no liver
initialvaluesReset(ismember(sNames,"PancreticCells")) = 1e-3;     % 10 pancretic spheroids x 2000 per islet

% HepaRG
[paramHepaRGHC] = MediaConditionScaling(HepaRG_params,pNames,PersonSpecificParametersEndoC,1);
Sim0     = model(0: resolution :48,initialvaluesReset,paramHepaRGHC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGHC,pNames,sNames,Sim0.statevalues(end,:));
Sim1     = model(48: resolution :96,initialvalues,paramHepaRGHC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGHC,pNames,sNames,Sim1.statevalues(end,:));
Sim2     = model(96: resolution :144,initialvalues,paramHepaRGHC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGHC,pNames,sNames,Sim2.statevalues(end,:));
Sim3     = model(144: resolution :192,initialvalues,paramHepaRGHC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGHC,pNames,sNames,Sim3.statevalues(end,:));
Sim4     = model(192: resolution :240,initialvalues,paramHepaRGHC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGHC,pNames,sNames,Sim4.statevalues(end,:));
Sim5     = model(240: resolution :288,initialvalues,paramHepaRGHC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGHC,pNames,sNames,Sim5.statevalues(end,:));
Sim6     = model(288: resolution :336,initialvalues,paramHepaRGHC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGHC,pNames,sNames,Sim6.statevalues(end,:));
Sim7     = model(336: resolution :384,initialvalues,paramHepaRGHC);
SimHepaRG.HC.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),           ];
SimHepaRG.HC.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:)];
SimHepaRG.HC.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:)];
SimHepaRG.HC.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);  ];
SimHepaRG.HC.variables      = [Sim1.variables];
SimHepaRG.HC.reactions      = [Sim1.reactions];
SimHepaRG.HC.states         = [Sim1.states];

[paramHepaRGLC] = MediaConditionScaling(HepaRG_params,pNames,PersonSpecificParametersEndoC,2);
Sim0     = model(0: resolution :48,initialvaluesReset,paramHepaRGLC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGLC,pNames,sNames,Sim0.statevalues(end,:));
Sim1     = model(48: resolution :96,initialvalues,paramHepaRGLC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGLC,pNames,sNames,Sim1.statevalues(end,:));
Sim2     = model(96: resolution :144,initialvalues,paramHepaRGLC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGLC,pNames,sNames,Sim2.statevalues(end,:));
Sim3     = model(144: resolution :192,initialvalues,paramHepaRGLC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGLC,pNames,sNames,Sim3.statevalues(end,:));
Sim4     = model(192: resolution :240,initialvalues,paramHepaRGLC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGLC,pNames,sNames,Sim4.statevalues(end,:));
Sim5     = model(240: resolution :288,initialvalues,paramHepaRGLC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGLC,pNames,sNames,Sim5.statevalues(end,:));
Sim6     = model(288: resolution :336,initialvalues,paramHepaRGLC);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGLC,pNames,sNames,Sim6.statevalues(end,:));
Sim7     = model(336: resolution :384,initialvalues,paramHepaRGLC);
SimHepaRG.LC.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),           ];
SimHepaRG.LC.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:)];
SimHepaRG.LC.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:)];
SimHepaRG.LC.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);  ];
SimHepaRG.LC.variables      = [Sim1.variables];
SimHepaRG.LC.reactions      = [Sim1.reactions];
SimHepaRG.LC.states         = [Sim1.states];

[paramHepaRGFCS] = MediaConditionScaling(HepaRG_params,pNames,PersonSpecificParametersEndoC,3);
Sim0     = model(0: resolution :48,initialvaluesReset,paramHepaRGFCS);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGFCS,pNames,sNames,Sim0.statevalues(end,:));
Sim1     = model(48: resolution :96,initialvalues,paramHepaRGFCS);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGFCS,pNames,sNames,Sim1.statevalues(end,:));
Sim2     = model(96: resolution :144,initialvalues,paramHepaRGFCS);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGFCS,pNames,sNames,Sim2.statevalues(end,:));
Sim3     = model(144: resolution :192,initialvalues,paramHepaRGFCS);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGFCS,pNames,sNames,Sim3.statevalues(end,:));
Sim4     = model(192: resolution :240,initialvalues,paramHepaRGFCS);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGFCS,pNames,sNames,Sim4.statevalues(end,:));
Sim5     = model(240: resolution :288,initialvalues,paramHepaRGFCS);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGFCS,pNames,sNames,Sim5.statevalues(end,:));
Sim6     = model(288: resolution :336,initialvalues,paramHepaRGFCS);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGFCS,pNames,sNames,Sim6.statevalues(end,:));
Sim7     = model(336: resolution :384,initialvalues,paramHepaRGFCS);
SimHepaRG.FCS.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),           ];
SimHepaRG.FCS.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:)];
SimHepaRG.FCS.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:)];
SimHepaRG.FCS.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);  ];
SimHepaRG.FCS.variables      = [Sim1.variables];
SimHepaRG.FCS.reactions      = [Sim1.reactions];
SimHepaRG.FCS.states         = [Sim1.states];

[paramHepaRGB27] = MediaConditionScaling(HepaRG_params,pNames,PersonSpecificParametersEndoC,4);
Sim0     = model(0: resolution :48,initialvaluesReset,paramHepaRGB27);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGB27,pNames,sNames,Sim0.statevalues(end,:));
Sim1     = model(48: resolution :96,initialvalues,paramHepaRGB27);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGB27,pNames,sNames,Sim1.statevalues(end,:));
Sim2     = model(96: resolution :144,initialvalues,paramHepaRGB27);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGB27,pNames,sNames,Sim2.statevalues(end,:));
Sim3     = model(144: resolution :192,initialvalues,paramHepaRGB27);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGB27,pNames,sNames,Sim3.statevalues(end,:));
Sim4     = model(192: resolution :240,initialvalues,paramHepaRGB27);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGB27,pNames,sNames,Sim4.statevalues(end,:));
Sim5     = model(240: resolution :288,initialvalues,paramHepaRGB27);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGB27,pNames,sNames,Sim5.statevalues(end,:));
Sim6     = model(288: resolution :336,initialvalues,paramHepaRGB27);
[initialvalues] = SetInitialValues(11, 0, 0, 0,paramHepaRGB27,pNames,sNames,Sim6.statevalues(end,:));
Sim7     = model(336: resolution :384,initialvalues,paramHepaRGB27);
SimHepaRG.B27.time           = [Sim0.time(1:end-1)            ,Sim1.time(1:end-1),             Sim2.time(1:end-1),             Sim3.time(1:end-1),             Sim4.time(1:end-1),             Sim5.time(1:end-1),             Sim6.time(1:end-1),             Sim7.time(1:end-1),           ];
SimHepaRG.B27.variablevalues = [Sim0.variablevalues(1:end-1,:);Sim1.variablevalues(1:end-1,:); Sim2.variablevalues(1:end-1,:); Sim3.variablevalues(1:end-1,:); Sim4.variablevalues(1:end-1,:); Sim5.variablevalues(1:end-1,:); Sim6.variablevalues(1:end-1,:); Sim7.variablevalues(1:end-1,:)];
SimHepaRG.B27.reactionvalues = [Sim0.reactionvalues(1:end-1,:);Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues(1:end-1,:); Sim3.reactionvalues(1:end-1,:); Sim4.reactionvalues(1:end-1,:); Sim5.reactionvalues(1:end-1,:); Sim6.reactionvalues(1:end-1,:); Sim7.reactionvalues(1:end-1,:)];
SimHepaRG.B27.statevalues    = [Sim0.statevalues(1:end-1,:);   Sim1.statevalues(1:end-1,:);    Sim2.statevalues(1:end-1,:);    Sim3.statevalues(1:end-1,:);    Sim4.statevalues(1:end-1,:);    Sim5.statevalues(1:end-1,:);    Sim6.statevalues(1:end-1,:);    Sim7.statevalues(1:end-1,:);  ];
SimHepaRG.B27.variables      = [Sim1.variables];
SimHepaRG.B27.reactions      = [Sim1.reactions];
SimHepaRG.B27.states         = [Sim1.states];
else
    SimHepaRG = [];
end

end

