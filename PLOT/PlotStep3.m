load('ModelUncertainty_RatFull')

[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param]               = IQMparameters(model);
Exenatide_x                   = logspace(-2,3,500);
SimulatePD                    = 1;
RecalcSimulations             = 0;
%% Extract PK vector and condition alterations

load('Pharmacokinetic_params')
ConditionAlterations.f   = [Pharmacokinetic_params(11), Pharmacokinetic_params(12)];                           % Ape, Rat
ConditionAlterations.Ka  = [Pharmacokinetic_params(13) Pharmacokinetic_params(14)];                            % Rat, monkey
ConditionAlterations.CL  = [Pharmacokinetic_params(15),Pharmacokinetic_params(16),Pharmacokinetic_params(17)]; % Rat, monkey, dog
ConditionAlterations.vd  = [Pharmacokinetic_params(18),Pharmacokinetic_params(19),Pharmacokinetic_params(20)]; % Rat, monkey, dog
ConditionAlterations.vd2 = [Pharmacokinetic_params(21),Pharmacokinetic_params(22),Pharmacokinetic_params(23)]; % Rat, monkey, dog

    %% Recalculate all simulations
    if RecalcSimulations == 1
        % Sort parameter vectors to cost-value and calculate it
[row column] = size(ModelUncertainty_Rat);

for j = 1:row
    params_temp = ModelUncertainty_Rat(j,1:column-1);
    cost        = Gao2011_costfunction(Gao2011Rat_data,GaoExenatideConcentrations_data,log(params_temp),Pharmacokinetic_params,modelName,sNames, pNames,initialvalues,AmountParameterOpti,1,1);
   ModelUncertainty_Rat(j,column) = cost;

end
[row column] = size(ModelUncertainty_Rat);
ModelUncertainty_Rat = sortrows(ModelUncertainty_Rat,column);

% Simulate
[pNames, CombinedParameters] = IQMparameters(model);
CombinedParameters(1:10)      = Pharmacokinetic_params(1:10);
for j = 1:row
    params_temp =    ModelUncertainty_Rat(j,1:column-1);
    CombinedParameters(13:62)    = params_temp(1:50);
    
    [simRatpd_vehicle,simRatpd_3,simRatpd_30,simRatpd_300,simRatpd_3000,simIV_50, simIV_5, simIV_0p5, simIVtransfusion_50, simIVtransfusion_5, simIVtransfusion_0p5, simSC_50, simSC_5, simSC_0p5] = SimulateGaoRat(model,[40],GaoExenatideConcentrations_data,CombinedParameters,ConditionAlterations,initialvalues,sNames,pNames,1);
    UncertaintyGaoRat
    
    % Dose-response calculations
    if j == 1
        Exenatide_hill   = Exenatide_x.^CombinedParameters(ismember(pNames,"ExenatideInsulin_hill"));
        maxExanitide_PD  = 1 + (((CombinedParameters(ismember(pNames,"ExenatideInsulinMax")).*Exenatide_hill./((CombinedParameters(ismember(pNames,"ExenatideInsulin50")).^CombinedParameters(ismember(pNames,"ExenatideInsulin_hill")))+Exenatide_hill)) - (Exenatide_hill.*CombinedParameters(ismember(pNames,"ExenatideInsulinDecayMax"))./(Exenatide_hill+(CombinedParameters(ismember(pNames,"ExenatideInsulinDecay50")).^CombinedParameters(ismember(pNames,"ExenatideInsulin_hill")))))));
        minExanitide_PD  = maxExanitide_PD;
        BestExanitide_PD = maxExanitide_PD;
    end
    Exenatide_hill   = Exenatide_x.^CombinedParameters(ismember(pNames,"ExenatideInsulin_hill"));
    NewExanitide_PD  =  1 + (((CombinedParameters(ismember(pNames,"ExenatideInsulinMax")).*Exenatide_hill./(( CombinedParameters(ismember(pNames,"ExenatideInsulin50")).^CombinedParameters(ismember(pNames,"ExenatideInsulin_hill")))+Exenatide_hill)) - (Exenatide_hill.*CombinedParameters(ismember(pNames,"ExenatideInsulinDecayMax"))./(Exenatide_hill+(CombinedParameters(ismember(pNames,"ExenatideInsulinDecay50")).^CombinedParameters(ismember(pNames,"ExenatideInsulin_hill")))))));
    maxExanitide_PD  = max(maxExanitide_PD,NewExanitide_PD);
    minExanitide_PD  = min(minExanitide_PD,NewExanitide_PD);
    EC50min_Rat(j) = min(Exenatide_x(NewExanitide_PD > 0.5*max(NewExanitide_PD)));
    EC75min_Rat(j) = min(Exenatide_x(NewExanitide_PD > 0.75*max(NewExanitide_PD)));
    EC100min_Rat(j) = min(Exenatide_x(NewExanitide_PD == 1*max(NewExanitide_PD)));

end
    else
        load('WorkspacePlotGao')  
    end
%% Build Rat EC responses (used in Fig. 7D)

ECBest_Rat.EC50   = EC50min_Rat(1);
EC_Rat.EC50    = [min(EC50min_Rat), max(EC50min_Rat)];
ECBest_Rat.EC75   = EC75min_Rat(1);
EC_Rat.EC75    = [min(EC75min_Rat), max(EC75min_Rat)];
ECBest_Rat.EC100   = EC100min_Rat(1);
EC_Rat.EC100    = [min(EC100min_Rat), max(EC100min_Rat)];
% save(['EC_Rat'],'EC_Rat');
% save(['ECBest_Rat'],'ECBest_Rat');

 %% Disp agreement to data

disp(' ')
if Cost_InsulinLow < chi2inv(0.95,76)
    disp('----- Best description of exenatide effect on rat insulin secretion is below statistical threshold -----')
end
fprintf('Best fit to rat data: %.2f, Statistical Limit: %.2f (dgf = %i)', Cost_InsulinLow, chi2inv(0.95,60), 60)
disp(' ')

%% Fig. 7A i-ii
figure()

% % Legend
% figure()
% hold on
% set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,10,20,30,40],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_blue,'LineWidth',3)
% plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_green,'LineWidth',3)
% plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_yellow,'LineWidth',3)
% plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_orange,'LineWidth',3)
% plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_red,'LineWidth',3)
% ylabel({'Glucose';'(mM)'},'FontSmoothing','on','FontSize', 20);
% legend('0 (pmol/kg/min)','3 (pmol/kg/min)','30 (pmol/kg/min)','300 (pmol/kg/min)','30000 (pmol/kg/min)','Location','Best','Orientation','horizontal')
% ylim( [0, 40])
% xlim( [-40, 90])
% grid on
% hold off

subplot(2,5,1)
hold on
set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,10,20,30,40],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minGaoG_Vehicle',maxGaoG_Vehicle',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_blue,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_blue,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_0,Gao2011Rat_data.glucoseSEM_0,'LineStyle', 'n', 'Marker',marker0,'color',color_blue,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Glucose'; '(mM)'},'FontSmoothing','on','FontSize', 20);
ylim( [0, 40])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,6)
hold on
set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,1000,2000,3000],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_Vehicle',minGaoI_Vehicle',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoI_Vehicle,'Color', color_blue,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_0,Gao2011Rat_data.insulinSEM_0,'LineStyle', 'n', 'Marker',marker0,'color',color_blue,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Insulin'; '(pM)'},'FontSmoothing','on','FontSize', 20);
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,2)
hold on
set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,10,20,30,40],'Yticklabel',[],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_3',minGaoG_3',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_green,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoG_3/18,'Color', color_green,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_3,Gao2011Rat_data.glucoseSEM_3,'LineStyle', 'n', 'Marker',marker0,'color',color_green,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 40])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,7)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_3',minGaoI_3',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoI_3,'Color', color_green,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_3,Gao2011Rat_data.insulinSEM_3,'LineStyle', 'n', 'Marker',marker0,'color',color_green,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,3)
hold on
set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,10,20,30,40],'Yticklabel',[],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_30',minGaoG_30',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_yellow,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoG_30/18,'Color', color_yellow,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_30,Gao2011Rat_data.glucoseSEM_30,'LineStyle', 'n', 'Marker',marker0,'color',color_yellow,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
xlabel({'Time (min)'},'FontSmoothing','on','FontSize', 20);
ylim( [0, 40])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,8)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_30',minGaoI_30',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoI_30,'Color', color_yellow,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_30,Gao2011Rat_data.insulinSEM_30,'LineStyle', 'n', 'Marker',marker0,'color',color_yellow,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
xlabel({'Time (min)'},'FontSmoothing','on','FontSize', 20);
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,4)
hold on
set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,10,20,30,40],'Yticklabel',[],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_300',minGaoG_300',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_orange,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoG_300/18,'Color', color_orange,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_300,Gao2011Rat_data.glucoseSEM_300,'LineStyle', 'n', 'Marker',marker0,'color',color_orange,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 40])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,9)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_300',minGaoI_300',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_orange,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoI_300,'Color', color_orange,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_300,Gao2011Rat_data.insulinSEM_300,'LineStyle', 'n', 'Marker',marker0,'color',color_orange,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,5)
hold on
set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,10,20,30,40],'Yticklabel',[],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_3000',minGaoG_3000',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_red,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoG_3000/18,'Color', color_red,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_3000,Gao2011Rat_data.glucoseSEM_3000,'LineStyle', 'n', 'Marker',marker0,'color',color_red,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 40])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,10)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_3000',minGaoI_3000',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.3,'EdgeAlpha',0);
plot(simRatpd_vehicle.time-30,BestGaoI_3000,'Color', color_red,'LineWidth',2)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_3000,Gao2011Rat_data.insulinSEM_3000,'LineStyle', 'n', 'Marker',marker0,'color',color_red,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

%% Fig. 7A iii-v
figure()

FillBarWidth = 0.2;
BarWidth     = 0.2;

subplot(2,3,1)
hold on
set(gca,'xtick',-30:30:90,'ytick',[0.1,10,1000],'FontSize', 20,'FontSmoothing','on','fontname','Arial','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_3',minGaoE_3',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.3,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_30',minGaoE_30',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',0.3,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_300',minGaoE_300',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_orange,'FaceAlpha',0.3,'EdgeAlpha',0);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoE_3000',minGaoE_3000',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.3,'EdgeAlpha',0);
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

subplot(2,3,2)
hold on
set(gca,'ytick',0:25:100,'xtick',1:5,'XTickLabel',{'0','3','30','300','30000'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
ylabel({'Phase-I insulin secretion'; '(%)'},'FontSmoothing','on','FontSize', 20);
xlabel({'Exenatide IV-infusion (pmol/kg/min)'},'FontSmoothing','on');
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1 ,100*[maxGaoSRatio_Vehicle  , maxGaoSRatio_Vehicle , minGaoSRatio_Vehicle  , minGaoSRatio_Vehicle] , color_blue,'FaceAlpha',0.3,'EdgeAlpha', 0.4);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2 ,100*[maxGaoSRatio_3       , maxGaoSRatio_3      , minGaoSRatio_3       , minGaoSRatio_3]      , color_green,'FaceAlpha',0.3,'EdgeAlpha', 0.4);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3 ,100*[maxGaoSRatio_30      , maxGaoSRatio_30     , minGaoSRatio_30      , minGaoSRatio_30]     , color_yellow,'FaceAlpha',0.3,'EdgeAlpha', 0.4);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+4 ,100*[maxGaoSRatio_300     , maxGaoSRatio_300    , minGaoSRatio_300     , minGaoSRatio_300]    , color_orange,'FaceAlpha',0.3,'EdgeAlpha', 0.4);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+5 ,100*[maxGaoSRatio_3000    , maxGaoSRatio_3000   , minGaoSRatio_3000    , minGaoSRatio_3000]   , color_red,'FaceAlpha',0.3,'EdgeAlpha', 0.4);
bar(1,100*BestGaoSRatio_Vehicle,BarWidth, 'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.8);
bar(2,100*BestGaoSRatio_3,BarWidth, 'FaceColor',color_green,'LineWidth',1,'FaceAlpha',0.8);
bar(3,100*BestGaoSRatio_30,BarWidth, 'FaceColor',color_yellow,'LineWidth',1,'FaceAlpha',0.8);
bar(4,100*BestGaoSRatio_300,BarWidth, 'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.8);
bar(5,100*BestGaoSRatio_3000,BarWidth, 'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.8);
ylim( [0, 100])
xlim( [0.5, 5.5])
grid on
hold off

load('HumanCellPhase')
subplot(2,3,3)
hold on
set(gca,'ytick',0:25:100,'xtick',[1,1.9,3],'XTickLabel',{'Rat','EndoC-BH5','Human islets'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
ylabel({'Phase-I/Phase-II'; 'Exenatide effect (%)'},'FontSmoothing','on','FontSize', 20);
bar(1,100-100*ModelUncertainty_Rat(1,22-12),FillBarWidth, 'FaceColor',color_gray,'LineWidth',2,'FaceAlpha',1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1 ,100-100*[max(ModelUncertainty_Rat(:,22-12)),max(ModelUncertainty_Rat(:,22-12)),min(ModelUncertainty_Rat(:,22-12)),min(ModelUncertainty_Rat(:,22-12))], color_gray,'FaceAlpha',0.2,'EdgeAlpha', 0.2);
bar(1.9,HumanCellPhase.EndoC(1),FillBarWidth, 'FaceColor',color_gray,'LineWidth',1,'FaceAlpha',1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1.9 ,[HumanCellPhase.EndoC(2),HumanCellPhase.EndoC(2),HumanCellPhase.EndoC(3),HumanCellPhase.EndoC(3)], color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.4);
bar(3,HumanCellPhase.Human(1),FillBarWidth, 'FaceColor',color_gray,'LineWidth',1,'FaceAlpha',1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3 ,[HumanCellPhase.Human(2),HumanCellPhase.Human(2),HumanCellPhase.Human(3),HumanCellPhase.Human(3)], color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.4);
ylim( [0, 100])
xlim( [0.65, 3.4])
grid on
hold off

% Exenatide dose response
subplot(2,3,4)
hold on
set(gca,'xtick',[0.01,1,100],'ytick',0:3:11,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxExanitide_PD,minExanitide_PD,Exenatide_x);
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_black,'FaceAlpha',0.2,'EdgeAlpha',0);
plot(Exenatide_x,BestExanitide_PD','Color', color_black,'LineWidth',2)
xlim( [0.01 300])
ylim( [0 11])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(increase from baseline)'},'FontSmoothing','on','FontSize', 20);
hold off
grid on

%% Create Rat exenatide parameter matrix for step 4

% load('ExenatideParamMatrix_population')
% load('ModelUncertainty_RatFull')
% Exenatide_x = logspace(-2,3,100);
% 
% [pNames, CombinedParameters]   = IQMparameters(model);
% CombinedParameters(1:10)       = Pharmacokinetic_params(1:10);
% CombinedParameters             = CombinedParameters'.*ones(length(ModelUncertainty_Rat),length(CombinedParameters));
% CombinedParameters(:,13:62)    =  ModelUncertainty_Rat(:,1:50);
% 
%     Emax_matrix      = CombinedParameters(:,ismember(pNames,"ExenatideInsulinMax"));
%     Emin_matrix      = CombinedParameters(:,ismember(pNames,"ExenatideInsulinDecayMax"));
%     Emax50_matrix    = CombinedParameters(:,ismember(pNames,"ExenatideInsulin50"));
%     Emin50_matrix    = CombinedParameters(:,ismember(pNames,"ExenatideInsulinDecay50"));
%     Ehill_matrix     = CombinedParameters(:,ismember(pNames,"ExenatideInsulin_hill"));
%     a = ones(length(Emax_matrix),1);
%     
% for j = 1:length(Ehill_matrix)
%     Emax     = Emax_matrix(j);
%     Emin     = Emin_matrix(j);
%     Emax50   = Emax50_matrix(j);
%     Emin50   = Emin50_matrix(j);
%     Ehill    = Ehill_matrix(j);
%     if j == 1 
%         maxEffect  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
%         minEffect  = maxEffect;
%     end
%     NewEffect  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
%     if sum(NewEffect < 1) == 0
%                 if sum(NewEffect > maxEffect)>0  | sum(NewEffect < minEffect)>0
%             a(j) = 0;
%                 end
%         maxEffect = max(maxEffect,NewEffect);
%         minEffect  = min(minEffect,NewEffect);
%     end
% end
%     a(1) = 0;
%     Emax_matrix(a == 1)      = [];
%     Emin_matrix(a == 1)      = [];
%     Emax50_matrix(a == 1)    = [];
%     Emin50_matrix(a == 1)    = [];
%     Ehill_matrix(a == 1)     = [];
%     
%     ExenatideParamMatrix.Emax_matrix_Rat(1)   = CombinedParameters(1,ismember(pNames,"ExenatideInsulinMax"));
%     ExenatideParamMatrix.Emin_matrix_Rat(1)   = CombinedParameters(1,ismember(pNames,"ExenatideInsulinDecayMax"));
%     ExenatideParamMatrix.Emax50_matrix_Rat(1) = CombinedParameters(1,ismember(pNames,"ExenatideInsulin50"));
%     ExenatideParamMatrix.Emin50_matrix_Rat(1) = CombinedParameters(1,ismember(pNames,"ExenatideInsulinDecay50"));
%     ExenatideParamMatrix.Ehill_matrix_Rat(1)  = CombinedParameters(1,ismember(pNames,"ExenatideInsulin_hill"));
%     ExenatideParamMatrix.Emax_matrix_Rat(2:length(Emax_matrix)+1)   = Emax_matrix;
%     ExenatideParamMatrix.Emin_matrix_Rat(2:length(Emax_matrix)+1)   = Emin_matrix;
%     ExenatideParamMatrix.Emax50_matrix_Rat(2:length(Emax_matrix)+1) = Emax50_matrix;
%     ExenatideParamMatrix.Emin50_matrix_Rat(2:length(Emax_matrix)+1) = Emin50_matrix;
%     ExenatideParamMatrix.Ehill_matrix_Rat(2:length(Emax_matrix)+1)  = Ehill_matrix;
%     
% save(['ExenatideParamMatrix' datestr(now, 'yymmdd-HHMMSS')],'ExenatideParamMatrix');