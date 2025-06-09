function [Cost_Model] = EstimationData_ObjectFunction(Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,params,PersonSpecificParameters,modelName,sNames, pNames,initialvalues,AmountParameterOpti,CountQualitativeDemands,fid)

model = str2func(modelName);

%% Create flexibility for both PS and MCMC

if size(params,1) > 1 %% flipping the parametervector back to a row vector when running MCMC
params = params';
else
    if any(params < 0)
        params=exp(params);
    end
end

%% Seperate co-parameters and EndoC/InSphero specific parameters
    [PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,AmountParameterOpti,params);
    
%% Agreement to data

try

    [initialvaluesInSphero,initialvaluesEndoC,initialvaluesLiverOnly]  = SimulateSteadystate(model   ,InSphero_params,EndoC_params,initialvalues,sNames,pNames);
       
    [Cost_InSphero,Cost_InSpheroStatistical] = InSphero_Costfunction(Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,InSphero_params,PersonSpecificParametersInSphero,modelName,sNames, pNames,initialvaluesInSphero,AmountParameterOpti);
    [Cost_EndoC,Cost_EndoCStatistical]       = EndoC_Costfunction   (Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,EndoC_params   ,PersonSpecificParametersEndoC   ,modelName,sNames, pNames,initialvaluesEndoC,AmountParameterOpti);
    [Cost_LO,Cost_LO_statistical]            = LO_Costfunction      (Study6_data                                                                                                                                                                                             ,InSphero_params,PersonSpecificParametersInSphero,modelName,sNames, pNames,initialvaluesLiverOnly,AmountParameterOpti);
    
    [simEndoC,simHuman,SimHepaRG] = SimulateMediaFunctionality(model,params,PersonSpecificParameters,initialvalues,sNames,pNames,AmountParameterOpti,672); % ensure parameter vector has long-term stability
    
    AgreementToData             = Cost_InSphero            + Cost_EndoC            + Cost_LO;
    AgreementToData_statistical = Cost_InSpheroStatistical + Cost_EndoCStatistical + Cost_LO_statistical;
    
    catch error
    Cost_Model = 1e40;
    return
end

%% Qualitative demands

if CountQualitativeDemands == 1
        
        %% Media-Media variability
        
        MatrixVariability  = [PersonSpecificParametersEndoC.InsulinResistanceTimeDependency(1:5)   ,PersonSpecificParametersEndoC.IS0(1:5)                   , PersonSpecificParametersEndoC.Fspheroids_hill(1:5), PersonSpecificParametersEndoC.Fspheroids0(1:5), PersonSpecificParametersEndoC.Fspheroids50(1:5)  , ...
                              PersonSpecificParametersEndoC.ExenatideResponse(1:7)                 ,PersonSpecificParametersEndoC.ExenatideResponse50(1:7)   , PersonSpecificParametersEndoC.Filets_hill(1:7)    , PersonSpecificParametersEndoC.Filets0(1:7)    , PersonSpecificParametersEndoC.Fislets50(1:7)     , PersonSpecificParametersEndoC.kv(1:7), ...
                              PersonSpecificParametersInSphero.ExenatideResponse(1:2)              ,PersonSpecificParametersInSphero.ExenatideResponse50(1:2), PersonSpecificParametersInSphero.Filets_hill(1:2) , PersonSpecificParametersInSphero.Filets0(1:2) , PersonSpecificParametersInSphero.Fislets50(1:2)  , ...
                              PersonSpecificParametersInSphero.ExenatideResponse(6:7)              ,PersonSpecificParametersInSphero.ExenatideResponse50(6:7), PersonSpecificParametersInSphero.Filets_hill(6:7) , PersonSpecificParametersInSphero.Filets0(6:7) ];
        IndexVariabilitySub1 = MatrixVariability < 1;
        MatrixVariability(IndexVariabilitySub1) = 1./MatrixVariability(IndexVariabilitySub1);
        Cost_Model_Qualitativedemands  = sum(((MatrixVariability - 1).^2)./1.^2);
        
        %% Cell-cell & batch-batch variability
        
        % Pancreatic: Donor-Donor & Batch-Batch
        MatrixVariability  = [PersonSpecificParametersInSphero.ExenatideResponse(8:19),PersonSpecificParametersInSphero.ExenatideResponse50(8:19), PersonSpecificParametersInSphero.Filets0(8:22)];
        IndexVariabilitySub1 = MatrixVariability < 1;
        MatrixVariability(IndexVariabilitySub1) = 1./MatrixVariability(IndexVariabilitySub1);
        Cost_Model_Qualitativedemands  = sum(((MatrixVariability - 1).^2)./1.^2) + Cost_Model_Qualitativedemands;
       
        % Hepatic: Batch-Batch
        MatrixVariability  = [PersonSpecificParametersEndoC.HepaRG_f50(1:5),PersonSpecificParametersEndoC.HepaRG_f0(1:5),PersonSpecificParametersEndoC.HepaRG_IS(1:5)];
        IndexVariabilitySub1 = MatrixVariability < 1;
        MatrixVariability(IndexVariabilitySub1) = 1./MatrixVariability(IndexVariabilitySub1);
        Cost_Model_Qualitativedemands  = sum(((MatrixVariability - 1).^2)./1.^2) + Cost_Model_Qualitativedemands;
        
        %% Uncertainty
        
        %  Move washing uncertainty towards mean
        MatrixVariability  = [PersonSpecificParametersEndoC.EndoCWashing_Uncertainty];
        IndexVariabilitySub1 = MatrixVariability < 1;
        MatrixVariability(IndexVariabilitySub1) = 1./MatrixVariability(IndexVariabilitySub1);
        Cost_Model_Qualitativedemands  = sum(((MatrixVariability - 1).^2)./0.03.^2) + Cost_Model_Qualitativedemands;
        
        % Move solution towards the lowest variability in uncertainty parameters medium
        MatrixVariability  = [PersonSpecificParametersEndoC.EndoCBasal_Uncertainty,PersonSpecificParametersInSphero.InSpheroInsulinPhases_Uncertainty];
        IndexVariabilitySub1 = MatrixVariability < 1;
        MatrixVariability(IndexVariabilitySub1) = 1./MatrixVariability(IndexVariabilitySub1);
        Cost_Model_Qualitativedemands  = sum(((MatrixVariability - 1).^2)./0.8.^2) + Cost_Model_Qualitativedemands;
        
        %  Move solution towards the lowest variability in uncertainty parameters low
        MatrixVariability  = [PersonSpecificParametersInSphero.FlowGSISBasalS];
        IndexVariabilitySub1 = MatrixVariability < 1;
        MatrixVariability(IndexVariabilitySub1) = 1./MatrixVariability(IndexVariabilitySub1);
        Cost_Model_Qualitativedemands  = sum(((MatrixVariability - 1).^2)./1.5.^2) + Cost_Model_Qualitativedemands;
        
        %% Lower difference between human and cell line groups
                
        % Move pancretic parameters towards eatchother 
        CellFuncDifference  = InSphero_params(1:42)./EndoC_params(1:42);
        IndexVariabilitySub1 = CellFuncDifference < 1;
        CellFuncDifference(IndexVariabilitySub1) = 1./CellFuncDifference(IndexVariabilitySub1);
        CellFuncDifference(37:38) = []; % Insulin secretion ROC is part of the low weight below because of fundamental differences
        CellFuncDifference(25)    = []; % Fundamental differences between proliferation
        CellFuncDifference(1:17)  = []; % Liver parameters are identical
        Cost_Model_Qualitativedemands  = sum(((CellFuncDifference - 1))./1.5) + Cost_Model_Qualitativedemands;
        
        % Move Media influence on cells towards eatchother 
        EndoC    = [PersonSpecificParametersEndoC.ExenatideResponse(1:2)   , PersonSpecificParametersEndoC.ExenatideResponse50(1:2)   , PersonSpecificParametersEndoC.Filets0(1:2)   , PersonSpecificParametersEndoC.Fislets50(1:2)   , PersonSpecificParametersEndoC.Filets_hill(1:2)];
        InSphero = [PersonSpecificParametersInSphero.ExenatideResponse(1:2), PersonSpecificParametersInSphero.ExenatideResponse50(1:2), PersonSpecificParametersInSphero.Filets0(1:2), PersonSpecificParametersInSphero.Fislets50(1:2), PersonSpecificParametersInSphero.Filets_hill(1:2)];
        MediaFuncDifference  = EndoC./InSphero;
        IndexVariabilitySub1 = MediaFuncDifference < 1;
        MediaFuncDifference(IndexVariabilitySub1) = 1./MediaFuncDifference(IndexVariabilitySub1);
        Cost_Model_Qualitativedemands  = sum(((MediaFuncDifference - 1))./1,'all') + Cost_Model_Qualitativedemands;

else
    Cost_Model_Qualitativedemands = 0;
end

%% Sum all cost

% Cost_Model       = AgreementToData + Cost_Model_Qualitativedemands; % Used in optimisation - contains the qualitative demands and extra weight to important datapoints for visual assessment
 
Cost_Model       = AgreementToData_statistical; % Used for statistical test

end
