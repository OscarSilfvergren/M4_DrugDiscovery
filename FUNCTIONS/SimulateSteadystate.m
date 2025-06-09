function [initialvaluesInSphero,initialvaluesEndoC,initialvaluesLiverOnly] = SimulateSteadystate(model,InSphero_params,EndoC_params,initialvalues,sNames,pNames)

[initialvalues] = SetInitialValues(5.5, 1000, 0, 0,[],pNames,sNames,initialvalues);
 
%% Pancreatic
initialvalues(ismember(sNames,"PancreticCells")) = 20000;     % 10 pancretic spheroids x 2000 per islet

% Human islets
        SteadyStateParams = InSphero_params;
         SteadyStateParams(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 20 liver cells
        SteadyStateParams(ismember(pNames,"V_m_medium"))            = 0.000605;  % media volume (L)
        SteadyStateParams(ismember(pNames,"EdU_boolean"))           = 0;
        sim_SteadyStateW    = model(0:48:48,initialvalues,SteadyStateParams); % START 00:00
        initialvaluesInSphero = sim_SteadyStateW.statevalues(end,:);
        initialvaluesInSphero(ismember(sNames,"TimeState"))          = 0;     % reset time
        initialvaluesInSphero(ismember(sNames,"GlucoseOverHealthy")) = 0;     % reset disease
        initialvaluesInSphero(ismember(sNames,"IP_gdROC_delay"))     = 0;     % reset delay
        
% EndoC islets
        SteadyStateParams = EndoC_params;
        SteadyStateParams(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 20 liver cells
        SteadyStateParams(ismember(pNames,"V_m_medium"))            = 0.000605;  % media volume (L)
        SteadyStateParams(ismember(pNames,"EdU_boolean"))           = 0;
        sim_SteadyStateW    = model(0:48:48,initialvalues,SteadyStateParams); % START 00:00
        initialvaluesEndoC = sim_SteadyStateW.statevalues(end,:);
        initialvaluesEndoC(ismember(sNames,"TimeState"))          = 0;     % reset time
        initialvaluesEndoC(ismember(sNames,"GlucoseOverHealthy")) = 0;     % reset disease
        initialvaluesEndoC(ismember(sNames,"IP_gdROC_delay"))     = 0;     % reset delay
       
        %% Hepatic
        
        SteadyStateParams = EndoC_params;
        initialvalues(ismember(sNames,"PancreticCells")) = 1e-5;
        SteadyStateParams(ismember(pNames,"CountLiver"))            = 1000000;   % 25000 * 20 liver cells
        
        SteadyStateParams(ismember(pNames,"V_m_medium"))            = 0.000605;  % media volume (L)
        SteadyStateParams(ismember(pNames,"EdU_boolean"))           = 0;
        sim_SteadyStateW    = model(0:48:48,initialvalues,SteadyStateParams); % START 00:00
        initialvaluesLiverOnly = sim_SteadyStateW.statevalues(end,:);

        initialvaluesLiverOnly(ismember(sNames,"TimeState"))          = 0;     % reset time
        initialvaluesLiverOnly(ismember(sNames,"GlucoseOverHealthy")) = 0;     % reset disease
        initialvaluesLiverOnly(ismember(sNames,"IP_gdROC_delay"))     = 0;     % reset delay
        
end

