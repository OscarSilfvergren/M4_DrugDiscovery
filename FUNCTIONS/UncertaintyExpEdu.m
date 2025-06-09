%% GSIS
if j == 1
    % EduPositiveSM0
    maxEduPositiveSM0 = FindEdU(simExpEdu_GSIS.SM(1),0);
    minEduPositiveSM0 = maxEduPositiveSM0;
    BestEduPositiveSM0 = maxEduPositiveSM0;
    % EduPositiveSM
    maxEduPositiveSM = FindEdU(simExpEdu_GSIS.SM(1),simExpEdu_GSIS.SM(2));
    minEduPositiveSM = maxEduPositiveSM;
    BestEduPositiveSM = maxEduPositiveSM;
    % EduPositiveHCHG
    maxEduPositiveHCHG = FindEdU(simExpEdu_GSIS.HCHG(1),simExpEdu_GSIS.HCHG(2));
    minEduPositiveHCHG = maxEduPositiveHCHG;
    BestEduPositiveHCHG = maxEduPositiveHCHG;
    % EduPositiveLCHG
    maxEduPositiveLCHG = FindEdU(simExpEdu_GSIS.LCHG(1),simExpEdu_GSIS.LCHG(2));
    minEduPositiveLCHG = maxEduPositiveLCHG;
    BestEduPositiveLCHG = maxEduPositiveLCHG;
    % EduPositiveHCLG
    maxEduPositiveHCLG = FindEdU(simExpEdu_GSIS.HCLG(1),simExpEdu_GSIS.HCLG(2));
    minEduPositiveHCLG = maxEduPositiveHCLG;
    BestEduPositiveHCLG = maxEduPositiveHCLG;
    % EduPositiveLCLG
    maxEduPositiveLCLG = FindEdU(simExpEdu_GSIS.LCLG(1),simExpEdu_GSIS.LCLG(2));
    minEduPositiveLCLG = maxEduPositiveLCLG;
    BestEduPositiveLCLG = maxEduPositiveLCLG;
    % EduPositiveB27
    maxEduPositiveB27 = FindEdU(simExpEdu_GSIS.B27(1),simExpEdu_GSIS.B27(2));
    minEduPositiveB27 = maxEduPositiveB27;
    BestEduPositiveB27 = maxEduPositiveB27;
    
    % EduPositive0
    maxEduPositive0 = FindEdU(simExpEdu_GSIS.HCHG(1),simExpEdu_GSIS.HCHG(2));
    minEduPositive0 = maxEduPositive0;
    BestEduPositive0 = maxEduPositive0;
    % EduPositive0p1
    maxEduPositive0p1 = FindEdU(simExpEdu_GSIS.HCHG_E0p1(1),simExpEdu_GSIS.HCHG_E0p1(2));
    minEduPositive0p1 = maxEduPositive0p1;
    BestEduPositive0p1 = maxEduPositive0p1;
    % EduPositive10
    maxEduPositive10 = FindEdU(simExpEdu_GSIS.HCHG_E10(1),simExpEdu_GSIS.HCHG_E10(2));
    minEduPositive10 = maxEduPositive10;
    BestEduPositive10 = maxEduPositive10;
    % EduPositive10
    maxEduPositive1000 = FindEdU(simExpEdu_GSIS.HCHG_E1000(1),simExpEdu_GSIS.HCHG_E1000(2));
    minEduPositive1000 = maxEduPositive1000;
    BestEduPositive1000 = maxEduPositive1000;


end
% SM
NewEduPositiveSM0 = FindEdU(simExpEdu_GSIS.SM(1),0);
minEduPositiveSM0 = min(minEduPositiveSM0,NewEduPositiveSM0);
maxEduPositiveSM0 = max(maxEduPositiveSM0,NewEduPositiveSM0);

% SM
NewEduPositiveSM = FindEdU(simExpEdu_GSIS.SM(1),simExpEdu_GSIS.SM(2));
minEduPositiveSM = min(minEduPositiveSM,NewEduPositiveSM);
maxEduPositiveSM = max(maxEduPositiveSM,NewEduPositiveSM);
% HCHG
NewEduPositiveHCHG = FindEdU(simExpEdu_GSIS.HCHG(1),simExpEdu_GSIS.HCHG(2));
minEduPositiveHCHG = min(minEduPositiveHCHG,NewEduPositiveHCHG);
maxEduPositiveHCHG = max(maxEduPositiveHCHG,NewEduPositiveHCHG);
% LCHG
NewEduPositiveLCHG = FindEdU(simExpEdu_GSIS.LCHG(1),simExpEdu_GSIS.LCHG(2));
minEduPositiveLCHG = min(minEduPositiveLCHG,NewEduPositiveLCHG);
maxEduPositiveLCHG = max(maxEduPositiveLCHG,NewEduPositiveLCHG);
% HCLG
NewEduPositiveHCLG = FindEdU(simExpEdu_GSIS.HCLG(1),simExpEdu_GSIS.HCLG(2));
minEduPositiveHCLG = min(minEduPositiveHCLG,NewEduPositiveHCLG);
maxEduPositiveHCLG = max(maxEduPositiveHCLG,NewEduPositiveHCLG);
% LCLG
NewEduPositiveLCLG = FindEdU(simExpEdu_GSIS.LCLG(1),simExpEdu_GSIS.LCLG(2));
minEduPositiveLCLG = min(minEduPositiveLCLG,NewEduPositiveLCLG);
maxEduPositiveLCLG = max(maxEduPositiveLCLG,NewEduPositiveLCLG);
% SM
NewEduPositiveB27 = FindEdU(simExpEdu_GSIS.B27(1),simExpEdu_GSIS.B27(2));
minEduPositiveB27 = min(minEduPositiveB27,NewEduPositiveB27);
maxEduPositiveB27 = max(maxEduPositiveB27,NewEduPositiveB27);

% SM
NewEduPositive0 = FindEdU(simExpEdu_GSIS.HCHG(1),simExpEdu_GSIS.HCHG(2));
minEduPositive0 = min(minEduPositive0,NewEduPositive0);
maxEduPositive0 = max(maxEduPositive0,NewEduPositive0);
% SM
NewEduPositive0p1 = FindEdU(simExpEdu_GSIS.HCHG_E0p1(1),simExpEdu_GSIS.HCHG_E0p1(2));
minEduPositive0p1 = min(minEduPositive0p1,NewEduPositive0p1);
maxEduPositive0p1 = max(maxEduPositive0p1,NewEduPositive0p1);
% SM
NewEduPositive10 = FindEdU(simExpEdu_GSIS.HCHG_E10(1),simExpEdu_GSIS.HCHG_E10(2));
minEduPositive10 = min(minEduPositive10,NewEduPositive10);
maxEduPositive10 = max(maxEduPositive10,NewEduPositive10);
% SM
NewEduPositive1000 = FindEdU(simExpEdu_GSIS.HCHG_E1000(1),simExpEdu_GSIS.HCHG_E1000(2));
minEduPositive1000 = min(minEduPositive1000,NewEduPositive1000);
maxEduPositive1000 = max(maxEduPositive1000,NewEduPositive1000);
    

function EduPositiveValue = FindEdU(NoEdU,EdU)
EduPositiveValue = 100*(EdU/(NoEdU+EdU));
end