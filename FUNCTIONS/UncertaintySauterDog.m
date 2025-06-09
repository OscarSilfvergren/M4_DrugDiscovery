
%% PK
if j == 1
    maxExenatideDog  = simDog_E.statevalues(:,ismember(simDog_E.states,'C1'));
    minExenatideDog  = maxExenatideDog;
    BestExenatideDog = simDog_E;
end
NewExenatideDog = simDog_E.statevalues(:,ismember(simDog_E.states,'C1'));
maxExenatideDog = max(maxExenatideDog,NewExenatideDog);
minExenatideDog = min(minExenatideDog,NewExenatideDog);