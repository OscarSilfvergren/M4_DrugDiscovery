[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param] = IQMparameters(model);

for i=1:2
    
    load('ModelUncertainty_Rat2')
    conditon = 'Without minimalistic change: Trained to both insulin and glucose';

    if i == 1
    load('ModelUncertainty_Rat')
    conditon = 'Without minimalistic change: Trained to insulin';
    end

load('Pharmacokinetic_params')
RandomEffects.f  = [Pharmacokinetic_params(11), Pharmacokinetic_params(12)]; % Ape, Rat
RandomEffects.Ka = [Pharmacokinetic_params(13) Pharmacokinetic_params(14)];                    % Rat, monkey
RandomEffects.CL = [Pharmacokinetic_params(15),Pharmacokinetic_params(16),Pharmacokinetic_params(17)]; % Rat, monkey, dog
RandomEffects.vd = [Pharmacokinetic_params(18),Pharmacokinetic_params(19),Pharmacokinetic_params(20)]; % Rat, monkey, dog
RandomEffects.vd2 = [Pharmacokinetic_params(21),Pharmacokinetic_params(22),Pharmacokinetic_params(23)];% Rat, monkey, dog

%% Cost
 [row column] = size(ModelUncertainty_Rat);
 
for j = 1:row
    params_temp = ModelUncertainty_Rat(j,1:column-1);
    cost        = Gao2011_costfunction(Gao2011Rat_data,GaoExenatideConcentrations_data,log(params_temp),Pharmacokinetic_params,modelName,sNames, pNames,initialvalues,1,1);
   ModelUncertainty_Rat(j,column) = cost;

end
[row column] = size(ModelUncertainty_Rat);

if i == 1
disp(' ')
if ModelUncertainty_Rat(1,column) < chi2inv(0.95,60)
    disp('----- Fit only to insulin: Best description of exenatide effect on insulin secretion is below threshold -----')
end
fprintf('Trained on only insulin: %.2f, Statistical Limit: %.2f (dgf = %i)', ModelUncertainty_Rat(1,column), chi2inv(0.95,60), 60)
disp(' ')

else
    
   disp(' ')
if ModelUncertainty_Rat(1,column) < chi2inv(0.95,120)
    disp('----- Fit to glucose and insulin: Best description of exenatide effect on insulin secretion is below threshold -----')
end
fprintf('Trained on insulin and glucose: %.2f, Statistical Limit: %.2f (dgf = %i)', ModelUncertainty_Rat(1,column), chi2inv(0.95,120), 120)
disp(' ') 
end

%% Collect uncertainty

 [row column] = size(ModelUncertainty_Rat);
 
[pNames, CombinedParameters] = IQMparameters(model);
CombinedParameters(1:10)      = Pharmacokinetic_params(1:10);

for j = 1:row
    params_temp =    ModelUncertainty_Rat(j,1:column-1);

CombinedParameters(16:70)    = params_temp(1:55);
    
    [simRatpd_vehicle,simRatpd_3,simRatpd_30,simRatpd_300,simRatpd_3000,simIV_50, simIV_5, simIV_0p5, simIVtransfusion_50, simIVtransfusion_5, simIVtransfusion_0p5, simSC_50, simSC_5, simSC_0p5] = SimulateGaoRat(model,[40],GaoExenatideConcentrations_data,CombinedParameters,RandomEffects,initialvalues,sNames,pNames,1);
    
    SimulatePD = 1;
    UncertaintyGaoRat
end

%% Rat PD
figure()

% Legend
hold on
set(gca,'xtick',[-30,0,30,60,90],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_blue,'LineWidth',3)
plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_green,'LineWidth',3)
plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_yellow,'LineWidth',3)
plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_orange,'LineWidth',3)
plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_red,'LineWidth',3)
ylabel({'Glucose (mM)'},'FontSmoothing','on','FontSize', TextSize-3);
legend('0 (pmol/kg/min)','3 (pmol/kg/min)','30 (pmol/kg/min)','300 (pmol/kg/min)','30000 (pmol/kg/min)','Location','Best','Orientation','horizontal')

xlim( [-40, 90])
grid on
hold off


% figure()

subplot(2,5,1)
hold on
set(gca,'xtick',[-30,0,30,60,90],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minGaoG_Vehicle',maxGaoG_Vehicle',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_blue,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoG_Vehicle/18,'Color', color_blue,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_0,Gao2011Rat_data.glucoseSEM_0,'LineStyle', 'n', 'Marker',marker0,'color',color_blue,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Glucose (mM)'},'FontSmoothing','on','FontSize', TextSize-3);

xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,6)
hold on
set(gca,'xtick',[-30,0,30,60,90],'ytick',[0,1000,2000,3000],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_Vehicle',minGaoI_Vehicle',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoI_Vehicle,'Color', color_blue,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_0,Gao2011Rat_data.insulinSEM_0,'LineStyle', 'n', 'Marker',marker0,'color',color_blue,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Insulin (pM)'},'FontSmoothing','on','FontSize', TextSize-3);
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,2)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_3',minGaoG_3',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoG_3/18,'Color', color_green,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_3,Gao2011Rat_data.glucoseSEM_3,'LineStyle', 'n', 'Marker',marker0,'color',color_green,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)

xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,7)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_3',minGaoI_3',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoI_3,'Color', color_green,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_3,Gao2011Rat_data.insulinSEM_3,'LineStyle', 'n', 'Marker',marker0,'color',color_green,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,3)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
title(conditon)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_30',minGaoG_30',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoG_30/18,'Color', color_yellow,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_30,Gao2011Rat_data.glucoseSEM_30,'LineStyle', 'n', 'Marker',marker0,'color',color_yellow,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)

xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,8)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_30',minGaoI_30',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoI_30,'Color', color_yellow,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_30,Gao2011Rat_data.insulinSEM_30,'LineStyle', 'n', 'Marker',marker0,'color',color_yellow,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
xlabel({'Time (min)'},'FontSmoothing','on','FontSize', TextSize-3);
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,4)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_300',minGaoG_300',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_orange,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoG_300/18,'Color', color_orange,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_300,Gao2011Rat_data.glucoseSEM_300,'LineStyle', 'n', 'Marker',marker0,'color',color_orange,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)

xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,9)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_300',minGaoI_300',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_orange,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoI_300,'Color', color_orange,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_300,Gao2011Rat_data.insulinSEM_300,'LineStyle', 'n', 'Marker',marker0,'color',color_orange,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,5)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoG_3000',minGaoG_3000',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)]/18, color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoG_3000/18,'Color', color_red,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.glucoseMean_3000,Gao2011Rat_data.glucoseSEM_3000,'LineStyle', 'n', 'Marker',marker0,'color',color_red,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)

xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

subplot(2,5,10)
hold on
set(gca,'xtick',[-30,0,30,60,90],'Yticklabel',[],'ytick',[0,1000,2000,3000],'FontSize', TextSize-10,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGaoI_3000',minGaoI_3000',simRatpd_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]-30,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha',0.25);
plot(simRatpd_vehicle.time-30,BestGaoI_3000,'Color', color_red,'LineWidth',3)
errorbar(Gao2011Rat_data.Time,Gao2011Rat_data.insulinMean_3000,Gao2011Rat_data.insulinSEM_3000,'LineStyle', 'n', 'Marker',marker0,'color',color_red,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylim( [0, 3200])
xlim( [-40, 90])
line([0 3], [0 0],'Color','k','LineWidth',8);
grid on
hold off

end