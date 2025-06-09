
%% Insulin reistance

if j == 1
    maxHepaRG_ISHC    = simHepaRG.HC.variablevalues(:,ismember(simHepaRG.HC.variables,'IS'));
    minHepaRG_ISHC    = maxHepaRG_ISHC;
    BestHepaRG_ISHC   = maxHepaRG_ISHC;
    
end
NewHepaRG_ISHC = simHepaRG.HC.variablevalues(:,ismember(simHepaRG.HC.variables,'IS'));
maxHepaRG_ISHC = max(maxHepaRG_ISHC,NewHepaRG_ISHC);
minHepaRG_ISHC = min(minHepaRG_ISHC,NewHepaRG_ISHC);

if j == 1
    maxHepaRG_ISLC    = simHepaRG.LC.variablevalues(:,ismember(simHepaRG.LC.variables,'IS'));
    minHepaRG_ISLC    = maxHepaRG_ISLC;
    BestHepaRG_ISLC   = maxHepaRG_ISLC;
end
NewHepaRG_ISLC = simHepaRG.LC.variablevalues(:,ismember(simHepaRG.LC.variables,'IS'));
maxHepaRG_ISLC = max(maxHepaRG_ISLC,NewHepaRG_ISLC);
minHepaRG_ISLC = min(minHepaRG_ISLC,NewHepaRG_ISLC);

if j == 1
    maxHepaRG_ISFCS    = simHepaRG.FCS.variablevalues(:,ismember(simHepaRG.FCS.variables,'IS'));
    minHepaRG_ISFCS    = maxHepaRG_ISFCS;
    BestHepaRG_ISFCS   = maxHepaRG_ISFCS;
end
NewHepaRG_ISFCS = simHepaRG.FCS.variablevalues(:,ismember(simHepaRG.FCS.variables,'IS'));
maxHepaRG_ISFCS = max(maxHepaRG_ISFCS,NewHepaRG_ISFCS);
minHepaRG_ISFCS = min(minHepaRG_ISFCS,NewHepaRG_ISFCS);

if j == 1
    maxHepaRG_ISB27    = simHepaRG.B27.variablevalues(:,ismember(simHepaRG.B27.variables,'IS'));
    minHepaRG_ISB27    = maxHepaRG_ISB27;
    BestHepaRG_ISB27   = maxHepaRG_ISB27;
end
NewHepaRG_ISB27 = simHepaRG.B27.variablevalues(:,ismember(simHepaRG.B27.variables,'IS'));
maxHepaRG_ISB27 = max(maxHepaRG_ISB27,NewHepaRG_ISB27);
minHepaRG_ISB27 = min(minHepaRG_ISB27,NewHepaRG_ISB27);

%% Glucose vector

if j == 1
 maxGlucoseOverHealthy       = params_temp(ismember(pNames,"ISk")) * max(0,(GlucoseVector  - params_temp(ismember(pNames,"InsulinResistanceUpperlimit"))));
    minGlucoseOverHealthy    = maxGlucoseOverHealthy;
    BestGlucoseOverHealthy   = maxGlucoseOverHealthy;
end
NewGlucoseOverHealthy = params_temp(ismember(pNames,"ISk")) * max(0,(GlucoseVector  - params_temp(ismember(pNames,"InsulinResistanceUpperlimit"))));
maxGlucoseOverHealthy = max(maxGlucoseOverHealthy,NewGlucoseOverHealthy);
minGlucoseOverHealthy = min(minGlucoseOverHealthy,NewGlucoseOverHealthy);
