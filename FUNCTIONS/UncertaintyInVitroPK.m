
%% PK
if j == 1
    maxInVitroE  = simInVitroPK.statevalues(:,ismember(simInVitroPK.states,'C1'));
    minInVitroE  = maxInVitroE;
    BestInVitroE = simInVitroPK;
end
NewInVitroE = simInVitroPK.statevalues(:,ismember(simInVitroPK.states,'C1'));
maxInVitroE = max(maxInVitroE,NewInVitroE);
minInVitroE = min(minInVitroE,NewInVitroE);