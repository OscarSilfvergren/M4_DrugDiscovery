function [SimGaoHuman_0p1,SimGaoHuman_0p2,SimGaoHuman_0p3,SimGaoHuman_0p4] = SimulateGaoHuman(param,RandomEffects,pNames,sNames,initialvalues,model)

f = mean(RandomEffects.f);

param(ismember(pNames,"BW"))                 = 91;  %correct from publication
param(ismember(pNames,"IVTransfusion"))      = 0;  

%% PK

UnitConvertion = 1000*param(ismember(pNames,"BW"))/4186.6; %ug/kg to nMol 4186.6 Da

initialvalues(ismember(sNames,"A")) = f*0.4*UnitConvertion; %nMol
SimGaoHuman_0p4    = model(0:1:1440,initialvalues,param);
initialvalues(ismember(sNames,"A")) = f*0.3*UnitConvertion;
SimGaoHuman_0p3     = model(0:1:1440,initialvalues,param);
initialvalues(ismember(sNames,"A")) = f*0.2*UnitConvertion;
SimGaoHuman_0p2   = model(0:1:1440,initialvalues,param);
initialvalues(ismember(sNames,"A")) = f*0.1*UnitConvertion;
SimGaoHuman_0p1   = model(0:1:1440,initialvalues,param);
end

