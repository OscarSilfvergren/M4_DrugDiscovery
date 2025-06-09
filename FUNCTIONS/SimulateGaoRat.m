function [simRatpd_vehicle,simRatpd_3,simRatpd_30,simRatpd_300,simRatpd_3000,simIV_50, simIV_5, simIV_0p5, simIVtransfusion_50, simIVtransfusion_5, simIVtransfusion_0p5, simSC_50, simSC_5, simSC_0p5] = SimulateGaoRat(model,OptimisedEffects,GaoExenatideConcentrations_data,param,ConditionAlterations,initialvalues,sNames,pNames,SimulatePD)

CaloriesInMeal     = 20;                         % As described in article - assumed 60 calories/day with 3 meals/day i.e. 20 kcal/meal
CarbohydrateInMeal = CaloriesInMeal*1000*0.55/4;
ProteinInMeal      = CaloriesInMeal*1000*0.15/4;

param(ismember(pNames,"GlucoseInjection"))       = 0; 
param(ismember(pNames,"Meal_ProteinFlow"))       = 0;  
param(ismember(pNames,"Meal_CarbohydratesFlow")) = 0; 
param(ismember(pNames,"BW"))                     = 0.34;   % kg - correct from publication https://pubmed.ncbi.nlm.nih.gov/22338110/
param(ismember(pNames,"IVTransfusion"))          = 0;  

param(ismember(pNames,"InsulinResistanceUpperlimit"))  = 1000;   % IR progression turned off because it is unidentifiable in short-term studies
param(ismember(pNames,"InsulinResistanceHealing"))     = 0;      % IR remission turned off because it is unidentifiable in short-term studies

param(ismember(pNames,"V1_ref"))   = param(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(1);
param(ismember(pNames,"V2_ref"))   = param(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(1);
param(ismember(pNames,"CL_ref"))   = param(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(1); 
param(ismember(pNames,"Ka"))       = param(ismember(pNames,"Ka"))     * ConditionAlterations.Ka(1);

V1                 = param(ismember(pNames,"V1_ref")); % Rat is the ref species, therefor no scaling
initialvaluesReset = initialvalues;
paramReset         = param;

%% Steady state simulation

if SimulatePD ==1
    
param(ismember(pNames,"D")) = CarbohydrateInMeal;
initialvalues(ismember(sNames,"GlucoseOverHealthy")) = 0; % add one parameter
sim_SteadyStateW    = model(0:1:1,initialvalues,param);   % START 00:00
sim_SteadyStateInitial = sim_SteadyStateW.statevalues(end,:);
for i = 0:21 % looped 3/meals per day i.e. about 7 days
param(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
param(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
sim_SteadyState     = model(0:15:15,sim_SteadyStateInitial,param);   % START 07:00
param(ismember(pNames,"Meal_ProteinFlow"))       = 0;
param(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
sim_SteadyState    = model(0:480:480,sim_SteadyState.statevalues(end,:),param); % START 07:15
sim_SteadyStateInitial = sim_SteadyState.statevalues(end,:);
end
initialvalues  = sim_SteadyStateInitial;
initialvaluesReset = initialvalues;
end

%% PK simulation
param = paramReset;

% IV
initialvalues(ismember(sNames,"C1")) = 50/V1; % nMol/L
simIV_50    = model(0:1:420,initialvalues,param);
initialvalues(ismember(sNames,"C1")) = 5/V1;
simIV_5     = model(0:1:420,initialvalues,param);
initialvalues(ismember(sNames,"C1")) = 0.5/V1;
simIV_0p5   = model(0:1:420,initialvalues,param);

initialvalues = initialvaluesReset;

% IV infusion
param(ismember(pNames,"IVTransfusion")) = 50/60; %nmol/min
simIVtransfusion_50     = model(0:1:180,initialvalues,param);
param(ismember(pNames,"IVTransfusion")) = 0;
simIVtransfusion_50B    = model(180:1:420,simIVtransfusion_50.statevalues(end,:),param);
[simIVtransfusion_50] = MergeSimulations(simIVtransfusion_50,simIVtransfusion_50B,pNames);
param(ismember(pNames,"IVTransfusion")) = 5/60; %nmol/min
simIVtransfusion_5     = model(0:1:180,initialvalues,param);
param(ismember(pNames,"IVTransfusion")) = 0;
simIVtransfusion_5B    = model(180:1:420,simIVtransfusion_5.statevalues(end,:),param);
[simIVtransfusion_5] = MergeSimulations(simIVtransfusion_5,simIVtransfusion_5B,pNames);
param(ismember(pNames,"IVTransfusion")) = 0.5/60; %nmol/min
simIVtransfusion_0p5     = model(0:1:180,initialvalues,param);
param(ismember(pNames,"IVTransfusion")) = 0;
simIVtransfusion_0p5B    = model(180:1:420,simIVtransfusion_0p5.statevalues(end,:),param);
[simIVtransfusion_0p5] = MergeSimulations(simIVtransfusion_0p5,simIVtransfusion_0p5B,pNames);

initialvalues = initialvaluesReset;

% SC
initialvalues(ismember(sNames,"A")) = 50*ConditionAlterations.f(2); %nmol
simSC_50    = model(0:1:420,initialvalues,param);
initialvalues(ismember(sNames,"A")) = 5*ConditionAlterations.f(2);
simSC_5     = model(0:1:420,initialvalues,param);
initialvalues(ismember(sNames,"A")) = 0.5*ConditionAlterations.f(2);
simSC_0p5   = model(0:1:420,initialvalues,param);
initialvalues(ismember(sNames,"A")) = 0;

%% PD simulation

if SimulatePD == 1 % to minimise workload PD simulation is only done when needed to declared with SimulatePD

param = paramReset;
UnitConvertion       = 0.001*0.34;   %pMol/kg/min to nMol/min where 0.34 is rat kg
GlucoseInjection     =  5.7*180.156; % mg/kg/min: glucose was added (5.7 mmol/kg) at the rate of 0.5ml/min over 2-3 min
TimeRes              = 1;            % var used to increase or decrease simulation resolution. note that costfunction is made for res=1

% Vehicle
param(ismember(pNames,"IVTransfusion")) = 0*UnitConvertion;
simRatpd_vehicle     = model(0:TimeRes:30,initialvaluesReset,param);
param(ismember(pNames,"GlucoseInjection")) = GlucoseInjection;
simRatpd_vehicleB    = model(30:TimeRes:32,simRatpd_vehicle.statevalues(end,:),param);
param(ismember(pNames,"GlucoseInjection")) = 0;
[simRatpd_vehicle] = MergeSimulations(simRatpd_vehicle,simRatpd_vehicleB,pNames);
simRatpd_vehicleB    = model(32:TimeRes:120,simRatpd_vehicle.statevalues(end,:),param);
[simRatpd_vehicle] = MergeSimulations(simRatpd_vehicle,simRatpd_vehicleB,pNames);
param = paramReset;

% 3
param(ismember(pNames,"IVTransfusion")) = 3*UnitConvertion;
simRatpd_3     = model(0:TimeRes:30,initialvaluesReset,param);
param(ismember(pNames,"GlucoseInjection")) = GlucoseInjection;
simRatpd_3B    = model(30:TimeRes:32,simRatpd_3.statevalues(end,:),param);
param(ismember(pNames,"GlucoseInjection")) = 0;
[simRatpd_3] = MergeSimulations(simRatpd_3,simRatpd_3B,pNames);
simRatpd_3B    = model(32:TimeRes:120,simRatpd_3.statevalues(end,:),param);
[simRatpd_3] = MergeSimulations(simRatpd_3,simRatpd_3B,pNames);
param = paramReset;

% 30
param(ismember(pNames,"IVTransfusion")) = 30*UnitConvertion;
simRatpd_30     = model(0:TimeRes:30,initialvaluesReset,param);
param(ismember(pNames,"GlucoseInjection")) = GlucoseInjection;
simRatpd_30B    = model(30:TimeRes:32,simRatpd_30.statevalues(end,:),param);
param(ismember(pNames,"GlucoseInjection")) = 0;
[simRatpd_30] = MergeSimulations(simRatpd_30,simRatpd_30B,pNames);
simRatpd_30B    = model(32:TimeRes:120,simRatpd_30.statevalues(end,:),param);
[simRatpd_30] = MergeSimulations(simRatpd_30,simRatpd_30B,pNames);
param = paramReset;

% 300
param(ismember(pNames,"IVTransfusion")) = 300*UnitConvertion;
simRatpd_300     = model(0:TimeRes:30,initialvaluesReset,param);
param(ismember(pNames,"GlucoseInjection")) = GlucoseInjection;
simRatpd_300B    = model(30:TimeRes:32,simRatpd_300.statevalues(end,:),param);
param(ismember(pNames,"GlucoseInjection")) = 0;
[simRatpd_300] = MergeSimulations(simRatpd_300,simRatpd_300B,pNames);
simRatpd_300B    = model(32:TimeRes:120,simRatpd_300.statevalues(end,:),param);
[simRatpd_300] = MergeSimulations(simRatpd_300,simRatpd_300B,pNames);
param = paramReset;

% 3000
param(ismember(pNames,"IVTransfusion")) = 3000*UnitConvertion;
simRatpd_3000     = model(0:TimeRes:30,initialvaluesReset,param);
param(ismember(pNames,"GlucoseInjection")) = GlucoseInjection;
simRatpd_3000B    = model(30:TimeRes:32,simRatpd_3000.statevalues(end,:),param);
param(ismember(pNames,"GlucoseInjection")) = 0;
[simRatpd_3000] = MergeSimulations(simRatpd_3000,simRatpd_3000B,pNames);
simRatpd_3000B    = model(32:TimeRes:120,simRatpd_3000.statevalues(end,:),param);
[simRatpd_3000] = MergeSimulations(simRatpd_3000,simRatpd_3000B,pNames);

else
simRatpd_vehicle = 0;
simRatpd_3       = 0;
simRatpd_30      = 0;
simRatpd_300     = 0;
simRatpd_3000    = 0;
end

end

