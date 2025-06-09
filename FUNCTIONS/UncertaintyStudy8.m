  %% GSIS
  
        if j == 1
          % simStudy8_GSIS
        maxInsulin_Study8GR    = simStudy8_GSIS.SaveInsulinSecretionGlucose;
        minInsulin_Study8GR    = maxInsulin_Study8GR;
        BestInsulin_Study8GR   = maxInsulin_Study8GR;
          % simStudy8_GSIS
        maxInsulin_Study8ER    = simStudy8_GSIS.SaveInsulinSecretionExenatide;
        minInsulin_Study8ER    = maxInsulin_Study8ER;
        BestInsulin_Study8ER   = maxInsulin_Study8ER;
        end
    % Insulin - Exp7p2GSISG0
NewInsulin_Study8GR = simStudy8_GSIS.SaveInsulinSecretionGlucose;
maxInsulin_Study8GR = max(maxInsulin_Study8GR,NewInsulin_Study8GR);
minInsulin_Study8GR = min(minInsulin_Study8GR,NewInsulin_Study8GR);
    % Insulin - Exp7p2GSISG0
NewInsulin_Study8ER = simStudy8_GSIS.SaveInsulinSecretionExenatide;
maxInsulin_Study8ER = max(maxInsulin_Study8ER,NewInsulin_Study8ER);
minInsulin_Study8ER = min(minInsulin_Study8ER,NewInsulin_Study8ER);