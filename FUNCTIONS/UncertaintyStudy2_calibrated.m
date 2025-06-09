  
    if j == 1

        % Insulin - simStudy1_LCHG
        maxStudy2calibrated_Insulin_LCHG  = simStudy2calibrated_LCHG.statevalues(:,ismember(simStudy2calibrated_LCHG.states,'Insulin_Medium'));
        minStudy2calibrated_Insulin_LCHG  = maxStudy2calibrated_Insulin_LCHG;
        BestStudy2calibrated_Insulin_LCHG = maxStudy2calibrated_Insulin_LCHG;
        % Glucose - simStudy2calibrated_LCHG
        maxStudy2calibrated_Glucose_LCHG  = simStudy2calibrated_LCHG.statevalues(:,ismember(simStudy2calibrated_LCHG.states,'Glucose_Medium'));
        minStudy2calibrated_Glucose_LCHG  = maxStudy2calibrated_Glucose_LCHG;
        BestStudy2calibrated_Glucose_LCHG = maxStudy2calibrated_Glucose_LCHG;
        
        % Insulin - simStudy2calibrated_HCHG
        maxStudy2calibrated_Insulin_HCHG  = simStudy2calibrated_HCHG.statevalues(:,ismember(simStudy2calibrated_HCHG.states,'Insulin_Medium'));
        minStudy2calibrated_Insulin_HCHG  = maxStudy2calibrated_Insulin_HCHG;
        BestStudy2calibrated_Insulin_HCHG = maxStudy2calibrated_Insulin_HCHG;
        % Glucose - simStudy2calibrated_HCHG
        maxStudy2calibrated_Glucose_HCHG  = simStudy2calibrated_HCHG.statevalues(:,ismember(simStudy2calibrated_HCHG.states,'Glucose_Medium'));
        minStudy2calibrated_Glucose_HCHG  = maxStudy2calibrated_Glucose_HCHG;
        BestStudy2calibrated_Glucose_HCHG = maxStudy2calibrated_Glucose_HCHG;
        
        
    end
    
    % Insulin - simStudy2calibrated_LCHG
    NewStudy2calibrated_Insulin_LCHG = simStudy2calibrated_LCHG.statevalues(:,ismember(simStudy2calibrated_LCHG.states,'Insulin_Medium'));
    maxStudy2calibrated_Insulin_LCHG = max(maxStudy2calibrated_Insulin_LCHG,NewStudy2calibrated_Insulin_LCHG);
    minStudy2calibrated_Insulin_LCHG = min(minStudy2calibrated_Insulin_LCHG,NewStudy2calibrated_Insulin_LCHG);
    % Glucose - simStudy2calibrated_LCHG
    NewStudy2calibrated_Glucose_LCHG = simStudy2calibrated_LCHG.statevalues(:,ismember(simStudy2calibrated_LCHG.states,'Glucose_Medium'));
    maxStudy2calibrated_Glucose_LCHG = max(maxStudy2calibrated_Glucose_LCHG,NewStudy2calibrated_Glucose_LCHG);
    minStudy2calibrated_Glucose_LCHG = min(minStudy2calibrated_Glucose_LCHG,NewStudy2calibrated_Glucose_LCHG);
    
        % Insulin - simStudy2calibrated_HCHG
    NewStudy2calibrated_Insulin_HCHG = simStudy2calibrated_HCHG.statevalues(:,ismember(simStudy2calibrated_HCHG.states,'Insulin_Medium'));
    maxStudy2calibrated_Insulin_HCHG = max(maxStudy2calibrated_Insulin_HCHG,NewStudy2calibrated_Insulin_HCHG);
    minStudy2calibrated_Insulin_HCHG = min(minStudy2calibrated_Insulin_HCHG,NewStudy2calibrated_Insulin_HCHG);
    % Glucose - simStudy2calibrated_HCHG
    NewStudy2calibrated_Glucose_HCHG = simStudy2calibrated_HCHG.statevalues(:,ismember(simStudy2calibrated_HCHG.states,'Glucose_Medium'));
    maxStudy2calibrated_Glucose_HCHG = max(maxStudy2calibrated_Glucose_HCHG,NewStudy2calibrated_Glucose_HCHG);
    minStudy2calibrated_Glucose_HCHG = min(minStudy2calibrated_Glucose_HCHG,NewStudy2calibrated_Glucose_HCHG);
    