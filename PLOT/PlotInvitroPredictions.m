[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param] = IQMparameters(model);
RecalcSimulations = 0;

load('ModelUncertainty_paramsFull')

[row column] = size(ModelUncertainty_params);
[PersonSpecificParameters] = AssignInitialUniqueParameters();
  
if RecalcSimulations == 1
        %% Recalculate all simulations
    % Sort parameter vectors to cost-value and calculate it

Calibration.Filets0 = 3;
Calibration.Fspheroids0 = 0.5;

for j = 1:row
    params_temp =    ModelUncertainty_params(j,1:column-1);
    cost =   Study2o9o10predictions_costfunction(Study2_data,Study9_data,Study10_data,log(params_temp),PersonSpecificParameters,modelName,sNames, pNames,Calibration,initialvalues);
    ModelUncertainty_params(j,column) = cost;
end
[row column] = size(ModelUncertainty_params);
ModelUncertainty_params = sortrows(ModelUncertainty_params,column);

% Simulate
[PersonSpecificParameters] = AssignInitialUniqueParameters();
for j = 1:row
    params_temp =    ModelUncertainty_params(j,1:column-1);
    
[PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,AmountParameterOpti,params_temp);

        [simStudy2calibrated_LCHG,simStudy2calibrated_HCHG]  = SimulateStudy2(model,Study2_data   ,InSphero_params,PersonSpecificParametersInSphero,Calibration,initialvalues,sNames,pNames);
        UncertaintyStudy2_calibrated  
        
        [simStudy9_control, simStudy9_0p1, simStudy9_10,simStudy10_GSIS] = SimulateStudy9o10(model,Study9_data,Study10_data,EndoC_params,PersonSpecificParametersEndoC,initialvalues,sNames,pNames,1);
        UncertaintyStudy9o10
end
else
 load('WorkspacePlotInVitropredictions')      
end

%% Disp agreement to data

disp(' ')
if ModelUncertainty_params(1,column) < chi2inv(0.95,63)
    disp('----- Best prediction of human cell data is below statistical threshold -----')
end
fprintf('Best prediction of human cell data: %.2f, Statistical Limit: %.2f (dgf = %i)', ModelUncertainty_params(1,column), chi2inv(0.95,63), 63)
disp(' ')

%% Fig. 5B i-ii

% % legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'ytick',0:10:40,'xtick',0:2:6,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% plot(simStudy9_control.time/24 -1, BestInsulin_Study9_control/1000 ,'Color', color_green   ,'LineWidth',4)
% plot(simStudy9_0p1.time    /24 -1, BestInsulin_Study9_0p1/1000     ,'Color', color_yellow   ,'LineWidth',4)
% plot(simStudy9_10.time     /24 -1, BestInsulin_Study9_10/1000      ,'Color', color_red   ,'LineWidth',4)
% legend('Vehicle','Exenatide 0.1 nM','Exenatide 10 nM','Location','North','FontSize',18,'Location','North','FontSize',20,'NumColumns',3)
% ylim([0 45])
% xlim([0 6])
% hold off
% grid on

figure('units','normalized','outerposition',[0 0 1 1])

% Study9 chip
subplot(2,2,1)
hold on
set(gca,'ytick',0:15:50,'xtick',0:1:7,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title({'Media insulin prediction'});
plot(simStudy9_control.time/24 -100, BestInsulin_Study9_control/1000 ,'Color', color_green   ,'LineWidth',4)
plot(simStudy9_0p1.time    /24 -100, BestInsulin_Study9_0p1/1000     ,'Color', color_yellow   ,'LineWidth',4)
plot(simStudy9_10.time     /24 -100, BestInsulin_Study9_10/1000      ,'Color', color_red   ,'LineWidth',4)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxInsulin_Study9_control,minInsulin_Study9_control,simStudy9_control.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minInsulin_Study9_0p1,maxInsulin_Study9_0p1,simStudy9_control.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minInsulin_Study9_10,maxInsulin_Study9_10,simStudy9_control.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy9_control.time/24, BestInsulin_Study9_control/1000 ,'Color', color_green   ,'LineWidth',2)
plot(simStudy9_0p1.time    /24, BestInsulin_Study9_0p1/1000     ,'Color', color_yellow   ,'LineWidth',2)
plot(simStudy9_10.time     /24, BestInsulin_Study9_10/1000      ,'Color', color_red   ,'LineWidth',2)
errorbar(Study9_data.GTTtime(1:12)/24,Study9_data.Insulin0(1:12)  ,Study9_data.Insulin0SEM(1:12)  ,'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study9_data.GTTtime(1:12)/24,Study9_data.Insulin0p1(1:12),Study9_data.Insulin0p1SEM(1:12),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study9_data.GTTtime(1:12)/24,Study9_data.Insulin10(1:12) ,Study9_data.Insulin10SEM(1:12) ,'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
ylabel({'Insulin '; '(nM)'},'FontSmoothing','on');
xlabel('Time (days)');
line([-0.05 0.05]+4, [0 0],'Color','k','LineWidth',8);
legend('Vehicle','Exenatide 0.1 nM','Exenatide 10 nM','Location','North','FontSize',20,'Location','North','NumColumns',3)
ylim([0 50])
xlim([1 7])
hold off
grid on

% Study9 chip
subplot(2,2,2)
hold on
set(gca,'ytick',[0.1,10,1000,100000],'xtick',0:1:7,'FontSize', 20,'FontSmoothing','on','fontname','Arial','YScale','log')
title({'Intracellular insulin prediction'});
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxINInsulin_Study9_control,minINInsulin_Study9_control,simStudy9_control.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_green,'FaceAlpha',0.3,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxINInsulin_Study9_0p1,minINInsulin_Study9_0p1,simStudy9_control.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_yellow,'FaceAlpha',0.3,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxINInsulin_Study9_10,minINInsulin_Study9_10,simStudy9_control.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_red,'FaceAlpha',0.3,'EdgeAlpha',0.1);
plot(simStudy9_control.time/24, BesINtInsulin_Study9_control/1000 ,'Color', color_green     ,'LineWidth',2)
plot(simStudy9_0p1.time    /24, BestINInsulin_Study9_0p1/1000      ,'Color', color_yellow   ,'LineWidth',2)
plot(simStudy9_10.time     /24, BestINInsulin_Study9_10/1000      ,'Color', color_red   ,'LineWidth',2)
ylabel({'Intracellular insulin'; '(nM)'},'FontSmoothing','on');
xlabel('Time (days)');line([-0.05 0.05]+0, [0 0],'Color','k','LineWidth',8);
line([-0.05 0.05]+4, [0.1 0.1],'Color','k','LineWidth',8);
ylim([0.1 400000])
xlim([1 7])
hold off
grid on

%% Fig. 5B iii
figure('units','normalized','outerposition',[0 0 1 1])

% Static cell assay 1: 0 mM glucose
subplot(3,3,1)
hold on
set(gca,'ytick',0:0.5:1.5,'xtick',0:10:45,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title({'Cell assay prediction 1'});
fill([simStudy10_GSIS.simULTd0_G0.time, fliplr(simStudy10_GSIS.simULTd0_G0.time)]*60,[maxInsulin_Study10_G0', fliplr(minInsulin_Study10_G0')]/1000, color_gray,'FaceAlpha',0.3,'EdgeAlpha',0.2);
errorbar(40, Study10_data.DGRInsulinMean(1)/1000, Study10_data.DGRInsulinSE(1)/1000,'LineStyle', 'n','Color', color_black, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
plot(simStudy10_GSIS.simULTd0_G0.time*60    , BestInsulin_Study10_G0/1000,'Color', color_black   ,'LineWidth',2)
ylabel({'Insulin '; '(nM)'},'FontSmoothing','on');
xlabel({'Time (min)'});
line([0 1], [0 0],'Color',color_black,'LineWidth',6);
ylim([0,1.8])
xlim([0,42])
hold off
grid on

% Static cell assay 2: 5.5 mM glucose & 1 nM exenatide
subplot(3,3,2)
hold on
set(gca,'ytick',0:0.5:1.5,'xtick',0:10:45,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title({'Cell assay prediction 2'});
fill([simStudy10_GSIS.simULTd0_G0.time, fliplr(simStudy10_GSIS.simULTd0_G0.time)]*60,[maxInsulin_Study10_G5p5E1', fliplr(minInsulin_Study10_G5p5E1')]/1000, color_gray,'FaceAlpha',0.3,'EdgeAlpha',0.2);
errorbar(40, Study10_data.DGRInsulinMean(2)/1000, Study10_data.DGRInsulinSE(2)/1000,'LineStyle', 'n','Color', color_black, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
plot(simStudy10_GSIS.simULTd0_G0.time*60    , BestInsulin_Study10_G5p5E1/1000,'Color', color_black   ,'LineWidth',2)
ylabel({'Insulin '; '(nM)'},'FontSmoothing','on');
xlabel({'Time (min)'});
line([0 1], [0 0],'Color',color_black,'LineWidth',6);
ylim([0,1.8])
xlim([0,42])
hold off
grid on

% Static cell assay 2: 20 mM glucose & 1 nM exenatide
subplot(3,3,3)
hold on
set(gca,'ytick',0:0.5:1.5,'xtick',0:10:45,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title({'Cell assay prediction 3'});
fill([simStudy10_GSIS.simULTd0_G0.time, fliplr(simStudy10_GSIS.simULTd0_G0.time)]*60,[maxInsulin_Study10_G20E1', fliplr(minInsulin_Study10_G20E1')]/1000, color_gray,'FaceAlpha',0.3,'EdgeAlpha',0.2);
errorbar(40, Study10_data.DGRInsulinMean(3)/1000, Study10_data.DGRInsulinSE(3)/1000,'LineStyle', 'n','Color', color_black, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
plot(simStudy10_GSIS.simULTd0_G0.time*60    , BestInsulin_Study10_G20E1/1000,'Color', color_black   ,'LineWidth',2)
ylabel({'Insulin '; '(nM)'},'FontSmoothing','on');
xlabel({'Time (min)'});
line([0 1], [0 0],'Color',color_black,'LineWidth',6);
ylim([0,1.8])
xlim([0,42])
hold off
grid on

%% Fig. 5C

% % legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'ytick',0:4:12,'xtick',[0,2,4,6,8,10,12,14],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% ylabel('Glucose (mM)')
% xlabel('Time (days)');
% errorbar(Study2_data.time(4:6)/24,Study2_data.GlucoseHCHG(4:6),Study2_data.GlucoseHCHGstdev(4:6),'CapSize',CapSize,'Color', color_black,'LineStyle', 'n', 'Marker',marker11, 'MarkerSize',0.1,'LineWidth',LineWidthValue);
% errorbar(Study2_data.time(4:6)/24,Study2_data.GlucoseLCHG(4:6),Study2_data.GlucoseLCHGstdev(4:6),'CapSize',CapSize,'Color', color_black,'LineStyle', 'n', 'Marker',marker  , 'MarkerSize',MarkerSize  ,'LineWidth',LineWidthValue);
% plot(simStudy2calibrated_LCHG.time/24,BestStudy2calibrated_Glucose_HCHG,'Color', color_green,'LineWidth',4)
% plot(simStudy2calibrated_LCHG.time/24,BestStudy2calibrated_Glucose_LCHG,'Color', color_red,'LineWidth',4)
% legend('Calibration data','Validation data','FCS & LC','FCS & HC','Orientation','horizontal')
% hold off

figure('units','normalized','outerposition',[0 0 1 1])
% Calibrated Glucose
subplot(2,3,1)
hold on
set(gca,'ytick',0:2:12,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Glucose'; '(mM)'})
xlabel('Time (days)');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy2calibrated_Glucose_HCHG(241:end)',minStudy2calibrated_Glucose_HCHG(241:end)',simStudy2calibrated_LCHG.time(241:end));
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.3,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy2calibrated_Glucose_LCHG(241:end)',minStudy2calibrated_Glucose_LCHG(241:end)',simStudy2calibrated_LCHG.time(241:end));
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.3,'EdgeAlpha',0.1);
plot(simStudy2calibrated_LCHG.time(241:end)/24,BestStudy2calibrated_Glucose_HCHG(241:end),'Color', color_red,'LineWidth',2)
plot(simStudy2calibrated_LCHG.time(241:end)/24,BestStudy2calibrated_Glucose_LCHG(241:end),'Color', color_green,'LineWidth',2)

errorbar(Study2_data.time(1:6)/24,Study2_data.GlucoseHCHG(1:6),Study2_data.GlucoseHCHGstdev(1:6),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study2_data.time(4:6)/24,Study2_data.GlucoseLCHG(4:6),Study2_data.GlucoseLCHGstdev(4:6),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study2_data.time(1:3)/24,Study2_data.GlucoseLCHG(1:3),Study2_data.GlucoseLCHGstdev(1:3),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker11, 'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue);

line([-0.075 0.075]+3, [4 4],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [4 4],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [4 4],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [4 4],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [4 4],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [4 4],'Color','k','LineWidth',8);
ylim([4 13])
xlim([1 15])
hold off
grid on

% Calibrated Insulin
subplot(2,3,2)
hold on
set(gca,'ytick',0:25:100,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Insulin'; '(nM)'})
xlabel('Time (days)');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy2calibrated_Insulin_HCHG(241:end)',minStudy2calibrated_Insulin_HCHG(241:end)',simStudy2calibrated_LCHG.time(241:end));
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_red,'FaceAlpha',0.3,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy2calibrated_Insulin_LCHG(241:end)',minStudy2calibrated_Insulin_LCHG(241:end)',simStudy2calibrated_LCHG.time(241:end));
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_green,'FaceAlpha',0.3,'EdgeAlpha',0.1);
plot(simStudy2calibrated_LCHG.time(241:end)/24,BestStudy2calibrated_Insulin_HCHG(241:end)/1000,'Color', color_red,'LineWidth',2)
plot(simStudy2calibrated_LCHG.time(241:end)/24,BestStudy2calibrated_Insulin_LCHG(241:end)/1000,'Color', color_green,'LineWidth',2)

errorbar(Study2_data.time(1:6)/24   ,Study2_data.InsulinHCHG(1:6),Study2_data.InsulinHCHGstdev(1:6),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study2_data.time(4:6)/24   ,Study2_data.InsulinLCHG(4:6),Study2_data.InsulinLCHGstdev(4:6),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);

errorbar(Study2_data.time(1:3)/24   ,Study2_data.InsulinLCHG(1:3),Study2_data.InsulinLCHGstdev(1:3),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker11, 'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue);

line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0 0],'Color','k','LineWidth',8);
ylim([0 110])
xlim([1 15])
hold off
grid on

%% 3D plots
load('ModelUncertainty_paramsFull')
[row column] = size(ModelUncertainty_params);

for j = 1:1
    params_temp =    ModelUncertainty_params(j,1:column-1);
    [PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,AmountParameterOpti,params_temp);
 
    % Simulate
    if j== 1
        WashingUncertainty = PersonSpecificParametersEndoC.EndoCWashing_Uncertainty;
        
[params_temp] = MediaConditionScaling(EndoC_params,pNames,PersonSpecificParametersEndoC,7); % ULT-media

initialvalues(ismember(sNames,"PancreticCells"))     = 2000;     % 1 pancretic spheroid x 2000 per islet
initialvalues(ismember(sNames,"Insulin_islets"))     = PersonSpecificParametersEndoC.EndoCStoredInsulin;

params_temp(ismember(pNames,"ExenatideInsulinMax"))                = params_temp(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParametersEndoC.ExenatideResponse(16);
params_temp(ismember(pNames,"ExenatideInsulinDecayMax"))           = params_temp(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParametersEndoC.ExenatideResponse(16);
params_temp(ismember(pNames,"ExenatideInsulin50"))                 = params_temp(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParametersEndoC.ExenatideResponse50(16);
params_temp(ismember(pNames,"ExenatideInsulinDecay50"))            = params_temp(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParametersEndoC.ExenatideResponse50(16);
params_temp(ismember(pNames,"Filets0"))                            = params_temp(ismember(pNames,"Filets0"))                        * PersonSpecificParametersEndoC.Filets0(19);
params_temp(ismember(pNames,"EdU_boolean"))                        = 0;
params_temp(ismember(pNames,"CountLiver"))                 = 1e-5;        % no liver
params_temp(ismember(pNames,"V_m_medium"))                 = 0.00005;  % media volume (L)

surfGlucose   = 0:0.5:20;

% Exenatide and glucose
surfExenatide = logspace(-2,4,41);
for k = 1:length(surfExenatide)
 for i =1:length(surfGlucose)
    [initialvalues] = SetInitialValues(surfGlucose(i), 0, surfExenatide(k),0,params_temp,pNames,sNames,initialvalues);
    initialvalues(ismember(sNames,"Glucose_islets")) = surfGlucose(i)*WashingUncertainty;
    simGER = model(0:2/3:2/3,initialvalues,params_temp);
    SaveInsulinSecretionGE(k,i) = simGER.variablevalues(end,ismember(simGER.variables,'IP'));
 end
end

% Time and glucose
surfTime      = 0:1/12:2;
 for i =1:length(surfGlucose)
    [initialvalues] = SetInitialValues(surfGlucose(i), 0, 0,0,params_temp,pNames,sNames,initialvalues);
    initialvalues(ismember(sNames,"Glucose_islets")) = surfGlucose(i)*WashingUncertainty;
    simGER = model(surfTime,initialvalues,params_temp);
    SaveInsulinSecretionGT(i,:) = simGER.statevalues(:,ismember(simGER.states,'Insulin_Medium'));
 end

    end
 
end
%

% Plot GER (Glucose & Exenatide response)
figure('units','normalized','outerposition',[0 0 1 1])
% colors and grid
[X,Y]               = meshgrid(surfGlucose,surfExenatide);
CO(1:length(surfExenatide),1:length(surfGlucose),1) = 0.4; % untrained
CO(1:length(surfExenatide),1:length(surfGlucose),2) = 0.66; % untrained
CO(1:length(surfExenatide),1:length(surfGlucose),3) = 0.81; % untrained
CO(1,1,1:3) = color_red;  % G0mM
CO(1,5,1:3) = color_red;  % G2.8mM
CO(1,11,1:3) = color_red; % G5.5mM
CO(1,16,1:3) = color_red; % G8mM
CO(1,22,1:3) = color_red; % G11mM
CO(1,33,1:3) = color_red; % G16.8mM
CO(1,40,1:3) = color_red; % G20mM
CO(1,22,1:3) = color_red;   % G11mM 0 - 0.01
CO(8,22,1:3) = color_red;   % G11mM E0.1
CO(14,22,1:3) = color_red;  % G11mM E1
CO(21,22,1:3) = color_red;   % G11mM E10
CO(28,22,1:3) = color_red; % G11mM E100
CO(1,22,1:3) = color_red;   % G11mM 0 - 0.01
CO(11,22,1:3) = color_red;  % G11mM E0.33
CO(18,22,1:3) = color_red; % G11mM E3.3
CO(21,22,1:3) = color_red; % G11mM E10
CO(24,22,1:3) = color_red; % G11mM E33
CO(31,22,1:3) = color_red; % G11mM E330
CO(34,22,1:3) = color_red; % G11mM E1000
CO(40,22,1:3) = color_red; % G11mM E10000
CO(14,1,1:3) = color_red;    % G0mM    E1
CO(14,5,1:3) = color_red;    % G2.8mM  E1
CO(14,22,1:3) = color_red;   % G11mM   E1
CO(14,33,1:3) = color_red;   % G16.8mM E1
CO(14,40,1:3) = color_red;   % G20mM   E1
CO(8,5,1:3) = color_red;     % G2.8mM E0.1
CO(21,5,1:3) = color_red;    % G2.8mM E10
CO(34,5,1:3) = color_red;    % G2.8mM E1000
CO(28,5,1:3) = color_red;    % G2.8mM E100
CO(28,11,1:3) = color_red; % G5.5mM E100
CO(28,16,1:3) = color_red; % G8mM E100
CO(28,22,1:3) = color_red;   % G11mM  E100
CO(28,33,1:3) = color_red;   % G16.8mME100

CO(1,1,1:3)   = color_white; % G0mM    E0
CO(14,11,1:3) = color_white; % G5.5mM  E1
CO(14,40,1:3) = color_white; % G20mM   E1

CO(1,11,1:3) = color_white; % G5.5 mMmM  E0

CO(8,11,1:3) = color_white; % G5.5 mMmM  E0.1
CO(8,22,1:3) = color_white; % G11 mMmM   E0.1

CO(21,11,1:3) = color_white; % G5.5 mMmM  E10
CO(21,22,1:3) = color_white; % G11 mMmM   E10

CO(1,23,1:3) = color_white; % G11 mMmM  E0
CO(1,19,1:3) = color_white; % G9 mMmM   E0
CO(1,17,1:3) = color_white; % G8 mMmM   E0

% GER plot
subplot(1,2,1)
surf(X,Y,SaveInsulinSecretionGE*1000,CO)
hold on
set(gca,'ytick',[0.01,1,100,10000],'xtick',0:5:20,'ztick',0:20:100,'FontSize', 20,'FontSmoothing','on','fontname','Arial','YScale','log')
set(get(gca,'xlabel'),'rotation',12)
set(get(gca,'ylabel'),'rotation',-25)
xlabel({'Pancretic glucose'; '(mM)'},'FontSmoothing','on');
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on');
zlabel({'Insulin secretion'; '(fmol/h)'},'FontSmoothing','on');
ylim([0.01,10000])
grid on
hold off


% GTR (glucose & time response) 
subplot(1,2,2)
% colors and grid
clear CO
surfTime      = (0:1/12:2)*60;
[X,Y]         = meshgrid(surfTime,surfGlucose);
CO(1:length(surfGlucose),1:length(surfTime),1) = 0.4; % untrained
CO(1:length(surfGlucose),1:length(surfTime),2) = 0.66; % untrained
CO(1:length(surfGlucose),1:length(surfTime),3) = 0.81; % untrained
 CO(5,24,1:3)   = color_red;               % G2.8mM 120min 
 CO(12,24,1:3)   = color_red;               % G5.5mM 120min 
 CO(17,24,1:3)   = color_red;               % G8mM 120min 
 CO(23,24,1:3)   = color_red;               % G11mM 120min 
 CO(34,24,1:3)   = color_red;               % G16.7mM 120min 
 CO(34,1:12,1:3) = ones(12,1).*color_red;   % G16.8mM 60min
 CO(5,1:6,1:3)   = ones(6,1).*color_red;    % G2.8mM 30min
 CO(1,10,1:3) = color_red;   % G0mM 40min
 CO(5,10,1:3) = color_red;   % G2.8mM 40min
 CO(17,10,1:3) = color_red;  % G8mM 40min
 CO(23,10,1:3) = color_red;  % G11mM 40min
 CO(34,10,1:3) = color_red;  % G16.8mM 40min
 CO(40,10,1:3) = color_red;  % G20mM 40min
 
 
CO(1,10,1:3) = color_white;   % G0mM 40min 
CO(12,10,1:3) = color_white;   % G5.5mM 40min 
CO(40,10,1:3) = color_white;   % G20mM 40min 

CO(12,1,1:3)  = color_white;   % G5.5 mMmM  0 min
CO(23,1,1:3)  = color_white;   % G11 mMmM   0 min
CO(12,12,1:3) = color_white;   % G5.5 mMmM  60 min
CO(23,12,1:3) = color_white;   % G11 mMmM   60 min

% glucose and time - plot
surf(X,Y,SaveInsulinSecretionGT/1000,CO)
hold on
set(gca,'ytick',0:5:20,'xtick',0:30:120,'ztick',0:0.5:4,'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
set(get(gca,'xlabel'),'rotation',12)
set(get(gca,'ylabel'),'rotation',-25)
xlabel({'Time'; '(min)'},'FontSmoothing','on');
ylabel({'Pancretic glucose'; '(mM)'},'FontSmoothing','on');
zlabel({'Insulin'; '(nM)'},'FontSmoothing','on');
xlim([0,120])
%zlim([0,1000])
hold off

% legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% fill(1,1,1,'FaceColor', color_blueBlindFriendly,'LineWidth',LineWidthValue)
% fill(1,1,1,'FaceColor', color_red,'LineWidth',LineWidthValue)
% fill(1,1,1,'FaceColor', color_white,'LineWidth',LineWidthValue)
% legend('Model predictions','Experimental data','Validation tests (Figs. 5B-C)','Location','North','FontSize',LegendSize,'FontSize',20,'Orientation','horizontal')
% hold off