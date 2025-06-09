function [Cost_Model] = Gao2011_costfunction(Gao2011Rat_data,GaoExenatideConcentrations_data,OptimisedParameters,Unoptimised_params,modelName,sNames, pNames,initialvalues,SimulatePD,fid)

OptimisedParameters=exp(OptimisedParameters);
%%

model      = str2func(modelName);

RandomEffects.f  = [Unoptimised_params(11), Unoptimised_params(12)];                       % Ape, Rat
RandomEffects.Ka = [Unoptimised_params(13) Unoptimised_params(14)];                        % Rat, monkey
RandomEffects.CL = [Unoptimised_params(15),Unoptimised_params(16),Unoptimised_params(17)]; % Rat, monkey, dog
RandomEffects.vd = [Unoptimised_params(18),Unoptimised_params(19),Unoptimised_params(20)]; % Rat, monkey, dog
RandomEffects.vd2 = [Unoptimised_params(21),Unoptimised_params(22),Unoptimised_params(23)];% Rat, monkey, dog

[pNames, CombinedParameters] = IQMparameters(model);
CombinedParameters(1:10)     = Unoptimised_params(1:10);
CombinedParameters(16:70)    = OptimisedParameters(1:55);

%% Simulate

try
    
    [simRatpd_vehicle,simRatpd_3,simRatpd_30,simRatpd_300,simRatpd_3000,simIV_50, simIV_5, simIV_0p5, simIVinfusion_50, simIVinfusion_5, simIVinfusion_0p5, simSC_50, simSC_5, simSC_0p5] = SimulateGaoRat(model,[40],GaoExenatideConcentrations_data,CombinedParameters,RandomEffects,initialvalues,sNames,pNames,SimulatePD);
    
catch error
    Cost_Model = 1e40;
    return
end

Cost_Model_Qualitativedemands = 0;

if SimulatePD == 1
    
if CombinedParameters(ismember(pNames,"ExenatideInsulinMax"))< CombinedParameters(ismember(pNames,"ExenatideInsulinDecayMax"))
    Cost_Model_Qualitativedemands = Cost_Model_Qualitativedemands + 1000;
elseif CombinedParameters(ismember(pNames,"ExenatideInsulin50")) > CombinedParameters(ismember(pNames,"ExenatideInsulinDecay50"))
    Cost_Model_Qualitativedemands = Cost_Model_Qualitativedemands + 1000;
end

% Glycogen not too low or high
Cost_Model_Qualitativedemands = Cost_Model_Qualitativedemands + 1 * sum(simRatpd_vehicle.variablevalues(:,ismember(simRatpd_vehicle.variables,'Glycogen_liver')) < 100);
Cost_Model_Qualitativedemands = Cost_Model_Qualitativedemands + 1 * sum(simRatpd_vehicle.variablevalues(:,ismember(simRatpd_vehicle.variables,'Glycogen_liver')) > 500);
end
%% PK

if SimulatePD == 0
    
    GaoExenatideConcentrations_data.ExenatideIV_0p5nMSEM(1:12) = GaoExenatideConcentrations_data.ExenatideIV_0p5nMSEM(1:12)*2;
    %IV
    DatapointsSampleFromSimulation = GaoExenatideConcentrations_data.timeExenatideIV(1:12);
    E_IV50       = simIV_50.statevalues(DatapointsSampleFromSimulation,ismember(simIV_50.states,'C1'))*1000;
    CostE_IV50      = ((GaoExenatideConcentrations_data.ExenatideIV_50nM(1:12) - E_IV50).^2)  ./((GaoExenatideConcentrations_data.ExenatideIV_50nMSEM(1:12)).^2);
    E_IV5       = simIV_5.statevalues(DatapointsSampleFromSimulation,ismember(simIV_5.states,'C1'))*1000;
    CostE_IV5      = ((GaoExenatideConcentrations_data.ExenatideIV_5nM(1:12) - E_IV5).^2)  ./((GaoExenatideConcentrations_data.ExenatideIV_5nMSEM(1:12)).^2);
    E_IV0p5       = simIV_0p5.statevalues(DatapointsSampleFromSimulation,ismember(simIV_0p5.states,'C1'))*1000;
    CostE_IV0p5      = ((GaoExenatideConcentrations_data.ExenatideIV_0p5nM(1:12) - E_IV0p5).^2)  ./((GaoExenatideConcentrations_data.ExenatideIV_0p5nMSEM(1:12)).^2);
    CostE_IV =  sum(CostE_IV50,'omitnan') + sum(CostE_IV5,'omitnan') + sum(CostE_IV0p5,'omitnan');
    
    GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nMSEM(1:17) = GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nMSEM(1:17)*3;
    GaoExenatideConcentrations_data.ExenatideIVinfusion_50nMSEM(1:17) = GaoExenatideConcentrations_data.ExenatideIVinfusion_50nMSEM(1:17)*0.5;
    %IVinfusion
    DatapointsSampleFromSimulation = GaoExenatideConcentrations_data.timeExenatideIVtransfusion(1:17);
    E_IVinfusion50       = simIVinfusion_50.statevalues(DatapointsSampleFromSimulation,ismember(simIVinfusion_50.states,'C1'))*1000;
    CostE_IVinfusion50      = ((GaoExenatideConcentrations_data.ExenatideIVinfusion_50nM(1:17) - E_IVinfusion50).^2)  ./((GaoExenatideConcentrations_data.ExenatideIVinfusion_50nMSEM(1:17)).^2);
    E_IVinfusion5       = simIVinfusion_5.statevalues(DatapointsSampleFromSimulation,ismember(simIVinfusion_5.states,'C1'))*1000;
    CostE_IVinfusion5      = ((GaoExenatideConcentrations_data.ExenatideIVinfusion_5nM(1:17) - E_IVinfusion5).^2)  ./((GaoExenatideConcentrations_data.ExenatideIVinfusion_5nMSEM(1:17)).^2);
    E_IVinfusion0p5       = simIVinfusion_0p5.statevalues(DatapointsSampleFromSimulation,ismember(simIVinfusion_0p5.states,'C1'))*1000;
    CostE_IVinfusion0p5      = ((GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nM(1:17) - E_IVinfusion0p5).^2)  ./((GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nMSEM(1:17)).^2);
    CostE_IVinfusion =  sum(CostE_IVinfusion50,'omitnan') + sum(CostE_IVinfusion5,'omitnan') + sum(CostE_IVinfusion0p5,'omitnan');
    
    %SC
    DatapointsSampleFromSimulation = GaoExenatideConcentrations_data.Exenatidestimesd(1:12);
    simE_SC50       = simSC_50.statevalues(DatapointsSampleFromSimulation,ismember(simSC_50.states,'C1'))*1000;
    CostE_SC50      = ((GaoExenatideConcentrations_data.Exenatidesd_50nM(1:12) - simE_SC50).^2)  ./((GaoExenatideConcentrations_data.Exenatidesd_50nMSEM(1:12)).^2);
    simE_SC5       = simSC_5.statevalues(DatapointsSampleFromSimulation,ismember(simSC_5.states,'C1'))*1000;
    CostE_SC5      = ((GaoExenatideConcentrations_data.Exenatidesd_5nM(1:12) - simE_SC5).^2)  ./((GaoExenatideConcentrations_data.Exenatidesd_5nMSEM(1:12)).^2);
    simE_SC0p5       = simSC_0p5.statevalues(DatapointsSampleFromSimulation,ismember(simSC_0p5.states,'C1'))*1000;
    CostE_SC0p5      = ((GaoExenatideConcentrations_data.Exenatidesd_0p5nM(1:12) - simE_SC0p5).^2)  ./((GaoExenatideConcentrations_data.Exenatidesd_0p5nMSEM(1:12)).^2);
    
    CostE_SC =  sum(CostE_SC50,'omitnan') + sum(CostE_SC5,'omitnan') + sum(CostE_SC0p5,'omitnan');
    
    Cost_PK = CostE_IV + CostE_IVinfusion + CostE_SC;
    
else
    Cost_PK = 0;
end
%% PD (dgf 120)

if SimulatePD == 1
    
    DatapointsSampleFromSimulation = round(Gao2011Rat_data.Time+30,2) + 1;
    
    simG       = simRatpd_vehicle.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_vehicle.variables,'G'))/18;
    CostG0      = ((Gao2011Rat_data.glucoseMean_0 - simG).^2)  ./(max(Gao2011Rat_data.glucoseSEM_0,mean(Gao2011Rat_data.glucoseSEM_0,'omitnan')).^2);
    simI       = simRatpd_vehicle.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_vehicle.variables,'I'));
    CostI0      = ((Gao2011Rat_data.insulinMean_0 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_0,mean(Gao2011Rat_data.insulinSEM_0,'omitnan')).^2);
    
    simG       = simRatpd_3.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_3.variables,'G'))/18;
    CostG3      = ((Gao2011Rat_data.glucoseMean_3 - simG).^2)  ./(max(Gao2011Rat_data.glucoseSEM_3,mean(Gao2011Rat_data.glucoseSEM_3,'omitnan')).^2);
    simI       = simRatpd_3.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_3.variables,'I'));
    CostI3      = ((Gao2011Rat_data.insulinMean_3 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_3,mean(Gao2011Rat_data.insulinSEM_3,'omitnan')).^2);
        
    simG       = simRatpd_30.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_30.variables,'G'))/18;
    CostG30      = ((Gao2011Rat_data.glucoseMean_30 - simG).^2)  ./(max(Gao2011Rat_data.glucoseSEM_30,mean(Gao2011Rat_data.glucoseSEM_30,'omitnan')).^2);
    simI       = simRatpd_30.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_30.variables,'I'));
    CostI30      = ((Gao2011Rat_data.insulinMean_30 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_30,mean(Gao2011Rat_data.insulinSEM_30,'omitnan')).^2);
    
    simG       = simRatpd_300.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_300.variables,'G'))/18;
    CostG300      = ((Gao2011Rat_data.glucoseMean_300 - simG).^2)  ./(max(Gao2011Rat_data.glucoseSEM_300,mean(Gao2011Rat_data.glucoseSEM_300,'omitnan')).^2);
    simI       = simRatpd_300.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_300.variables,'I'));
    CostI300      = ((Gao2011Rat_data.insulinMean_300 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_300,mean(Gao2011Rat_data.insulinSEM_300,'omitnan')).^2);
        
    simG       = simRatpd_3000.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_3000.variables,'G'))/18;
    CostG3000      = ((Gao2011Rat_data.glucoseMean_3000 - simG).^2)  ./(max(Gao2011Rat_data.glucoseSEM_3000,mean(Gao2011Rat_data.glucoseSEM_3000,'omitnan')).^2);
    simI       = simRatpd_3000.variablevalues(DatapointsSampleFromSimulation,ismember(simRatpd_3000.variables,'I'));
    CostI3000      = ((Gao2011Rat_data.insulinMean_3000 - simI).^2)  ./(max(Gao2011Rat_data.insulinSEM_3000,mean(Gao2011Rat_data.insulinSEM_3000,'omitnan')).^2);
    
    Cost_PD_G = sum(CostG0,'omitnan') + sum(CostG3,'omitnan') + sum(CostG30,'omitnan') + sum(CostG300,'omitnan') + sum(CostG3000,'omitnan');
    Cost_PD_I = sum(CostI0,'omitnan') + sum(CostI3,'omitnan') + sum(CostI30,'omitnan') + sum(CostI300,'omitnan') + sum(CostI3000,'omitnan');
    
else
    Cost_PD_G = 0;
    Cost_PD_I = 0;
    
end

Cost_Model  =  Cost_PK + Cost_PD_I + Cost_Model_Qualitativedemands;

end
