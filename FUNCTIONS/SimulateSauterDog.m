function [simDog_E] = SimulateSauterDog(model,Sauter2020_data,param,ConditionAlterations,initialvalues,sNames,pNames)

param(ismember(pNames,"V1_ref"))   = param(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(3);
param(ismember(pNames,"V2_ref"))   = param(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(3);
param(ismember(pNames,"CL_ref"))   = param(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(3); 

param(ismember(pNames,"BW"))                     = 9.725;  %correct from publication - https://www.sciencedirect.com/science/article/pii/S2095177919310895
param(ismember(pNames,"IVTransfusion"))          = 0;  

V1 = param(ismember(pNames,"V1_ref")) * ((param(ismember(pNames,"BW"))/0.34)^param(ismember(pNames,"b_volume")));

%% Simulate
initialvalues(ismember(sNames,"C1")) = 23.88/V1; %nMol/L - 100000/4186.63
simDog_E    = model(0:1:720,initialvalues,param);

end