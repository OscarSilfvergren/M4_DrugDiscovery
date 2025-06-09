%% GSIS
if j == 1
    
    % Control
    maxsimExpIS_Control = simInsulinPhases_GSIS.Simulation(1,:)./simInsulinPhases_GSIS.Simulation(1,1);
    minsimExpIS_Control = maxsimExpIS_Control;
    BestsimExpIS_Control = maxsimExpIS_Control;
    % Exenatide
    maxsimExpIS_Exenatide = simInsulinPhases_GSIS.Simulation(2,:)./simInsulinPhases_GSIS.Simulation(2,1);
    minsimExpIS_Exenatide = maxsimExpIS_Exenatide;
    BestsimExpIS_Exenatide = maxsimExpIS_Exenatide;
    % Data
    maxsimExpIS_Data  = simInsulinPhases_GSIS.Data;
    minsimExpIS_Data  = maxsimExpIS_Data;
    BestsimExpIS_Data = maxsimExpIS_Data;
    
end
% SM
NewsimExpIS_Control = simInsulinPhases_GSIS.Simulation(1,:)./simInsulinPhases_GSIS.Simulation(1,1);
minsimExpIS_Control = min(minsimExpIS_Control,NewsimExpIS_Control);
maxsimExpIS_Control = max(maxsimExpIS_Control,NewsimExpIS_Control);
NewsimExpIS_Exenatide = simInsulinPhases_GSIS.Simulation(2,:)./simInsulinPhases_GSIS.Simulation(2,1);
minsimExpIS_Exenatide = min(minsimExpIS_Exenatide,NewsimExpIS_Exenatide);
maxsimExpIS_Exenatide = max(maxsimExpIS_Exenatide,NewsimExpIS_Exenatide);

NewsimExpIS_Data = simInsulinPhases_GSIS.Data;
minsimExpIS_Data = min(minsimExpIS_Data,NewsimExpIS_Data);
maxsimExpIS_Data = max(maxsimExpIS_Data,NewsimExpIS_Data);


%% Flow

if j == 1
    % simExpIS_LO
    maxExpIS_flow0  = simInsulinPhases_flow0.variablevalues(:,ismember(simInsulinPhases_flow0.variables,'S'))./simInsulinPhases_flow0.variablevalues(2,ismember(simInsulinPhases_flow0.variables,'S'));
    minExpIS_flow0  = maxExpIS_flow0;
    BestExpIS_flow0 = maxExpIS_flow0;
        % simInsulinPhases_flow100
    maxExpIS_flow100  = simInsulinPhases_flow100.variablevalues(:,ismember(simInsulinPhases_flow100.variables,'S'))./simInsulinPhases_flow100.variablevalues(2,ismember(simInsulinPhases_flow100.variables,'S'));
    minExpIS_flow100  = maxExpIS_flow100;
    BestExpIS_flow100 = maxExpIS_flow100;
    % simExpIS_LO
    maxExpIS_A2  = simInsulinPhases_Article2.variablevalues(:,ismember(simInsulinPhases_Article2.variables,'S'))./simInsulinPhases_Article2.variablevalues(2,ismember(simInsulinPhases_Article2.variables,'S'));
    minExpIS_A2  = maxExpIS_A2;
    BestExpIS_A2 = maxExpIS_A2;
    
    % simExpIS_LO
    maxExpIS_static0  = simInsulinPhases_static0.variablevalues(:,ismember(simInsulinPhases_static0.variables,'S'))./simInsulinPhases_static0.variablevalues(2,ismember(simInsulinPhases_static0.variables,'S'));
    minExpIS_static0  = maxExpIS_static0;
    BestExpIS_static0 = maxExpIS_static0;
    % simExpIS_LO
    maxExpIS_static100  = simInsulinPhases_static100.variablevalues(:,ismember(simInsulinPhases_static100.variables,'S'))./simInsulinPhases_static100.variablevalues(2,ismember(simInsulinPhases_static100.variables,'S'));
    minExpIS_static100  = maxExpIS_static100;
    BestExpIS_static100 = maxExpIS_static100;
end

NewExpIS_flow0 = simInsulinPhases_flow0.variablevalues(:,ismember(simInsulinPhases_flow0.variables,'S'))./simInsulinPhases_flow0.variablevalues(2,ismember(simInsulinPhases_flow0.variables,'S'));
minExpIS_flow0 = min(minExpIS_flow0,NewExpIS_flow0);
maxExpIS_flow0 = max(maxExpIS_flow0,NewExpIS_flow0);
NewExpIS_flow100 = simInsulinPhases_flow100.variablevalues(:,ismember(simInsulinPhases_flow100.variables,'S'))./simInsulinPhases_flow100.variablevalues(2,ismember(simInsulinPhases_flow100.variables,'S'));
minExpIS_flow100 = min(minExpIS_flow100,NewExpIS_flow100);
maxExpIS_flow100 = max(maxExpIS_flow100,NewExpIS_flow100);
NewExpIS_A2 = simInsulinPhases_Article2.variablevalues(:,ismember(simInsulinPhases_Article2.variables,'S'))./simInsulinPhases_Article2.variablevalues(2,ismember(simInsulinPhases_Article2.variables,'S'));
minExpIS_A2 = min(minExpIS_A2,NewExpIS_A2);
maxExpIS_A2 = max(maxExpIS_A2,NewExpIS_A2);

NewExpIS_static0 = simInsulinPhases_static0.variablevalues(:,ismember(simInsulinPhases_static0.variables,'S'))./simInsulinPhases_static0.variablevalues(2,ismember(simInsulinPhases_static0.variables,'S'));
minExpIS_static0 = min(minExpIS_static0,NewExpIS_static0);
maxExpIS_static0 = max(maxExpIS_static0,NewExpIS_static0);
NewExpIS_static100 = simInsulinPhases_static100.variablevalues(:,ismember(simInsulinPhases_static100.variables,'S'))./simInsulinPhases_static100.variablevalues(2,ismember(simInsulinPhases_static100.variables,'S'));
minExpIS_static100 = min(minExpIS_static100,NewExpIS_static100);
maxExpIS_static100 = max(maxExpIS_static100,NewExpIS_static100);
