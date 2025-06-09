  
    if j == 1

        % Insulin - B27
        maxStudy3_InsulinB27  = simStudy3_B27.statevalues(:,ismember(simStudy3_B27.states,'Insulin_Medium'));
        minStudy3_InsulinB27  = maxStudy3_InsulinB27;
        BestStudy3_InsulinB27 = maxStudy3_InsulinB27;
        % Glucose - simStudy3_B27GSISGB27
        maxStudy3_GlucoseB27  = simStudy3_B27.statevalues(:,ismember(simStudy3_B27.states,'Glucose_Medium'));
        minStudy3_GlucoseB27  = maxStudy3_GlucoseB27;
        BestStudy3_GlucoseB27 = maxStudy3_GlucoseB27;
                % Lactate - simStudy3_B27GSISGB27
        maxStudy3_LactateB27  = simStudy3_B27.statevalues(:,ismember(simStudy3_B27.states,'Lactate_Medium'));
        minStudy3_LactateB27  = maxStudy3_LactateB27;
        BestStudy3_LactateB27 = maxStudy3_LactateB27;
        
                % Insulin - B27
        maxStudy3_InsulinFCS  = simStudy3_FCS.statevalues(:,ismember(simStudy3_FCS.states,'Insulin_Medium'));
        minStudy3_InsulinFCS  = maxStudy3_InsulinFCS;
        BestStudy3_InsulinFCS = maxStudy3_InsulinFCS;
        % Glucose - simStudy3_FCSGSISGFCS
        maxStudy3_GlucoseFCS  = simStudy3_FCS.statevalues(:,ismember(simStudy3_FCS.states,'Glucose_Medium'));
        minStudy3_GlucoseFCS  = maxStudy3_GlucoseFCS;
        BestStudy3_GlucoseFCS = maxStudy3_GlucoseFCS;
                % Lactate - simStudy3_FCSGSISGFCS
        maxStudy3_LactateFCS  = simStudy3_FCS.statevalues(:,ismember(simStudy3_FCS.states,'Lactate_Medium'));
        minStudy3_LactateFCS  = maxStudy3_LactateFCS;
        BestStudy3_LactateFCS = maxStudy3_LactateFCS;

    end
    
    % Insulin - simStudy3_B27
    NewStudy3_InsulinB27 = simStudy3_B27.statevalues(:,ismember(simStudy3_B27.states,'Insulin_Medium'));
    maxStudy3_InsulinB27 = max(maxStudy3_InsulinB27,NewStudy3_InsulinB27);
    minStudy3_InsulinB27 = min(minStudy3_InsulinB27,NewStudy3_InsulinB27);
    % Glucose - simStudy3_B27
    NewStudy3_GlucoseB27 = simStudy3_B27.statevalues(:,ismember(simStudy3_B27.states,'Glucose_Medium'));
    maxStudy3_GlucoseB27 = max(maxStudy3_GlucoseB27,NewStudy3_GlucoseB27);
    minStudy3_GlucoseB27 = min(minStudy3_GlucoseB27,NewStudy3_GlucoseB27);
        % Lactate - simStudy3_B27
    NewStudy3_LactateB27 = simStudy3_B27.statevalues(:,ismember(simStudy3_B27.states,'Lactate_Medium'));
    maxStudy3_LactateB27 = max(maxStudy3_LactateB27,NewStudy3_LactateB27);
    minStudy3_LactateB27 = min(minStudy3_LactateB27,NewStudy3_LactateB27);
    
        % Insulin - simStudy3_B27
    NewStudy3_InsulinFCS = simStudy3_FCS.statevalues(:,ismember(simStudy3_FCS.states,'Insulin_Medium'));
    maxStudy3_InsulinFCS = max(maxStudy3_InsulinFCS,NewStudy3_InsulinFCS);
    minStudy3_InsulinFCS = min(minStudy3_InsulinFCS,NewStudy3_InsulinFCS);
    % Glucose - simStudy3_FCS
    NewStudy3_GlucoseFCS = simStudy3_FCS.statevalues(:,ismember(simStudy3_FCS.states,'Glucose_Medium'));
    maxStudy3_GlucoseFCS = max(maxStudy3_GlucoseFCS,NewStudy3_GlucoseFCS);
    minStudy3_GlucoseFCS = min(minStudy3_GlucoseFCS,NewStudy3_GlucoseFCS);
        % Lactate - simStudy3_FCS
    NewStudy3_LactateFCS = simStudy3_FCS.statevalues(:,ismember(simStudy3_FCS.states,'Lactate_Medium'));
    maxStudy3_LactateFCS = max(maxStudy3_LactateFCS,NewStudy3_LactateFCS);
    minStudy3_LactateFCS = min(minStudy3_LactateFCS,NewStudy3_LactateFCS);

