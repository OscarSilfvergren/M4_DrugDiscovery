%% GSIS
if j == 1
    simBestStudy5_GSIS = simStudy5_GSIS;
    
    % D0
    maxsimStudy5_ERD0_LG1 = simStudy5_GSIS.SaveInsulinSecretionD0(:,1);
    minsimStudy5_ERD0_LG1 = maxsimStudy5_ERD0_LG1;
    maxsimStudy5_ERD0_LG2 = simStudy5_GSIS.SaveInsulinSecretionD0(:,2);
    minsimStudy5_ERD0_LG2 = maxsimStudy5_ERD0_LG2;
    
    % D15
    maxsimStudy5_ERD15_LG1 = [simStudy5_GSIS.SaveInsulinSecretionD15vehicle(1), simStudy5_GSIS.SaveInsulinSecretionD15_0p1(1), simStudy5_GSIS.SaveInsulinSecretionD15_10(1), simStudy5_GSIS.SaveInsulinSecretionD15_1000(1)];
    minsimStudy5_ERD15_LG1 = maxsimStudy5_ERD15_LG1;
    maxsimStudy5_ERD15_LG2 = [simStudy5_GSIS.SaveInsulinSecretionD15vehicle(2), simStudy5_GSIS.SaveInsulinSecretionD15_0p1(2), simStudy5_GSIS.SaveInsulinSecretionD15_10(2), simStudy5_GSIS.SaveInsulinSecretionD15_1000(2)];
    minsimStudy5_ERD15_LG2 = maxsimStudy5_ERD15_LG2;
end

% ERD0_LG
NewsimStudy5_ERD0_LG1 = simStudy5_GSIS.SaveInsulinSecretionD0(:,1);
minsimStudy5_ERD0_LG1 = min(minsimStudy5_ERD0_LG1,NewsimStudy5_ERD0_LG1);
maxsimStudy5_ERD0_LG1 = max(maxsimStudy5_ERD0_LG1,NewsimStudy5_ERD0_LG1);
NewsimStudy5_ERD0_LG2 = simStudy5_GSIS.SaveInsulinSecretionD0(:,2);
minsimStudy5_ERD0_LG2 = min(minsimStudy5_ERD0_LG2,NewsimStudy5_ERD0_LG2);
maxsimStudy5_ERD0_LG2 = max(maxsimStudy5_ERD0_LG2,NewsimStudy5_ERD0_LG2);

% ERD15_LG
NewsimStudy5_ERD15_LG1 = [simStudy5_GSIS.SaveInsulinSecretionD15vehicle(1), simStudy5_GSIS.SaveInsulinSecretionD15_0p1(1), simStudy5_GSIS.SaveInsulinSecretionD15_10(1), simStudy5_GSIS.SaveInsulinSecretionD15_1000(1)];
minsimStudy5_ERD15_LG1 = min(minsimStudy5_ERD15_LG1,NewsimStudy5_ERD15_LG1);
maxsimStudy5_ERD15_LG1 = max(maxsimStudy5_ERD15_LG1,NewsimStudy5_ERD15_LG1);
NewsimStudy5_ERD15_LG2 = [simStudy5_GSIS.SaveInsulinSecretionD15vehicle(2), simStudy5_GSIS.SaveInsulinSecretionD15_0p1(2), simStudy5_GSIS.SaveInsulinSecretionD15_10(2), simStudy5_GSIS.SaveInsulinSecretionD15_1000(2)];
minsimStudy5_ERD15_LG2 = min(minsimStudy5_ERD15_LG2,NewsimStudy5_ERD15_LG2);
maxsimStudy5_ERD15_LG2 = max(maxsimStudy5_ERD15_LG2,NewsimStudy5_ERD15_LG2);


%% 2OC

if j == 1
    SimBestStudy4_vehicle = SimStudy4_vehicle;
    SimBestStudy4_0p1 = SimStudy4_0p1;
    SimBestStudy4_10 = SimStudy4_10;
    SimBestStudy4_1000 = SimStudy4_1000;
    
    % simStudy4_2OC
    maxStudy4_2OC_VehicleI = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Insulin_Medium'));
    minStudy4_2OC_VehicleI = maxStudy4_2OC_VehicleI;
        % simStudy4_2OC
    maxStudy4_2OC_0p1I = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Insulin_Medium'));
    minStudy4_2OC_0p1I = maxStudy4_2OC_0p1I;
        % simStudy4_2OC
    maxStudy4_2OC_10I = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Insulin_Medium'));
    minStudy4_2OC_10I = maxStudy4_2OC_10I;
        % simStudy4_2OC
    maxStudy4_2OC_1000I = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Insulin_Medium'));
    minStudy4_2OC_1000I = maxStudy4_2OC_1000I;
    
        % simStudy4_2OC
    maxStudy4_2OC_VehicleG = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Glucose_Medium'));
    minStudy4_2OC_VehicleG = maxStudy4_2OC_VehicleG;
        % simStudy4_2OC
    maxStudy4_2OC_0p1G = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Glucose_Medium'));
    minStudy4_2OC_0p1G = maxStudy4_2OC_0p1G;
        % simStudy4_2OC
    maxStudy4_2OC_10G = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Glucose_Medium'));
    minStudy4_2OC_10G = maxStudy4_2OC_10G;
        % simStudy4_2OC
    maxStudy4_2OC_1000G = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Glucose_Medium'));
    minStudy4_2OC_1000G = maxStudy4_2OC_1000G;
    
            % simStudy4_2OC
    maxStudy4_2OC_VehicleL = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Lactate_Medium'));
    minStudy4_2OC_VehicleL = maxStudy4_2OC_VehicleL;
        % simStudy4_2OC
    maxStudy4_2OC_0p1L = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Lactate_Medium'));
    minStudy4_2OC_0p1L = maxStudy4_2OC_0p1L;
        % simStudy4_2OC
    maxStudy4_2OC_10L = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Lactate_Medium'));
    minStudy4_2OC_10L = maxStudy4_2OC_10L;
        % simStudy4_2OC
    maxStudy4_2OC_1000L = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Lactate_Medium'));
    minStudy4_2OC_1000L = maxStudy4_2OC_1000L;
    
    % simStudy4_2OC
    maxStudy4_2OC_VehicleE = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Exenatide_Medium'));
    minStudy4_2OC_VehicleE = maxStudy4_2OC_VehicleE;
        % simStudy4_2OC
    maxStudy4_2OC_0p1E = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Exenatide_Medium'));
    minStudy4_2OC_0p1E = maxStudy4_2OC_0p1E;
        % simStudy4_2OC
    maxStudy4_2OC_10E = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Exenatide_Medium'));
    minStudy4_2OC_10E = maxStudy4_2OC_10E;
        % simStudy4_2OC
    maxStudy4_2OC_1000E = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Exenatide_Medium'));
    minStudy4_2OC_1000E = maxStudy4_2OC_1000E;
    
    
end
NewStudy4_2OC_VehicleI = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Insulin_Medium'));
minStudy4_2OC_VehicleI = min(minStudy4_2OC_VehicleI,NewStudy4_2OC_VehicleI);
maxStudy4_2OC_VehicleI = max(maxStudy4_2OC_VehicleI,NewStudy4_2OC_VehicleI);
NewStudy4_2OC_0p1I = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Insulin_Medium'));
minStudy4_2OC_0p1I = min(minStudy4_2OC_0p1I,NewStudy4_2OC_0p1I);
maxStudy4_2OC_0p1I = max(maxStudy4_2OC_0p1I,NewStudy4_2OC_0p1I);
NewStudy4_2OC_10I = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Insulin_Medium'));
minStudy4_2OC_10I = min(minStudy4_2OC_10I,NewStudy4_2OC_10I);
maxStudy4_2OC_10I = max(maxStudy4_2OC_10I,NewStudy4_2OC_10I);
NewStudy4_2OC_1000I = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Insulin_Medium'));
minStudy4_2OC_1000I = min(minStudy4_2OC_1000I,NewStudy4_2OC_1000I);
maxStudy4_2OC_1000I = max(maxStudy4_2OC_1000I,NewStudy4_2OC_1000I);

NewStudy4_2OC_VehicleG = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Glucose_Medium'));
minStudy4_2OC_VehicleG = min(minStudy4_2OC_VehicleG,NewStudy4_2OC_VehicleG);
maxStudy4_2OC_VehicleG = max(maxStudy4_2OC_VehicleG,NewStudy4_2OC_VehicleG);
NewStudy4_2OC_0p1G = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Glucose_Medium'));
minStudy4_2OC_0p1G = min(minStudy4_2OC_0p1G,NewStudy4_2OC_0p1G);
maxStudy4_2OC_0p1G = max(maxStudy4_2OC_0p1G,NewStudy4_2OC_0p1G);
NewStudy4_2OC_10G = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Glucose_Medium'));
minStudy4_2OC_10G = min(minStudy4_2OC_10G,NewStudy4_2OC_10G);
maxStudy4_2OC_10G = max(maxStudy4_2OC_10G,NewStudy4_2OC_10G);
NewStudy4_2OC_1000G = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Glucose_Medium'));
minStudy4_2OC_1000G = min(minStudy4_2OC_1000G,NewStudy4_2OC_1000G);
maxStudy4_2OC_1000G = max(maxStudy4_2OC_1000G,NewStudy4_2OC_1000G);

NewStudy4_2OC_VehicleL = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Lactate_Medium'));
minStudy4_2OC_VehicleL = min(minStudy4_2OC_VehicleL,NewStudy4_2OC_VehicleL);
maxStudy4_2OC_VehicleL = max(maxStudy4_2OC_VehicleL,NewStudy4_2OC_VehicleL);
NewStudy4_2OC_0p1L = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Lactate_Medium'));
minStudy4_2OC_0p1L = min(minStudy4_2OC_0p1L,NewStudy4_2OC_0p1L);
maxStudy4_2OC_0p1L = max(maxStudy4_2OC_0p1L,NewStudy4_2OC_0p1L);
NewStudy4_2OC_10L = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Lactate_Medium'));
minStudy4_2OC_10L = min(minStudy4_2OC_10L,NewStudy4_2OC_10L);
maxStudy4_2OC_10L = max(maxStudy4_2OC_10L,NewStudy4_2OC_10L);
NewStudy4_2OC_1000L = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Lactate_Medium'));
minStudy4_2OC_1000L = min(minStudy4_2OC_1000L,NewStudy4_2OC_1000L);
maxStudy4_2OC_1000L = max(maxStudy4_2OC_1000L,NewStudy4_2OC_1000L);

NewStudy4_2OC_VehicleE = SimStudy4_vehicle.statevalues(:,ismember(SimStudy4_vehicle.states,'Exenatide_Medium'));
minStudy4_2OC_VehicleE = min(minStudy4_2OC_VehicleE,NewStudy4_2OC_VehicleE);
maxStudy4_2OC_VehicleE = max(maxStudy4_2OC_VehicleE,NewStudy4_2OC_VehicleE);
NewStudy4_2OC_0p1E = SimStudy4_0p1.statevalues(:,ismember(SimStudy4_0p1.states,'Exenatide_Medium'));
minStudy4_2OC_0p1E = min(minStudy4_2OC_0p1E,NewStudy4_2OC_0p1E);
maxStudy4_2OC_0p1E = max(maxStudy4_2OC_0p1E,NewStudy4_2OC_0p1E);
NewStudy4_2OC_10E = SimStudy4_10.statevalues(:,ismember(SimStudy4_10.states,'Exenatide_Medium'));
minStudy4_2OC_10E = min(minStudy4_2OC_10E,NewStudy4_2OC_10E);
maxStudy4_2OC_10E = max(maxStudy4_2OC_10E,NewStudy4_2OC_10E);
NewStudy4_2OC_1000E = SimStudy4_1000.statevalues(:,ismember(SimStudy4_1000.states,'Exenatide_Medium'));
minStudy4_2OC_1000E = min(minStudy4_2OC_1000E,NewStudy4_2OC_1000E);
maxStudy4_2OC_1000E = max(maxStudy4_2OC_1000E,NewStudy4_2OC_1000E);