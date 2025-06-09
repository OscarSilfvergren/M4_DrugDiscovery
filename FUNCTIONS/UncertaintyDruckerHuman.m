%% Rat

% Glucose
if j == 1 & i == 1 & k==1 & i == 1 & k==1
    maxDrucker2008_GlucoseRat  = SimDruckerRat.variablevalues(:,ismember(SimDruckerRat.variables,'G'))/18;
    minDrucker2008_GlucoseRat  = maxDrucker2008_GlucoseRat;
    BestDrucker2008_GlucoseRat = maxDrucker2008_GlucoseRat;
end
NewDrucker2008_GlucoseRat = SimDruckerRat.variablevalues(:,ismember(SimDruckerRat.variables,'G'))/18;
maxDrucker2008_GlucoseRat = max(maxDrucker2008_GlucoseRat,NewDrucker2008_GlucoseRat);
minDrucker2008_GlucoseRat = min(minDrucker2008_GlucoseRat,NewDrucker2008_GlucoseRat);

% Insulin
if j == 1 & i == 1 & k==1 & i == 1 & k==1
    maxDrucker2008_InsulinRat  = SimDruckerRat.variablevalues(:,ismember(SimDruckerRat.variables,'I'));
    minDrucker2008_InsulinRat  = maxDrucker2008_InsulinRat;
    BestDrucker2008_InsulinRat = maxDrucker2008_InsulinRat;
end
NewDrucker2008_InsulinRat = SimDruckerRat.variablevalues(:,ismember(SimDruckerRat.variables,'I'));
maxDrucker2008_InsulinRat = max(maxDrucker2008_InsulinRat,NewDrucker2008_InsulinRat);
minDrucker2008_InsulinRat = min(minDrucker2008_InsulinRat,NewDrucker2008_InsulinRat);

% Glycogen_liver
if j == 1 & i == 1 & k==1 & i == 1 & k==1
    maxDrucker2008_GlycogenRat  = SimDruckerRat.variablevalues(:,ismember(SimDruckerRat.variables,'Glycogen_liver'));
    minDrucker2008_GlycogenRat  = maxDrucker2008_GlycogenRat;
    BestDrucker2008_GlycogenRat = maxDrucker2008_GlycogenRat;
end
NewDrucker2008_GlycogenRat = SimDruckerRat.variablevalues(:,ismember(SimDruckerRat.variables,'Glycogen_liver'));
maxDrucker2008_GlycogenRat = max(maxDrucker2008_GlycogenRat,NewDrucker2008_GlycogenRat);
minDrucker2008_GlycogenRat = min(minDrucker2008_GlycogenRat,NewDrucker2008_GlycogenRat);

%% In vitro human

try
    % Agreement to data calculation
time = (Ducker2008_data.GlucoseOGTTWeekly_time(1:8)+10+(420+1440*7*0))/5;
simG       = SimDruckerInVitroHuman.variablevalues(time,ismember(SimDruckerInVitroHuman.variables,'G'))/18;
CostOGTT1  = ((Ducker2008_data.GlucoseWeeklyOGTT1(1:8) - simG).^2)  ./(max(Ducker2008_data.GlucoseWeeklyOGTT1SEM(1:8),mean(Ducker2008_data.GlucoseWeeklyOGTT1SEM(1:8))).^2);
time = (Ducker2008_data.GlucoseOGTTWeekly_time(1:8)+10+(420+1440*7*14))/5;
simG       = SimDruckerInVitroHuman.variablevalues(time,ismember(SimDruckerInVitroHuman.variables,'G'))/18;
CostOGTT2  = ((Ducker2008_data.GlucoseWeeklyOGTT2(1:8) - simG).^2)  ./(max(Ducker2008_data.GlucoseWeeklyOGTT2SEM(1:8),mean(Ducker2008_data.GlucoseWeeklyOGTT2SEM(1:8))).^2);
Cost_ModelOGTT =  sum(CostOGTT1,'omitnan') + sum(CostOGTT2,'omitnan');
% Weekly glucose
time = (Ducker2008_data.BasalGlucose_time(1:9)*1440*7 + 10)/5;
time(1) = (Ducker2008_data.GlucoseOGTTWeekly_time(1)+10+(420+1440*7*0))/5;  % OGTT1 time
time(5) = (Ducker2008_data.GlucoseOGTTWeekly_time(1)+10+(420+1440*7*14))/5; % OGTT2 time
simGlucose       = SimDruckerInVitroHuman.variablevalues(time,ismember(SimDruckerInVitroHuman.variables,'G'))/18;
CostGlucose = ((Ducker2008_data.BasalGlucoseWeekly(1:9) - simGlucose).^2)  ./((Ducker2008_data.BasalGlucoseWeeklySE(1:9)).^2);
CostGlucose = [CostGlucose(1),CostGlucose(5)];
Cost_ModelW =  sum(CostGlucose,'omitnan');
% Weekly exenatide
time = (Ducker2008_data.Exenatide_time(1:13)*1440*7 + 10)/5;
time(1) = 1;
simExenatide       = SimDruckerInVitroHuman.statevalues(time,ismember(SimDruckerInVitroHuman.states,'C1'))*1000;
CostExenatide      = ((Ducker2008_data.ExenatideWeekly(1:13) - simExenatide).^2)  ./((Ducker2008_data.ExenatideWeekly(1:13)*0.7).^2); % In article only the interquartile range is given - without sufficient data the interquartile range had to be simplified to an assumed stdev of 0.7x mean for calibration purposes
Cost_ModelE =  sum(CostExenatide,'omitnan');

Cost_Human = Cost_ModelOGTT + Cost_ModelW + Cost_ModelE;

    % Agreement to data
    if j == 1 & i == 1 & k==1 & i == 1 & k==1
        Cost_HumanLow  = Cost_Human;
    end
    Cost_HumanLow  = min(Cost_HumanLow,Cost_Human);
    
    % Glucose
    if j == 1 & i == 1 & k==1 & i == 1 & k==1
        maxDrucker2008_Glucose  = SimDruckerInVitroHuman.variablevalues(:,ismember(SimDruckerInVitroHuman.variables,'G'))/18;
        minDrucker2008_Glucose  = maxDrucker2008_Glucose;
        BestDrucker2008_Glucose = maxDrucker2008_Glucose;
    end
    NewDrucker2008_Glucose = SimDruckerInVitroHuman.variablevalues(:,ismember(SimDruckerInVitroHuman.variables,'G'))/18;
    maxDrucker2008_Glucose = max(maxDrucker2008_Glucose,NewDrucker2008_Glucose);
    minDrucker2008_Glucose = min(minDrucker2008_Glucose,NewDrucker2008_Glucose);
    
    % Insulin
    if j == 1 & i == 1 & k==1 & i == 1 & k==1
        maxDrucker2008_Insulin  = SimDruckerInVitroHuman.variablevalues(:,ismember(SimDruckerInVitroHuman.variables,'I'));
        minDrucker2008_Insulin  = maxDrucker2008_Insulin;
        BestDrucker2008_Insulin = maxDrucker2008_Insulin;
    end
    NewDrucker2008_Insulin = SimDruckerInVitroHuman.variablevalues(:,ismember(SimDruckerInVitroHuman.variables,'I'));
    maxDrucker2008_Insulin = max(maxDrucker2008_Insulin,NewDrucker2008_Insulin);
    minDrucker2008_Insulin = min(minDrucker2008_Insulin,NewDrucker2008_Insulin);
    
    % Glycogen_liver
    if j == 1 & i == 1 & k==1 & i == 1 & k==1
        maxDrucker2008_Glycogen  = SimDruckerInVitroHuman.variablevalues(:,ismember(SimDruckerInVitroHuman.variables,'Glycogen_liver'));
        minDrucker2008_Glycogen  = maxDrucker2008_Glycogen;
        BestDrucker2008_Glycogen = maxDrucker2008_Glycogen;
    end
    NewDrucker2008_Glycogen = SimDruckerInVitroHuman.variablevalues(:,ismember(SimDruckerInVitroHuman.variables,'Glycogen_liver'));
    maxDrucker2008_Glycogen = max(maxDrucker2008_Glycogen,NewDrucker2008_Glycogen);
    minDrucker2008_Glycogen = min(minDrucker2008_Glycogen,NewDrucker2008_Glycogen);
    
    % Exanitide
    if j == 1 & i == 1 & k==1
        maxDrucker2008_C1  = SimDruckerInVitroHuman.statevalues(:,ismember(SimDruckerInVitroHuman.states,'C1'));
        minDrucker2008_C1  = maxDrucker2008_C1;
        BestDrucker2008_C1 = maxDrucker2008_C1;
    end
    NewDrucker2008_C1 = SimDruckerInVitroHuman.statevalues(:,ismember(SimDruckerInVitroHuman.states,'C1'));
    maxDrucker2008_C1 = max(maxDrucker2008_C1,NewDrucker2008_C1);
    minDrucker2008_C1 = min(minDrucker2008_C1,NewDrucker2008_C1);
    
    % Exanitide_PD
    if j == 1 & i == 1 & k==1
        maxDrucker2008_Exanitide_PD  = 1 + SimDruckerInVitroHuman.reactionvalues(:,ismember(SimDruckerInVitroHuman.reactions,'Exanitide_PD'));
        minDrucker2008_Exanitide_PD  = maxDrucker2008_Exanitide_PD;
        BestDrucker2008_Exanitide_PD = maxDrucker2008_Exanitide_PD;
    end
    NewDrucker2008_Exanitide_PD = 1 + SimDruckerInVitroHuman.reactionvalues(:,ismember(SimDruckerInVitroHuman.reactions,'Exanitide_PD'));
    maxDrucker2008_Exanitide_PD = max(maxDrucker2008_Exanitide_PD,NewDrucker2008_Exanitide_PD);
    minDrucker2008_Exanitide_PD = min(minDrucker2008_Exanitide_PD,NewDrucker2008_Exanitide_PD);
    
    % InsulinResponseNew
    if j == 1 & i == 1 & k==1
        maxDrucker2008_InsulinResponseNew  = 1 + SimDruckerInVitroHuman.reactionvalues(:,ismember(SimDruckerInVitroHuman.reactions,'InsulinResponseNew'));
        minDrucker2008_InsulinResponseNew  = maxDrucker2008_InsulinResponseNew;
        BestDrucker2008_InsulinResponseNew = maxDrucker2008_InsulinResponseNew;
    end
    NewDrucker2008_InsulinResponseNew = 1 + SimDruckerInVitroHuman.reactionvalues(:,ismember(SimDruckerInVitroHuman.reactions,'InsulinResponseNew'));
    maxDrucker2008_InsulinResponseNew = max(maxDrucker2008_InsulinResponseNew,NewDrucker2008_InsulinResponseNew);
    minDrucker2008_InsulinResponseNew = min(minDrucker2008_InsulinResponseNew,NewDrucker2008_InsulinResponseNew);
    
    % IS
    if j == 1 & i == 1 & k==1 & i == 1 & k==1
        maxDrucker2008_IS = SimDruckerInVitroHuman.reactionvalues(:,ismember(SimDruckerInVitroHuman.reactions,'IS'));
        minDrucker2008_IS = maxDrucker2008_IS;
        BestDrucker2008_IS= maxDrucker2008_IS;
    end
    NewDrucker2008_IS = SimDruckerInVitroHuman.reactionvalues(:,ismember(SimDruckerInVitroHuman.reactions,'IS'));
    maxDrucker2008_IS = max(maxDrucker2008_IS,NewDrucker2008_IS);
    minDrucker2008_IS = min(minDrucker2008_IS,NewDrucker2008_IS);
    
    %%
    % Glucose production - L
    EGP_Liver   = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'EGP_Liver')));
    EGP         = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'EGP')));
    if j == 1 & i == 1 & k==1
        maxratioL_EGP  = EGP_Liver/EGP;
        minratioL_EGP  = maxratioL_EGP;
        BestratioL_EGP = maxratioL_EGP;
    end
    NewratioL_EGP = EGP_Liver/EGP;
    maxratioL_EGP = max(maxratioL_EGP,NewratioL_EGP);
    minratioL_EGP = min(minratioL_EGP,NewratioL_EGP);
    
    %Glucose utilization
    U_idl = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'U_il')));
    U_idm = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'U_idm')));
    U_idf = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'U_idf')));
    U_ii  = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'U_ii_print')));
    U     = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'U')));
    % f
    if j == 1 & i == 1 & k==1
        maxratio_Uidf  = U_idf/U;
        minratio_Uidf  = maxratio_Uidf;
        Bestratio_Uidf = maxratio_Uidf;
    end
    Newratio_Uidf = U_idf/U;
    maxratio_Uidf = max(maxratio_Uidf,Newratio_Uidf);
    minratio_Uidf = min(minratio_Uidf,Newratio_Uidf);
    % m
    if j == 1 & i == 1 & k==1
        maxratio_Uidm  = U_idm/U;
        minratio_Uidm  = maxratio_Uidm;
        Bestratio_Uidm = maxratio_Uidm;
    end
    Newratio_Uidm = U_idm/U;
    maxratio_Uidm = max(maxratio_Uidm,Newratio_Uidm);
    minratio_Uidm = min(minratio_Uidm,Newratio_Uidm);
    % b
    if j == 1 & i == 1 & k==1
        maxratio_Uii  = U_ii/U;
        minratio_Uii  = maxratio_Uii;
        Bestratio_Uii = maxratio_Uii;
    end
    Newratio_Uii = U_ii/U;
    maxratio_Uii = max(maxratio_Uii,Newratio_Uii);
    minratio_Uii = min(minratio_Uii,Newratio_Uii);
    % l
    if j == 1 & i == 1 & k==1
        maxratio_Uidl  = U_idl/U;
        minratio_Uidl  = maxratio_Uidl;
        Bestratio_Uidl = maxratio_Uidl;
    end
    Newratio_Uidl = U_idl/U;
    maxratio_Uidl = max(maxratio_Uidl,Newratio_Uidl);
    minratio_Uidl = min(minratio_Uidl,Newratio_Uidl);
    
    % Insulin clearance - L
    InsulinDegradation_Blood     = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'InsulinDegradation_Blood')));
    InsulinDegradation_Liver     = sum(SimDruckerInVitroHuman.reactionvalues(405/5:1:1845/5,ismember(SimDruckerInVitroHuman.reactions,'InsulinDegradation_Liver')));
    
    if j == 1 & i == 1 & k==1
        maxratioL_IC  = InsulinDegradation_Liver/(InsulinDegradation_Blood + InsulinDegradation_Liver);
        minratioL_IC  = maxratioL_IC;
        BestratioL_IC = maxratioL_IC;
    end
    NewratioL_IC = InsulinDegradation_Liver/(InsulinDegradation_Blood + InsulinDegradation_Liver);
    maxratioL_IC = max(maxratioL_IC,NewratioL_IC);
    minratioL_IC = min(minratioL_IC,NewratioL_IC);
    
    %% week 14
    % Glucose production - L
    EGP_Liver   = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'EGP_Liver')));
    EGP         = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'EGP')));
    if j == 1 & i == 1 & k==1
        maxratioL_EGPW14  = EGP_Liver/EGP;
        minratioL_EGPW14  = maxratioL_EGPW14;
        BestratioL_EGPW14 = maxratioL_EGPW14;
    end
    NewratioL_EGPW14 = EGP_Liver/EGP;
    maxratioL_EGPW14 = max(maxratioL_EGPW14,NewratioL_EGPW14);
    minratioL_EGPW14 = min(minratioL_EGPW14,NewratioL_EGPW14);
    
    %Glucose utilization
    U_idl = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'U_il')));
    U_idm = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'U_idm')));
    U_idf = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'U_idf')));
    U_ii  = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'U_ii_print')));
    U     = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'U')));
    % f
    if j == 1 & i == 1 & k==1
        maxratio_UidfW14  = U_idf/U;
        minratio_UidfW14  = maxratio_UidfW14;
        Bestratio_UidfW14 = maxratio_UidfW14;
    end
    Newratio_UidfW14 = U_idf/U;
    maxratio_UidfW14 = max(maxratio_UidfW14,Newratio_UidfW14);
    minratio_UidfW14 = min(minratio_UidfW14,Newratio_UidfW14);
    % m
    if j == 1 & i == 1 & k==1
        maxratio_UidmW14  = U_idm/U;
        minratio_UidmW14  = maxratio_UidmW14;
        Bestratio_UidmW14 = maxratio_UidmW14;
    end
    Newratio_UidmW14 = U_idm/U;
    maxratio_UidmW14 = max(maxratio_UidmW14,Newratio_UidmW14);
    minratio_UidmW14 = min(minratio_UidmW14,Newratio_UidmW14);
    % b
    if j == 1 & i == 1 & k==1
        maxratio_UiiW14  = U_ii/U;
        minratio_UiiW14  = maxratio_UiiW14;
        Bestratio_UiiW14 = maxratio_UiiW14;
    end
    Newratio_UiiW14 = U_ii/U;
    maxratio_UiiW14 = max(maxratio_UiiW14,Newratio_UiiW14);
    minratio_UiiW14 = min(minratio_UiiW14,Newratio_UiiW14);
    % l
    if j == 1 & i == 1 & k==1
        maxratio_UidlW14  = U_idl/U;
        minratio_UidlW14  = maxratio_UidlW14;
        Bestratio_UidlW14 = maxratio_UidlW14;
    end
    Newratio_UidlW14 = U_idl/U;
    maxratio_UidlW14 = max(maxratio_UidlW14,Newratio_UidlW14);
    minratio_UidlW14 = min(minratio_UidlW14,Newratio_UidlW14);
    
    % Insulin clearance - L
    InsulinDegradation_Blood     = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'InsulinDegradation_Blood')));
    InsulinDegradation_Liver     = sum(SimDruckerInVitroHuman.reactionvalues(141120/5:1:142560/5,ismember(SimDruckerInVitroHuman.reactions,'InsulinDegradation_Liver')));
    if j == 1 & i == 1 & k==1
        maxratioL_ICW14  = InsulinDegradation_Liver/(InsulinDegradation_Blood + InsulinDegradation_Liver);
        minratioL_ICW14  = maxratioL_ICW14;
        BestratioL_ICW14 = maxratioL_ICW14;
    end
    NewratioL_ICW14 = InsulinDegradation_Liver/(InsulinDegradation_Blood + InsulinDegradation_Liver);
    maxratioL_ICW14 = max(maxratioL_ICW14,NewratioL_ICW14);
    minratioL_ICW14 = min(minratioL_ICW14,NewratioL_ICW14);
    
    %% Week 30
    
    % Glucose production - L
    EGP_Liver   = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'EGP_Liver')));
    EGP         = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'EGP')));
    if j == 1 & i == 1 & k==1
        maxratioL_EGPW30  = EGP_Liver/EGP;
        minratioL_EGPW30  = maxratioL_EGPW30;
        BestratioL_EGPW30 = maxratioL_EGPW30;
    end
    NewratioL_EGPW30 = EGP_Liver/EGP;
    maxratioL_EGPW30 = max(maxratioL_EGPW30,NewratioL_EGPW30);
    minratioL_EGPW30 = min(minratioL_EGPW30,NewratioL_EGPW30);
    
    %Glucose utilization
    U_idl = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'U_il')));
    U_idm = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'U_idm')));
    U_idf = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'U_idf')));
    U_ii  = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'U_ii_print')));
    U     = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'U')));
    % f
    if j == 1 & i == 1 & k==1
        maxratio_UidfW30  = U_idf/U;
        minratio_UidfW30  = maxratio_UidfW30;
        Bestratio_UidfW30 = maxratio_UidfW30;
    end
    Newratio_UidfW30 = U_idf/U;
    maxratio_UidfW30 = max(maxratio_UidfW30,Newratio_UidfW30);
    minratio_UidfW30 = min(minratio_UidfW30,Newratio_UidfW30);
    % m
    if j == 1 & i == 1 & k==1
        maxratio_UidmW30  = U_idm/U;
        minratio_UidmW30  = maxratio_UidmW30;
        Bestratio_UidmW30 = maxratio_UidmW30;
    end
    Newratio_UidmW30 = U_idm/U;
    maxratio_UidmW30 = max(maxratio_UidmW30,Newratio_UidmW30);
    minratio_UidmW30 = min(minratio_UidmW30,Newratio_UidmW30);
    % b
    if j == 1 & i == 1 & k==1
        maxratio_UiiW30  = U_ii/U;
        minratio_UiiW30  = maxratio_UiiW30;
        Bestratio_UiiW30 = maxratio_UiiW30;
    end
    Newratio_UiiW30 = U_ii/U;
    maxratio_UiiW30 = max(maxratio_UiiW30,Newratio_UiiW30);
    minratio_UiiW30 = min(minratio_UiiW30,Newratio_UiiW30);
    % l
    if j == 1 & i == 1 & k==1
        maxratio_UidlW30  = U_idl/U;
        minratio_UidlW30  = maxratio_UidlW30;
        Bestratio_UidlW30 = maxratio_UidlW30;
    end
    Newratio_UidlW30 = U_idl/U;
    maxratio_UidlW30 = max(maxratio_UidlW30,Newratio_UidlW30);
    minratio_UidlW30 = min(minratio_UidlW30,Newratio_UidlW30);
    
    % Insulin clearance - L
    InsulinDegradation_Blood     = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'InsulinDegradation_Blood')));
    InsulinDegradation_Liver     = sum(SimDruckerInVitroHuman.reactionvalues(299925/5:1:301365/5,ismember(SimDruckerInVitroHuman.reactions,'InsulinDegradation_Liver')));
    if j == 1 & i == 1 & k==1
        maxratioL_ICW30  = InsulinDegradation_Liver/(InsulinDegradation_Blood + InsulinDegradation_Liver);
        minratioL_ICW30  = maxratioL_ICW30;
        BestratioL_ICW30 = maxratioL_ICW30;
    end
    NewratioL_ICW30 = InsulinDegradation_Liver/(InsulinDegradation_Blood + InsulinDegradation_Liver);
    maxratioL_ICW30 = max(maxratioL_ICW30,NewratioL_ICW30);
    minratioL_ICW30 = min(minratioL_ICW30,NewratioL_ICW30);
    
catch error
    disp('In vitro human params end')
end