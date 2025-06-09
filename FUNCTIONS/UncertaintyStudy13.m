%% GSIS
if j == 1
    
    % Donor1
    maxsimStudy13_Donor1  = simStudy13_GSIS.Donor1(1:7);
    minsimStudy13_Donor1  = maxsimStudy13_Donor1;
    BestsimStudy13_Donor1 = maxsimStudy13_Donor1;
        % Donor2
    maxsimStudy13_Donor2  = simStudy13_GSIS.Donor2(1:7);
    minsimStudy13_Donor2  = maxsimStudy13_Donor2;
    BestsimStudy13_Donor2 = maxsimStudy13_Donor2;
            % Donor3
    maxsimStudy13_Donor3  = simStudy13_GSIS.Donor3(1:7);
    minsimStudy13_Donor3  = maxsimStudy13_Donor3;
    BestsimStudy13_Donor3 = maxsimStudy13_Donor3;
                % Donor4
    maxsimStudy13_Donor4  = simStudy13_GSIS.Donor4(1:7);
    minsimStudy13_Donor4  = maxsimStudy13_Donor4;
    BestsimStudy13_Donor4 = maxsimStudy13_Donor4;

end
% 1
NewsimStudy13_Donor1 = simStudy13_GSIS.Donor1(1:7);
minsimStudy13_Donor1 = min(minsimStudy13_Donor1,NewsimStudy13_Donor1);
maxsimStudy13_Donor1 = max(maxsimStudy13_Donor1,NewsimStudy13_Donor1);
% 2
NewsimStudy13_Donor2 = simStudy13_GSIS.Donor2(1:7);
minsimStudy13_Donor2 = min(minsimStudy13_Donor2,NewsimStudy13_Donor2);
maxsimStudy13_Donor2 = max(maxsimStudy13_Donor2,NewsimStudy13_Donor2);
% 3
NewsimStudy13_Donor3 = simStudy13_GSIS.Donor3(1:7);
minsimStudy13_Donor3 = min(minsimStudy13_Donor3,NewsimStudy13_Donor3);
maxsimStudy13_Donor3 = max(maxsimStudy13_Donor3,NewsimStudy13_Donor3);
% 4
NewsimStudy13_Donor4 = simStudy13_GSIS.Donor4(1:7);
minsimStudy13_Donor4 = min(minsimStudy13_Donor4,NewsimStudy13_Donor4);
maxsimStudy13_Donor4 = max(maxsimStudy13_Donor4,NewsimStudy13_Donor4);

