load('Pharmacokinetic_paramsFull')

[row column]                  = size(Pharmacokinetic_params);
[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, params]              = IQMparameters(model);
SimulatePD                    = 1;

%% Collect uncertainty

WeightPlotVector     = (0.1:0.1:100);

for j = 1:row
    params_temp   =    Pharmacokinetic_params(j,1:column-1);
    
    % Build parameter and condition alterations
    params(1:10) = params_temp(1:10);
    ConditionAlterations.f  = [params_temp(11), params_temp(12)];                % Ape, Rat
    ConditionAlterations.Ka = [params_temp(13) params_temp(14)];                 % Rat, monkey
    ConditionAlterations.CL = [params_temp(15),params_temp(16),params_temp(17)]; % Rat, monkey, dog
    ConditionAlterations.vd = [params_temp(18),params_temp(19),params_temp(20)]; % Rat, monkey, dog
    ConditionAlterations.vd2 = [params_temp(21),params_temp(22),params_temp(23)];% Rat, monkey, dog
    
    try
        [simInVitroPK]                                 = SimulateInVitroPK(model,MPSpk_data,params,initialvalues,sNames,pNames);
        [simDog_E]                                     = SimulateSauterDog(model,Sauter2020_data,params,ConditionAlterations,initialvalues,sNames,pNames);
        [simApe_IV3,simApe_SC1,simApe_SC3,simApe_SC10] = SimulateGaoApe(model,GaoApe_data,params,ConditionAlterations,initialvalues,sNames,pNames);
        [simRatpd_vehicle,simRatpd_3,simRatpd_30,simRatpd_300,simRatpd_3000,simIV_50, simIV_5, simIV_0p5, simIVtransfusion_50, simIVtransfusion_5, simIVtransfusion_0p5, simSC_50, simSC_5, simSC_0p5] = SimulateGaoRat(model,[50],GaoExenatideConcentrations_data,params,ConditionAlterations,initialvalues,sNames,pNames,1);
        
        UncertaintyInVitroPK
        UncertaintyGaoRat
        UncertaintySauterDog
        UncertaintyGaoApe
        UncertaintyPKscaling
        
    end
end

%% Fig. 6B
figure()

TextSize = 20;

% legend
% subplot(2,5,1)
% hold on
% set(gca,'xtick',[0.1,1,10,100],'ytick',[0.01,1,100],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','XScale','log','YScale','log')
% [maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxTranslation_vd(1:97),minTranslation_vd(1:97),WeightPlotVector(1:97));
% fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.5,'EdgeAlpha',EdgeAlphaValue);
% plot(WeightPlotVector(98:end),maxTranslation_vd(98:end),'--','Color', color_blue,'LineWidth',2)
% fill([0.9 0.9 1.1 1.1] *0.34, [minRat_vd maxRat_vd maxRat_vd minRat_vd]            , color_red   ,'FaceAlpha',1,'EdgeAlpha',1);
% fill([0.9 0.9 1.1 1.1] *4.31, [minMonkey_vd maxMonkey_vd maxMonkey_vd minMonkey_vd], color_yellow,'FaceAlpha',1,'EdgeAlpha',1);
% fill([0.9 0.9 1.1 1.1] *9.725,[minDog_vd maxDog_vd maxDog_vd minDog_vd]            , color_black ,'FaceAlpha',1,'EdgeAlpha',1);
% fill([0.9 0.9 1.1 1.1] *91   ,[minHuman_vd maxHuman_vd maxHuman_vd minHuman_vd]    , color_green ,'FaceAlpha',1,'EdgeAlpha',1);
% legend('Scaling function','Prediction','Rat','Monkey','Dog','Human','FontSize',LegendSize,'Orientation','horizontal')
% hold off
% grid on

% vd
subplot(2,5,1)
hold on
set(gca,'xtick',[0.1,1,10,100],'ytick',[0.01,1,100],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','XScale','log','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxTranslation_vd(1:97),minTranslation_vd(1:97),WeightPlotVector(1:97));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.5,'EdgeAlpha',EdgeAlphaValue);
plot(WeightPlotVector(98:end),maxTranslation_vd(98:end),'--','Color', color_blue,'LineWidth',2)
plot(WeightPlotVector(98:end),minTranslation_vd(98:end),'--','Color', color_blue,'LineWidth',2)
fill([0.9 0.9 1.1 1.1] *0.34, [minRat_vd maxRat_vd maxRat_vd minRat_vd]            , color_red   ,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *4.31, [minMonkey_vd maxMonkey_vd maxMonkey_vd minMonkey_vd], color_yellow,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *9.725,[minDog_vd maxDog_vd maxDog_vd minDog_vd]            , color_black ,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *91   ,[minHuman_vd maxHuman_vd maxHuman_vd minHuman_vd]    , color_green ,'FaceAlpha',1,'EdgeAlpha',1);
xlim( [0.1 110])
ylim( [0.01 200])
ylabel({'Central volume'; '(L)'});
%xlabel({'Body weight (kg)'});
hold off
grid on

% vd2
subplot(2,5,2)
hold on
set(gca,'xtick',[0.1,1,10,100],'ytick',[0.01,1,100],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','XScale','log','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxTranslation_vd2(1:97),minTranslation_vd2(1:97),WeightPlotVector(1:97));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.5,'EdgeAlpha',EdgeAlphaValue);
plot(WeightPlotVector(98:end),maxTranslation_vd2(98:end),'--','Color', color_blue,'LineWidth',2)
plot(WeightPlotVector(98:end),minTranslation_vd2(98:end),'--','Color', color_blue,'LineWidth',2)
fill([0.9 0.9 1.1 1.1] *0.34, [minRat_vd2 maxRat_vd2 maxRat_vd2 minRat_vd2]            , color_red   ,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *4.31, [minMonkey_vd2 maxMonkey_vd2 maxMonkey_vd2 minMonkey_vd2], color_yellow,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *9.725,[minDog_vd2 maxDog_vd2 maxDog_vd2 minDog_vd2]            , color_black ,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *91   ,[minHuman_vd2 maxHuman_vd2 maxHuman_vd2 minHuman_vd2]    , color_green ,'FaceAlpha',1,'EdgeAlpha',1);
xlim( [0.1 110])
ylim( [0.01 200])
ylabel({'Peripheral volume'; '(L)'});
%xlabel({'Body weight (kg)'});
hold off
grid on

% Clearance
subplot(2,5,3)
hold on
set(gca,'xtick',[0.1,1,10,100],'ytick',[0.01,1,100],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','XScale','log','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxTranslation_cl(1:97),minTranslation_cl(1:97),WeightPlotVector(1:97));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.5,'EdgeAlpha',EdgeAlphaValue);
plot(WeightPlotVector(98:end),minTranslation_cl(98:end),'--','Color', color_blue,'LineWidth',2)
plot(WeightPlotVector(98:end),maxTranslation_cl(98:end),'--','Color', color_blue,'LineWidth',2)
fill([0.9 0.9 1.1 1.1] *0.34, [minRat_cl maxRat_cl maxRat_cl minRat_cl]            ,color_red   ,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *4.31, [minMonkey_cl maxMonkey_cl maxMonkey_cl minMonkey_cl],color_yellow,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *9.725,[minDog_cl maxDog_cl maxDog_cl minDog_cl]            ,color_black ,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *91   ,[minHuman_cl maxHuman_cl maxHuman_cl minHuman_cl]    ,color_green ,'FaceAlpha',1,'EdgeAlpha',1);
xlim( [0.1 110])
ylim( [0.01 200])
ylabel({'Additional in vivo'; 'clearance (1/min)'});
xlabel({'Body weight (kg)'});
hold off
grid on

% Ka
subplot(2,5,4)
hold on
set(gca,'xtick',[0.1,1,10,100],'ytick',[0.01,1,100],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','XScale','log','YScale','log')
fill([0.1 0.1 9.725 9.725],[min(Pharmacokinetic_params(:,ismember(pNames,"Ka"))), max(Pharmacokinetic_params(:,ismember(pNames,"Ka"))), max(Pharmacokinetic_params(:,ismember(pNames,"Ka"))), min(Pharmacokinetic_params(:,ismember(pNames,"Ka")))], color_blue,'FaceAlpha',0.5,'EdgeAlpha',EdgeAlphaValue);
plot(WeightPlotVector(98:end),WeightPlotVector(98:end)./WeightPlotVector(98:end) * max(Pharmacokinetic_params(:,ismember(pNames,"Ka"))),'--','Color', color_blue,'LineWidth',2)
plot(WeightPlotVector(98:end),WeightPlotVector(98:end)./WeightPlotVector(98:end) * min(Pharmacokinetic_params(:,ismember(pNames,"Ka"))),'--','Color', color_blue,'LineWidth',2)
fill([0.9 0.9 1.1 1.1] *0.34,[minKa(1), maxKa(1), maxKa(1), minKa(1)],color_red   ,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *4.31,[minKa(2), maxKa(2), maxKa(2), minKa(2)],color_yellow,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *91  ,[min(Pharmacokinetic_params(:,ismember(pNames,"Ka"))), max(Pharmacokinetic_params(:,ismember(pNames,"Ka"))), max(Pharmacokinetic_params(:,ismember(pNames,"Ka"))), min(Pharmacokinetic_params(:,ismember(pNames,"Ka")))], color_green,'FaceAlpha',1,'EdgeAlpha',1);
xlim( [0.1 110])
ylim( [0.01 200])
ylabel({'Ka'; '(1/min)'});
%xlabel({'Body weight (kg)'});
hold off
grid on

% f
subplot(2,5,5)
hold on
set(gca,'xtick',[0.1,1,10,100],'ytick',0:25:100,'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','XScale','log')
fill([0.9 0.9 1.1 1.1] *0.34,100*[min(Pharmacokinetic_params(:,12)), max(Pharmacokinetic_params(:,12)), max(Pharmacokinetic_params(:,12)), min(Pharmacokinetic_params(:,12))],color_red,'FaceAlpha',1,'EdgeAlpha',1);
fill([0.9 0.9 1.1 1.1] *4.31,100*[min(Pharmacokinetic_params(:,11)), max(Pharmacokinetic_params(:,11)), max(Pharmacokinetic_params(:,11)), min(Pharmacokinetic_params(:,11))],color_yellow,'FaceAlpha',1,'EdgeAlpha',1);
MeanF = mean(Pharmacokinetic_params(:,11:12)');
fill([0.9 0.9 1.1 1.1] *91  ,100*[min(MeanF), max(MeanF), max(MeanF), min(MeanF)],color_green,'FaceAlpha',1,'EdgeAlpha',1);
xlim( [0.1 110])
ylim( [0 110])
ylabel({'Bioavailability from'; 'subcutaneous injections (%)'});
%xlabel({'Body weight (kg)'});
hold off
grid on

%% Fig. 6C
figure()

subplot(3,5,1)
hold on
Y =100*[simInvitro.variablevalues(:,ismember(simInvitro.variables,'E1')), simInvitro.variablevalues(:,ismember(simInvitro.variables,'E2')), simInvitro.statevalues(:,ismember(simInvitro.states,'SumDegradation')), simInvitro.statevalues(:,ismember(simInvitro.states,'SumClearance'))];
set(gca,'xtick',0:2:6,'ytick',0:20:100,'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
area(simInvitro.time/60,Y)
ylim( [0,110])
xlim( [0, 6])
ylabel({'Exenatide' ; '(%)'});
xlabel({'Time (h)'});
%legend('Central volume','Peripheral volume','In vitro degradation','Additional in vivo clearance','Orientation','horizontal')
hold off
grid on

subplot(3,5,2)
hold on
Y =100*[simRat.variablevalues(:,ismember(simRat.variables,'E1')), simRat.variablevalues(:,ismember(simRat.variables,'E2')), simRat.statevalues(:,ismember(simRat.states,'SumDegradation')), simRat.statevalues(:,ismember(simRat.states,'SumClearance'))];
set(gca,'xtick',0:2:6,'ytick',0:20:100,'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
area(simInvitro.time/60,Y)
ylim( [0,110])
xlim( [0, 6])
ylabel({'Exenatide' ; '(%)'});
xlabel({'Time (h)'});
hold off
grid on

subplot(3,5,3)
hold on
Y =100*[simApe.variablevalues(:,ismember(simApe.variables,'E1')), simApe.variablevalues(:,ismember(simApe.variables,'E2')), simApe.statevalues(:,ismember(simApe.states,'SumDegradation')), simApe.statevalues(:,ismember(simApe.states,'SumClearance'))];
set(gca,'xtick',0:2:6,'ytick',0:20:100,'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
area(simInvitro.time/60,Y)
ylim( [0,110])
xlim( [0, 6])
ylabel({'Exenatide' ; '(%)'});
xlabel({'Time (h)'});
hold off
grid on

subplot(3,5,4)
hold on
Y =100*[simDog.variablevalues(:,ismember(simDog.variables,'E1')), simDog.variablevalues(:,ismember(simDog.variables,'E2')), simDog.statevalues(:,ismember(simDog.states,'SumDegradation')), simDog.statevalues(:,ismember(simDog.states,'SumClearance'))];
set(gca,'xtick',0:2:6,'ytick',0:20:100,'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
area(simInvitro.time/60,Y)
ylim( [0,110])
xlim( [0, 6])
ylabel({'Exenatide' ; '(%)'});
xlabel({'Time (h)'});
hold off
grid on

subplot(3,5,5)
hold on
Y =100*[simHuman.variablevalues(:,ismember(simHuman.variables,'E1')), simHuman.variablevalues(:,ismember(simHuman.variables,'E2')), simHuman.statevalues(:,ismember(simHuman.states,'SumDegradation')), simHuman.statevalues(:,ismember(simHuman.states,'SumClearance'))];
set(gca,'xtick',0:2:6,'ytick',0:20:100,'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
area(simInvitro.time/60,Y)
ylim( [0,110])
xlim( [0, 6])
ylabel({'Exenatide' ; '(%)'});
xlabel({'Time (h)'});
hold off
grid on

%% Fig. 6A - Rat
figure()

% IV
subplot(2,3,1)
hold on
set(gca,'xtick',0:2:6,'ytick',[0.00001,0.001,0.1,10,1000,100000],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','YScale','log')
errorbar(GaoExenatideConcentrations_data.timeExenatideIV/60,GaoExenatideConcentrations_data.ExenatideIV_50nM/1000,GaoExenatideConcentrations_data.ExenatideIV_50nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_red)
errorbar(GaoExenatideConcentrations_data.timeExenatideIV/60,GaoExenatideConcentrations_data.ExenatideIV_5nM/1000,GaoExenatideConcentrations_data.ExenatideIV_5nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_yellow)
errorbar(GaoExenatideConcentrations_data.timeExenatideIV/60,GaoExenatideConcentrations_data.ExenatideIV_0p5nM/1000,GaoExenatideConcentrations_data.ExenatideIV_0p5nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_green)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideIV_50',maxExenatideIV_50',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideIV_5',maxExenatideIV_5',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideIV_0p5',maxExenatideIV_0p5',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
plot(simIV_50.time/60,BestExenatideIV_50.statevalues(:,ismember(BestExenatideIV_50.states,'C1'))  ,'Color', color_red,'LineWidth',4)
plot(simIV_50.time/60,BestExenatideIV_5.statevalues(:,ismember(BestExenatideIV_5.states,'C1'))   ,'Color', color_yellow,'LineWidth',4)
plot(simIV_50.time/60,BestExenatideIV_0p5.statevalues(:,ismember(BestExenatideIV_0p5.states,'C1')) ,'Color', color_green,'LineWidth',4)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on','FontSize', TextSize);
xlabel({'Time (h)'},'FontSmoothing','on');
ylim( [0.00001, 1000])
xlim( [0, 7])
line([0 0.2], [0.00001 0.00001],'Color','k','LineWidth',8);
legend('IV: 50 nMol','IV: 5 nMol','IV: 0.5 nMol','Location','Best','FontSize',20)
grid on
hold off

% IV infusion
subplot(2,3,2)
hold on
set(gca,'xtick',0:2:6,'ytick',[0.00001,0.001,0.1,10,1000,100000],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','YScale','log')
errorbar(GaoExenatideConcentrations_data.timeExenatideIVtransfusion/60,GaoExenatideConcentrations_data.ExenatideIVinfusion_50nM/1000,GaoExenatideConcentrations_data.ExenatideIVinfusion_50nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_red)
errorbar(GaoExenatideConcentrations_data.timeExenatideIVtransfusion/60,GaoExenatideConcentrations_data.ExenatideIVinfusion_5nM/1000,GaoExenatideConcentrations_data.ExenatideIVinfusion_5nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_yellow)
errorbar(GaoExenatideConcentrations_data.timeExenatideIVtransfusion/60,GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nM/1000,GaoExenatideConcentrations_data.ExenatideIVinfusion_0p5nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_green)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideIVtransfusion_50',maxExenatideIVtransfusion_50',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideIVtransfusion_5',maxExenatideIVtransfusion_5',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideIVtransfusion_0p5',maxExenatideIVtransfusion_0p5',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
plot(simIV_50.time/60,BestExenatideIVtransfusion_50  ,'Color', color_red,'LineWidth',4)
plot(simIV_50.time/60,BestExenatideIVtransfusion_5   ,'Color', color_yellow,'LineWidth',4)
plot(simIV_50.time/60,BestExenatideIVtransfusion_0p5 ,'Color', color_green,'LineWidth',4)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on','FontSize', TextSize);
xlabel({'Time (h)'},'FontSmoothing','on');
ylim( [0.00001, 1000])
xlim( [0, 7])
line([0 3], [0.00001 0.00001],'Color','k','LineWidth',4);
legend('IV infusion: 50 nMol/h','IV infusion: 5 nMol/h','IV infusion: 0.5 nMol/h','Location','Best','FontSize',20)
grid on
hold off

% SC
subplot(2,3,3)
hold on
set(gca,'xtick',0:2:6,'ytick',[0.00001,0.001,0.1,10,1000,100000],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','YScale','log')
errorbar(GaoExenatideConcentrations_data.Exenatidestimesd/60,GaoExenatideConcentrations_data.Exenatidesd_50nM/1000,GaoExenatideConcentrations_data.Exenatidesd_50nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_red)
errorbar(GaoExenatideConcentrations_data.Exenatidestimesd/60,GaoExenatideConcentrations_data.Exenatidesd_5nM/1000,GaoExenatideConcentrations_data.Exenatidesd_5nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_yellow)
errorbar(GaoExenatideConcentrations_data.Exenatidestimesd/60,GaoExenatideConcentrations_data.Exenatidesd_0p5nM/1000,GaoExenatideConcentrations_data.Exenatidesd_0p5nMSEM/1000,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_green)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideSC_50',maxExenatideSC_50',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideSC_5',maxExenatideSC_5',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideSC_0p5',maxExenatideSC_0p5',simIV_50.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
plot(simIV_50.time/60,BestExenatideSC_50 ,'Color', color_red,'LineWidth',4)
plot(simIV_50.time/60,BestExenatideSC_5  ,'Color', color_yellow,'LineWidth',4)
plot(simIV_50.time/60,BestExenatideSC_0p5,'Color', color_green,'LineWidth',4)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on','FontSize', TextSize);
xlabel({'Time (h)'},'FontSmoothing','on');
ylim( [0.00001, 1000])
xlim( [0, 7])
line([0 0.2], [0.00001 0.00001],'Color','k','LineWidth',8);
legend('subcutaneous injection: 50 nMol','subcutaneous injection: 5 nMol','subcutaneous injection: 0.5 nMol','Location','Best','FontSize',20)
grid on
hold off

% The infusion for the PD (Fig. 7A iii)
figure()
subplot(2,3,1)
hold on
set(gca,'xtick',-30:30:90,'ytick',[0.1,10,1000],'FontSize', 20,'FontSmoothing','on','fontname','Arial','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_3',minGaoE_3',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_30',minGaoE_30',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_300',minGaoE_300',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_orange,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_3000',minGaoE_3000',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_3.time-30   ,BestGaoE_3    ,'Color', color_green,'LineWidth',4)
plot(simRatpd_30.time-30  ,BestGaoE_30   ,'Color', color_yellow,'LineWidth',4)
plot(simRatpd_300.time-30 ,BestGaoE_300  ,'Color', color_orange,'LineWidth',4)
plot(simRatpd_3000.time-30,BestGaoE_3000,'Color', color_red,'LineWidth',4)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on','FontSize', 20);
xlabel({'Time (min)'},'FontSmoothing','on');
ylim( [0.01, 1000])
xlim( [-30, 90])
line([0 2], [0.01 0.01],'Color','k','LineWidth',8);
grid on
hold off

%% Fig. 6A (non-rats)
figure()

% human cell study PK
subplot(2,3,1)
hold on
set(gca,'xtick',0:12:48,'ytick',0:0.2:1,'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minInVitroE',maxInVitroE',simInVitroPK.time);
errorbar([0,48]   ,[1,MPSpk_data.All(1)],[0,MPSpk_data.All(2)],'Color', color_black,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp./maxTemp(1), fliplr(minTemp)./minTemp(1)], color_black,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
line([0 1], [0 0],'Color','k','LineWidth',8);
ylabel({'Exenatide'; '(normalised to dose)'},'FontSmoothing','on');
xlabel({'Time (h)'},'FontSmoothing','on');
xlim( [0 48.5])
ylim( [0 1.1])
grid on
hold off

% Monkey PK
subplot(2,3,2)
hold on
set(gca,'xtick',0:2:12,'ytick',[0.001,0.1,10,1000,100000],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','YScale','log')
plot(GaoApe_data.timeIV3/60,GaoApe_data.IV3,' x','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_yellow)
plot(GaoApe_data.timeSC1(2:end)/60,GaoApe_data.SC1(2:end),' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_green)
plot(GaoApe_data.timeSC3(2:end)/60,GaoApe_data.SC3(2:end),' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_yellow)
plot(GaoApe_data.timeSC10(2:end)/60,GaoApe_data.SC10(2:end),' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_red)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideMonkey_IV3',maxExenatideMonkey_IV3',simApe_IV3.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideMonkey_SC1',maxExenatideMonkey_SC1',simApe_IV3.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideMonkey_SC3',maxExenatideMonkey_SC3',simApe_IV3.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideMonkey_SC10',maxExenatideMonkey_SC10',simApe_IV3.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
plot(simApe_IV3.time/60, BestExenatideMonkey_IV3.statevalues(:,ismember(BestExenatideMonkey_IV3.states,'C1')),'Color', color_yellow,'LineWidth',4)
plot(simApe_IV3.time/60, BestExenatideMonkey_SC1,'Color', color_green,'LineWidth',4)
plot(simApe_IV3.time/60, BestExenatideMonkey_SC3,'Color', color_yellow,'LineWidth',4)
plot(simApe_IV3.time/60, BestExenatideMonkey_SC10,'Color', color_red,'LineWidth',4)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on');
xlabel({'Time (h)'},'FontSmoothing','on');
ylim( [0.001, 40])
xlim( [0, 12.1])
line([0 0.2], [0.001 0.001],'Color','k','LineWidth',8);
legend('IV: 3 ug/kg','subcutaneous injection: 1 ug/kg','subcutaneous injection: 3 ug/kg','subcutaneous injection: 10 ug/kg','Location','Best','FontSize',15)
grid on
hold off

% Dog PK
subplot(2,3,3)
hold on
set(gca,'xtick',0:2:12,'ytick',[0.001,0.1,10,1000,100000],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','YScale','log')
errorbar(Sauter2020_data.Time/60,Sauter2020_data.E,Sauter2020_data.Estdev,' .','MarkerSize',MarkerSize,'LineWidth',LineWidthValue,'color',color_black)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideDog',maxExenatideDog',simDog_E.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)], color_black,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0);
plot(simDog_E.time/60,BestExenatideDog.statevalues(:,ismember(BestExenatideDog.states,'C1')),'Color', color_black,'LineWidth',4)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on');
xlabel({'Time (h)'},'FontSmoothing','on');
ylim( [0.0001, 50])
xlim( [0, 12])
line([0 0.3], [0.0001 0.0001],'Color','k','LineWidth',8);
legend('IV: 100 ug','FontSize',15,'Orientation','horizontal')
grid on
hold off

%% Simulate prediction and sort based on cost
load('Pharmacokinetic_paramsFull')

% Sort
for j = 1:row
        % Build parameter vector
    params_temp   =    Pharmacokinetic_params(j,1:column-1);
    params(1:10)  = params_temp(1:10);
    ConditionAlterations.f  = [params_temp(11), params_temp(12)];                % Ape, Rat
    ConditionAlterations.Ka = [params_temp(13) params_temp(14)];                 % Rat, monkey
    ConditionAlterations.CL = [params_temp(15),params_temp(16),params_temp(17)]; % Rat, monkey, dog
    ConditionAlterations.vd = [params_temp(18),params_temp(19),params_temp(20)]; % Rat, monkey, dog
    ConditionAlterations.vd2 = [params_temp(21),params_temp(22),params_temp(23)];% Rat, monkey, dog
    try
        % Simulate
        [SimGaoHuman_0p1,SimGaoHuman_0p2,SimGaoHuman_0p3,SimGaoHuman_0p4] = SimulateGaoHuman(params,ConditionAlterations,pNames,sNames,initialvalues,model);
        % Calculate cost
        DatapointsSampleFromSimulation = round(GaoHuman_data.Time(1:19),0);
        E0p1_human       = SimGaoHuman_0p1.statevalues(DatapointsSampleFromSimulation,ismember(SimGaoHuman_0p1.states,'C1'))*1000;
        E0p2_human       = SimGaoHuman_0p2.statevalues(DatapointsSampleFromSimulation,ismember(SimGaoHuman_0p2.states,'C1'))*1000;
        E0p3_human       = SimGaoHuman_0p3.statevalues(DatapointsSampleFromSimulation,ismember(SimGaoHuman_0p3.states,'C1'))*1000;
        E0p4_human       = SimGaoHuman_0p4.statevalues(DatapointsSampleFromSimulation,ismember(SimGaoHuman_0p4.states,'C1'))*1000;
        Cost_Human0p1    = ((GaoHuman_data.sd0p1(1:19) - E0p1_human).^2)  ./(mean(GaoHuman_data.sd0p1stdev(1:19)).^2);
        Cost_Human0p2    = ((GaoHuman_data.sd0p2(1:19) - E0p2_human).^2)  ./(mean(GaoHuman_data.sd0p2stdev(1:19)).^2);
        Cost_Human0p3    = ((GaoHuman_data.sd0p3(1:19) - E0p3_human).^2)  ./(mean(GaoHuman_data.sd0p3stdev(1:19)).^2);
        Cost_Human0p4    = ((GaoHuman_data.sd0p4(1:19) - E0p4_human).^2)  ./(mean(GaoHuman_data.sd0p4stdev(1:19)).^2);
        Cost_Human       = sum(Cost_Human0p1,'omitnan') + sum(Cost_Human0p2,'omitnan') + sum(Cost_Human0p3,'omitnan') + sum(Cost_Human0p4,'omitnan');
        Pharmacokinetic_params(j,column) = Cost_Human;
    end
end
[row column]           = size(Pharmacokinetic_params);
Pharmacokinetic_params = sortrows(Pharmacokinetic_params,column); % set the best prediction first

% Simulate
for j = 1:row
    % Build parameter and condition alterations
    params_temp   =    Pharmacokinetic_params(j,1:column-1);
    params(1:10)  = params_temp(1:10);
    ConditionAlterations.f  = [params_temp(11), params_temp(12)];                % Ape, Rat
    ConditionAlterations.Ka = [params_temp(13) params_temp(14)];                 % Rat, monkey
    ConditionAlterations.CL = [params_temp(15),params_temp(16),params_temp(17)]; % Rat, monkey, dog
    ConditionAlterations.vd = [params_temp(18),params_temp(19),params_temp(20)]; % Rat, monkey, dog
    ConditionAlterations.vd2 = [params_temp(21),params_temp(22),params_temp(23)];% Rat, monkey, dog
    try
        [SimGaoHuman_0p1,SimGaoHuman_0p2,SimGaoHuman_0p3,SimGaoHuman_0p4] = SimulateGaoHuman(params,ConditionAlterations,pNames,sNames,initialvalues,model);
        UncertaintyGaoHuman
    end
end

%% Fig. 6D (Human PK prediction)

% Disp agreement to data
disp(' ')
if Pharmacokinetic_params(1,column) < chi2inv(0.95,76)
    disp('----- Best prediction of human exenatide pharmacokinetics is below statistical threshold -----')
end
fprintf('Best fit to human cell data: %.2f, Statistical Limit: %.2f (dgf = %i)', Pharmacokinetic_params(1,column), chi2inv(0.95,76), 76)
disp(' ')

% Plot
figure()
subplot(2,1,1)
hold on
set(gca,'xtick',0:6:24,'ytick',[0.1,10,1000],'FontSize', TextSize,'FontSmoothing','on','fontname','Arial','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideHuman_0p1',maxExenatideHuman_0p1',SimGaoHuman_0p1.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)]*1000, color_blue,'FaceAlpha',0.3,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideHuman_0p2',maxExenatideHuman_0p2',SimGaoHuman_0p1.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)]*1000, color_green,'FaceAlpha',0.3,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideHuman_0p3',maxExenatideHuman_0p3',SimGaoHuman_0p1.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)]*1000, color_yellow,'FaceAlpha',0.3,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExenatideHuman_0p4',maxExenatideHuman_0p4',SimGaoHuman_0p1.time);
fill([timeTemp, fliplr(timeTemp)]/60,[maxTemp, fliplr(minTemp)]*1000, color_red,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(SimGaoHuman_0p1.time/60,BestExenatideHuman_0p1*1000  ,'Color', color_blue  ,'LineWidth',2)
plot(SimGaoHuman_0p2.time/60,BestExenatideHuman_0p2*1000  ,'Color', color_green ,'LineWidth',2)
plot(SimGaoHuman_0p3.time/60,BestExenatideHuman_0p3*1000  ,'Color', color_yellow,'LineWidth',2)
plot(SimGaoHuman_0p4.time/60,BestExenatideHuman_0p4*1000  ,'Color', color_red   ,'LineWidth',2)
errorbar(GaoHuman_data.Time/60,GaoHuman_data.sd0p1,GaoHuman_data.sd0p1stdev,'Color', color_blue,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(GaoHuman_data.Time/60,GaoHuman_data.sd0p2,GaoHuman_data.sd0p2stdev,'Color', color_green,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(GaoHuman_data.Time/60,GaoHuman_data.sd0p3,GaoHuman_data.sd0p3stdev,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(GaoHuman_data.Time/60,GaoHuman_data.sd0p4,GaoHuman_data.sd0p4stdev,'Color', color_red,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Exenatide' ; '(nM)'},'FontSmoothing','on');
xlabel({'Time (h)'},'FontSmoothing','on');
line([0 0.3], [0.05 0.05],'Color','k','LineWidth',8);
legend('subcutaneous injection: 0.1 ug/kg','subcutaneous injection: 0.2 ug/kg','subcutaneous injection: 0.3 ug/kg','subcutaneous injection: 0.4 ug/kg','Location','Best','FontSize',20)
ylim([0.05 2000])
xlim([-0.1 24])
grid on
hold off