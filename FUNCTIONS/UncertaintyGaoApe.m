
%% PK
if j == 1
    
    % IV3
    maxExenatideMonkey_IV3  = simApe_IV3.statevalues(:,ismember(simApe_IV3.states,'C1'));
    minExenatideMonkey_IV3  = maxExenatideMonkey_IV3;
    BestExenatideMonkey_IV3 = simApe_IV3;
    % SC1
    maxExenatideMonkey_SC1  = simApe_SC1.statevalues(:,ismember(simApe_SC1.states,'C1'));
    minExenatideMonkey_SC1  = maxExenatideMonkey_SC1;
    BestExenatideMonkey_SC1 = maxExenatideMonkey_SC1;
    % SC3
    maxExenatideMonkey_SC3  = simApe_SC3.statevalues(:,ismember(simApe_SC3.states,'C1'));
    minExenatideMonkey_SC3  = maxExenatideMonkey_SC3;
    BestExenatideMonkey_SC3 = maxExenatideMonkey_SC3;
        % SC10
    maxExenatideMonkey_SC10  = simApe_SC10.statevalues(:,ismember(simApe_SC10.states,'C1'));
    minExenatideMonkey_SC10  = maxExenatideMonkey_SC10;
    BestExenatideMonkey_SC10 = maxExenatideMonkey_SC10;

end

% IV3
NewExenatideMonkey_IV3 = simApe_IV3.statevalues(:,ismember(simApe_IV3.states,'C1'));
maxExenatideMonkey_IV3 = max(maxExenatideMonkey_IV3,NewExenatideMonkey_IV3);
minExenatideMonkey_IV3 = min(minExenatideMonkey_IV3,NewExenatideMonkey_IV3);
%  SC1
NewExenatideMonkey_SC1 = simApe_SC1.statevalues(:,ismember(simApe_SC1.states,'C1'));
maxExenatideMonkey_SC1 = max(maxExenatideMonkey_SC1,NewExenatideMonkey_SC1);
minExenatideMonkey_SC1 = min(minExenatideMonkey_SC1,NewExenatideMonkey_SC1);
% SC3
NewExenatideMonkey_SC3 = simApe_SC3.statevalues(:,ismember(simApe_SC3.states,'C1'));
maxExenatideMonkey_SC3 = max(maxExenatideMonkey_SC3,NewExenatideMonkey_SC3);
minExenatideMonkey_SC3 = min(minExenatideMonkey_SC3,NewExenatideMonkey_SC3);
% SC10
NewExenatideMonkey_SC10 = simApe_SC10.statevalues(:,ismember(simApe_SC10.states,'C1'));
maxExenatideMonkey_SC10 = max(maxExenatideMonkey_SC10,NewExenatideMonkey_SC10);
minExenatideMonkey_SC10 = min(minExenatideMonkey_SC10,NewExenatideMonkey_SC10);
