
%% PK
if j == 1
    
    % IV
    maxExenatideIV_50  = simIV_50.statevalues(:,ismember(simIV_50.states,'C1'));
    minExenatideIV_50  = maxExenatideIV_50;
    BestExenatideIV_50 = simIV_50;
    % 5
    maxExenatideIV_5  = simIV_5.statevalues(:,ismember(simIV_5.states,'C1'));
    minExenatideIV_5  = maxExenatideIV_5;
    BestExenatideIV_5 = simIV_5;
    % 50
    maxExenatideIV_0p5  = simIV_0p5.statevalues(:,ismember(simIV_0p5.states,'C1'));
    minExenatideIV_0p5  = maxExenatideIV_0p5;
    BestExenatideIV_0p5 = simIV_0p5;
    
    % IV
    maxExenatideIVtransfusion_50  = simIVtransfusion_50.statevalues(:,ismember(simIVtransfusion_50.states,'C1'));
    minExenatideIVtransfusion_50  = maxExenatideIVtransfusion_50;
    BestExenatideIVtransfusion_50 = maxExenatideIVtransfusion_50;
    % 5
    maxExenatideIVtransfusion_5  = simIVtransfusion_5.statevalues(:,ismember(simIVtransfusion_5.states,'C1'));
    minExenatideIVtransfusion_5  = maxExenatideIVtransfusion_5;
    BestExenatideIVtransfusion_5 = maxExenatideIVtransfusion_5;
    % 50
    maxExenatideIVtransfusion_0p5  = simIVtransfusion_0p5.statevalues(:,ismember(simIVtransfusion_0p5.states,'C1'));
    minExenatideIVtransfusion_0p5  = maxExenatideIVtransfusion_0p5;
    BestExenatideIVtransfusion_0p5 = maxExenatideIVtransfusion_0p5;
    
    % SC
    maxExenatideSC_50  = simSC_50.statevalues(:,ismember(simSC_50.states,'C1'));
    minExenatideSC_50  = maxExenatideSC_50;
    BestExenatideSC_50 = maxExenatideSC_50;
    % 5
    maxExenatideSC_5  = simSC_5.statevalues(:,ismember(simSC_5.states,'C1'));
    minExenatideSC_5  = maxExenatideSC_5;
    BestExenatideSC_5 = maxExenatideSC_5;
    % 50
    maxExenatideSC_0p5  = simSC_0p5.statevalues(:,ismember(simSC_0p5.states,'C1'));
    minExenatideSC_0p5  = maxExenatideSC_0p5;
    BestExenatideSC_0p5 = maxExenatideSC_0p5;
    
    %
    
end

% 30
NewExenatideIV_50 = simIV_50.statevalues(:,ismember(simIV_50.states,'C1'));
maxExenatideIV_50 = max(maxExenatideIV_50,NewExenatideIV_50);
minExenatideIV_50 = min(minExenatideIV_50,NewExenatideIV_50);
%  3
NewExenatideIV_5 = simIV_5.statevalues(:,ismember(simIV_5.states,'C1'));
maxExenatideIV_5 = max(maxExenatideIV_5,NewExenatideIV_5);
minExenatideIV_5 = min(minExenatideIV_5,NewExenatideIV_5);
% IV 0
NewExenatideIV_0p5 = simIV_0p5.statevalues(:,ismember(simIV_0p5.states,'C1'));
maxExenatideIV_0p5 = max(maxExenatideIV_0p5,NewExenatideIV_0p5);
minExenatideIV_0p5 = min(minExenatideIV_0p5,NewExenatideIV_0p5);

% 30
NewExenatideIVtransfusion_50 = simIVtransfusion_50.statevalues(:,ismember(simIVtransfusion_50.states,'C1'));
maxExenatideIVtransfusion_50 = max(maxExenatideIVtransfusion_50,NewExenatideIVtransfusion_50);
minExenatideIVtransfusion_50 = min(minExenatideIVtransfusion_50,NewExenatideIVtransfusion_50);
%  3
NewExenatideIVtransfusion_5 = simIVtransfusion_5.statevalues(:,ismember(simIVtransfusion_5.states,'C1'));
maxExenatideIVtransfusion_5 = max(maxExenatideIVtransfusion_5,NewExenatideIVtransfusion_5);
minExenatideIVtransfusion_5 = min(minExenatideIVtransfusion_5,NewExenatideIVtransfusion_5);
% IVtransfusion 0
NewExenatideIVtransfusion_0p5 = simIVtransfusion_0p5.statevalues(:,ismember(simIVtransfusion_0p5.states,'C1'));
maxExenatideIVtransfusion_0p5 = max(maxExenatideIVtransfusion_0p5,NewExenatideIVtransfusion_0p5);
minExenatideIVtransfusion_0p5 = min(minExenatideIVtransfusion_0p5,NewExenatideIVtransfusion_0p5);

% 30
NewExenatideSC_50 = simSC_50.statevalues(:,ismember(simSC_50.states,'C1'));
maxExenatideSC_50 = max(maxExenatideSC_50,NewExenatideSC_50);
minExenatideSC_50 = min(minExenatideSC_50,NewExenatideSC_50);
%  3
NewExenatideSC_5 = simSC_5.statevalues(:,ismember(simSC_5.states,'C1'));
maxExenatideSC_5 = max(maxExenatideSC_5,NewExenatideSC_5);
minExenatideSC_5 = min(minExenatideSC_5,NewExenatideSC_5);
% SC 0
NewExenatideSC_0p5 = simSC_0p5.statevalues(:,ismember(simSC_0p5.states,'C1'));
maxExenatideSC_0p5 = max(maxExenatideSC_0p5,NewExenatideSC_0p5);
minExenatideSC_0p5 = min(minExenatideSC_0p5,NewExenatideSC_0p5);

%% PD
if SimulatePD == 1
    
    % Cost
    DatapointsSampleFromSimulation = round(Gao2011Rat_data.Time+30,2) + 1;
    simI       = simRatpd_vehicle.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_vehicle.variables,'I'));
    CostI0      = ((Gao2011Rat_data.insulinMean_0 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_0,mean(Gao2011Rat_data.insulinSEM_0,'omitnan')).^2);
    simI       = simRatpd_3.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_3.variables,'I'));
    CostI3      = ((Gao2011Rat_data.insulinMean_3 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_3,mean(Gao2011Rat_data.insulinSEM_3,'omitnan')).^2);
    simI       = simRatpd_30.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_30.variables,'I'));
    CostI30      = ((Gao2011Rat_data.insulinMean_30 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_30,mean(Gao2011Rat_data.insulinSEM_30,'omitnan')).^2);
    simI       = simRatpd_300.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_300.variables,'I'));
    CostI300      = ((Gao2011Rat_data.insulinMean_300 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_300,mean(Gao2011Rat_data.insulinSEM_300,'omitnan')).^2);
    simI       = simRatpd_3000.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_3000.variables,'I'));
    CostI3000      = ((Gao2011Rat_data.insulinMean_3000 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_3000,mean(Gao2011Rat_data.insulinSEM_3000,'omitnan')).^2);
    Cost_PD_I = sum(CostI0,'omitnan') + sum(CostI3,'omitnan') + sum(CostI30,'omitnan') + sum(CostI300,'omitnan') + sum(CostI3000,'omitnan');
    if j == 1
    Cost_InsulinLow  = Cost_PD_I;
    end
    Cost_InsulinLow  = min(Cost_InsulinLow,Cost_PD_I);
    
% Glucose
if j == 1
    maxGaoG_Vehicle  = simRatpd_vehicle.variablevalues(:,ismember(simRatpd_vehicle.variables,'G'));
    minGaoG_Vehicle  = maxGaoG_Vehicle;
    BestGaoG_Vehicle = maxGaoG_Vehicle;
    maxGaoG_3  = simRatpd_3.variablevalues(:,ismember(simRatpd_3.variables,'G'));
    minGaoG_3  = maxGaoG_3;
    BestGaoG_3 = maxGaoG_3;
    maxGaoG_30  = simRatpd_30.variablevalues(:,ismember(simRatpd_30.variables,'G'));
    minGaoG_30  = maxGaoG_30;
    BestGaoG_30 = maxGaoG_30;
    maxGaoG_300  = simRatpd_300.variablevalues(:,ismember(simRatpd_300.variables,'G'));
    minGaoG_300  = maxGaoG_300;
    BestGaoG_300 = maxGaoG_300;
    maxGaoG_3000  = simRatpd_3000.variablevalues(:,ismember(simRatpd_3000.variables,'G'));
    minGaoG_3000  = maxGaoG_3000;
    BestGaoG_3000 = maxGaoG_3000;
end
NewGaoG_Vehicle = simRatpd_vehicle.variablevalues(:,ismember(simRatpd_vehicle.variables,'G'));
maxGaoG_Vehicle = max(maxGaoG_Vehicle,NewGaoG_Vehicle);
minGaoG_Vehicle = min(minGaoG_Vehicle,NewGaoG_Vehicle);
NewGaoG_3 = simRatpd_3.variablevalues(:,ismember(simRatpd_3.variables,'G'));
maxGaoG_3 = max(maxGaoG_3,NewGaoG_3);
minGaoG_3 = min(minGaoG_3,NewGaoG_3);
NewGaoG_30 = simRatpd_30.variablevalues(:,ismember(simRatpd_30.variables,'G'));
maxGaoG_30 = max(maxGaoG_30,NewGaoG_30);
minGaoG_30 = min(minGaoG_30,NewGaoG_30);
NewGaoG_300 = simRatpd_300.variablevalues(:,ismember(simRatpd_300.variables,'G'));
maxGaoG_300 = max(maxGaoG_300,NewGaoG_300);
minGaoG_300 = min(minGaoG_300,NewGaoG_300);
NewGaoG_3000 = simRatpd_3000.variablevalues(:,ismember(simRatpd_3000.variables,'G'));
maxGaoG_3000 = max(maxGaoG_3000,NewGaoG_3000);
minGaoG_3000 = min(minGaoG_3000,NewGaoG_3000);

% Insulin
if j == 1
    maxGaoI_Vehicle  = simRatpd_vehicle.variablevalues(:,ismember(simRatpd_vehicle.variables,'I'));
    minGaoI_Vehicle  = maxGaoI_Vehicle;
    BestGaoI_Vehicle = maxGaoI_Vehicle;
    maxGaoI_3  = simRatpd_3.variablevalues(:,ismember(simRatpd_3.variables,'I'));
    minGaoI_3  = maxGaoI_3;
    BestGaoI_3 = maxGaoI_3;
    maxGaoI_30  = simRatpd_30.variablevalues(:,ismember(simRatpd_30.variables,'I'));
    minGaoI_30  = maxGaoI_30;
    BestGaoI_30 = maxGaoI_30;
    maxGaoI_300  = simRatpd_300.variablevalues(:,ismember(simRatpd_300.variables,'I'));
    minGaoI_300  = maxGaoI_300;
    BestGaoI_300 = maxGaoI_300;
    maxGaoI_3000  = simRatpd_3000.variablevalues(:,ismember(simRatpd_3000.variables,'I'));
    minGaoI_3000  = maxGaoI_3000;
    BestGaoI_3000 = maxGaoI_3000;
end
NewGaoI_Vehicle = simRatpd_vehicle.variablevalues(:,ismember(simRatpd_vehicle.variables,'I'));
maxGaoI_Vehicle = max(maxGaoI_Vehicle,NewGaoI_Vehicle);
minGaoI_Vehicle = min(minGaoI_Vehicle,NewGaoI_Vehicle);
NewGaoI_3 = simRatpd_3.variablevalues(:,ismember(simRatpd_3.variables,'I'));
maxGaoI_3 = max(maxGaoI_3,NewGaoI_3);
minGaoI_3 = min(minGaoI_3,NewGaoI_3);
NewGaoI_30 = simRatpd_30.variablevalues(:,ismember(simRatpd_30.variables,'I'));
maxGaoI_30 = max(maxGaoI_30,NewGaoI_30);
minGaoI_30 = min(minGaoI_30,NewGaoI_30);
NewGaoI_300 = simRatpd_300.variablevalues(:,ismember(simRatpd_300.variables,'I'));
maxGaoI_300 = max(maxGaoI_300,NewGaoI_300);
minGaoI_300 = min(minGaoI_300,NewGaoI_300);
NewGaoI_3000 = simRatpd_3000.variablevalues(:,ismember(simRatpd_3000.variables,'I'));
maxGaoI_3000 = max(maxGaoI_3000,NewGaoI_3000);
minGaoI_3000 = min(minGaoI_3000,NewGaoI_3000);

% PK
if j == 1
    maxGaoE_Vehicle  = simRatpd_vehicle.statevalues(:,ismember(simRatpd_vehicle.states,'C1'));
    minGaoE_Vehicle  = maxGaoE_Vehicle;
    BestGaoE_Vehicle = maxGaoE_Vehicle;
    maxGaoE_3  = simRatpd_3.statevalues(:,ismember(simRatpd_3.states,'C1'));
    minGaoE_3  = maxGaoE_3;
    BestGaoE_3 = maxGaoE_3;
    maxGaoE_30  = simRatpd_30.statevalues(:,ismember(simRatpd_30.states,'C1'));
    minGaoE_30  = maxGaoE_30;
    BestGaoE_30 = maxGaoE_30;
    maxGaoE_300  = simRatpd_300.statevalues(:,ismember(simRatpd_300.states,'C1'));
    minGaoE_300  = maxGaoE_300;
    BestGaoE_300 = maxGaoE_300;
    maxGaoE_3000  = simRatpd_3000.statevalues(:,ismember(simRatpd_3000.states,'C1'));
    minGaoE_3000  = maxGaoE_3000;
    BestGaoE_3000 = maxGaoE_3000;
end
NewGaoE_Vehicle = simRatpd_vehicle.statevalues(:,ismember(simRatpd_vehicle.states,'C1'));
maxGaoE_Vehicle = max(maxGaoE_Vehicle,NewGaoE_Vehicle);
minGaoE_Vehicle = min(minGaoE_Vehicle,NewGaoE_Vehicle);
NewGaoE_3 = simRatpd_3.statevalues(:,ismember(simRatpd_3.states,'C1'));
maxGaoE_3 = max(maxGaoE_3,NewGaoE_3);
minGaoE_3 = min(minGaoE_3,NewGaoE_3);
NewGaoE_30 = simRatpd_30.statevalues(:,ismember(simRatpd_30.states,'C1'));
maxGaoE_30 = max(maxGaoE_30,NewGaoE_30);
minGaoE_30 = min(minGaoE_30,NewGaoE_30);
NewGaoE_300 = simRatpd_300.statevalues(:,ismember(simRatpd_300.states,'C1'));
maxGaoE_300 = max(maxGaoE_300,NewGaoE_300);
minGaoE_300 = min(minGaoE_300,NewGaoE_300);
NewGaoE_3000 = simRatpd_3000.statevalues(:,ismember(simRatpd_3000.states,'C1'));
maxGaoE_3000 = max(maxGaoE_3000,NewGaoE_3000);
minGaoE_3000 = min(minGaoE_3000,NewGaoE_3000);

% Insulin Secretion: PhaseI/total
if j == 1
    % Vehicle
    maxGaoSRatio_Vehicle  = sum(simRatpd_vehicle.reactionvalues(30:40,ismember(simRatpd_vehicle.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
    minGaoSRatio_Vehicle  = maxGaoSRatio_Vehicle;
    BestGaoSRatio_Vehicle = maxGaoSRatio_Vehicle;
    % 3
    maxGaoSRatio_3  = sum(simRatpd_3.reactionvalues(30:40,ismember(simRatpd_3.reactions,'S')))/sum(simRatpd_3.reactionvalues(30:90,ismember(simRatpd_3.reactions,'S')));
    minGaoSRatio_3  = maxGaoSRatio_3;
    BestGaoSRatio_3 = maxGaoSRatio_3;
    % 30
    maxGaoSRatio_30  = sum(simRatpd_30.reactionvalues(30:40,ismember(simRatpd_30.reactions,'S')))/sum(simRatpd_30.reactionvalues(30:90,ismember(simRatpd_30.reactions,'S')));
    minGaoSRatio_30  = maxGaoSRatio_30;
    BestGaoSRatio_30 = maxGaoSRatio_30;
        % 3
    maxGaoSRatio_300  = sum(simRatpd_300.reactionvalues(30:40,ismember(simRatpd_300.reactions,'S')))/sum(simRatpd_300.reactionvalues(30:90,ismember(simRatpd_300.reactions,'S')));
    minGaoSRatio_300  = maxGaoSRatio_300;
    BestGaoSRatio_300 = maxGaoSRatio_300;
    % 30
    maxGaoSRatio_3000  = sum(simRatpd_3000.reactionvalues(30:40,ismember(simRatpd_3000.reactions,'S')))/sum(simRatpd_3000.reactionvalues(30:90,ismember(simRatpd_3000.reactions,'S')));
    minGaoSRatio_3000  = maxGaoSRatio_3000;
    BestGaoSRatio_3000 = maxGaoSRatio_3000;
     
end

% Vehicle
NewGaoSRatio_Vehicle = sum(simRatpd_vehicle.reactionvalues(30:40,ismember(simRatpd_vehicle.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
maxGaoSRatio_Vehicle = max(maxGaoSRatio_Vehicle,NewGaoSRatio_Vehicle);
minGaoSRatio_Vehicle = min(minGaoSRatio_Vehicle,NewGaoSRatio_Vehicle);
%  3
NewGaoSRatio_3 = sum(simRatpd_3.reactionvalues(30:40,ismember(simRatpd_3.reactions,'S')))/sum(simRatpd_3.reactionvalues(30:90,ismember(simRatpd_3.reactions,'S')));
maxGaoSRatio_3 = max(maxGaoSRatio_3,NewGaoSRatio_3);
minGaoSRatio_3 = min(minGaoSRatio_3,NewGaoSRatio_3);
% 30
NewGaoSRatio_30 = sum(simRatpd_30.reactionvalues(30:40,ismember(simRatpd_30.reactions,'S')))/sum(simRatpd_30.reactionvalues(30:90,ismember(simRatpd_30.reactions,'S')));
maxGaoSRatio_30 = max(maxGaoSRatio_30,NewGaoSRatio_30);
minGaoSRatio_30 = min(minGaoSRatio_30,NewGaoSRatio_30);
% 300
NewGaoSRatio_300 = sum(simRatpd_300.reactionvalues(30:40,ismember(simRatpd_300.reactions,'S')))/sum(simRatpd_300.reactionvalues(30:90,ismember(simRatpd_300.reactions,'S')));
maxGaoSRatio_300 = max(maxGaoSRatio_300,NewGaoSRatio_300);
minGaoSRatio_300 = min(minGaoSRatio_300,NewGaoSRatio_300);
% 3000
NewGaoSRatio_3000 = sum(simRatpd_3000.reactionvalues(30:40,ismember(simRatpd_3000.reactions,'S')))/sum(simRatpd_3000.reactionvalues(30:90,ismember(simRatpd_3000.reactions,'S')));
maxGaoSRatio_3000 = max(maxGaoSRatio_3000,NewGaoSRatio_3000);
minGaoSRatio_3000 = min(minGaoSRatio_3000,NewGaoSRatio_3000);

% Insulin Secretion: Relative vehicle 
if j == 1
    % Vehicle
    maxGaoS_Vehicle  = sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
    minGaoS_Vehicle  = maxGaoS_Vehicle;
    BestGaoS_Vehicle = maxGaoS_Vehicle;
    % 3
    maxGaoS_3  = sum(simRatpd_3.reactionvalues(30:90,ismember(simRatpd_3.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
    minGaoS_3  = maxGaoS_3;
    BestGaoS_3 = maxGaoS_3;
    % 30
    maxGaoS_30  = sum(simRatpd_30.reactionvalues(30:90,ismember(simRatpd_30.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
    minGaoS_30  = maxGaoS_30;
    BestGaoS_30 = maxGaoS_30;
        % 3
    maxGaoS_300  = sum(simRatpd_300.reactionvalues(30:90,ismember(simRatpd_300.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
    minGaoS_300  = maxGaoS_300;
    BestGaoS_300 = maxGaoS_300;
    % 30
    maxGaoS_3000  = sum(simRatpd_3000.reactionvalues(30:90,ismember(simRatpd_3000.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
    minGaoS_3000  = maxGaoS_3000;
    BestGaoS_3000 = maxGaoS_3000;
end
% Vehicle
NewGaoS_Vehicle = sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
maxGaoS_Vehicle = max(maxGaoS_Vehicle,NewGaoS_Vehicle);
minGaoS_Vehicle = min(minGaoS_Vehicle,NewGaoS_Vehicle);
%  3
NewGaoS_3 = sum(simRatpd_3.reactionvalues(30:90,ismember(simRatpd_3.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
maxGaoS_3 = max(maxGaoS_3,NewGaoS_3);
minGaoS_3 = min(minGaoS_3,NewGaoS_3);
% 30
NewGaoS_30 = sum(simRatpd_30.reactionvalues(30:90,ismember(simRatpd_30.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
maxGaoS_30 = max(maxGaoS_30,NewGaoS_30);
minGaoS_30 = min(minGaoS_30,NewGaoS_30);
% 300
NewGaoS_300 = sum(simRatpd_300.reactionvalues(30:90,ismember(simRatpd_300.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
maxGaoS_300 = max(maxGaoS_300,NewGaoS_300);
minGaoS_300 = min(minGaoS_300,NewGaoS_300);
% 3000
NewGaoS_3000 = sum(simRatpd_3000.reactionvalues(30:90,ismember(simRatpd_3000.reactions,'S')))/sum(simRatpd_vehicle.reactionvalues(30:90,ismember(simRatpd_vehicle.reactions,'S')));
maxGaoS_3000 = max(maxGaoS_3000,NewGaoS_3000);
minGaoS_3000 = min(minGaoS_3000,NewGaoS_3000);

end