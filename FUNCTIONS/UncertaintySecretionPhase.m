%% EndoC

if j == 1
    maxEndoCphases  = simExp8p3_H10.statevalues(:,ismember(simExp8p3_H10.states,'Insulin_Medium'));
    BestAgreementToDataEndoC = maxEndoCphases;
    maxEndoCphases           = maxEndoCphases./BestAgreementToDataEndoC(end);
    minEndoCphases           = maxEndoCphases;
    BestEndoCphases          = maxEndoCphases;
end
NewEndoCphases = simExp8p3_H10.statevalues(:,ismember(simExp8p3_H10.states,'Insulin_Medium'));
NewEndoCphases = NewEndoCphases./BestAgreementToDataEndoC(end);
minEndoCphases = min(minEndoCphases,NewEndoCphases);
maxEndoCphases = max(maxEndoCphases,NewEndoCphases);

%% SimHumanMT

if j == 1
    maxHumanphases  = SimExp6p2_10.statevalues(:,ismember(SimExp6p2_10.states,'Insulin_Medium'));
    BestAgreementToDataHumanphases = maxHumanphases;
    maxHumanphases = maxHumanphases./BestAgreementToDataHumanphases(end);
    minHumanphases  = maxHumanphases;
    BestHumanphases = maxHumanphases;
end
NewHumanphases = SimExp6p2_10.statevalues(:,ismember(SimExp6p2_10.states,'Insulin_Medium'));
NewHumanphases = NewHumanphases./BestAgreementToDataHumanphases(end);
minHumanphases = min(minHumanphases,NewHumanphases);
maxHumanphases = max(maxHumanphases,NewHumanphases);
