function [simApe_IV3,simApe_SC1,simApe_SC3,simApe_SC10] = SimulateGaoApe(model,GaoApe_data,param,ConditionAlterations,initialvalues,sNames,pNames);

param(ismember(pNames,"V1_ref"))   = param(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(2);
param(ismember(pNames,"V2_ref"))   = param(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(2);
param(ismember(pNames,"CL_ref"))   = param(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(2); 
param(ismember(pNames,"Ka"))       = param(ismember(pNames,"Ka"))     * ConditionAlterations.Ka(2); 
param(ismember(pNames,"BW"))                 = 4.31; % kg - correct from publication https://pubmed.ncbi.nlm.nih.gov/22338110/
param(ismember(pNames,"IVTransfusion"))      = 0;  

UnitConvertion = 1000*param(ismember(pNames,"BW"))/4186.6; % ug/kg to nMol
V1             = param(ismember(pNames,"V1_ref")) * ((param(ismember(pNames,"BW"))/0.34)^param(ismember(pNames,"b_volume")));
%% Simulate

% IV
initialvalues(ismember(sNames,"C1")) = 3*UnitConvertion/V1; %nmol/L
simApe_IV3    = model(0:1:720,initialvalues,param);
initialvalues(ismember(sNames,"C1")) = 0;

% SC
initialvalues(ismember(sNames,"A")) = ConditionAlterations.f(1)*1*UnitConvertion; %nmol (changed to nMol/L in model)
simApe_SC1    = model(0:1:720,initialvalues,param);
initialvalues(ismember(sNames,"A")) = ConditionAlterations.f(1)*3*UnitConvertion; %nmol
simApe_SC3     = model(0:1:720,initialvalues,param);
initialvalues(ismember(sNames,"A")) = ConditionAlterations.f(1)*10*UnitConvertion; %nmol
simApe_SC10   = model(0:1:720,initialvalues,param);

end

