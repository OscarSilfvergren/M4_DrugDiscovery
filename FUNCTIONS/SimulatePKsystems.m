function [simInvitro,simRat,simApe,simDog,simHuman] = SimulatePKsystems(model,params,RandomEffects,initialvalues,sNames,pNames)

paramsReset = params;

%% InVitro
params = paramsReset;

params(ismember(pNames,"Ka"))       = 0;
params(ismember(pNames,"Q_ref"))    = 0;
params(ismember(pNames,"V1_ref"))   = 0.000605;
params(ismember(pNames,"V2_ref"))   = 100;
params(ismember(pNames,"CL_ref"))   = 0; 
params(ismember(pNames,"BW"))   = 0.34;
params(ismember(pNames,"IVTransfusion"))   = 0; 
V1 = 0.000605;

initialvalues(ismember(sNames,"C1")) = 1/V1;
simInvitro    = model(0:1:360,initialvalues,params);

%% Rat
params = paramsReset;

params(ismember(pNames,"V1_ref"))   = params(ismember(pNames,"V1_ref")) * RandomEffects.vd(1);
params(ismember(pNames,"V2_ref"))   = params(ismember(pNames,"V2_ref")) * RandomEffects.vd2(1);
params(ismember(pNames,"CL_ref"))   = params(ismember(pNames,"CL_ref")) * RandomEffects.CL(1); 
params(ismember(pNames,"BW"))                     = 0.34;   % kg - correct from publication
params(ismember(pNames,"IVTransfusion"))          = 0;  
V1 = params(ismember(pNames,"V1_ref")); % Rat is the ref species

initialvalues(ismember(sNames,"C1")) = 1/V1;
simRat    = model(0:1:360,initialvalues,params);

%% Ape
params = paramsReset;

params(ismember(pNames,"V1_ref"))   = params(ismember(pNames,"V1_ref")) * RandomEffects.vd(2);
params(ismember(pNames,"V2_ref"))   = params(ismember(pNames,"V2_ref")) * RandomEffects.vd2(2);
params(ismember(pNames,"CL_ref"))   = params(ismember(pNames,"CL_ref")) * RandomEffects.CL(2); 
params(ismember(pNames,"BW"))                     = 4.31;   % kg - correct from publication
params(ismember(pNames,"IVTransfusion"))          = 0;  
V1 = params(ismember(pNames,"V1_ref")) * ((params(ismember(pNames,"BW"))/0.34)^params(ismember(pNames,"b_volume")));

initialvalues(ismember(sNames,"C1")) = 1/V1;
simApe    = model(0:1:360,initialvalues,params);

%% Dog
params = paramsReset;

params(ismember(pNames,"V1_ref"))   = params(ismember(pNames,"V1_ref")) * RandomEffects.vd(3);
params(ismember(pNames,"V2_ref"))   = params(ismember(pNames,"V2_ref")) * RandomEffects.vd2(3);
params(ismember(pNames,"CL_ref"))   = params(ismember(pNames,"CL_ref")) * RandomEffects.CL(3); 
params(ismember(pNames,"BW"))                     = 9.725;  %correct from publication
params(ismember(pNames,"IVTransfusion"))          = 0;  
V1 = params(ismember(pNames,"V1_ref")) * ((params(ismember(pNames,"BW"))/0.34)^params(ismember(pNames,"b_volume")));

initialvalues(ismember(sNames,"C1")) = 1/V1;
simDog    = model(0:1:360,initialvalues,params);

%% Human
params = paramsReset;

params(ismember(pNames,"BW"))                 = 91;  %correct from publication
params(ismember(pNames,"IVTransfusion"))      = 0;  
V1 = params(ismember(pNames,"V1_ref")) * ((params(ismember(pNames,"BW"))/0.34)^params(ismember(pNames,"b_volume")));

initialvalues(ismember(sNames,"C1")) = 1/V1;
simHuman    = model(0:1:360,initialvalues,params);

end