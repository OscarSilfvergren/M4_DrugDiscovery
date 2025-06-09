
%  -------------------- Exp 7 GSIS  --------------------
if j == 1
    % CM1BSA_D7
    maxInsulin_CM2BSA_D7    = simStudy7_GSIS.CM2_BSAd7(1:3);
    minInsulin_CM2BSA_D7    = maxInsulin_CM2BSA_D7;
    BestInsulin_CM2BSA_D7   = maxInsulin_CM2BSA_D7;
    % CM1BSA_D7
    maxInsulin_CM3_D7    = simStudy7_GSIS.CM3d7(1:3);
    minInsulin_CM3_D7    = maxInsulin_CM3_D7;
    BestInsulin_CM3_D7   = maxInsulin_CM3_D7;
    % ULT_d7
    maxInsulin_ULT_d7    = simStudy7_GSIS.ULTd7(1:3);
    minInsulin_ULT_d7    = maxInsulin_ULT_d7;
    BestInsulin_ULT_d7   = maxInsulin_ULT_d7;
    
    % CM1FCS_D7
    maxInsulin_CM1_FCSd10    = simStudy7_GSIS.CM1_FCSd10(1:2);
    minInsulin_CM1_FCSd10    = maxInsulin_CM1_FCSd10;
    BestInsulin_CM1_FCSd10   = maxInsulin_CM1_FCSd10;
    % CM2_FCSd10
    maxInsulin_CM2_FCSd10    = simStudy7_GSIS.CM2_FCSd10(1:2);
    minInsulin_CM2_FCSd10    = maxInsulin_CM2_FCSd10;
    BestInsulin_CM2_FCSd10   = maxInsulin_CM2_FCSd10;
    % ULTd10
    maxInsulin_ULTd10    = simStudy7_GSIS.ULTd10(1:2);
    minInsulin_ULTd10    = maxInsulin_ULTd10;
    BestInsulin_ULTd10   = maxInsulin_ULTd10; 
    
end

% Insulin - Exp7p2GSISG0
NewInsulin_CM2BSA_D7 = simStudy7_GSIS.CM2_BSAd7(1:3);
maxInsulin_CM2BSA_D7 = max(maxInsulin_CM2BSA_D7,NewInsulin_CM2BSA_D7);
minInsulin_CM2BSA_D7 = min(minInsulin_CM2BSA_D7,NewInsulin_CM2BSA_D7);
% Insulin - Exp7p2GSISG0
NewInsulin_CM3_D7 = simStudy7_GSIS.CM3d7(1:3);
maxInsulin_CM3_D7 = max(maxInsulin_CM3_D7,NewInsulin_CM3_D7);
minInsulin_CM3_D7 = min(minInsulin_CM3_D7,NewInsulin_CM3_D7);
% Insulin - Exp7p2GSISG0
NewInsulin_ULT_d7 = simStudy7_GSIS.ULTd7(1:3);
maxInsulin_ULT_d7 = max(maxInsulin_ULT_d7,NewInsulin_ULT_d7);
minInsulin_ULT_d7 = min(minInsulin_ULT_d7,NewInsulin_ULT_d7);

% Insulin - Exp7p2GSISG0
NewInsulin_CM1_FCSd10 = simStudy7_GSIS.CM1_FCSd10(1:2);
maxInsulin_CM1_FCSd10 = max(maxInsulin_CM1_FCSd10,NewInsulin_CM1_FCSd10);
minInsulin_CM1_FCSd10 = min(minInsulin_CM1_FCSd10,NewInsulin_CM1_FCSd10);
% Insulin - Exp7p2GSISG0
NewInsulin_CM2_FCSd10  = simStudy7_GSIS.CM2_FCSd10(1:2);
maxInsulin_CM2_FCSd10  = max(maxInsulin_CM2_FCSd10 ,NewInsulin_CM2_FCSd10 );
minInsulin_CM2_FCSd10  = min(minInsulin_CM2_FCSd10 ,NewInsulin_CM2_FCSd10 );
% Insulin - Exp7p2GSISG0
NewInsulin_ULTd10 = simStudy7_GSIS.ULTd10(1:2);
maxInsulin_ULTd10 = max(maxInsulin_ULTd10,NewInsulin_ULTd10);
minInsulin_ULTd10 = min(minInsulin_ULTd10,NewInsulin_ULTd10);




