%% PK
if j == 1
    
    % 0p1
    maxExenatideHuman_0p1  = SimGaoHuman_0p1.statevalues(:,ismember(SimGaoHuman_0p1.states,'C1'));
    minExenatideHuman_0p1  = maxExenatideHuman_0p1;
    BestExenatideHuman_0p1 = maxExenatideHuman_0p1;
    % 0p2
    maxExenatideHuman_0p2  = SimGaoHuman_0p2.statevalues(:,ismember(SimGaoHuman_0p2.states,'C1'));
    minExenatideHuman_0p2  = maxExenatideHuman_0p2;
    BestExenatideHuman_0p2 = maxExenatideHuman_0p2;
    % 0p3
    maxExenatideHuman_0p3  = SimGaoHuman_0p3.statevalues(:,ismember(SimGaoHuman_0p3.states,'C1'));
    minExenatideHuman_0p3  = maxExenatideHuman_0p3;
    BestExenatideHuman_0p3 = maxExenatideHuman_0p3;
        % 0p4
    maxExenatideHuman_0p4  = SimGaoHuman_0p4.statevalues(:,ismember(SimGaoHuman_0p4.states,'C1'));
    minExenatideHuman_0p4  = maxExenatideHuman_0p4;
    BestExenatideHuman_0p4 = maxExenatideHuman_0p4;
    
end
        
% 0p1
NewExenatideHuman_0p1 = SimGaoHuman_0p1.statevalues(:,ismember(SimGaoHuman_0p1.states,'C1'));
maxExenatideHuman_0p1 = max(maxExenatideHuman_0p1,NewExenatideHuman_0p1);
minExenatideHuman_0p1 = min(minExenatideHuman_0p1,NewExenatideHuman_0p1);
%  0p2
NewExenatideHuman_0p2 = SimGaoHuman_0p2.statevalues(:,ismember(SimGaoHuman_0p2.states,'C1'));
maxExenatideHuman_0p2 = max(maxExenatideHuman_0p2,NewExenatideHuman_0p2);
minExenatideHuman_0p2 = min(minExenatideHuman_0p2,NewExenatideHuman_0p2);
% 0p3
NewExenatideHuman_0p3 = SimGaoHuman_0p3.statevalues(:,ismember(SimGaoHuman_0p3.states,'C1'));
maxExenatideHuman_0p3 = max(maxExenatideHuman_0p3,NewExenatideHuman_0p3);
minExenatideHuman_0p3 = min(minExenatideHuman_0p3,NewExenatideHuman_0p3);
% 0p4
NewExenatideHuman_0p4 = SimGaoHuman_0p4.statevalues(:,ismember(SimGaoHuman_0p4.states,'C1'));
maxExenatideHuman_0p4 = max(maxExenatideHuman_0p4,NewExenatideHuman_0p4);
minExenatideHuman_0p4 = min(minExenatideHuman_0p4,NewExenatideHuman_0p4);
