%% Study1

% % legend
% figure()
% hold on
% set(gca,'ytick',0:4:12,'xtick',[0,2,4,6,8,10,12,14],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% ylabel('Glucose (mM)')
% xlabel('Time (days)');
% plot(simStudy1_LCHG.time/24,BestStudy1_Glucose_HCHG,':','Color', color_black,'LineWidth',4)
% plot(simStudy1_LCHG.time/24,BestStudy1_Glucose_HCHG,'Color', color_green,'LineWidth',4)
% plot(simStudy1_LCHG.time/24,BestStudy1_Glucose_HCHG,'Color', color_red,'LineWidth',4)
% plot(simStudy1_LCHG.time/24,BestStudy1_Glucose_HCHG,'Color', color_magenta,'LineWidth',4)
% plot(simStudy1_LCHG.time/24,BestStudy1_Glucose_HCHG     ,'Color', color_black,'LineWidth',4)
% legend('Islet donor 8 & Liver spheroid 1','FCS & LC','FCS & HC','B27 & LC','Islet donor 9 & Liver spheroid 2','Orientation','horizontal')
% hold off

figure()
% Study1 Glucose
subplot(2,4,1)
hold on
set(gca,'ytick',0:2:12,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Glucose';'(mM)'})
xlabel('Time (days)');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy1_Glucose_HCHG',minStudy1_Glucose_HCHG',simStudy1_LCHG.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy1_Glucose_LCHG',minStudy1_Glucose_LCHG',simStudy1_LCHG.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy1_LCHG.time/24,BestStudy1_Glucose_HCHG,':','Color', color_red,'LineWidth',2)
plot(simStudy1_LCHG.time/24,BestStudy1_Glucose_LCHG,':','Color', color_green,'LineWidth',2)
errorbar(Study1_data.time(1:8)/24,Study1_data.GlucoseHCHG(1:8),Study1_data.GlucoseHCHGstdev(1:8),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study1_data.time(1:8)/24,Study1_data.GlucoseLCHG(1:8),Study1_data.GlucoseLCHGstdev(1:8),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+3, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [6 6],'Color','k','LineWidth',8);
ylim([6 12])
xlim([1 16])
hold off
grid on

% Study1 Insulin
subplot(2,4,2)
hold on
set(gca,'ytick',0:10:45,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Insulin';'(nM)'})
xlabel('Time (days)');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy1_Insulin_HCHG',minStudy1_Insulin_HCHG',simStudy1_LCHG.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy1_Insulin_LCHG',minStudy1_Insulin_LCHG',simStudy1_LCHG.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy1_LCHG.time/24,BestStudy1_Insulin_HCHG/1000,':','Color', color_red,'LineWidth',2)
plot(simStudy1_LCHG.time/24,BestStudy1_Insulin_LCHG/1000,':','Color', color_green,'LineWidth',2)
errorbar(Study1_data.time(1:8)/24   ,Study1_data.InsulinHCHG(1:8),Study1_data.InsulinHCHGstdev(1:8),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study1_data.time(1:8)/24   ,Study1_data.InsulinLCHG(1:8),Study1_data.InsulinLCHGstdev(1:8),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0 0],'Color','k','LineWidth',8);
ylim([0 42])
xlim([1 16])
hold off
grid on

% Study3 Glucose
subplot(2,4,3)
hold on
set(gca,'ytick',0:2:12,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Glucose';'(mM)'})
xlabel('Time (days)');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy3_GlucoseB27',minStudy3_GlucoseB27',simStudy3_B27.time);
fill([timeTemp(241:end), fliplr(timeTemp(241:end))]/24,[maxTemp(241:end), fliplr(minTemp(241:end))], color_magenta,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy3_GlucoseFCS',minStudy3_GlucoseFCS',simStudy3_B27.time);
fill([timeTemp(241:end), fliplr(timeTemp(241:end))]/24,[maxTemp(241:end), fliplr(minTemp(241:end))], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy3_B27.time(241:end)/24,BestStudy3_GlucoseB27(241:end),'Color', color_magenta,'LineWidth',2)
plot(simStudy3_B27.time(241:end)/24,BestStudy3_GlucoseFCS(241:end),'Color', color_green,'LineWidth',2)
errorbar(Study3_data.time(1:7)/24,Study3_data.GlucoseB27(1:7),Study3_data.GlucoseB27stdev(1:7),'CapSize',CapSize,'Color', color_magenta,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study3_data.time(1:7)/24,Study3_data.GlucoseFCS(1:7),Study3_data.GlucoseFCSstdev(1:7),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+3, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [6 6],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [6 6],'Color','k','LineWidth',8);
ylim([6 12])
xlim([1 16])
hold off
grid on

% Study3 Insulin
subplot(2,4,4)
hold on
set(gca,'ytick',0:30:120,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
ylabel({'Insulin';'(nM)'})
xlabel('Time (days)');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy3_InsulinB27',minStudy3_InsulinB27',simStudy3_B27.time);
fill([timeTemp(241:end), fliplr(timeTemp(241:end))]/24,[maxTemp(241:end), fliplr(minTemp(241:end))]/1000, color_magenta,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy3_InsulinFCS',minStudy3_InsulinFCS',simStudy3_B27.time);
fill([timeTemp(241:end), fliplr(timeTemp(241:end))]/24,[maxTemp(241:end), fliplr(minTemp(241:end))]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy3_B27.time(241:end)/24,BestStudy3_InsulinB27(241:end)/1000,'Color', color_magenta,'LineWidth',2)
plot(simStudy3_B27.time(241:end)/24,BestStudy3_InsulinFCS(241:end)/1000,'Color', color_green,'LineWidth',2)
errorbar(Study3_data.time(1:7)/24   ,Study3_data.InsulinB27(1:7),Study3_data.InsulinB27stdev(1:7),'CapSize',CapSize,'Color', color_magenta,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study3_data.time(1:7)/24   ,Study3_data.InsulinFCS(1:7),Study3_data.InsulinFCSstdev(1:7),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0 0],'Color','k','LineWidth',8);
ylim([0 125])
xlim([1 16])
hold off
grid on

% Lactate
subplot(2,4,8)
hold on
set(gca,'ytick',0:5:20,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title('Lactate - S1')
ylabel({'Lactate';'(mM)'})
xlabel('Time (days)');
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy3_LactateB27',minStudy3_LactateB27',simStudy3_FCS.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_magenta,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy3_LactateFCS',minStudy3_LactateFCS',simStudy3_FCS.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy3_FCS.time/24,BestStudy3_LactateB27,'Color', color_magenta,'LineWidth',2)
plot(simStudy3_FCS.time/24,BestStudy3_LactateFCS,'Color', color_green,'LineWidth',2)
errorbar(Study3_data.timeLactate(1:8)/24,Study3_data.LactateB27(1:8),Study3_data.LactateB27stdev(1:8),'CapSize',CapSize,'Color', color_magenta,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study3_data.timeLactate(1:8)/24,Study3_data.LactateFCS(1:8),Study3_data.LactateFCSstdev(1:8),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0 0],'Color','k','LineWidth',8);
ylim([0 20])
xlim([0 16])
hold off
grid on

%% Exp 6.2

figure()

% InSphero GSIS exenatide
subplot(2,4,1)
hold on
title('Fig. S1')
set(gca,'ytick',0:2:6,'xtick',0:1:5,'Xticklabel',{'0^ ','10^-^1','10^0','10^1','10^2','10^3'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((0:1:5)-1000,simBestStudy5_GSIS.SaveInsulinSecretionD0(:,2),'Color', color_black,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minsimStudy5_ERD0_LG2',maxsimStudy5_ERD0_LG2',(0:1:5));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_black,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(0:1:5,simBestStudy5_GSIS.SaveInsulinSecretionD0(:,2),'Color', color_black,'LineWidth',2)
errorbar(0:5, Study5_data.HG_D0(1:6), Study5_data.HG_D0stdev(1:6),'LineStyle', 'n','Color', color_black, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
legend('Islet donor 1','FontSize', 15)
ylabel({'Insulin';'(nM)'})
xlabel({'Exenatide (nM)'},'FontSmoothing','on');
ylim([0,7.5])
xlim([-0.2,5.2])
hold off
grid on

% InSphero GSIS exenatide
subplot(2,4,3)
hold on
set(gca,'ytick',0:1:6,'xtick',0:1:6,'Xticklabel',{'0^ ', '10^-^2  ', '10^-^1', '10^0', '10^1', '10^2', '10^3'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((0:1:6),BestsimStudy13_Donor1/1000,'LineWidth',2,'Color', color_blue)
plot((0:1:6),BestsimStudy13_Donor2/1000,'LineWidth',2,'Color', color_red)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxsimStudy13_Donor1,minsimStudy13_Donor1,(0:1:6));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxsimStudy13_Donor2,minsimStudy13_Donor2,(0:1:6));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)]/1000, color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
errorbar((0:1:6), Study13_data.Meanp1(1:7)/(5808*0.00005/1000)/1000, Study13_data.Stdevp1(1:7)/(5808*0.00005/1000)/1000,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar((0:1:5), Study13_data.Meanp2(1:6)/(5808*0.00005/1000)/1000, Study13_data.Stdevp2(1:6)/(5808*0.00005/1000)/1000,'LineStyle', 'n','Color', color_red, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Insulin';'(nM)'})
xlabel({'Exenatide (nM)'},'FontSmoothing','on');
legend('Islet donor 4','Islet donor 5','Location','North','FontSize', 15)
ylim([0,4])
xlim([-0.1,6.1])
hold off
grid on

% InSphero GSIS exenatide
subplot(2,4,4)
hold on
set(gca,'ytick',0:1:6,'xtick',0:1:6,'Xticklabel',{'0^ ', '10^-^2  ', '10^-^1', '10^0', '10^1', '10^2', '10^3'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((0:1:6),BestsimStudy13_Donor3/1000,'LineWidth',2,'Color', color_green)
plot((0:1:6),BestsimStudy13_Donor4/1000,'LineWidth',2,'Color', color_black)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxsimStudy13_Donor3,minsimStudy13_Donor3,(0:1:6));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxsimStudy13_Donor4,minsimStudy13_Donor4,(0:1:6));
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)]/1000, color_black,'FaceAlpha',0.2,'EdgeAlpha',0.1);
errorbar((0:1:5), Study13_data.Meanp3(1:6)/(5808*0.00005/1000)/1000, Study13_data.Stdevp3(1:6)/(5808*0.00005/1000)/1000,'LineStyle', 'n','Color', color_green, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar((0:1:5), Study13_data.Meanp4(1:6)/(5808*0.00005/1000)/1000, Study13_data.Stdevp4(1:6)/(5808*0.00005/1000)/1000,'LineStyle', 'n','Color', color_black, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
legend('Islet donor 6','Islet donor 7','Location','North','FontSize', 15)
xlabel({'Exenatide (nM)'},'FontSmoothing','on');
ylabel({'Insulin';'(nM)'})
ylim([0,4])
xlim([-0.1,6.1])
hold off
grid on

%%
figure()

% Insulin
subplot(2,3,1)
hold on
set(gca,'xtick',[0,1,3,5,7,9,11,13,15],'ytick',0:2:15,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot(SimBestStudy4_vehicle.time/24,SimBestStudy4_vehicle.statevalues(:,ismember(SimBestStudy4_vehicle.states,'Insulin_Medium'))/1000,'Color', color_blue,'LineWidth',2)
plot(SimBestStudy4_0p1.time/24    ,SimBestStudy4_0p1.statevalues(:,ismember(SimBestStudy4_0p1.states,'Insulin_Medium'))/1000  ,'Color', color_green,'LineWidth',2)
plot(SimBestStudy4_10.time/24     ,SimBestStudy4_10.statevalues(:,ismember(SimBestStudy4_10.states,'Insulin_Medium'))/1000  ,'Color', color_yellow,'LineWidth',2)
plot(SimBestStudy4_1000.time/24   ,SimBestStudy4_1000.statevalues(:,ismember(SimBestStudy4_1000.states,'Insulin_Medium'))/1000  ,'Color', color_red,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_VehicleI',minStudy4_2OC_VehicleI',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_0p1I',minStudy4_2OC_0p1I',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_10I',minStudy4_2OC_10I',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_1000I',minStudy4_2OC_1000I',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)]/1000, color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
errorbar(Study4_data.time/24,Study4_data.Insulin_Vehicle,Study4_data.InsulinSEM_Vehicle,'LineStyle', 'n','color',color_blue  ,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.time/24,Study4_data.Insulin_1uM    ,Study4_data.InsulinSEM_1uM    ,'LineStyle', 'n','color',color_red   ,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.time/24,Study4_data.Insulin_10nM    ,Study4_data.InsulinSEM_10nM  ,'LineStyle', 'n','color',color_yellow,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.time/24,Study4_data.Insulin_0p1nM    ,Study4_data.InsulinSEM_0p1nM  ,'LineStyle', 'n','color',color_green,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Insulin';'(nM)'})
xlabel({'Time (days)'},'FontSmoothing','on');
line([7 16], [9.2 9.2],'Color',color_gray,'LineWidth',2);
line([0 0.1], [0 0],'Color',color_black,'LineWidth',6);
for i = 0:3
    line([7+2*i (7+2*i+0.15)], [0 0],'Color',color_black,'LineWidth',6);
end
for i = 0:6
    line([1+2*i (1+2*i+0.15)], [0 0],'Color',color_black,'LineWidth',6);
end
legend('Vehicle','Exenatide 0.1 nM','Exenatide 10 nM','Exenatide 1000 nM','Location','North','FontSize',LegendSize-5,'Orientation','horizontal')
xlim( [-0.1 15.1])
ylim( [0 10])
grid on
hold off

% Glucose
subplot(2,3,2)
hold on
set(gca,'xtick',[0,1,3,5,7,9,11,13,15],'ytick',0:2:15,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot(SimStudy4_vehicle.time/24,SimBestStudy4_vehicle.statevalues(:,ismember(SimBestStudy4_vehicle.states,'Glucose_Medium')),'Color', color_blue,'LineWidth',2)
plot(SimStudy4_0p1.time/24 ,SimBestStudy4_0p1.statevalues(:,ismember(SimBestStudy4_0p1.states,'Glucose_Medium'))  ,'Color', color_green,'LineWidth',2)
plot(SimStudy4_10.time/24 ,SimBestStudy4_10.statevalues(:,ismember(SimBestStudy4_10.states,'Glucose_Medium'))  ,'Color', color_yellow,'LineWidth',2)
plot(SimStudy4_1000.time/24 ,SimBestStudy4_1000.statevalues(:,ismember(SimBestStudy4_1000.states,'Glucose_Medium'))  ,'Color', color_red,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_VehicleG',minStudy4_2OC_VehicleG',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_0p1G',minStudy4_2OC_0p1G',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_10G',minStudy4_2OC_10G',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_1000G',minStudy4_2OC_1000G',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
errorbar(Study4_data.time/24,Study4_data.Glucose_Vehicle,Study4_data.GlucoseSEM_Vehicle,'LineStyle', 'n','color',color_blue  ,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.time/24,Study4_data.Glucose_1uM  ,Study4_data.GlucoseSEM_1uM    ,'LineStyle', 'n','color',color_red   ,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.time/24,Study4_data.Glucose_10nM  ,Study4_data.GlucoseSEM_10nM  ,'LineStyle', 'n','color',color_yellow,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.time/24,Study4_data.Glucose_0p1nM  ,Study4_data.GlucoseSEM_0p1nM  ,'LineStyle', 'n','color',color_green,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Glucose';'(mM)'})
xlabel({'Time (days)'},'FontSmoothing','on');
line([7 16], [11.5 11.5],'Color',color_gray,'LineWidth',2);
line([0 0.1], [0 0],'Color',color_black,'LineWidth',6);
for i = 0:3
    line([7+2*i (7+2*i+0.15)], [4 4],'Color',color_black,'LineWidth',6);
end
for i = 0:6
    line([1+2*i (1+2*i+0.15)], [4 4],'Color',color_black,'LineWidth',6);
end
%legend('Vehicle','Exenatide 1uM','Exenatide 10nM','Location','North','FontSize',LegendSize-5)
xlim( [-0.1 15.1])
ylim( [4 12])
grid on
hold off

% Lactate
subplot(2,3,3)
hold on
set(gca,'xtick',[0,1,3,5,7,9,11,13,15],'ytick',0:4:15,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot(SimStudy4_vehicle.time/24,SimBestStudy4_vehicle.statevalues(:,ismember(SimBestStudy4_vehicle.states,'Lactate_Medium')),'Color', color_blue,'LineWidth',2)
plot(SimStudy4_0p1.time/24 ,SimBestStudy4_0p1.statevalues(:,ismember(SimBestStudy4_0p1.states,'Lactate_Medium'))  ,'Color', color_green,'LineWidth',2)
plot(SimStudy4_10.time/24 ,SimBestStudy4_10.statevalues(:,ismember(SimBestStudy4_10.states,'Lactate_Medium'))  ,'Color', color_yellow,'LineWidth',2)
plot(SimStudy4_1000.time/24 ,SimBestStudy4_1000.statevalues(:,ismember(SimBestStudy4_1000.states,'Lactate_Medium'))  ,'Color', color_red,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_VehicleL',minStudy4_2OC_VehicleL',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_0p1L',minStudy4_2OC_0p1L',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_10L',minStudy4_2OC_10L',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_1000L',minStudy4_2OC_1000L',SimBestStudy4_vehicle.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
errorbar(Study4_data.timeLactate/24,Study4_data.Lactate_Vehicle,Study4_data.LactateSEM_Vehicle,'LineStyle', 'n','color',color_blue  ,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.timeLactate/24,Study4_data.Lactate_1uM    ,Study4_data.LactateSEM_1uM    ,'LineStyle', 'n','color',color_red   ,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.timeLactate/24,Study4_data.Lactate_10nM   ,Study4_data.LactateSEM_10nM  ,'LineStyle', 'n','color',color_yellow,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.timeLactate/24,Study4_data.Lactate_0p1nM  ,Study4_data.LactateSEM_0p1nM  ,'LineStyle', 'n','color',color_green,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Lactate';'(mM)'})
xlabel({'Time (days)'},'FontSmoothing','on');
line([7 16], [11.5 11.5],'Color',color_gray,'LineWidth',2);
line([0 0.1], [0 0],'Color',color_black,'LineWidth',6);
for i = 0:3
    line([7+2*i (7+2*i+0.15)], [0 0],'Color',color_black,'LineWidth',6);
end
for i = 0:6
    line([1+2*i (1+2*i+0.15)], [0 0],'Color',color_black,'LineWidth',6);
end
xlim( [-0.1 15.1])
ylim( [0 12])
grid on
hold off

% PK
subplot(2,3,6)
hold on
set(gca,'xtick',[0,1,3,5,7,9,11,13,15],'ytick',[0.1,10,1000],'FontSize', 20,'FontSmoothing','on','fontname','Arial','YScale','log')
title('Fig. S1')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_0p1E,minStudy4_2OC_0p1E,SimBestStudy4_0p1.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_10E,minStudy4_2OC_10E,SimBestStudy4_0p1.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy4_2OC_1000E,minStudy4_2OC_1000E,SimBestStudy4_0p1.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);

plot(SimBestStudy4_0p1.time/24 ,SimBestStudy4_0p1.statevalues(:,ismember(SimBestStudy4_0p1.states,'Exenatide_Medium'))  ,'Color', color_green,'LineWidth',2)
plot(SimBestStudy4_0p1.time/24 ,SimBestStudy4_10.statevalues(:,ismember(SimBestStudy4_10.states,'Exenatide_Medium'))  ,'Color', color_yellow,'LineWidth',2)
plot(SimBestStudy4_0p1.time/24 ,SimBestStudy4_1000.statevalues(:,ismember(SimBestStudy4_1000.states,'Exenatide_Medium'))  ,'Color', color_red,'LineWidth',2)
errorbar(Study4_data.timeExenatide(1:12)/24,Study4_data.Exenatide_0p1(1:12),Study4_data.ExenatideSEM_0p1(1:12),'Color', color_green,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.timeExenatide(1:12)/24,Study4_data.Exenatide_10nM(1:12),Study4_data.ExenatideSEM_10nM(1:12)  ,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study4_data.timeExenatide(1:12)/24,Study4_data.Exenatide_1uM(1:12),Study4_data.ExenatideSEM_1uM(1:12)  ,'Color', color_red,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on');
xlabel({'Time (days)'},'FontSmoothing','on');
xlim( [0 15.1])
ylim( [0.015 3000])
line([7 16], [2000 2000],'Color',color_gray,'LineWidth',2);
line([-0.075 0.075]+7, [0.015 0.015],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0.015 0.015],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0.015 0.015],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0.015 0.015],'Color','k','LineWidth',8);
grid on
hold off

%% Exp Edu
figure()
FillBarWidth = 0.07;

% GSIS proliferation
subplot(2,2,1)
hold on
set(gca,'ytick',0:5:20,'xtick',1:1:7,'Xticklabel',{'HIMM-media','NC + B27','NC + FCS','HC + FCS','HC + FCS + Exenatide 0.1 nM','HC + FCS + Exenatide 10 nM','HC + FCS + Exenatide 1 uM'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
%title('Fig. S1')
xtickangle(30)
% legend
fill([[1-FillBarWidth, 1+FillBarWidth], fliplr([1-FillBarWidth,1+FillBarWidth])]-50,[minEduPositiveSM, minEduPositiveSM , maxEduPositiveSM, maxEduPositiveSM]            , color_blue,'FaceAlpha',0.5,'EdgeAlpha', 0.1);
fill([[1-FillBarWidth, 1+FillBarWidth], fliplr([1-FillBarWidth,1+FillBarWidth])]-50,[minEduPositiveSM, minEduPositiveSM , maxEduPositiveSM, maxEduPositiveSM]            , color_red,'FaceAlpha',0.5,'EdgeAlpha', 0.1);
errorbar(-50, 1, 1,'LineStyle', 'n','Color', color_black,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(-50,1,1  ,'LineStyle', 'n','Color', color_black, 'Marker',marker11,'MarkerSize',1,'LineWidth',LineWidthValue)
% legend
fill([[1-FillBarWidth, 1+FillBarWidth], fliplr([1-FillBarWidth,1+FillBarWidth])],[minEduPositiveSM, minEduPositiveSM , maxEduPositiveSM, maxEduPositiveSM]            , color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);

fill([[2-FillBarWidth, 2+FillBarWidth], fliplr([2-FillBarWidth,2+FillBarWidth])],[minEduPositiveB27, minEduPositiveB27 , maxEduPositiveB27, maxEduPositiveB27]    , color_red,'FaceAlpha',0.2,'EdgeAlpha', 0.1);

fill([[3-0.1-FillBarWidth, 3-0.1+FillBarWidth], fliplr([3-0.1-FillBarWidth,3-0.1+FillBarWidth])],[minEduPositiveLCLG, minEduPositiveLCLG , maxEduPositiveLCLG, maxEduPositiveLCLG]    , color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[3+0.1-FillBarWidth, 3+0.1+FillBarWidth], fliplr([3+0.1-FillBarWidth,3+0.1+FillBarWidth])],[minEduPositiveLCHG, minEduPositiveLCHG , maxEduPositiveLCHG, maxEduPositiveLCHG]    , color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);

fill([[4-0.2-FillBarWidth, 4-0.2+FillBarWidth], fliplr([4-0.2-FillBarWidth,4-0.2+FillBarWidth])],[minEduPositiveHCLG, minEduPositiveHCLG , maxEduPositiveHCLG, maxEduPositiveHCLG]    , color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[4+0.0-FillBarWidth, 4+0.0+FillBarWidth], fliplr([4+0.0-FillBarWidth,4+0.0+FillBarWidth])],[minEduPositiveHCHG, minEduPositiveHCHG , maxEduPositiveHCHG, maxEduPositiveHCHG]    , color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[4+0.2-FillBarWidth, 4+0.2+FillBarWidth], fliplr([4+0.2-FillBarWidth,4+0.2+FillBarWidth])],[minEduPositive0, minEduPositive0 , maxEduPositive0, maxEduPositive0]                , color_red,'FaceAlpha',0.2,'EdgeAlpha', 0.1);

fill([[5-FillBarWidth, 5+FillBarWidth], fliplr([5-FillBarWidth,5+FillBarWidth])],[minEduPositive0p1, minEduPositive0p1 , maxEduPositive0p1, maxEduPositive0p1]                        , color_red,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[6-FillBarWidth, 6+FillBarWidth], fliplr([6-FillBarWidth,6+FillBarWidth])],[minEduPositive10, minEduPositive10 , maxEduPositive10, maxEduPositive10]                            , color_red,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[7-FillBarWidth, 7+FillBarWidth], fliplr([7-FillBarWidth,7+FillBarWidth])],[minEduPositive1000, minEduPositive1000 , maxEduPositive1000, maxEduPositive1000]                    , color_red,'FaceAlpha',0.2,'EdgeAlpha', 0.1);

bar(1,BestEduPositiveSM,FillBarWidth,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(2,BestEduPositiveB27,FillBarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.2)
bar(3-0.1,BestEduPositiveLCLG,FillBarWidth,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(3+0.1,BestEduPositiveLCHG,FillBarWidth,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(4-0.2,BestEduPositiveHCLG,FillBarWidth,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(4+0.0,BestEduPositiveHCHG,FillBarWidth,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(4+0.2,BestEduPositive0,FillBarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.2)
bar(5,BestEduPositive0p1,FillBarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.2)
bar(6,BestEduPositive10,FillBarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.2)
bar(7,BestEduPositive1000,FillBarWidth,'FaceColor',color_red,'LineWidth',1,'FaceAlpha',0.2)

errorbar(1,Study14_data.Control(1), Study14_data.Control(2),'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(2-0.0, Study14_data.B27(1), Study14_data.B27(2),'LineStyle', 'n','Color', color_red,'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(3-0.1, Study14_data.LC_FCS_NG(1), Study14_data.LC_FCS_NG(2),'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(3+0.1, Study14_data.LC_FCS_HG(1), Study14_data.LC_FCS_HG(2),'LineStyle', 'n','Color', color_blue, 'Marker',marker11,'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue)
errorbar(4-0.2,Study14_data.HC_FCS_NG(1), Study14_data.HC_FCS_NG(2),'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(4+0.0,Study14_data.HC_FCS_HG(1), Study14_data.HC_FCS_HG(2),'LineStyle', 'n','Color', color_blue, 'Marker',marker11,'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue)
errorbar(4+0.2,Study14_data.EdU_E0(1), Study14_data.EdU_E0(2),'LineStyle', 'n','Color', color_red, 'Marker',marker11,'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue)
errorbar(5,Study14_data.EdU_E0p1nM(1), Study14_data.EdU_E0p1nM(2),'LineStyle', 'n','Color', color_red, 'Marker',marker11,'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue)
errorbar(6,Study14_data.EdU_E10nM(1), Study14_data.EdU_E10nM(2),'LineStyle', 'n','Color', color_red, 'Marker',marker11,'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue)
errorbar(7,Study14_data.EdU_E1uM(1), Study14_data.EdU_E1uM(2),'LineStyle', 'n','Color', color_red, 'Marker',marker11,'MarkerSize',MarkerSize11,'LineWidth',LineWidthValue)
ylabel({'EdU-positive';'(%)'});
legend('Study 14B','Study 14A','Glucose 5.5 mM','Glucose 11 mM','Location','North','FontSize',15,'Orientation','horizontal')
ylim([0,20])
xlim([0.9,7.1])
hold off
grid on
%%
%% SimulateInsulinPhases

figure()
subplot(3,2,1)
hold on
set(gca,'ytick',0:20:90,'xtick',-120:15:120,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
basalSecretion = 0.04; % % normalisation to an avg basal
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxExpIS_A2,minExpIS_A2,simInsulinPhases_Article2.time);
fill([timeTemp, fliplr(timeTemp)]*60    -60,[maxTemp', fliplr(minTemp')], color_black,'FaceAlpha',0.2,'EdgeAlpha',0.2);
plot(InSpheroInsulinPhases_data.timep1-8  , InSpheroInsulinPhases_data.Isletp1/basalSecretion, '.','Color', [0.2,0.2,0.2],'Marker',marker,'MarkerSize',10,'LineWidth',LineWidthValue)
plot(InSpheroInsulinPhases_data.timep2-8, InSpheroInsulinPhases_data.Isletp2/basalSecretion, '.','Color'  , [0.2,0.2,0.2],'Marker',marker,'MarkerSize',10,'LineWidth',LineWidthValue)
plot(InSpheroInsulinPhases_data.timep3-8  , InSpheroInsulinPhases_data.Isletp3/basalSecretion, '.','Color', [0.2,0.2,0.2],'Marker',marker,'MarkerSize',10,'LineWidth',LineWidthValue)
plot(InSpheroInsulinPhases_data.timep4-8  , InSpheroInsulinPhases_data.Islet4/basalSecretion, '.','Color' , [0.2,0.2,0.2],'Marker',marker,'MarkerSize',10,'LineWidth',LineWidthValue)
plot(simInsulinPhases_Article2.time*60 -60,BestExpIS_A2     ,'LineWidth',2,'Color', color_black)
line([0 34], [-3 -3],'Color',color_black,'LineWidth',2);
ylabel({'Insulin secretion';'(fold change to basal)'},'FontSmoothing','on');
xlabel('Time (min)','FontSmoothing','on');
ylim([-3,60])
xlim([-10,60])
hold off
grid on

subplot(3,2,2)
hold on
set(gca,'ytick',0:20:60,'xtick',-120:15:120,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot(simInsulinPhases_flow100.time*60 -60,BestExpIS_flow100,'LineWidth',2,'Color', color_orange)
plot(simInsulinPhases_flow0.time*60   -60,BestExpIS_flow0,'LineWidth',2,'Color', color_blue)
line([0 60], [-1 -1],'Color',color_black,'LineWidth',2);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExpIS_flow0,maxExpIS_flow0,simInsulinPhases_flow0.time);
fill([timeTemp, fliplr(timeTemp)]*60    -60,[maxTemp', fliplr(minTemp')], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minExpIS_flow100,maxExpIS_flow100,simInsulinPhases_flow0.time);
fill([timeTemp, fliplr(timeTemp)]*60    -60,[maxTemp', fliplr(minTemp')], color_orange,'FaceAlpha',0.2,'EdgeAlpha',0.1);
basalSecretion = 0.18; %normalisation to an avg basal
plot(InSpheroInsulinPhases_data.timeflowVehicle-99, InSpheroInsulinPhases_data.flowVehicle./basalSecretion, '.','Color', color_blue,'Marker',marker,'MarkerSize',12,'LineWidth',LineWidthValue)
plot(InSpheroInsulinPhases_data.timeflowExenatide-99, InSpheroInsulinPhases_data.flowExenatide./basalSecretion, '.','Color', color_orange,'Marker',marker,'MarkerSize',12,'LineWidth',LineWidthValue)
ylabel({'Insulin secretion';'(fold change to basal)'},'FontSmoothing','on');
xlabel({'Time (min)'},'FontSmoothing','on');
legend('Exenatide 100 nM','Vehicle','Location','North','Orientation','horizontal')
ylim([-3,60])
xlim([-10,75])
hold off
grid on

%%
load('InSpheroInsulinPhases_data')

figure()
subplot(2,2,1)
hold on
%title('Static GSIS')
set(gca,'ytick',0:15:75,'xtick',InSpheroInsulinPhases_data.Glucose(1:5),'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot(2.8:0.1:16.7,BestsimExpIS_Exenatide,'LineWidth',2,'Color', color_orange)
plot(2.8:0.1:16.7,BestsimExpIS_Control,'LineWidth',2,'Color', color_blue)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxsimExpIS_Control,minsimExpIS_Control,(2.8:0.1:16.7)');
fill([timeTemp', fliplr(timeTemp')],[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxsimExpIS_Exenatide,minsimExpIS_Exenatide,(2.8:0.1:16.7)');
fill([timeTemp', fliplr(timeTemp')],[maxTemp, fliplr(minTemp)], color_orange,'FaceAlpha',0.2,'EdgeAlpha',0.1);
InSpheroInsulinPhases_data.staticGSISVehicle(1)   = InSpheroInsulinPhases_data.staticGSISVehicle(1)   * BestsimExpIS_Data;
InSpheroInsulinPhases_data.staticGSISExenatide(1) = InSpheroInsulinPhases_data.staticGSISExenatide(1) * BestsimExpIS_Data;
data       = InSpheroInsulinPhases_data.staticGSISVehicle(1:5)     ./InSpheroInsulinPhases_data.staticGSISVehicle(1);
weight     = InSpheroInsulinPhases_data.staticGSISVehicleSEM(1:5)  ./InSpheroInsulinPhases_data.staticGSISVehicle(1);
errorbar(InSpheroInsulinPhases_data.Glucose(1:5),data,weight,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
data       = InSpheroInsulinPhases_data.staticGSISExenatide(1:5)     ./InSpheroInsulinPhases_data.staticGSISExenatide(1);
weight     = InSpheroInsulinPhases_data.staticGSISExenatideSEM(1:5)  ./InSpheroInsulinPhases_data.staticGSISExenatide(1);
errorbar(InSpheroInsulinPhases_data.Glucose(1:5),data,weight,'LineStyle', 'n','Color', color_orange, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
legend('Exenatide 100 nM', 'Vehicle')
ylabel({'Insulin secretion';'(fold change to basal)'},'FontSmoothing','on');
xlabel({'Glucose (mM)'},'FontSmoothing','on');
ylim([0,60])
xlim([2.5,16.9])
hold off
grid on

load('InSpheroInsulinPhases_data')
