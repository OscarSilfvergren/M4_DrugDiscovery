%% GSIS

if j == 1
    % simExp7p3_GSIS
    maxInsulin_Study10GR    = simStudy10_GSIS.GR;
    minInsulin_Study10GR    = maxInsulin_Study10GR;
    BestInsulin_Study10GR   = maxInsulin_Study10GR;
    % simStudy10_GSIS
    maxInsulin_Study10ER    = simStudy10_GSIS.ER;
    minInsulin_Study10ER    = maxInsulin_Study10ER;
    BestInsulin_Study10ER   = maxInsulin_Study10ER;
    
    % Insulin - G0
    maxInsulin_Study10_G0  = simStudy10_GSIS.simULTd0_G0.statevalues(:,ismember(simStudy10_GSIS.simULTd0_G0.states,'Insulin_Medium'));
    minInsulin_Study10_G0  = maxInsulin_Study10_G0;
    BestInsulin_Study10_G0 = maxInsulin_Study10_G0;
    % G5p5E1
    maxInsulin_Study10_G5p5E1  = simStudy10_GSIS.simULTd0_G5p5E1.statevalues(:,ismember(simStudy10_GSIS.simULTd0_G5p5E1.states,'Insulin_Medium'));
    minInsulin_Study10_G5p5E1  = maxInsulin_Study10_G5p5E1;
    BestInsulin_Study10_G5p5E1 = maxInsulin_Study10_G5p5E1;
        % G20E1
    maxInsulin_Study10_G20E1  = simStudy10_GSIS.simULTd0_G20E1.statevalues(:,ismember(simStudy10_GSIS.simULTd0_G20E1.states,'Insulin_Medium'));
    minInsulin_Study10_G20E1  = maxInsulin_Study10_G20E1;
    BestInsulin_Study10_G20E1 = maxInsulin_Study10_G20E1;
end
% Insulin - Exp7p2GSISG0
NewInsulin_Study10GR = simStudy10_GSIS.GR;
maxInsulin_Study10GR = max(maxInsulin_Study10GR,NewInsulin_Study10GR);
minInsulin_Study10GR = min(minInsulin_Study10GR,NewInsulin_Study10GR);
% Insulin - Exp7p2GSISG0
NewInsulin_Study10ER = simStudy10_GSIS.ER;
maxInsulin_Study10ER = max(maxInsulin_Study10ER,NewInsulin_Study10ER);
minInsulin_Study10ER = min(minInsulin_Study10ER,NewInsulin_Study10ER);

% Insulin - G0E0
NewInsulin_Study10_G0 = simStudy10_GSIS.simULTd0_G0.statevalues(:,ismember(simStudy10_GSIS.simULTd0_G0.states,'Insulin_Medium'));
maxInsulin_Study10_G0 = max(maxInsulin_Study10_G0,NewInsulin_Study10_G0);
minInsulin_Study10_G0 = min(minInsulin_Study10_G0,NewInsulin_Study10_G0);
% Insulin - G5p5E1
NewInsulin_Study10_G5p5E1 = simStudy10_GSIS.simULTd0_G5p5E1.statevalues(:,ismember(simStudy10_GSIS.simULTd0_G5p5E1.states,'Insulin_Medium'));
maxInsulin_Study10_G5p5E1 = max(maxInsulin_Study10_G5p5E1,NewInsulin_Study10_G5p5E1);
minInsulin_Study10_G5p5E1 = min(minInsulin_Study10_G5p5E1,NewInsulin_Study10_G5p5E1);
% Insulin - G20E1
NewInsulin_Study10_G20E1 = simStudy10_GSIS.simULTd0_G20E1.statevalues(:,ismember(simStudy10_GSIS.simULTd0_G20E1.states,'Insulin_Medium'));
maxInsulin_Study10_G20E1 = max(maxInsulin_Study10_G20E1,NewInsulin_Study10_G20E1);
minInsulin_Study10_G20E1 = min(minInsulin_Study10_G20E1,NewInsulin_Study10_G20E1);

%% chip

if j == 1
    % Insulin - simExp8p1_control
    maxInsulin_Study9_control  = simStudy9_control.statevalues(:,ismember(simStudy9_control.states,'Insulin_Medium'));
    minInsulin_Study9_control  = maxInsulin_Study9_control;
    BestInsulin_Study9_control = maxInsulin_Study9_control;
    % simStudy9_0p1
    maxInsulin_Study9_0p1  = simStudy9_0p1.statevalues(:,ismember(simStudy9_0p1.states,'Insulin_Medium'));
    minInsulin_Study9_0p1  = maxInsulin_Study9_0p1;
    BestInsulin_Study9_0p1 = maxInsulin_Study9_0p1;
    % simStudy9_10
    maxInsulin_Study9_10  = simStudy9_10.statevalues(:,ismember(simStudy9_10.states,'Insulin_Medium'));
    minInsulin_Study9_10  = maxInsulin_Study9_10;
    BestInsulin_Study9_10 = maxInsulin_Study9_10;
end
% Insulin Vehicle
NewInsulin_Study9_control = simStudy9_control.statevalues(:,ismember(simStudy9_control.states,'Insulin_Medium'));
maxInsulin_Study9_control = max(maxInsulin_Study9_control,NewInsulin_Study9_control);
minInsulin_Study9_control = min(minInsulin_Study9_control,NewInsulin_Study9_control);
% 0.1nM
NewInsulin_Study9_0p1 = simStudy9_0p1.statevalues(:,ismember(simStudy9_0p1.states,'Insulin_Medium'));
maxInsulin_Study9_0p1 = max(maxInsulin_Study9_0p1,NewInsulin_Study9_0p1);
minInsulin_Study9_0p1 = min(minInsulin_Study9_0p1,NewInsulin_Study9_0p1);
%  10nM
NewInsulin_Study9_10 = simStudy9_10.statevalues(:,ismember(simStudy9_10.states,'Insulin_Medium'));
maxInsulin_Study9_10 = max(maxInsulin_Study9_10,NewInsulin_Study9_10);
minInsulin_Study9_10 = min(minInsulin_Study9_10,NewInsulin_Study9_10);


if j == 1

    % Pancreatic - simStudy9_control
    maxINInsulin_Study9_control  = simStudy9_control.statevalues(:,ismember(simStudy9_control.states,'Insulin_islets'));
    minINInsulin_Study9_control  = maxInsulin_Study9_control;
    BesINtInsulin_Study9_control = maxInsulin_Study9_control;
        % simStudy9_0p1
    maxINInsulin_Study9_0p1  = simStudy9_0p1.statevalues(:,ismember(simStudy9_0p1.states,'Insulin_islets'));
    minINInsulin_Study9_0p1  = maxInsulin_Study9_0p1;
    BestINInsulin_Study9_0p1 = maxInsulin_Study9_0p1;
    % simStudy9_10
    maxINInsulin_Study9_10  = simStudy9_10.statevalues(:,ismember(simStudy9_10.states,'Insulin_islets'));
    minINInsulin_Study9_10  = maxInsulin_Study9_10;
    BestINInsulin_Study9_10 = maxInsulin_Study9_10;

end
% Insulin Vehicle
NewINInsulin_Study9_control = simStudy9_control.statevalues(:,ismember(simStudy9_control.states,'Insulin_Medium'));
maxINInsulin_Study9_control = max(maxINInsulin_Study9_control,NewINInsulin_Study9_control);
minINInsulin_Study9_control = min(minINInsulin_Study9_control,NewINInsulin_Study9_control);
%  0.1 nM
NewINInsulin_Study9_0p1 = simStudy9_0p1.statevalues(:,ismember(simStudy9_0p1.states,'Insulin_Medium'));
maxINInsulin_Study9_0p1 = max(maxINInsulin_Study9_0p1,NewINInsulin_Study9_0p1);
minINInsulin_Study9_0p1 = min(minINInsulin_Study9_0p1,NewINInsulin_Study9_0p1);
%  10nM
NewINInsulin_Study9_10 = simStudy9_10.statevalues(:,ismember(simStudy9_10.states,'Insulin_Medium'));
maxINInsulin_Study9_10 = max(maxINInsulin_Study9_10,NewINInsulin_Study9_10);
minINInsulin_Study9_10 = min(minINInsulin_Study9_10,NewINInsulin_Study9_10);


