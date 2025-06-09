%% GSIS

if j == 1
    
    % Glucose response curve
    maxInsulin_BH5refGR    = simBH5ref_GSIS.GR./simBH5ref_GSIS.GR(1);
    minInsulin_BH5refGR    = maxInsulin_BH5refGR;
    BestInsulin_BH5refGR   = maxInsulin_BH5refGR;
    % Exenatide response curve
    maxInsulin_BH5refER    = simBH5ref_GSIS.ER./simBH5ref_GSIS.ER(1);
    minInsulin_BH5refER    = maxInsulin_BH5refER;
    BestInsulin_BH5refER   = maxInsulin_BH5refER;
    
    % D0
    maxInsulin_BH5refD0    = simBH5ref_GSIS.ULTD0./simBH5ref_GSIS.ULTD0(1);
    minInsulin_BH5refD0    = maxInsulin_BH5refD0;
    BestInsulin_BH5refD0   = maxInsulin_BH5refD0;
    % D14
    maxInsulin_BH5refD14    = simBH5ref_GSIS.ULTD7./simBH5ref_GSIS.ULTD0(1);
    minInsulin_BH5refD14    = maxInsulin_BH5refD14;
    BestInsulin_BH5refD14   = maxInsulin_BH5refD14;
        % D21
    maxInsulin_BH5refD21    = simBH5ref_GSIS.ULTD14./simBH5ref_GSIS.ULTD0(1);
    minInsulin_BH5refD21    = maxInsulin_BH5refD21;
    BestInsulin_BH5refD21   = maxInsulin_BH5refD21;
        % D28
    maxInsulin_BH5refD28    = simBH5ref_GSIS.ULTD21./simBH5ref_GSIS.ULTD0(1);
    minInsulin_BH5refD28    = maxInsulin_BH5refD28;
    BestInsulin_BH5refD28   = maxInsulin_BH5refD28;

end

% Insulin - Exp7p2GSISG0
NewInsulin_BH5refGR = simBH5ref_GSIS.GR./simBH5ref_GSIS.GR(1);
maxInsulin_BH5refGR = max(maxInsulin_BH5refGR,NewInsulin_BH5refGR);
minInsulin_BH5refGR = min(minInsulin_BH5refGR,NewInsulin_BH5refGR);
% Insulin - Exp7p2GSISG0
NewInsulin_BH5refER = simBH5ref_GSIS.ER./simBH5ref_GSIS.ER(1);
maxInsulin_BH5refER = max(maxInsulin_BH5refER,NewInsulin_BH5refER);
minInsulin_BH5refER = min(minInsulin_BH5refER,NewInsulin_BH5refER);

% Insulin - D0
NewInsulin_BH5refD0 = simBH5ref_GSIS.ULTD0./simBH5ref_GSIS.ULTD0(1);
maxInsulin_BH5refD0 = max(maxInsulin_BH5refD0,NewInsulin_BH5refD0);
minInsulin_BH5refD0 = min(minInsulin_BH5refD0,NewInsulin_BH5refD0);
% Insulin - D14
NewInsulin_BH5refD14 = simBH5ref_GSIS.ULTD7./simBH5ref_GSIS.ULTD0(1);
maxInsulin_BH5refD14 = max(maxInsulin_BH5refD14,NewInsulin_BH5refD14);
minInsulin_BH5refD14 = min(minInsulin_BH5refD14,NewInsulin_BH5refD14);
% Insulin - D21
NewInsulin_BH5refD21 = simBH5ref_GSIS.ULTD14./simBH5ref_GSIS.ULTD0(1);
maxInsulin_BH5refD21 = max(maxInsulin_BH5refD21,NewInsulin_BH5refD21);
minInsulin_BH5refD21 = min(minInsulin_BH5refD21,NewInsulin_BH5refD21);
% Insulin - D28
NewInsulin_BH5refD28 = simBH5ref_GSIS.ULTD21./simBH5ref_GSIS.ULTD0(1);
maxInsulin_BH5refD28 = max(maxInsulin_BH5refD28,NewInsulin_BH5refD28);
minInsulin_BH5refD28 = min(minInsulin_BH5refD28,NewInsulin_BH5refD28);

