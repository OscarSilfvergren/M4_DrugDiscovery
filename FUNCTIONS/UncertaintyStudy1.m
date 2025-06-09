  
    if j == 1

        % Insulin - simStudy1_LCHG
        maxStudy1_Insulin_LCHG  = simStudy1_LCHG.statevalues(:,ismember(simStudy1_LCHG.states,'Insulin_Medium'));
        minStudy1_Insulin_LCHG  = maxStudy1_Insulin_LCHG;
        BestStudy1_Insulin_LCHG = maxStudy1_Insulin_LCHG;
        % Glucose - simStudy1_LCHG
        maxStudy1_Glucose_LCHG  = simStudy1_LCHG.statevalues(:,ismember(simStudy1_LCHG.states,'Glucose_Medium'));
        minStudy1_Glucose_LCHG  = maxStudy1_Glucose_LCHG;
        BestStudy1_Glucose_LCHG = maxStudy1_Glucose_LCHG;
        
        % Insulin - simStudy1_HCHG
        maxStudy1_Insulin_HCHG  = simStudy1_HCHG.statevalues(:,ismember(simStudy1_HCHG.states,'Insulin_Medium'));
        minStudy1_Insulin_HCHG  = maxStudy1_Insulin_HCHG;
        BestStudy1_Insulin_HCHG = maxStudy1_Insulin_HCHG;
        % Glucose - simStudy1_HCHG
        maxStudy1_Glucose_HCHG  = simStudy1_HCHG.statevalues(:,ismember(simStudy1_HCHG.states,'Glucose_Medium'));
        minStudy1_Glucose_HCHG  = maxStudy1_Glucose_HCHG;
        BestStudy1_Glucose_HCHG = maxStudy1_Glucose_HCHG;
        
        
    end
    
    % Insulin - simStudy1_LCHG
    NewStudy1_Insulin_LCHG = simStudy1_LCHG.statevalues(:,ismember(simStudy1_LCHG.states,'Insulin_Medium'));
    maxStudy1_Insulin_LCHG = max(maxStudy1_Insulin_LCHG,NewStudy1_Insulin_LCHG);
    minStudy1_Insulin_LCHG = min(minStudy1_Insulin_LCHG,NewStudy1_Insulin_LCHG);
    % Glucose - simStudy1_LCHG
    NewStudy1_Glucose_LCHG = simStudy1_LCHG.statevalues(:,ismember(simStudy1_LCHG.states,'Glucose_Medium'));
    maxStudy1_Glucose_LCHG = max(maxStudy1_Glucose_LCHG,NewStudy1_Glucose_LCHG);
    minStudy1_Glucose_LCHG = min(minStudy1_Glucose_LCHG,NewStudy1_Glucose_LCHG);
    
        % Insulin - simStudy1_HCHG
    NewStudy1_Insulin_HCHG = simStudy1_HCHG.statevalues(:,ismember(simStudy1_HCHG.states,'Insulin_Medium'));
    maxStudy1_Insulin_HCHG = max(maxStudy1_Insulin_HCHG,NewStudy1_Insulin_HCHG);
    minStudy1_Insulin_HCHG = min(minStudy1_Insulin_HCHG,NewStudy1_Insulin_HCHG);
    % Glucose - simStudy1_HCHG
    NewStudy1_Glucose_HCHG = simStudy1_HCHG.statevalues(:,ismember(simStudy1_HCHG.states,'Glucose_Medium'));
    maxStudy1_Glucose_HCHG = max(maxStudy1_Glucose_HCHG,NewStudy1_Glucose_HCHG);
    minStudy1_Glucose_HCHG = min(minStudy1_Glucose_HCHG,NewStudy1_Glucose_HCHG);
    