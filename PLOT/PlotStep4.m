[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param]               = IQMparameters(model);
RecalcSimulations             = 0;

%% Use params and uncertainty from step 2

load('Pharmacokinetic_params')
ConditionAlterations.f   = [Pharmacokinetic_params(11), Pharmacokinetic_params(12)];                           % Ape, Rat
ConditionAlterations.Ka  = [Pharmacokinetic_params(13), Pharmacokinetic_params(14)];                           % Rat, monkey
ConditionAlterations.CL  = [Pharmacokinetic_params(15),Pharmacokinetic_params(16),Pharmacokinetic_params(17)]; % Rat, monkey, dog
ConditionAlterations.vd  = [Pharmacokinetic_params(18),Pharmacokinetic_params(19),Pharmacokinetic_params(20)]; % Rat, monkey, dog
ConditionAlterations.vd2 = [Pharmacokinetic_params(21),Pharmacokinetic_params(22),Pharmacokinetic_params(23)]; % Rat, monkey, dog

%% Simulate
load('ExenatideParamMatrix_population')
load('ModelUncertainty_HumanPK')
load('ModelUncertainty_Human')
[row column] = size(ModelUncertainty_Human);

if RecalcSimulations == 1
    for j = 1:row
        param_HumanCalibration =    ModelUncertainty_Human(j,1:column);
        param(13:14)           = param_HumanCalibration(1:2);
        
        % Build dose-response vectors
        [paramInVitroHuman,paramRat]       = InsertExenatidePD(param',ExenatideParamMatrix,pNames);
        [row1 column1]  = size(paramInVitroHuman);
        [row2 column2]  = size(paramRat);
        
        for k = 1:max([row1 row2])
            try
                param_tempInVitroHuman =    paramInVitroHuman(k,:);
            catch error
                param_tempInVitroHuman =    [];
            end
            param_tempRat =    paramRat(k,:);
            
            % Simulate all vectors above with the PK vectors
            for i = 1:3
                param_tempInVitroHuman(ismember(pNames,"KaSlow"))     = ModelUncertainty_HumanPK(i,1);
                param_tempInVitroHuman(ismember(pNames,"KaSlow50"))   = ModelUncertainty_HumanPK(i,2);
                param_tempRat(ismember(pNames,"KaSlow"))              = ModelUncertainty_HumanPK(i,1);
                param_tempRat(ismember(pNames,"KaSlow50"))            = ModelUncertainty_HumanPK(i,2);
                
                [SimDruckerInVitroHuman,SimDruckerRat] = SimulateDrucker2008(param_tempInVitroHuman,param_tempRat,[param_HumanCalibration(3),param_HumanCalibration(4),mean(ConditionAlterations.f)],Ducker2008_data,pNames,sNames,initialvalues,model,1);
                UncertaintyDruckerHuman
            end
        end
    end
    
else
    load('WorkspacePlotDrucker2008')
end
%% Disp agreement to data

disp(' ')
if Cost_HumanLow < chi2inv(0.95,31)
    disp('----- Best prediction of exenatide treatment is below statistical threshold -----')
end
fprintf('Best fit to human study: %.2f, Statistical Limit: %.2f (dgf = %i)', Cost_HumanLow, chi2inv(0.95,31), 31)
disp(' ')

%% Legend

% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'ytick',0:5:15,'xtick',[0,60,120,180,240,300],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% [maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog([1,5],[1,5],[1,5]);
% fill([timeTemp, fliplr(timeTemp)]-(420+0*1440*7),[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.5,'EdgeAlpha',0.2);
% fill([timeTemp, fliplr(timeTemp)]-(420+14*1440*7),[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',0.5,'EdgeAlpha',0.2);
% fill([timeTemp, fliplr(timeTemp)]-(420+29*1440*7),[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.5,'EdgeAlpha',0.2);
% errorbar(Ducker2008_data.GlucoseOGTTWeekly_time(1:8),Ducker2008_data.GlucoseWeeklyOGTT1(1:8),Ducker2008_data.GlucoseWeeklyOGTT1SEM(1:8),'Color', color_black,'LineStyle', 'n', 'Marker','.','MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
% errorbar(Ducker2008_data.GlucoseOGTTWeekly_time(1),Ducker2008_data.GlucoseWeeklyOGTT2(1),Ducker2008_data.GlucoseWeeklyOGTT2SEM(1),'Color', color_black,'LineStyle', 'n', 'Marker','x','MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
% plot(Ducker2008_data.BasalGlucose_time(1:9),Ducker2008_data.BasalGlucoseWeekly(1:9),'Color', color_black,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
% legend('Pre-treatment','Week 14','Week 30','Predicted datapoint','Calibrated datapoint','Mean population','FontSize',LegendSize,'NumColumns',6)
% hold off
%% Fig. 8B

load('ExenatideParamMatrix_population')
Exenatide_x = 0.001:0.001:0.3;
[row column] = size(ExenatideParamMatrix.InVitroPD);

% Average in vitro human cell
Emax     = ExenatideParamMatrix.InVitroPDbest(1);
Emin     = ExenatideParamMatrix.InVitroPDbest(2);
Emax50   = ExenatideParamMatrix.InVitroPDbest(3);
Emin50   = ExenatideParamMatrix.InVitroPDbest(4);
Ehill    = ExenatideParamMatrix.InVitroPDbest(5);
BestEffectInVitro  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
for j = 1:row
    
    Emax     = ExenatideParamMatrix.InVitroPD(j,1);
    Emin     = ExenatideParamMatrix.InVitroPD(j,2);
    Emax50   = ExenatideParamMatrix.InVitroPD(j,3);
    Emin50   = ExenatideParamMatrix.InVitroPD(j,4);
    Ehill    = ExenatideParamMatrix.InVitroPD(j,5);
    
    if j == 1
        maxEffectInVitro  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
        minEffectInVitro  = maxEffectInVitro;
    end
    
    NewEffectInVitro  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
    maxEffectInVitro = max(maxEffectInVitro,NewEffectInVitro);
    minEffectInVitro  = min(minEffectInVitro,NewEffectInVitro);
    
end

% Rat population
a = ones(length(ExenatideParamMatrix.Emax_matrix_Rat),1);
for j = 1:length(ExenatideParamMatrix.Emax_matrix_Rat)
    
    % Rat
    Emax     = ExenatideParamMatrix.Emax_matrix_Rat(j);
    Emin     = ExenatideParamMatrix.Emin_matrix_Rat(j);
    Emax50   = ExenatideParamMatrix.Emax50_matrix_Rat(j);
    Emin50   = ExenatideParamMatrix.Emin50_matrix_Rat(j);
    Ehill    = ExenatideParamMatrix.Ehill_matrix_Rat(j);
    
    if j == 1
        maxEffectRat  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
        minEffectRat  = maxEffectRat;
        BestEffectRat = maxEffectRat;
    end
    
    NewEffectRat  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
    maxEffectRat = max(maxEffectRat,NewEffectRat);
    minEffectRat  = min(minEffectRat,NewEffectRat);
    
end

figure('units','normalized','outerposition',[0 0 1 1])

% Exenatide
subplot(3,3,1)
hold on
set(gca,'ytick',[0.001,0.01,0.1,1],'xtick',0:10:30,'FontSize', 20,'FontSmoothing','on','fontname','Arial','YScale','log')
ylabel({'Exenatide' ; '(nM)'},'FontSmoothing','on');
xlabel({'Time (weeks)'},'FontSmoothing','on');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_C1',minDrucker2008_C1',SimDruckerRat.time);
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)]/10080,[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.4,'EdgeAlpha',0);
colormap(map)
plot(SimDruckerRat.time/10080,BestDrucker2008_C1,'Color', color_black,'LineWidth',1)
errorbar(Ducker2008_data.Exenatide_time(1:13),Ducker2008_data.ExenatideWeekly(1:13)/1000,(Ducker2008_data.ExenatideWeekly(1:13)-Ducker2008_data.ExenatideWeeklyRange_min(1:13))/1000,(Ducker2008_data.ExenatideWeekly(1:13)-Ducker2008_data.ExenatideWeeklyRange_max(1:13))/1000,'Color', color_black,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Ducker2008_data.Exenatide_time(1:13),Ducker2008_data.ExenatideWeekly(1:13)/1000,(Ducker2008_data.ExenatideWeekly(1:13)-Ducker2008_data.ExenatideWeeklyRange_min(1:13))/1000,(Ducker2008_data.ExenatideWeekly(1:13)-Ducker2008_data.ExenatideWeeklyRange_max(1:13))/1000,'Color', color_black,'LineStyle', 'n', 'Marker','x','MarkerSize',16,'LineWidth',LineWidthValue)
% legend('Exenatide 2 mg/week')
ylim([0 0.25])
xlim([-0.1 30.1])
grid on
hold off

subplot(3,3,2)
hold on
set(gca,'xtick',[0.001,0.01,0.1,1],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
title('In vitro human experiments')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxEffectInVitro,minEffectInVitro,Exenatide_x);
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.4,'EdgeAlpha',0.2);
colormap(map)
plot(Exenatide_x,BestEffectInVitro,'Color', color_black,'LineWidth',2)
xlim( [0.001 0.25])
ylim( [0 9])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(relative vehicle)'},'FontSmoothing','on','FontSize', 20);
hold off
grid on

subplot(3,3,3)
hold on
set(gca,'xtick',[0.001,0.01,0.1,1],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
title('In vivo rat experiments')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxEffectRat,minEffectRat,Exenatide_x);
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.4,'EdgeAlpha',0.2);
colormap(map)
plot(Exenatide_x,BestEffectRat,'Color', color_black,'LineWidth',2)
xlim( [0.001 0.25])
ylim( [0 9])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(relative vehicle)'},'FontSmoothing','on','FontSize', 20);
hold off
grid on

%% Fig. 8D

figure('units','normalized','outerposition',[0 0 1 1])
time         = round((420:1440:(30*7*60*24))/5,0);
time(end)    = 60276;

% Weekly - Plasma glucose
subplot(2,2,1)
hold on
set(gca,'ytick',0:5:15,'xtick',0:10:30,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Basal plasma glucose';'(mM)'},'FontSmoothing','on');
xlabel({'Time (weeks)'},'FontSmoothing','on');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_Glucose(time)',minDrucker2008_Glucose(time)',SimDruckerRat.time(time));
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)]/10080,[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.4,'EdgeAlpha',0.2);
colormap(map)
plot(SimDruckerRat.time(time)/10080,BestDrucker2008_Glucose(time),'Color', color_black,'LineWidth',1)

plot(Ducker2008_data.BasalGlucose_time(1:9),Ducker2008_data.BasalGlucoseWeekly(1:9),'Color', color_black,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
plot(Ducker2008_data.BasalGlucose_time(1),Ducker2008_data.BasalGlucoseWeekly(1),'Color', color_black,'LineStyle', 'n', 'Marker','x','MarkerSize',16,'LineWidth',LineWidthValue)
plot(Ducker2008_data.BasalGlucose_time(5),Ducker2008_data.BasalGlucoseWeekly(5),'Color', color_black,'LineStyle', 'n', 'Marker','x','MarkerSize',16,'LineWidth',LineWidthValue)
ylim([0 17])
xlim([-0.2 30.2])
grid on
hold off

%Plasma glucose
subplot(2,2,2)
hold on
set(gca,'ytick',0:5:15,'xtick',[0,60,120,180,240,300],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Plasma glucose';'(mM)'},'FontSmoothing','on');
xlabel({'Time (min)'},'FontSmoothing','on');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_Glucose',minDrucker2008_Glucose',SimDruckerRat.time);
fill([timeTemp, fliplr(timeTemp)]-(420+0*1440*7),[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.4,'EdgeAlpha',0.2);
fill([timeTemp, fliplr(timeTemp)]-(420+14*1440*7),[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',0.4,'EdgeAlpha',0.2);
fill([timeTemp, fliplr(timeTemp)]-(420+29*1440*7),[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.4,'EdgeAlpha',0.2);
plot(SimDruckerRat.time-(420+0*1440*7),BestDrucker2008_Glucose,'Color', color_black,'LineWidth',1)
plot(SimDruckerRat.time-(420+14*1440*7),BestDrucker2008_Glucose,'Color', color_black,'LineWidth',1)
plot(SimDruckerRat.time-(420+29*1440*7),BestDrucker2008_Glucose,'Color', color_black,'LineWidth',1)

errorbar(Ducker2008_data.GlucoseOGTTWeekly_time(1:8),Ducker2008_data.GlucoseWeeklyOGTT1(1:8),Ducker2008_data.GlucoseWeeklyOGTT1SEM(1:8),'Color', color_red,'LineStyle', 'n', 'Marker','.','MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Ducker2008_data.GlucoseOGTTWeekly_time(1:8),Ducker2008_data.GlucoseWeeklyOGTT2(1:8),Ducker2008_data.GlucoseWeeklyOGTT2SEM(1:8),'Color', color_yellow,'LineStyle', 'n', 'Marker','.','MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Ducker2008_data.GlucoseOGTTWeekly_time(1:8),Ducker2008_data.GlucoseWeeklyOGTT1(1:8),Ducker2008_data.GlucoseWeeklyOGTT1SEM(1:8),'Color', color_red,'LineStyle', 'n', 'Marker','x','MarkerSize',16,'LineWidth',LineWidthValue)
errorbar(Ducker2008_data.GlucoseOGTTWeekly_time(1),Ducker2008_data.GlucoseWeeklyOGTT2(1),Ducker2008_data.GlucoseWeeklyOGTT2SEM(1),'Color', color_yellow,'LineStyle', 'n', 'Marker','x','MarkerSize',16,'LineWidth',LineWidthValue)
line([0 15], [0 0],'Color','k','LineWidth',8);
ylim([0 17])
xlim([-45 320])
grid on
hold off


%% Fig. 8C
% The 4 alternatives are generated from changing the rat/human dose assumption, changing ForcedDietChange to either 1 or 0 and turning off exenatide administration

% Weekly - Plasma glucose
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
hold on
set(gca,'ytick',0:5:15,'xtick',0:10:30,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Basal plasma glucose';'(mM)'},'FontSmoothing','on');
xlabel({'Time (weeks)'},'FontSmoothing','on');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_GlucoseRat(time)',minDrucker2008_GlucoseRat(time)',SimDruckerRat.time(time));
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)]/10080,[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.4,'EdgeAlpha',0.2);
colormap(map)
plot(SimDruckerRat.time(time)/10080,BestDrucker2008_GlucoseRat(time),'Color', color_black,'LineWidth',1)
ylim([0 17])
xlim([-0.2 30.2])
grid on
hold off

%% Fig. S2
figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,2,1)
hold on
set(gca,'xtick',[0.001,0.01,0.1,1],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
title('In vitro human experiments')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxEffectInVitro,minEffectInVitro,Exenatide_x);
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.4,'EdgeAlpha',0.2);
colormap(map)
plot(Exenatide_x,BestEffectInVitro,'Color', color_black,'LineWidth',2)
xlim( [0.001 0.3])
ylim( [0 11])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(relative vehicle)'},'FontSmoothing','on','FontSize', 20);
hold off
grid on

%% Fig. S2C
figure('units','normalized','outerposition',[0 0 1 1])

% Weekly - Plasma glucose
subplot(3,3,1)
hold on
set(gca,'ytick',0:0.5:2,'xtick',[0,60,120,180,240,300],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Plasma insulin';'(nM)'},'FontSmoothing','on');
xlabel({'Time (min)'},'FontSmoothing','on');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_Insulin',minDrucker2008_Insulin',SimDruckerRat.time);
fill([timeTemp, fliplr(timeTemp)]-(420+29*1440*7),[maxTemp, fliplr(minTemp)]/1000, color_green,'FaceAlpha',0.4,'EdgeAlpha',0.2);
fill([timeTemp, fliplr(timeTemp)]-(420+14*1440*7),[maxTemp, fliplr(minTemp)]/1000, color_yellow,'FaceAlpha',0.4,'EdgeAlpha',0.2);
fill([timeTemp, fliplr(timeTemp)]-(420+0*1440*7),[maxTemp, fliplr(minTemp)]/1000, color_red,'FaceAlpha',0.4,'EdgeAlpha',0.2);
line([0 20], [0 0],'Color','k','LineWidth',8);
ylim([0 2000]/1000)
xlim([-45 350])
grid on
hold off

%InsulinResponseNew
timeMeal        = round((405+150:1440:405+150+(30*7*1440)-1440)/5,0);
timeBaseline    = round((405:1440:405+(30*7*1440)-1440)/5,0);
subplot(3,3,2)
hold on
set(gca,'ytick',0:3:15,'xtick',0:10:30,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Hepatic insulin response';'(Daily min/max)'},'FontSmoothing','on');
xlabel({'Time (weeks)'},'FontSmoothing','on');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_InsulinResponseNew(timeMeal)',minDrucker2008_InsulinResponseNew(timeBaseline)',SimDruckerRat.time(time));
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)]/10080,[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.7,'EdgeAlpha',0.2);
colormap(map)
line([0 0.5]  , [0 0],'Color',color_red,'LineWidth',8);
line([14 14.5], [0 0],'Color',color_yellow,'LineWidth',8);
line([29 29.5], [0 0],'Color',color_green,'LineWidth',8);
ylim([0 20])
xlim([-0.2 30.2])
grid on
hold off

% Glycogen
subplot(3,3,3)
hold on
set(gca,'ytick',0:150:500,'xtick',0:10:30,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_Glycogen',minDrucker2008_Glycogen',SimDruckerRat.time);
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)]/10080,[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.9,'EdgeAlpha',0.1);
colormap(map)
line([0 0.5]  , [0 0],'Color',color_red,'LineWidth',8);
line([14 14.5], [0 0],'Color',color_yellow,'LineWidth',8);
line([29 29.5], [0 0],'Color',color_green,'LineWidth',8);
ylabel({'Hepatic glycogen'; '(mM)'},'FontSmoothing','on');
xlabel({'Time (weeks)'},'FontSmoothing','on');
ylim([0,400])
xlim([0 30])
hold off
grid on

% Weekly - Plasma glucose
subplot(3,3,4)
hold on
set(gca,'ytick',1:2:15,'xtick',0:10:30,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Insulin resistance';'(multiplicaiton EC50)'},'FontSmoothing','on');
xlabel({'Time (weeks)'},'FontSmoothing','on');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxDrucker2008_IS(time)',minDrucker2008_IS(time)',SimDruckerRat.time(time));
colorfill = [linspace(1,2,length(timeTemp)/2), linspace(2,3,length(timeTemp)/2)];
colorfill = [colorfill, fliplr(colorfill)];
map(1:length(timeTemp),1) = [linspace(color_red(1),color_yellow(1),length(timeTemp)/2)'; linspace(color_yellow(1),color_green(1),length(timeTemp)/2)'];
map(1:length(timeTemp),2) = [linspace(color_red(2),color_yellow(2),length(timeTemp)/2)'; linspace(color_yellow(2),color_green(2),length(timeTemp)/2)'];
map(1:length(timeTemp),3) = [linspace(color_red(3),color_yellow(3),length(timeTemp)/2)'; linspace(color_yellow(3),color_green(3),length(timeTemp)/2)'];
fill([timeTemp, fliplr(timeTemp)]/10080,[maxTemp, fliplr(minTemp)], colorfill,'FaceAlpha',0.4,'EdgeAlpha',0.2);
colormap(map)
plot(SimDruckerRat.time(time)/10080,BestDrucker2008_IS(time),'Color', color_black,'LineWidth',1)
ylim([0 6])
xlim([-0.2 30.2])
grid on
hold off

%% Fig. S2D
figure('units','normalized','outerposition',[0 0 1 1])
BarWidth     = 0.1;
FillBarWidth = 0.12;

% Glucose utilization
subplot(3,3,1)
hold on
set(gca,'ytick',0:25:100,'xtick',0.15:1:5.15,'Xticklabel',{'Fat','Muscle','Brain','Liver'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0,100*[maxratio_Uidf, maxratio_Uidf, minratio_Uidf, minratio_Uidf], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1,100*[maxratio_Uidm, maxratio_Uidm , minratio_Uidm, minratio_Uidm], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2,100*[maxratio_Uii, maxratio_Uii , minratio_Uii, minratio_Uii], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3,100*[maxratio_Uidl, maxratio_Uidl , minratio_Uidl, minratio_Uidl], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0, 1, 2, 3],100*[Bestratio_Uidf,Bestratio_Uidm,Bestratio_Uii,Bestratio_Uidl],BarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.5)

fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0+0.15,100*[maxratio_UidfW14, maxratio_UidfW14, minratio_UidfW14, minratio_UidfW14], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1+0.15,100*[maxratio_UidmW14, maxratio_UidmW14 , minratio_UidmW14, minratio_UidmW14], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2+0.15,100*[maxratio_UiiW14, maxratio_UiiW14 , minratio_UiiW14, minratio_UiiW14], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3+0.15,100*[maxratio_UidlW14, maxratio_UidlW14 , minratio_UidlW14, minratio_UidlW14], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0, 1, 2, 3]+0.15,100*[Bestratio_UidfW14,Bestratio_UidmW14,Bestratio_UiiW14,Bestratio_UidlW14],BarWidth,'FaceColor',color_yellow,'LineWidth',1,'FaceAlpha',0.5)

fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0+0.3,100*[maxratio_UidfW30, maxratio_UidfW30, minratio_UidfW30, minratio_UidfW30], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1+0.3,100*[maxratio_UidmW30, maxratio_UidmW30 , minratio_UidmW30, minratio_UidmW30], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2+0.3,100*[maxratio_UiiW30, maxratio_UiiW30 , minratio_UiiW30, minratio_UiiW30], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3+0.3,100*[maxratio_UidlW30, maxratio_UidlW30 , minratio_UidlW30, minratio_UidlW30], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0, 1, 2, 3]+0.3,100*[Bestratio_UidfW30,Bestratio_UidmW30,Bestratio_UiiW30,Bestratio_UidlW30],BarWidth,'FaceColor',color_green,'LineWidth',1,'FaceAlpha',0.5)

ylabel({'Glucose utilisation'; '(%)'},'FontSmoothing','on');
ylim([0,100])
xlim([-0.25 3.55])
hold off
grid on

% Glucose production
subplot(3,3,2)
hold on
set(gca,'ytick',0:25:100,'xtick',0.15:1:5.15,'Xticklabel',{'Kidneys','Liver'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0,100*[1-maxratioL_EGP, 1-maxratioL_EGP , 1-minratioL_EGP, 1-minratioL_EGP], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1,100*[maxratioL_EGP, maxratioL_EGP , minratioL_EGP, minratioL_EGP], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0 1],100*[1-BestratioL_EGP,BestratioL_EGP],BarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.5)

fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0+0.15,100*[1-maxratioL_EGPW14, 1-maxratioL_EGPW14 , 1-minratioL_EGPW14, 1-minratioL_EGPW14], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1+0.15,100*[maxratioL_EGPW14, maxratioL_EGPW14 , minratioL_EGPW14, minratioL_EGPW14], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0 1]+0.15,100*[1-BestratioL_EGPW14,BestratioL_EGPW14],BarWidth,'FaceColor',color_yellow,'LineWidth',1,'FaceAlpha',0.5)

fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0+0.3,100*[1-maxratioL_EGPW30, 1-maxratioL_EGPW30 , 1-minratioL_EGPW30, 1-minratioL_EGPW30], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1+0.3,100*[maxratioL_EGPW30, maxratioL_EGPW30 , minratioL_EGPW30, minratioL_EGPW30], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0 1]+0.3,100*[1-BestratioL_EGPW30,BestratioL_EGPW30],BarWidth,'FaceColor',color_green,'LineWidth',1,'FaceAlpha',0.5)

ylabel({'Glucose production'; '(%)'},'FontSmoothing','on');
ylim([0,100])
xlim([-0.25 1.55])
hold off
grid on

% Insulin clearance
subplot(3,3,3)
hold on
set(gca,'ytick',0:25:100,'xtick',0.15:1:5.15,'Xticklabel',{'Liver','Non-liver'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0,100*[maxratioL_IC  , maxratioL_IC  , minratioL_IC  , minratioL_IC], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1,100*[1-maxratioL_IC, 1-maxratioL_IC, 1-minratioL_IC, 1-minratioL_IC], color_red,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0, 1,],100*[BestratioL_IC,1-BestratioL_IC],BarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.5)

fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0+0.15,100*[maxratioL_ICW14  , maxratioL_ICW14  , minratioL_ICW14  , minratioL_ICW14]  , color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1+0.15,100*[1-maxratioL_ICW14, 1-maxratioL_ICW14, 1-minratioL_ICW14, 1-minratioL_ICW14], color_yellow,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0, 1,]+0.15,100*[BestratioL_ICW14,1-BestratioL_ICW14],BarWidth,'FaceColor',color_yellow,'LineWidth',1,'FaceAlpha',0.5)

fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+0+0.3,100*[maxratioL_ICW30  , maxratioL_ICW30  , minratioL_ICW30  , minratioL_ICW30]  , color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1+0.3,100*[1-maxratioL_ICW30, 1-maxratioL_ICW30, 1-minratioL_ICW30, 1-minratioL_ICW30], color_green,'FaceAlpha',FaceAlphaValue,'EdgeAlpha', 1);
bar([0, 1,]+0.3,100*[BestratioL_ICW30,1-BestratioL_ICW30],BarWidth,'FaceColor',color_green,'LineWidth',1,'FaceAlpha',0.5)

ylabel({'Insulin clearance'; '(%)'},'FontSmoothing','on');
ylim([0,100])
xlim([-0.25 1.55])
hold off
grid on