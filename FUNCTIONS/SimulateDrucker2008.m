function [SimDruckerInVitroHuman,SimDruckerRat] = SimulateDrucker2008(params_tempInVitro,params_tempRat,OptimisedEffects,Ducker2008_data,pNames,sNames,initialvalues,model,ForcedDietChange)

GlucoseOverHealthy = OptimisedEffects(1);
CaloriesInMeal     = OptimisedEffects(2);

CarbohydrateInMeal_Test = CaloriesInMeal*1000*0.55/4;
ProteinInMeal_Test      = CaloriesInMeal*1000*0.15/4;

CarbohydrateInMeal_HighAppetite = CarbohydrateInMeal_Test;
ProteinInMeal_HighAppetite      = ProteinInMeal_Test;
CarbohydrateInMeal_LowAppetite  = 0.7*CarbohydrateInMeal_HighAppetite;
ProteinInMeal_LowAppetite       = 0.7*ProteinInMeal_HighAppetite;

Bioavailability = OptimisedEffects(3);
ExenatideDose   = 2*1000000/4186; % mg to nMol
initialvalues(ismember(sNames,"GlucoseOverHealthy")) = GlucoseOverHealthy; % add one parameter

%% Steady state Exenatide once a week (2 mg/week)

CarbohydrateInMeal             = CarbohydrateInMeal_HighAppetite;
ProteinInMeal                  = ProteinInMeal_HighAppetite;

params_tempRat(ismember(pNames,"GlucoseInjection"))      = 0;
params_tempRat(ismember(pNames,"Meal_ProteinFlow"))      = 0;
params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow"))= 0;
params_tempRat(ismember(pNames,"BW"))                    = 102;
params_tempRat(ismember(pNames,"IVTransfusion"))         = 0;
params_tempRat(ismember(pNames,"D")) = CarbohydrateInMeal;

sim_SteadyStateW    = model(0:1:1,initialvalues,params_tempRat); % START 00:00
sim_SteadyStateInitial = sim_SteadyStateW.statevalues(end,:);

for i = 0:9 % 1 week steady state low res
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    sim_SteadyStateW     = model(0:420:420,sim_SteadyStateInitial,params_tempRat); % START 07:00
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = ProteinInMeal/15;
    sim_SteadyStateW    = model(420:15:435,sim_SteadyStateW.statevalues(end,:),params_tempRat); % START 07:15
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    sim_SteadyStateW     = model(435:345:780,sim_SteadyStateW.statevalues(end,:),params_tempRat); % START 07:00
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = ProteinInMeal/15;
    sim_SteadyStateW    = model(780:15:795,sim_SteadyStateW.statevalues(end,:),params_tempRat); % START 07:15
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    sim_SteadyStateW    = model(795:285:1080,sim_SteadyStateW.statevalues(end,:),params_tempRat); % START 07:15
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow"))     = ProteinInMeal/15;
    sim_SteadyStateW    = model(1080:15:1095,sim_SteadyStateW.statevalues(end,:),params_tempRat); % START 07:15
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))        = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow"))  = 0;
    sim_SteadyStateW    = model(1095:345:1440,sim_SteadyStateW.statevalues(end,:),params_tempRat); % START 07:15
    
    sim_SteadyStateInitial = sim_SteadyStateW.statevalues(end,:);
    sim_SteadyStateInitial(ismember(sNames,"GlucoseOverHealthy")) = GlucoseOverHealthy;
    
end

SimDruckerW    = model(0:1:1,sim_SteadyStateW.statevalues(end,:),params_tempRat); % START 00:00
InitialValuesW  = SimDruckerW.statevalues(end,:);

for day = 0:3 % 4 days steady state high res
    SimDruckerW2    = model(0+ (day*1440):5:420+ (day*1440),InitialValuesW,params_tempRat); % START 00:00
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
    SimDruckerW3     = model(420+ (day*1440):5:435+ (day*1440),SimDruckerW2.statevalues(end,:),params_tempRat); % START 07:00
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    SimDruckerW4    = model(435+ (day*1440):5:780+ (day*1440),SimDruckerW3.statevalues(end,:),params_tempRat); % START 07:15
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
    SimDruckerW5     = model(780+ (day*1440):5:795+ (day*1440),SimDruckerW4.statevalues(end,:),params_tempRat); % START 13:00
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    SimDruckerW6    = model(795+ (day*1440):5:1080+ (day*1440),SimDruckerW5.statevalues(end,:),params_tempRat); % START 13:15
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
    SimDruckerW7     = model(1080+ (day*1440):5:1095+ (day*1440),SimDruckerW6.statevalues(end,:),params_tempRat); % START 18:00
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    SimDruckerW8    = model(1095+ (day*1440):5:1440+ (day*1440),SimDruckerW7.statevalues(end,:),params_tempRat); % START 18:15
    
    SimDruckerW.time           = [SimDruckerW.time(1:end-1),             SimDruckerW2.time(1:end-1),             SimDruckerW3.time(1:end-1),             SimDruckerW4.time(1:end-1),             SimDruckerW5.time(1:end-1),             SimDruckerW6.time(1:end-1),             SimDruckerW7.time(1:end-1),             SimDruckerW8.time(1:end),           ];
    SimDruckerW.variablevalues = [SimDruckerW.variablevalues(1:end-1,:); SimDruckerW2.variablevalues(1:end-1,:); SimDruckerW3.variablevalues(1:end-1,:); SimDruckerW4.variablevalues(1:end-1,:); SimDruckerW5.variablevalues(1:end-1,:); SimDruckerW6.variablevalues(1:end-1,:); SimDruckerW7.variablevalues(1:end-1,:); SimDruckerW8.variablevalues(1:end,:)];
    SimDruckerW.reactionvalues = [SimDruckerW.reactionvalues(1:end-1,:); SimDruckerW2.reactionvalues(1:end-1,:); SimDruckerW3.reactionvalues(1:end-1,:); SimDruckerW4.reactionvalues(1:end-1,:); SimDruckerW5.reactionvalues(1:end-1,:); SimDruckerW6.reactionvalues(1:end-1,:); SimDruckerW7.reactionvalues(1:end-1,:); SimDruckerW8.reactionvalues(1:end,:)];
    SimDruckerW.statevalues    = [SimDruckerW.statevalues(1:end-1,:);    SimDruckerW2.statevalues(1:end-1,:);    SimDruckerW3.statevalues(1:end-1,:);    SimDruckerW4.statevalues(1:end-1,:);    SimDruckerW5.statevalues(1:end-1,:);    SimDruckerW6.statevalues(1:end-1,:);    SimDruckerW7.statevalues(1:end-1,:);    SimDruckerW8.statevalues(1:end,:);  ];
    SimDruckerW.variables      = [SimDruckerW.variables];
    SimDruckerW.reactions      = [SimDruckerW.reactions];
    SimDruckerW.states         = [SimDruckerW.states];
    
    InitialValuesW  = SimDruckerW.statevalues(end,:);
end

InitialValuesReset = InitialValuesW;

%%

if ForcedDietChange == 1
    CarbohydrateInMeal_HighAppetite = 0.8*CarbohydrateInMeal_HighAppetite;
    ProteinInMeal_HighAppetite      = 0.8*ProteinInMeal_HighAppetite;
end

%% In Vitro exenatide once a week (2 mg/week)

CarbohydrateInMeal             = CarbohydrateInMeal_HighAppetite;
ProteinInMeal                  = ProteinInMeal_HighAppetite;

params_tempInVitro(ismember(pNames,"GlucoseInjection"))      = 0;
params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))      = 0;
params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow"))= 0;
params_tempInVitro(ismember(pNames,"BW"))                    = 102;
params_tempInVitro(ismember(pNames,"IVTransfusion"))         = 0;
params_tempInVitro(ismember(pNames,"D")) = CarbohydrateInMeal;

try
    InitialValuesW  = InitialValuesReset;
    SimDruckerW     = model(0:1:1,InitialValuesReset,params_tempInVitro); % START 00:00
    
    % D0
    for day = 0:209 % 210 days in 30 weeks

        SimDruckerW2    = model(0+ (day*1440):5:420+ (day*1440),InitialValuesW,params_tempInVitro); % START 00:00
        params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
        params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
        SimDruckerW3     = model(420+ (day*1440):5:435+ (day*1440),SimDruckerW2.statevalues(end,:),params_tempInVitro); % START 07:00
        
        if sum(day == [0, 98 , 203])
            
            params_tempInVitro(ismember(pNames,"D")) = CarbohydrateInMeal_Test;
            params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal_Test/15;
            params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal_Test/15;
            SimDruckerW3     = model(420+ (day*1440):5:435+ (day*1440),SimDruckerW2.statevalues(end,:),params_tempInVitro); % START 07:00
           
            params_tempInVitro(ismember(pNames,"D")) = CarbohydrateInMeal;

        end
        
        params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))       = 0;
        params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
        SimDruckerW4    = model(435+ (day*1440):5:780+ (day*1440),SimDruckerW3.statevalues(end,:),params_tempInVitro); % START 07:15
        params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
        params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
        SimDruckerW5     = model(780+ (day*1440):5:795+ (day*1440),SimDruckerW4.statevalues(end,:),params_tempInVitro); % START 13:00
        params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))       = 0;
        params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
        SimDruckerW6    = model(795+ (day*1440):5:1080+ (day*1440),SimDruckerW5.statevalues(end,:),params_tempInVitro); % START 13:15
        params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
        params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
        SimDruckerW7     = model(1080+ (day*1440):5:1095+ (day*1440),SimDruckerW6.statevalues(end,:),params_tempInVitro); % START 18:00
        params_tempInVitro(ismember(pNames,"Meal_ProteinFlow"))       = 0;
        params_tempInVitro(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
        SimDruckerW8    = model(1095+ (day*1440):5:1440+ (day*1440),SimDruckerW7.statevalues(end,:),params_tempInVitro); % START 18:15
        
        SimDruckerW.time           = [SimDruckerW.time(1:end-1),             SimDruckerW2.time(1:end-1),             SimDruckerW3.time(1:end-1),             SimDruckerW4.time(1:end-1),             SimDruckerW5.time(1:end-1),             SimDruckerW6.time(1:end-1),             SimDruckerW7.time(1:end-1),             SimDruckerW8.time(1:end),           ];
        SimDruckerW.variablevalues = [SimDruckerW.variablevalues(1:end-1,:); SimDruckerW2.variablevalues(1:end-1,:); SimDruckerW3.variablevalues(1:end-1,:); SimDruckerW4.variablevalues(1:end-1,:); SimDruckerW5.variablevalues(1:end-1,:); SimDruckerW6.variablevalues(1:end-1,:); SimDruckerW7.variablevalues(1:end-1,:); SimDruckerW8.variablevalues(1:end,:)];
        SimDruckerW.reactionvalues = [SimDruckerW.reactionvalues(1:end-1,:); SimDruckerW2.reactionvalues(1:end-1,:); SimDruckerW3.reactionvalues(1:end-1,:); SimDruckerW4.reactionvalues(1:end-1,:); SimDruckerW5.reactionvalues(1:end-1,:); SimDruckerW6.reactionvalues(1:end-1,:); SimDruckerW7.reactionvalues(1:end-1,:); SimDruckerW8.reactionvalues(1:end,:)];
        SimDruckerW.statevalues    = [SimDruckerW.statevalues(1:end-1,:);    SimDruckerW2.statevalues(1:end-1,:);    SimDruckerW3.statevalues(1:end-1,:);    SimDruckerW4.statevalues(1:end-1,:);    SimDruckerW5.statevalues(1:end-1,:);    SimDruckerW6.statevalues(1:end-1,:);    SimDruckerW7.statevalues(1:end-1,:);    SimDruckerW8.statevalues(1:end,:);  ];
        SimDruckerW.variables      = [SimDruckerW.variables];
        SimDruckerW.reactions      = [SimDruckerW.reactions];
        SimDruckerW.states         = [SimDruckerW.states];
        
        InitialValuesW  = SimDruckerW.statevalues(end,:);
        if sum(day == [7:7:209])
            InitialValuesW(ismember(sNames,"Aslow")) = InitialValuesW(ismember(sNames,"Aslow")) + Bioavailability*ExenatideDose;
        end
        
        if SimDruckerW.reactionvalues(end,ismember(SimDruckerW.reactions,'Exanitide_PD')) > 0.1*params_tempInVitro(ismember(pNames,"ExenatideInsulinMax"))
            CarbohydrateInMeal                       = CarbohydrateInMeal_LowAppetite;
            ProteinInMeal                            = ProteinInMeal_LowAppetite;
            params_tempInVitro(ismember(pNames,"D")) = CarbohydrateInMeal;
        end
        
    end
    SimDruckerInVitroHuman = SimDruckerW;
    
catch error
    disp('In vitro human params end')
    SimDruckerInVitroHuman = [];
end
%% Rat

CarbohydrateInMeal             = CarbohydrateInMeal_HighAppetite;
ProteinInMeal                  = ProteinInMeal_HighAppetite;

params_tempRat(ismember(pNames,"GlucoseInjection"))      = 0;
params_tempRat(ismember(pNames,"Meal_ProteinFlow"))      = 0;
params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow"))= 0;
params_tempRat(ismember(pNames,"BW"))                    = 102;
params_tempRat(ismember(pNames,"IVTransfusion"))         = 0;
params_tempRat(ismember(pNames,"D")) = CarbohydrateInMeal;

InitialValuesW  = InitialValuesReset;
SimDruckerW     = model(0:1:1,InitialValuesReset,params_tempRat); % START 00:00

% D0
for day = 0:209 % 210 days in 30 weeks
   
    SimDruckerW2    = model(0+ (day*1440):5:420+ (day*1440),InitialValuesW,params_tempRat); % START 00:00
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
    SimDruckerW3     = model(420+ (day*1440):5:435+ (day*1440),SimDruckerW2.statevalues(end,:),params_tempRat); % START 07:00
    
    if  sum(day == [0 , 98 , 203])

        params_tempRat(ismember(pNames,"D")) = CarbohydrateInMeal_Test;
        params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal_Test/15;
        params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal_Test/15;
        SimDruckerW3     = model(420+ (day*1440):5:435+ (day*1440),SimDruckerW2.statevalues(end,:),params_tempRat); % START 07:00

       params_tempRat(ismember(pNames,"D")) = CarbohydrateInMeal;
    end
    
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    SimDruckerW4    = model(435+ (day*1440):5:780+ (day*1440),SimDruckerW3.statevalues(end,:),params_tempRat); % START 07:15
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
    SimDruckerW5     = model(780+ (day*1440):5:795+ (day*1440),SimDruckerW4.statevalues(end,:),params_tempRat); % START 13:00
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    SimDruckerW6    = model(795+ (day*1440):5:1080+ (day*1440),SimDruckerW5.statevalues(end,:),params_tempRat); % START 13:15
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = CarbohydrateInMeal/15;
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = ProteinInMeal/15;
    SimDruckerW7     = model(1080+ (day*1440):5:1095+ (day*1440),SimDruckerW6.statevalues(end,:),params_tempRat); % START 18:00
    params_tempRat(ismember(pNames,"Meal_ProteinFlow"))       = 0;
    params_tempRat(ismember(pNames,"Meal_CarbohydratesFlow")) = 0;
    SimDruckerW8    = model(1095+ (day*1440):5:1440+ (day*1440),SimDruckerW7.statevalues(end,:),params_tempRat); % START 18:15
    
    SimDruckerW.time           = [SimDruckerW.time(1:end-1),             SimDruckerW2.time(1:end-1),             SimDruckerW3.time(1:end-1),             SimDruckerW4.time(1:end-1),             SimDruckerW5.time(1:end-1),             SimDruckerW6.time(1:end-1),             SimDruckerW7.time(1:end-1),             SimDruckerW8.time(1:end),           ];
    SimDruckerW.variablevalues = [SimDruckerW.variablevalues(1:end-1,:); SimDruckerW2.variablevalues(1:end-1,:); SimDruckerW3.variablevalues(1:end-1,:); SimDruckerW4.variablevalues(1:end-1,:); SimDruckerW5.variablevalues(1:end-1,:); SimDruckerW6.variablevalues(1:end-1,:); SimDruckerW7.variablevalues(1:end-1,:); SimDruckerW8.variablevalues(1:end,:)];
    SimDruckerW.reactionvalues = [SimDruckerW.reactionvalues(1:end-1,:); SimDruckerW2.reactionvalues(1:end-1,:); SimDruckerW3.reactionvalues(1:end-1,:); SimDruckerW4.reactionvalues(1:end-1,:); SimDruckerW5.reactionvalues(1:end-1,:); SimDruckerW6.reactionvalues(1:end-1,:); SimDruckerW7.reactionvalues(1:end-1,:); SimDruckerW8.reactionvalues(1:end,:)];
    SimDruckerW.statevalues    = [SimDruckerW.statevalues(1:end-1,:);    SimDruckerW2.statevalues(1:end-1,:);    SimDruckerW3.statevalues(1:end-1,:);    SimDruckerW4.statevalues(1:end-1,:);    SimDruckerW5.statevalues(1:end-1,:);    SimDruckerW6.statevalues(1:end-1,:);    SimDruckerW7.statevalues(1:end-1,:);    SimDruckerW8.statevalues(1:end,:);  ];
    SimDruckerW.variables      = [SimDruckerW.variables];
    SimDruckerW.reactions      = [SimDruckerW.reactions];
    SimDruckerW.states         = [SimDruckerW.states];
    
    InitialValuesW  = SimDruckerW.statevalues(end,:);
    if sum(day == [7:7:209])
        InitialValuesW(ismember(sNames,"Aslow")) = InitialValuesW(ismember(sNames,"Aslow")) + Bioavailability*ExenatideDose;
    end
    
    if SimDruckerW.reactionvalues(end,ismember(SimDruckerW.reactions,'Exanitide_PD')) > 0.1*params_tempRat(ismember(pNames,"ExenatideInsulinMax"))
        CarbohydrateInMeal                       = CarbohydrateInMeal_LowAppetite;
        ProteinInMeal                            = ProteinInMeal_LowAppetite;
        params_tempRat(ismember(pNames,"D")) = CarbohydrateInMeal;
        
    end
end
SimDruckerRat = SimDruckerW;

end

