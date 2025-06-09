function [simInVitroPK] = SimulateInVitroPK(model,MPSpk_data,params,initialvalues,sNames,pNames)

params(ismember(pNames,"Ka"))            = 0;
params(ismember(pNames,"Q_ref"))         = 0;
params(ismember(pNames,"V1_ref"))        = 0.000605;
params(ismember(pNames,"V2_ref"))        = 100;
params(ismember(pNames,"CL_ref"))        = 0; 
params(ismember(pNames,"BW"))            = 0.34;
params(ismember(pNames,"IVTransfusion")) = 0; 

%% Simulate

initialvalues(ismember(sNames,"C1")) = 1/params(ismember(pNames,"V1_ref")); %nmol/L
simInVitroPK    = model(0:120:2880,initialvalues,params);

end

