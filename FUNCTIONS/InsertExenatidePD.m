function [paramInVitroHuman,paramRat] = InsertExenatidePD(param,ExenatideParamMatrix,pNames)

% InVitroHuman
[row column] = size(ExenatideParamMatrix.InVitroPD);

    paramInVitroHuman = param.*ones(row+1,length(param));
        paramInVitroHuman(1,ismember(pNames,"ExenatideInsulinMax"))      = ExenatideParamMatrix.InVitroPDbest(1);
        paramInVitroHuman(1,ismember(pNames,"ExenatideInsulinDecayMax")) = ExenatideParamMatrix.InVitroPDbest(2);
        paramInVitroHuman(1,ismember(pNames,"ExenatideInsulin50"))       = ExenatideParamMatrix.InVitroPDbest(3);
        paramInVitroHuman(1,ismember(pNames,"ExenatideInsulinDecay50"))  = ExenatideParamMatrix.InVitroPDbest(4);
        paramInVitroHuman(1,ismember(pNames,"ExenatideInsulin_hill"))    = ExenatideParamMatrix.InVitroPDbest(5);

        paramInVitroHuman(2:row+1,ismember(pNames,"ExenatideInsulinMax"))      = ExenatideParamMatrix.InVitroPD(:,1);
        paramInVitroHuman(2:row+1,ismember(pNames,"ExenatideInsulinDecayMax")) = ExenatideParamMatrix.InVitroPD(:,2);
        paramInVitroHuman(2:row+1,ismember(pNames,"ExenatideInsulin50"))       = ExenatideParamMatrix.InVitroPD(:,3);
        paramInVitroHuman(2:row+1,ismember(pNames,"ExenatideInsulinDecay50"))  = ExenatideParamMatrix.InVitroPD(:,4);
        paramInVitroHuman(2:row+1,ismember(pNames,"ExenatideInsulin_hill"))    = ExenatideParamMatrix.InVitroPD(:,5);

     
    % Rat
    paramRat = param.*ones(length(ExenatideParamMatrix.Emax_matrix_Rat),length(param));
        paramRat(:,ismember(pNames,"ExenatideInsulinMax"))      = ExenatideParamMatrix.Emax_matrix_Rat;
        paramRat(:,ismember(pNames,"ExenatideInsulinDecayMax")) = ExenatideParamMatrix.Emin_matrix_Rat;
        paramRat(:,ismember(pNames,"ExenatideInsulin50"))       = ExenatideParamMatrix.Emax50_matrix_Rat;
        paramRat(:,ismember(pNames,"ExenatideInsulinDecay50"))  = ExenatideParamMatrix.Emin50_matrix_Rat;
        paramRat(:,ismember(pNames,"ExenatideInsulin_hill"))    = ExenatideParamMatrix.Ehill_matrix_Rat;
end


