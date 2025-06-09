function [Cost_Model] = Pharmacokinetic_objectivefunction(MPSpk_data,GaoExenatideConcentrations_data,Sauter2020_data,GaoApe_data,OptimisedParams,params,modelName,sNames, pNames,initialvalues,fid)

model            = str2func(modelName);
OptimisedParams  = exp(OptimisedParams);

% Build the parameter vector and declare condition alterations
params(1:10)     = OptimisedParams(1:10);
ConditionAlterations.f  = [OptimisedParams(11), OptimisedParams(12)];                    % Ape, Rat
ConditionAlterations.Ka = [OptimisedParams(13), OptimisedParams(14)];                    % Rat, monkey
ConditionAlterations.CL = [OptimisedParams(15),OptimisedParams(16),OptimisedParams(17)]; % Rat, monkey, dog
ConditionAlterations.vd = [OptimisedParams(18),OptimisedParams(19),OptimisedParams(20)]; % Rat, monkey, dog
ConditionAlterations.vd2 = [OptimisedParams(21),OptimisedParams(22),OptimisedParams(23)];% Rat, monkey, dog

%% Simulate

try
    [simInVitroPK]                                 = SimulateInVitroPK(model,MPSpk_data,params,initialvalues,sNames,pNames);
    [simDog_E]                                     = SimulateSauterDog(model,Sauter2020_data,params,ConditionAlterations,initialvalues,sNames,pNames);
    [simApe_IV3,simApe_SC1,simApe_SC3,simApe_SC10] = SimulateGaoApe(model,GaoApe_data,params,ConditionAlterations,initialvalues,sNames,pNames);
    [simRatpd_vehicle,simRatpd_3,simRatpd_30,simRatpd_300,simRatpd_3000,simIV_50, simIV_5, simIV_0p5, simIVtransfusion_50, simIVtransfusion_5, simIVtransfusion_0p5, simSC_50, simSC_5, simSC_0p5] = SimulateGaoRat(model,[50],GaoExenatideConcentrations_data,params,ConditionAlterations,initialvalues,sNames,pNames,0);
    
catch error
    Cost_Model = 1e40;
    return
end

%% Minimise condition alterations

MatrixVariability  = [ConditionAlterations.Ka,ConditionAlterations.CL,ConditionAlterations.vd,ConditionAlterations.vd2];
IndexVariabilitySub1 = MatrixVariability < 1;
MatrixVariability(IndexVariabilitySub1) = 1./MatrixVariability(IndexVariabilitySub1);
Cost_Model_Qualitativedemands  = sum(((MatrixVariability - 1).^2)  ./(0.5.^2));

%% Human cell PK

E = simInVitroPK.statevalues(end,ismember(simInVitroPK.states,'C1'))./simInVitroPK.statevalues(1,ismember(simInVitroPK.states,'C1'));
CostE_InVitro      = ((MPSpk_data.All(1) - E).^2)  ./(MPSpk_data.All(1).^2);

%% Rat

WeightedStdev = [max(GaoExenatideConcentrations_data.ExenatideIV_50nMSEM(1:12) ,0.3*GaoExenatideConcentrations_data.ExenatideIV_50nM(1:12))'  ,...
                 max(GaoExenatideConcentrations_data.ExenatideIV_5nMSEM(1:12)  ,0.3*GaoExenatideConcentrations_data.ExenatideIV_5nM(1:12))'   ,...
                 max(GaoExenatideConcentrations_data.ExenatideIV_0p5nMSEM(1:12),0.3*GaoExenatideConcentrations_data.ExenatideIV_0p5nM(1:12))'];
GaoExenatideConcentrations_data.ExenatideIV_0p5nMSEM(1:12) = GaoExenatideConcentrations_data.ExenatideIV_0p5nMSEM(1:12)*2;

%IV
DatapointsSampleFromSimulation = GaoExenatideConcentrations_data.timeExenatideIV(1:12);
E_IV50           = simIV_50.statevalues(DatapointsSampleFromSimulation,ismember(simIV_50.states,'C1'))*1000;
CostE_IV50       = ((GaoExenatideConcentrations_data.ExenatideIV_50nM(1:12) - E_IV50)'.^2)  ./(WeightedStdev(1,:).^2);
CostE_IV50(12)   = CostE_IV50(12)*2;
E_IV5            = simIV_5.statevalues(DatapointsSampleFromSimulation,ismember(simIV_5.states,'C1'))*1000;
CostE_IV5        = ((GaoExenatideConcentrations_data.ExenatideIV_5nM(1:12) - E_IV5)'.^2)  ./(WeightedStdev(2,:).^2);
CostE_IV5(11)    = CostE_IV5(11)*2;
E_IV0p5          = simIV_0p5.statevalues(DatapointsSampleFromSimulation,ismember(simIV_0p5.states,'C1'))*1000;
CostE_IV0p5      = ((GaoExenatideConcentrations_data.ExenatideIV_0p5nM(1:12) - E_IV0p5)'.^2)  ./(WeightedStdev(3,:).^2);
CostE_IV0p5(6)   = CostE_IV5(6)*2;
CostE_IV =  sum(CostE_IV50,'omitnan') + sum(CostE_IV5,'omitnan') + sum(CostE_IV0p5,'omitnan');

WeightedStdev = [max(0.3*GaoExenatideConcentrations_data.ExenatideIVinfusion_50nM(1:17),GaoExenatideConcentrations_data.ExenatideIVinfusion_50nMSEM(1:17))'   ,...
                 max(0.3*GaoExenatideConcentrations_data.ExenatideIVinfusion_5nM(1:17),GaoExenatideConcentrations_data.ExenatideIVinfusion_5nMSEM(1:17))'     ,...
                 max(0.3*GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nM(1:17),GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nMSEM(1:17))'];
%IVinfusion
DatapointsSampleFromSimulation = GaoExenatideConcentrations_data.timeExenatideIVtransfusion(1:17);
E_IVinfusion50          = simIVtransfusion_50.statevalues(DatapointsSampleFromSimulation,ismember(simIVtransfusion_50.states,'C1'))*1000;
CostE_IVinfusion50      = ((GaoExenatideConcentrations_data.ExenatideIVinfusion_50nM(1:17) - E_IVinfusion50)'.^2)  ./(WeightedStdev(1,:).^2);
CostE_IVinfusion50(7)   = CostE_IVinfusion50(7)*16;
E_IVinfusion5           = simIVtransfusion_5.statevalues(DatapointsSampleFromSimulation,ismember(simIVtransfusion_5.states,'C1'))*1000;
CostE_IVinfusion5       = ((GaoExenatideConcentrations_data.ExenatideIVinfusion_5nM(1:17) - E_IVinfusion5)'.^2)  ./(WeightedStdev(2,:).^2);
CostE_IVinfusion5(7)    = CostE_IVinfusion5(7)*16;
E_IVinfusion0p5         = simIVtransfusion_0p5.statevalues(DatapointsSampleFromSimulation,ismember(simIVtransfusion_0p5.states,'C1'))*1000;
CostE_IVinfusion0p5     = ((GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nM(1:17) - E_IVinfusion0p5)'.^2)  ./(WeightedStdev(3,:).^2);
CostE_IVinfusion0p5(7)  = CostE_IVinfusion0p5(7)*16;
CostE_IVinfusion =  sum(CostE_IVinfusion50,'omitnan') + sum(CostE_IVinfusion5,'omitnan') + sum(CostE_IVinfusion0p5,'omitnan');

%SC
DatapointsSampleFromSimulation = GaoExenatideConcentrations_data.Exenatidestimesd(1:12);
simE_SC50       = simSC_50.statevalues(DatapointsSampleFromSimulation,ismember(simSC_50.states,'C1'))*1000;
CostE_SC50      = ((GaoExenatideConcentrations_data.Exenatidesd_50nM(1:12) - simE_SC50).^2)  ./((GaoExenatideConcentrations_data.Exenatidesd_50nMSEM(1:12)).^2);
CostE_SC50(12)  = CostE_SC50(12)*5;
simE_SC5        = simSC_5.statevalues(DatapointsSampleFromSimulation,ismember(simSC_5.states,'C1'))*1000;
CostE_SC5       = ((GaoExenatideConcentrations_data.Exenatidesd_5nM(1:12) - simE_SC5).^2)  ./((GaoExenatideConcentrations_data.Exenatidesd_5nMSEM(1:12)).^2);
CostE_SC5(12)   = CostE_SC5(12)*5;
simE_SC0p5      = simSC_0p5.statevalues(DatapointsSampleFromSimulation,ismember(simSC_0p5.states,'C1'))*1000;
CostE_SC0p5     = ((GaoExenatideConcentrations_data.Exenatidesd_0p5nM(1:12) - simE_SC0p5).^2)  ./((GaoExenatideConcentrations_data.Exenatidesd_0p5nMSEM(1:12)).^2);
CostE_SC0p5(12) = CostE_SC0p5(12)*5;
CostE_SC =  sum(CostE_SC50,'omitnan') + sum(CostE_SC5,'omitnan') + sum(CostE_SC0p5,'omitnan');

Cost_Rat = CostE_IV + CostE_SC + CostE_IVinfusion;
%% Ape

%IV
DatapointsSampleFromSimulation = round(GaoApe_data.timeIV3(1:9),0);
E_Ape       = simApe_IV3.statevalues(DatapointsSampleFromSimulation,ismember(simApe_IV3.states,'C1'));
CostE_ApeIV = ((GaoApe_data.IV3(1:9) - E_Ape).^2)  ./((0.2*GaoApe_data.IV3(1:9)).^2);

%SC1
DatapointsSampleFromSimulation = round(GaoApe_data.timeSC1(2:10),0);
E_Ape        = simApe_SC1.statevalues(DatapointsSampleFromSimulation,ismember(simApe_SC1.states,'C1'));
CostE_ApeSC1 = ((GaoApe_data.SC1(2:10) - E_Ape).^2)  ./((0.2*GaoApe_data.SC1(2:10)).^2);
%SC3
DatapointsSampleFromSimulation = round(GaoApe_data.timeSC3(2:13),0);
E_Ape         = simApe_SC3.statevalues(DatapointsSampleFromSimulation,ismember(simApe_SC3.states,'C1'));
CostE_ApeSC3  = ((GaoApe_data.SC3(2:13) - E_Ape).^2)  ./((0.2*GaoApe_data.SC3(2:13)).^2);
%SC10
DatapointsSampleFromSimulation = round(GaoApe_data.timeSC10(2:14),0);
E_Ape         = simApe_SC10.statevalues(DatapointsSampleFromSimulation,ismember(simApe_SC10.states,'C1'));
CostE_ApeSC10 = ((GaoApe_data.SC10(2:14) - E_Ape).^2)  ./((0.2*GaoApe_data.SC10(2:14)).^2);

Cost_Ape = sum(CostE_ApeIV,'omitnan') + sum(CostE_ApeSC1,'omitnan')+ sum(CostE_ApeSC3,'omitnan') + sum(CostE_ApeSC10,'omitnan');

%% Dog

DatapointsSampleFromSimulation = Sauter2020_data.Time(1:7);
E_dog       = simDog_E.statevalues(DatapointsSampleFromSimulation,ismember(simDog_E.states,'C1'));
Cost_Dog    = ((Sauter2020_data.E(1:7) - E_dog).^2)  ./((Sauter2020_data.Estdev(1:7)).^2);
Cost_Dog = sum(Cost_Dog,'omitnan');

%% Cost

Cost_Model = Cost_Rat + CostE_InVitro + Cost_Ape + Cost_Dog + Cost_Model_Qualitativedemands; % Used in optimisation

end
