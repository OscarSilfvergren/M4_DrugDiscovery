  if j == 1
        
        %  Compare systems plot simulation
        [simInvitro,simRat,simApe,simDog,simHuman] = SimulatePKsystems(model,params,ConditionAlterations,initialvalues,sNames,pNames);
        
        % Clearance
        maxTranslation_cl  = params_temp(ismember(pNames,"CL_ref")) .*(WeightPlotVector./0.34).^params_temp(ismember(pNames,"b_reaction"));
        minTranslation_cl  = maxTranslation_cl;
        BestTranslation_cl = maxTranslation_cl;
        RatCL_ref   = params_temp(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(1);
        maxRat_cl  = RatCL_ref .*(WeightPlotVector(3)./0.34).^params_temp(ismember(pNames,"b_reaction"));
        minRat_cl  = maxRat_cl;
        BestRat_cl = maxRat_cl;
        MonkeyCL_ref   = params_temp(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(2);
        maxMonkey_cl  = MonkeyCL_ref .*(WeightPlotVector(43)./0.34).^params_temp(ismember(pNames,"b_reaction"));
        minMonkey_cl  = maxMonkey_cl;
        BestMonkey_cl = maxMonkey_cl;
        DogCL_ref   = params_temp(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(3);
        maxDog_cl  = DogCL_ref .*(WeightPlotVector(97)./0.34).^params_temp(ismember(pNames,"b_reaction"));
        minDog_cl  = maxDog_cl;
        BestDog_cl = maxDog_cl;
        HumanCL_ref   = params_temp(ismember(pNames,"CL_ref"));
        maxHuman_cl  = HumanCL_ref .*(WeightPlotVector(910)./0.34).^params_temp(ismember(pNames,"b_reaction"));
        minHuman_cl  = maxHuman_cl;
        BestHuman_cl = maxHuman_cl;

        % Volume compartment 1
        maxTranslation_vd  = params_temp(ismember(pNames,"V1_ref")) .*(WeightPlotVector./0.34).^params_temp(ismember(pNames,"b_volume"));
        minTranslation_vd  = maxTranslation_vd;
        BestTranslation_vd = maxTranslation_vd;
        RatV1_ref   = params_temp(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(1);
        maxRat_vd  = RatV1_ref .*(WeightPlotVector(3)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minRat_vd  = maxRat_vd;
        BestRat_vd = maxRat_vd;
        MonkeyV1_ref   = params_temp(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(2);
        maxMonkey_vd  = MonkeyV1_ref .*(WeightPlotVector(43)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minMonkey_vd  = maxMonkey_vd;
        BestMonkey_vd = maxMonkey_vd;
        DogV1_ref   = params_temp(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(3);
        maxDog_vd  = DogV1_ref .*(WeightPlotVector(97)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minDog_vd  = maxDog_vd;
        BestDog_vd = maxDog_vd;
        HumanV1_ref   = params_temp(ismember(pNames,"V1_ref"));
        maxHuman_vd  = HumanV1_ref .*(WeightPlotVector(910)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minHuman_vd  = maxHuman_vd;
        BestHuman_vd = maxHuman_vd;
        
        % Volume compartment 2
        maxTranslation_vd2  = params_temp(ismember(pNames,"V2_ref")) .*(WeightPlotVector./0.34).^params_temp(ismember(pNames,"b_volume"));
        minTranslation_vd2  = maxTranslation_vd2;
        BestTranslation_vd2 = maxTranslation_vd2;
        RatV1_ref   = params_temp(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(1);
        maxRat_vd2  = RatV1_ref .*(WeightPlotVector(3)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minRat_vd2  = maxRat_vd2;
        BestRat_vd2 = maxRat_vd2;
        MonkeyV1_ref   = params_temp(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(2);
        maxMonkey_vd2  = MonkeyV1_ref .*(WeightPlotVector(43)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minMonkey_vd2  = maxMonkey_vd2;
        BestMonkey_vd2 = maxMonkey_vd2;
        DogV1_ref   = params_temp(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(3);
        maxDog_vd2  = DogV1_ref .*(WeightPlotVector(97)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minDog_vd2  = maxDog_vd2;
        BestDog_vd2 = maxDog_vd2;
        HumanV1_ref   = params_temp(ismember(pNames,"V2_ref"));
        maxHuman_vd2  = HumanV1_ref .*(WeightPlotVector(910)./0.34).^params_temp(ismember(pNames,"b_volume"));
        minHuman_vd2  = maxHuman_vd2;
        BestHuman_vd2 = maxHuman_vd2;
        
        % Ka
        maxKa  = params_temp(ismember(pNames,"Ka"))*ConditionAlterations.Ka(1:2);
        minKa  = maxKa;
        BestKa = maxKa;
        
    end
    
    % Clearance
    NewTranslation_cl  = params_temp(ismember(pNames,"CL_ref")) .*(WeightPlotVector./0.34).^params_temp(ismember(pNames,"b_reaction")) ;
    maxTranslation_cl  = max(maxTranslation_cl,NewTranslation_cl);
    minTranslation_cl  = min(minTranslation_cl,NewTranslation_cl);
    RatCL_ref   = params_temp(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(1);
    NewRat_cl  = RatCL_ref .*(WeightPlotVector(3)./0.34).^params_temp(ismember(pNames,"b_reaction")) ;
    maxRat_cl  = max(maxRat_cl,NewRat_cl);
    minRat_cl  = min(minRat_cl,NewRat_cl);
    MonkeyCL_ref   = params_temp(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(2);
    NewMonkey_cl  = MonkeyCL_ref .*(WeightPlotVector(43)./0.34).^params_temp(ismember(pNames,"b_reaction")) ;
    maxMonkey_cl  = max(maxMonkey_cl,NewMonkey_cl);
    minMonkey_cl  = min(minMonkey_cl,NewMonkey_cl);
    DogCL_ref   = params_temp(ismember(pNames,"CL_ref")) * ConditionAlterations.CL(3);
    NewDog_cl  = DogCL_ref .*(WeightPlotVector(97)./0.34).^params_temp(ismember(pNames,"b_reaction")) ;
    maxDog_cl  = max(maxDog_cl,NewDog_cl);
    minDog_cl  = min(minDog_cl,NewDog_cl);
    HumanCL_ref   = params_temp(ismember(pNames,"CL_ref"));
    NewHuman_cl  = HumanCL_ref .*(WeightPlotVector(910)./0.34).^params_temp(ismember(pNames,"b_reaction")) ;
    maxHuman_cl  = max(maxHuman_cl,NewHuman_cl);
    minHuman_cl  = min(minHuman_cl,NewHuman_cl);
    
    % VolumeDistribution
    NewTranslation_vd  = params_temp(ismember(pNames,"V1_ref")) .*(WeightPlotVector./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxTranslation_vd  = max(maxTranslation_vd,NewTranslation_vd);
    minTranslation_vd  = min(minTranslation_vd,NewTranslation_vd);
    RatV1_ref   = params_temp(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(1);
    NewRat_vd  = RatV1_ref .*(WeightPlotVector(3)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxRat_vd  = max(maxRat_vd,NewRat_vd);
    minRat_vd  = min(minRat_vd,NewRat_vd);
    MonkeyV1_ref   = params_temp(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(2);
    NewMonkey_vd  = MonkeyV1_ref .*(WeightPlotVector(43)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxMonkey_vd  = max(maxMonkey_vd,NewMonkey_vd);
    minMonkey_vd  = min(minMonkey_vd,NewMonkey_vd);
    DogV1_ref   = params_temp(ismember(pNames,"V1_ref")) * ConditionAlterations.vd(3);
    NewDog_vd  = DogV1_ref .*(WeightPlotVector(97)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxDog_vd  = max(maxDog_vd,NewDog_vd);
    minDog_vd  = min(minDog_vd,NewDog_vd);
    HumanV1_ref   = params_temp(ismember(pNames,"V1_ref"));
    NewHuman_vd  = HumanV1_ref .*(WeightPlotVector(910)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxHuman_vd  = max(maxHuman_vd,NewHuman_vd);
    minHuman_vd  = min(minHuman_vd,NewHuman_vd);
    
    % VolumeDistribution2
    NewTranslation_vd2  = params_temp(ismember(pNames,"V2_ref")) .*(WeightPlotVector./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxTranslation_vd2  = max(maxTranslation_vd2,NewTranslation_vd2);
    minTranslation_vd2  = min(minTranslation_vd2,NewTranslation_vd2);
    RatV1_ref   = params_temp(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(1);
    NewRat_vd2  = RatV1_ref .*(WeightPlotVector(3)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxRat_vd2  = max(maxRat_vd2,NewRat_vd2);
    minRat_vd2  = min(minRat_vd2,NewRat_vd2);
    MonkeyV1_ref   = params_temp(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(2);
    NewMonkey_vd2  = MonkeyV1_ref .*(WeightPlotVector(43)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxMonkey_vd2  = max(maxMonkey_vd2,NewMonkey_vd2);
    minMonkey_vd2  = min(minMonkey_vd2,NewMonkey_vd2);
    DogV1_ref   = params_temp(ismember(pNames,"V2_ref")) * ConditionAlterations.vd2(3);
    NewDog_vd2  = DogV1_ref .*(WeightPlotVector(97)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxDog_vd2  = max(maxDog_vd2,NewDog_vd2);
    minDog_vd2  = min(minDog_vd2,NewDog_vd2);
    HumanV1_ref   = params_temp(ismember(pNames,"V2_ref"));
    NewHuman_vd2  = HumanV1_ref .*(WeightPlotVector(910)./0.34).^params_temp(ismember(pNames,"b_volume"));
    maxHuman_vd2  = max(maxHuman_vd2,NewHuman_vd2);
    minHuman_vd2  = min(minHuman_vd2,NewHuman_vd2);
    % Ka
    NewKa  = params_temp(ismember(pNames,"Ka"))*ConditionAlterations.Ka(1:2);  % 0.5, 5,50
    maxKa  = max(maxKa,NewKa);
    minKa  = min(minKa,NewKa);