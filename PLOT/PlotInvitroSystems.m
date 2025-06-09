[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param]               = IQMparameters(model);
InsulinPlotVector = logspace(2,5,100);
CountLiver        = 1000000:100000:10000000;
RecalcSimulations = 0;

load('ModelUncertainty_paramsFull')

%%
[row column]               = size(ModelUncertainty_params);
[PersonSpecificParameters] = AssignInitialUniqueParameters();

if RecalcSimulations == 1
    
    %% Recalculate all simulations
    
%    Sort parameter vectors to cost-value and calculate it
for j = 1:row
    params =    ModelUncertainty_params(j,1:column-1);
    cost =   EstimationData_ObjectFunction(Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,log(params),PersonSpecificParameters,modelName,sNames, pNames,initialvalues,AmountParameterOpti,1);
    ModelUncertainty_params(j,column) = cost;
end
 [row column] = size(ModelUncertainty_params);
 ModelUncertainty_params = sortrows(ModelUncertainty_params,column);

% Simulate
for j = 1:row
    params =    ModelUncertainty_params(j,1:column-1);
    
    % Do same calculations as objective function to minimise numerical errors from computer
    params = log(params);
    if size(params,1) > 1 
params = params';
else
    if any(params < 0)
        params=exp(params);
    end
    end
    
        [PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,AmountParameterOpti,params);
        
        % Steady state
         [initialvaluesInSphero,initialvaluesEndoC,initialvaluesLiverOnly]  = SimulateSteadystate(model   ,InSphero_params,EndoC_params,initialvalues,sNames,pNames);
       
        % Human islets
        [simStudy1_LCHG,simStudy1_HCHG]                                                  = SimulateStudy1(model,Study1_data   ,InSphero_params,PersonSpecificParametersInSphero,initialvaluesInSphero,sNames,pNames);
        [simStudy3_B27,simStudy3_FCS]                                                    = SimulateStudy3(model,Study3_data   ,InSphero_params,PersonSpecificParametersInSphero,initialvaluesInSphero,sNames,pNames);
        [SimStudy4_vehicle, SimStudy4_0p1, SimStudy4_10, SimStudy4_1000,simStudy5_GSIS]  = SimulateStudy4o5(model,Study4_data ,InSphero_params,PersonSpecificParametersInSphero,initialvaluesInSphero,sNames,pNames);
        [simStudy14_GSIS]                                                                = SimulateStudy14(model              ,InSphero_params,Study14_data,PersonSpecificParametersInSphero,initialvaluesInSphero,sNames,pNames);
        [simInsulinPhases_flow0,simInsulinPhases_flow100,simInsulinPhases_static0,simInsulinPhases_static100,simInsulinPhases_Article2,simInsulinPhases_GSIS] = SimulateInsulinPhases(model,Study14_data,InSphero_params,PersonSpecificParametersInSphero,initialvaluesInSphero,sNames,pNames,1);
        [simStudy13_GSIS]                                                                = SimulateStudy13(model,Study13_data,InSphero_params,PersonSpecificParametersInSphero,initialvaluesInSphero,sNames,pNames);
        UncertaintyStudy1
        UncertaintyStudy3
        UncertaintyStudy4o5
        UncertaintyStudy14
        UncertaintyExpInShpero
        UncertaintyStudy13
        
        % EndoC-BH5 spheroids
        [simStudy7_GSIS]                                                 = SimulateStudy7   (model,EndoC_params,Study7_data             ,PersonSpecificParametersEndoC,initialvalues,sNames,pNames);
        [simStudy8_GSIS]                                                 = SimulateStudy8   (model,EndoC_params,Study8_data             ,PersonSpecificParametersEndoC,initialvalues,sNames,pNames,1);
        [simStudy9_control, simStudy9_0p1, simStudy9_10,simStudy10_GSIS] = SimulateStudy9o10(model,Study9_data,Study10_data,EndoC_params,PersonSpecificParametersEndoC,initialvalues,sNames,pNames,1);
        [simBH5ref_GSIS]                                                 = SimulateBH5ref   (model,BH5ref_data,EndoC_params             ,PersonSpecificParametersEndoC,initialvalues,sNames,pNames,1);
        [simStudy11_Hcontrol, simStudy11_H0p1, simStudy11_H10,simStudy11_Dcontrol, simStudy11_D0p1, simStudy11_D10,simStudy12_GSIS] = SimulateStudy11o12(model,Study11_data,Study12_data,EndoC_params,PersonSpecificParametersEndoC,initialvalues,sNames,pNames);

        UncertaintyStudy7
        UncertaintyStudy8
        UncertaintyStudy9o10
        UncertaintyStudy11o12
        UncertaintyExpBH5ref
        
        % HepaRG only
        [SimStudy6_Vehicle0,SimStudy6_Vehicle5,SimStudy6_Vehicle10,SimStudy6_Vehicle100,SimStudy6_Spheroids0,SimStudy6_Spheroids5,SimStudy6_Spheroids10,SimStudy6_Spheroids100,SimStudy6_Volume0,SimStudy6_Volume5,SimStudy6_Volume10,SimStudy6_Volume100,SimStudy6_VolumeSpheroids0,SimStudy6_VolumeSpheroids5,SimStudy6_VolumeSpheroids10,SimStudy6_VolumeSpheroids100] = SimulateStudy6(model,Study6_data,InSphero_params,PersonSpecificParametersInSphero,initialvaluesLiverOnly,sNames,pNames);
        CalcAverageResponseStudy6
        UncertaintyStudy6

end  
else
load('WorkspacePlotInVitroSystems')    
end


%% Disp agreement to data

disp(' ')
if ModelUncertainty_params(1,column) < chi2inv(0.95,671)
    disp('----- Best description of human cell data is below statistical threshold -----')
end
fprintf('Best fit to human cell data: %.2f, Statistical Limit: %.2f (dgf = %i)', ModelUncertainty_params(1,column), chi2inv(0.95,671), 671)
disp(' ')

%% Plot

     PlotInSphero
     PlotEndoC
     PlotLO