       %% GSIS

if j == 1
    % simExp7p3_GSIS
    maxInsulin_Exp8p3GSIS    = [simStudy12_GSIS.ULTd0(1),simStudy12_GSIS.ULTd0(2), simStudy12_GSIS.ULTd0(3)];
    minInsulin_Exp8p3GSIS    = maxInsulin_Exp8p3GSIS;
    BestInsulin_Exp8p3GSIS   = maxInsulin_Exp8p3GSIS;

end
% Insulin - Exp7p2GSISG0
NewInsulin_Exp8p3GSIS = [simStudy12_GSIS.ULTd0(1),simStudy12_GSIS.ULTd0(2), simStudy12_GSIS.ULTd0(3)];
maxInsulin_Exp8p3GSIS = max(maxInsulin_Exp8p3GSIS,NewInsulin_Exp8p3GSIS);
minInsulin_Exp8p3GSIS = min(minInsulin_Exp8p3GSIS,NewInsulin_Exp8p3GSIS);


%% Healthy

    if j == 1

   
        % Insulin - simExp8p2GSISG0
        maxStudy11_Insulin0  = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Insulin_Medium'));
        minStudy11_Insulin0  = maxStudy11_Insulin0;
        BestStudy11_Insulin0 = maxStudy11_Insulin0;
        % simStudy11GSISG11p1
        maxStudy11_Insulin0p1  = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Insulin_Medium'));
        minStudy11_Insulin0p1  = maxStudy11_Insulin0p1;
        BestStudy11_Insulin0p1 = maxStudy11_Insulin0p1;
        % simStudy11GSISG11p1E1
        maxStudy11_Insulin10  = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Insulin_Medium'));
        minStudy11_Insulin10  = maxStudy11_Insulin10;
        BestStudy11_Insulin10 = maxStudy11_Insulin10;
        
        % Glucose - simStudy11GSISG0
        maxStudy11_Glucose0  = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Glucose_Medium'));
        minStudy11_Glucose0  = maxStudy11_Glucose0;
        BestStudy11_Glucose0 = maxStudy11_Glucose0;
        % simStudy11GSISG11p1
        maxStudy11_Glucose0p1  = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Glucose_Medium'));
        minStudy11_Glucose0p1  = maxStudy11_Glucose0p1;
        BestStudy11_Glucose0p1 = maxStudy11_Glucose0p1;
        % simStudy11GSISG11p1E1
        maxStudy11_Glucose10  = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Glucose_Medium'));
        minStudy11_Glucose10  = maxStudy11_Glucose10;
        BestStudy11_Glucose10 = maxStudy11_Glucose10;
        
                % Lactate - simStudy11GSISG0
        maxStudy11_Lactate0  = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Lactate_Medium'));
        minStudy11_Lactate0  = maxStudy11_Lactate0;
        BestStudy11_Lactate0 = maxStudy11_Lactate0;
        % simStudy11GSISG11p1
        maxStudy11_Lactate0p1  = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Lactate_Medium'));
        minStudy11_Lactate0p1  = maxStudy11_Lactate0p1;
        BestStudy11_Lactate0p1 = maxStudy11_Lactate0p1;
        % simStudy11GSISG11p1E1
        maxStudy11_Lactate10  = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Lactate_Medium'));
        minStudy11_Lactate10  = maxStudy11_Lactate10;
        BestStudy11_Lactate10 = maxStudy11_Lactate10;
        
        % Exenatide - simStudy11GSISG0
        maxStudy11_Exenatide0  = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Exenatide_Medium'));
        minStudy11_Exenatide0  = maxStudy11_Exenatide0;
        BestStudy11_Exenatide0 = maxStudy11_Exenatide0;
        % simStudy11GSISG11p1
        maxStudy11_Exenatide0p1  = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Exenatide_Medium'));
        minStudy11_Exenatide0p1  = maxStudy11_Exenatide0p1;
        BestStudy11_Exenatide0p1 = maxStudy11_Exenatide0p1;
        % simStudy11GSISG11p1E1
        maxStudy11_Exenatide10  = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Exenatide_Medium'));
        minStudy11_Exenatide10  = maxStudy11_Exenatide10;
        BestStudy11_Exenatide10 = maxStudy11_Exenatide10;
        
    end
    
    % Insulin - simStudy11_Hcontrol
    NewStudy11_Insulin0 = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Insulin_Medium'));
    maxStudy11_Insulin0 = max(maxStudy11_Insulin0,NewStudy11_Insulin0);
    minStudy11_Insulin0 = min(minStudy11_Insulin0,NewStudy11_Insulin0);
    % simStudy11_H0p1
    NewStudy11_Insulin0p1 = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Insulin_Medium'));
    maxStudy11_Insulin0p1 = max(maxStudy11_Insulin0p1,NewStudy11_Insulin0p1);
    minStudy11_Insulin0p1 = min(minStudy11_Insulin0p1,NewStudy11_Insulin0p1);
    % simStudy11_H10
    NewStudy11_Insulin10 = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Insulin_Medium'));
    maxStudy11_Insulin10 = max(maxStudy11_Insulin10,NewStudy11_Insulin10);
    minStudy11_Insulin10 = min(minStudy11_Insulin10,NewStudy11_Insulin10);
    
    % Glucose - simStudy11_Hcontrol
    NewStudy11_Glucose0 = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Glucose_Medium'));
    maxStudy11_Glucose0 = max(maxStudy11_Glucose0,NewStudy11_Glucose0);
    minStudy11_Glucose0 = min(minStudy11_Glucose0,NewStudy11_Glucose0);
    % simStudy11_H0p1
    NewStudy11_Glucose0p1 = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Glucose_Medium'));
    maxStudy11_Glucose0p1 = max(maxStudy11_Glucose0p1,NewStudy11_Glucose0p1);
    minStudy11_Glucose0p1 = min(minStudy11_Glucose0p1,NewStudy11_Glucose0p1);
    % simStudy11_H10
    NewStudy11_Glucose10 = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Glucose_Medium'));
    maxStudy11_Glucose10 = max(maxStudy11_Glucose10,NewStudy11_Glucose10);
    minStudy11_Glucose10 = min(minStudy11_Glucose10,NewStudy11_Glucose10);
    
        % Lactate - simStudy11_Hcontrol
    NewStudy11_Lactate0 = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Lactate_Medium'));
    maxStudy11_Lactate0 = max(maxStudy11_Lactate0,NewStudy11_Lactate0);
    minStudy11_Lactate0 = min(minStudy11_Lactate0,NewStudy11_Lactate0);
    % simStudy11_H0p1
    NewStudy11_Lactate0p1 = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Lactate_Medium'));
    maxStudy11_Lactate0p1 = max(maxStudy11_Lactate0p1,NewStudy11_Lactate0p1);
    minStudy11_Lactate0p1 = min(minStudy11_Lactate0p1,NewStudy11_Lactate0p1);
    % simStudy11_H10
    NewStudy11_Lactate10 = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Lactate_Medium'));
    maxStudy11_Lactate10 = max(maxStudy11_Lactate10,NewStudy11_Lactate10);
    minStudy11_Lactate10 = min(minStudy11_Lactate10,NewStudy11_Lactate10);
    
    % Exenatide - simStudy11_Hcontrol
    NewStudy11_Exenatide0 = simStudy11_Hcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Exenatide_Medium'));
    maxStudy11_Exenatide0 = max(maxStudy11_Exenatide0,NewStudy11_Exenatide0);
    minStudy11_Exenatide0 = min(minStudy11_Exenatide0,NewStudy11_Exenatide0);
    % simStudy11_H0p1
    NewStudy11_Exenatide0p1 = simStudy11_H0p1.statevalues(:,ismember(simStudy11_H0p1.states,'Exenatide_Medium'));
    maxStudy11_Exenatide0p1 = max(maxStudy11_Exenatide0p1,NewStudy11_Exenatide0p1);
    minStudy11_Exenatide0p1 = min(minStudy11_Exenatide0p1,NewStudy11_Exenatide0p1);
    % simStudy11_H10
    NewStudy11_Exenatide10 = simStudy11_H10.statevalues(:,ismember(simStudy11_H10.states,'Exenatide_Medium'));
    maxStudy11_Exenatide10 = max(maxStudy11_Exenatide10,NewStudy11_Exenatide10);
    minStudy11_Exenatide10 = min(minStudy11_Exenatide10,NewStudy11_Exenatide10);
    

%% Diseased

    if j == 1

   
        % Insulin - simExp8p2GSISG0
        maxStudy11_Insulin0d  = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Dcontrol.states,'Insulin_Medium'));
        minStudy11_Insulin0d  = maxStudy11_Insulin0d;
        BestStudy11_Insulin0d = maxStudy11_Insulin0d;
        % simStudy11GSISG11p1
        maxStudy11_Insulin0p1d  = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Insulin_Medium'));
        minStudy11_Insulin0p1d  = maxStudy11_Insulin0p1d;
        BestStudy11_Insulin0p1d = maxStudy11_Insulin0p1d;
        % simStudy11GSISG11p1E1
        maxStudy11_Insulin10d  = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Insulin_Medium'));
        minStudy11_Insulin10d  = maxStudy11_Insulin10d;
        BestStudy11_Insulin10d = maxStudy11_Insulin10d;
        
        % Glucose - simStudy11GSISG0
        maxStudy11_Glucose0d  = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Dcontrol.states,'Glucose_Medium'));
        minStudy11_Glucose0d  = maxStudy11_Glucose0d;
        BestStudy11_Glucose0d = maxStudy11_Glucose0d;
        % simStudy11GSISG11p1
        maxStudy11_Glucose0p1d  = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Glucose_Medium'));
        minStudy11_Glucose0p1d  = maxStudy11_Glucose0p1d;
        BestStudy11_Glucose0p1d = maxStudy11_Glucose0p1d;
        % simStudy11GSISG11p1E1
        maxStudy11_Glucose10d  = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Glucose_Medium'));
        minStudy11_Glucose10d  = maxStudy11_Glucose10d;
        BestStudy11_Glucose10d = maxStudy11_Glucose10d;
        
                % Lactate - simStudy11GSISG0
        maxStudy11_Lactate0d  = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Dcontrol.states,'Lactate_Medium'));
        minStudy11_Lactate0d  = maxStudy11_Lactate0d;
        BestStudy11_Lactate0d = maxStudy11_Lactate0d;
        % simStudy11GSISG11p1
        maxStudy11_Lactate0p1d  = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Lactate_Medium'));
        minStudy11_Lactate0p1d  = maxStudy11_Lactate0p1d;
        BestStudy11_Lactate0p1d = maxStudy11_Lactate0p1d;
        % simStudy11GSISG11p1E1
        maxStudy11_Lactate10d  = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Lactate_Medium'));
        minStudy11_Lactate10d  = maxStudy11_Lactate10d;
        BestStudy11_Lactate10d = maxStudy11_Lactate10d;
        
        % Exenatide - simStudy11GSISG0
        maxStudy11_Exenatide0d  = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Dcontrol.states,'Exenatide_Medium'));
        minStudy11_Exenatide0d  = maxStudy11_Exenatide0d;
        BestStudy11_Exenatide0d = maxStudy11_Exenatide0d;
        % simStudy11GSISG11p1
        maxStudy11_Exenatide0p1d  = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Exenatide_Medium'));
        minStudy11_Exenatide0p1d  = maxStudy11_Exenatide0p1d;
        BestStudy11_Exenatide0p1d = maxStudy11_Exenatide0p1d;
        % simStudy11GSISG11p1E1
        maxStudy11_Exenatide10d  = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Exenatide_Medium'));
        minStudy11_Exenatide10d  = maxStudy11_Exenatide10d;
        BestStudy11_Exenatide10d = maxStudy11_Exenatide10d;
        
    end
    
    % Insulin - simStudy11_Dcontrol
    NewStudy11_Insulin0d = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Hcontrol.states,'Insulin_Medium'));
    maxStudy11_Insulin0d = max(maxStudy11_Insulin0d,NewStudy11_Insulin0d);
    minStudy11_Insulin0d = min(minStudy11_Insulin0d,NewStudy11_Insulin0d);
    % simStudy11_D0p1
    NewStudy11_Insulin0p1d = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Insulin_Medium'));
    maxStudy11_Insulin0p1d = max(maxStudy11_Insulin0p1d,NewStudy11_Insulin0p1d);
    minStudy11_Insulin0p1d = min(minStudy11_Insulin0p1d,NewStudy11_Insulin0p1d);
    % simStudy11_D10
    NewStudy11_Insulin10d = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Insulin_Medium'));
    maxStudy11_Insulin10d = max(maxStudy11_Insulin10d,NewStudy11_Insulin10d);
    minStudy11_Insulin10d = min(minStudy11_Insulin10d,NewStudy11_Insulin10d);
    
    % Glucose - simStudy11_Dcontrol
    NewStudy11_Glucose0d = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Dcontrol.states,'Glucose_Medium'));
    maxStudy11_Glucose0d = max(maxStudy11_Glucose0d,NewStudy11_Glucose0d);
    minStudy11_Glucose0d = min(minStudy11_Glucose0d,NewStudy11_Glucose0d);
    % simStudy11_D0p1
    NewStudy11_Glucose0p1d = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Glucose_Medium'));
    maxStudy11_Glucose0p1d = max(maxStudy11_Glucose0p1d,NewStudy11_Glucose0p1d);
    minStudy11_Glucose0p1d = min(minStudy11_Glucose0p1d,NewStudy11_Glucose0p1d);
    % simStudy11_D10
    NewStudy11_Glucose10d = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Glucose_Medium'));
    maxStudy11_Glucose10d = max(maxStudy11_Glucose10d,NewStudy11_Glucose10d);
    minStudy11_Glucose10d = min(minStudy11_Glucose10d,NewStudy11_Glucose10d);
    
        % Lactate - simStudy11_Dcontrol
    NewStudy11_Lactate0d = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Dcontrol.states,'Lactate_Medium'));
    maxStudy11_Lactate0d = max(maxStudy11_Lactate0d,NewStudy11_Lactate0d);
    minStudy11_Lactate0d = min(minStudy11_Lactate0d,NewStudy11_Lactate0d);
    % simStudy11_D0p1
    NewStudy11_Lactate0p1d = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Lactate_Medium'));
    maxStudy11_Lactate0p1d = max(maxStudy11_Lactate0p1d,NewStudy11_Lactate0p1d);
    minStudy11_Lactate0p1d = min(minStudy11_Lactate0p1d,NewStudy11_Lactate0p1d);
    % simStudy11_D10
    NewStudy11_Lactate10d = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Lactate_Medium'));
    maxStudy11_Lactate10d = max(maxStudy11_Lactate10d,NewStudy11_Lactate10d);
    minStudy11_Lactate10d = min(minStudy11_Lactate10d,NewStudy11_Lactate10d);
    
    % Exenatide - simStudy11_Dcontrol
    NewStudy11_Exenatide0d = simStudy11_Dcontrol.statevalues(:,ismember(simStudy11_Dcontrol.states,'Exenatide_Medium'));
    maxStudy11_Exenatide0d = max(maxStudy11_Exenatide0d,NewStudy11_Exenatide0d);
    minStudy11_Exenatide0d = min(minStudy11_Exenatide0d,NewStudy11_Exenatide0d);
    % simStudy11_D0p1
    NewStudy11_Exenatide0p1d = simStudy11_D0p1.statevalues(:,ismember(simStudy11_D0p1.states,'Exenatide_Medium'));
    maxStudy11_Exenatide0p1d = max(maxStudy11_Exenatide0p1d,NewStudy11_Exenatide0p1d);
    minStudy11_Exenatide0p1d = min(minStudy11_Exenatide0p1d,NewStudy11_Exenatide0p1d);
    % simStudy11_D10
    NewStudy11_Exenatide10d = simStudy11_D10.statevalues(:,ismember(simStudy11_D10.states,'Exenatide_Medium'));
    maxStudy11_Exenatide10d = max(maxStudy11_Exenatide10d,NewStudy11_Exenatide10d);
    minStudy11_Exenatide10d = min(minStudy11_Exenatide10d,NewStudy11_Exenatide10d);

