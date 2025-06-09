%% Declare stuff
BarWidth     = 0.02;
FillBarWidth = 0.05;
BarPlotVector =[-0.1,0.0,0.1];
 
%% Glucose control
% figure('units','normalized','outerposition',[0 0 1 1])
% 
% % Legend
% hold on
% set(gca,'ytick',4:4:12,'xtick',0:12:72,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% plot((SimStudy6_Vehicle0.time(1:720)-24),simBestG_0nM(1:720)  ,'Color', color_blue,'LineWidth',4)
% plot((SimStudy6_Vehicle5.time(1:720)-24),simBestG_5nM(1:720)  ,'Color', color_green,'LineWidth',4)
% plot((SimStudy6_Vehicle10.time(1:720)-24),simBestG_10nM(1:720) ,'Color', color_yellow,'LineWidth',4)
% plot((SimStudy6_Vehicle100.time(1:720)-24),simBestG_100nM(1:720),'Color', color_red,'LineWidth',4)
% legend('Insulin 0 nM', 'Insulin 5 nM', 'Insulin 10 nM', 'Insulin 100 nM','Location','North','FontSize',20,'Orientation','horizontal')
% hold off
% grid on

figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,4,1)
hold on
set(gca,'ytick',0:4:12,'xtick',0:12:72,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((SimStudy6_Vehicle0.time(1:720)-24),simBestG_0nM(1:720)  ,'Color', color_blue,'LineWidth',LineWidthValue)
plot((SimStudy6_Vehicle5.time(1:720)-24),simBestG_5nM(1:720)  ,'Color', color_green,'LineWidth',LineWidthValue)
plot((SimStudy6_Vehicle10.time(1:720)-24),simBestG_10nM(1:720) ,'Color', color_yellow,'LineWidth',LineWidthValue)
plot((SimStudy6_Vehicle100.time(1:720)-24),simBestG_100nM(1:720),'Color', color_red,'LineWidth',LineWidthValue)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_0(1:720)',minGlucose_Study6_0(1:720)',SimStudy6_Vehicle0.time(1:720));
fill([timeTemp, fliplr(timeTemp)]-24,[maxTemp', fliplr(minTemp')], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_5(1:720)',minGlucose_Study6_5(1:720)',SimStudy6_Vehicle0.time(1:720));
fill([timeTemp, fliplr(timeTemp)]-24,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_10(1:720)',minGlucose_Study6_10(1:720)',SimStudy6_Vehicle0.time(1:720));
fill([timeTemp, fliplr(timeTemp)]-24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_100(1:720)',minGlucose_Study6_100(1:720)',SimStudy6_Vehicle0.time(1:720));
fill([timeTemp, fliplr(timeTemp)]-24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);

errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_0nM(1:4)   ,Study6_data.G_0nMstdev(1:4) ,'LineStyle', 'n','Color', color_blue, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_5nM(1:4)   ,Study6_data.G_5nMstdev(1:4),'LineStyle', 'n','Color', color_green, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_10nM(1:4)  ,Study6_data.G_10nMstdev(1:4),'LineStyle', 'n','Color', color_yellow, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_100nM(1:4) ,Study6_data.G_100nMstdev(1:4),'LineStyle', 'n','Color', color_red, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
line([-1 1], [0 0],'Color','k','LineWidth',8);
ylabel({'Glucose';'(mM)'},'FontSmoothing','on');
xlabel('Time (h)');
xlim([0,48])
ylim([0,12.5])
legend('Insulin 0 nM', 'Insulin 5 nM', 'Insulin 10 nM', 'Insulin 100 nM','Location','North','FontSize',15,'Orientation','horizontal')
hold off
grid on

% IP
subplot(2,4,2)
hold on
set(gca,'ytick',0:5:20,'xtick',[0.1,1,10,100],'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxIR',minIR',InsulinPlotVector);
  fill([timeTemp, fliplr(timeTemp)]/1000,[maxTemp', fliplr(minTemp')], color_gray,'FaceAlpha',0.4,'EdgeAlpha',0.1);
 plot(InsulinPlotVector/1000,BestIR,'Color', color_black,'LineWidth',2)
xlabel('Hepatic insulin (nM)','FontSmoothing','on');
ylabel({'Hepatic insulin response';'(increase from baseline)'},'FontSmoothing','on');
% xlim([0.1,100])
% ylim([0,20])
hold off
grid on

% Glucose control
subplot(2,4,3)
hold on
set(gca,'ytick',0:50:150,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_0Relative',minGlucose_Study6_0Relative',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]/24,100*[maxTemp', fliplr(minTemp')], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_5Relative',minGlucose_Study6_5Relative',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]/24,100*[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_10Relative',minGlucose_Study6_10Relative',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]/24,100*[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_100Relative',minGlucose_Study6_100Relative',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]/24,100*[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(SimStudy6_Vehicle0.time/24  ,100*simBestG_0nMRelative ,'Color', color_blue,'LineWidth',LineWidthValue)
plot(SimStudy6_Vehicle5.time/24  ,100*simBestG_5nMRelative ,'Color', color_green,'LineWidth',LineWidthValue)
plot(SimStudy6_Vehicle10.time/24 ,100*simBestG_10nMRelative ,'Color', color_yellow,'LineWidth',LineWidthValue)
plot(SimStudy6_Vehicle100.time/24,100*simBestG_100nMRelative ,'Color', color_red,'LineWidth',LineWidthValue)

errorbar(Study6_data.timeGlucose/24,100*Study6_data.IR_0nM   ,100*Study6_data.IR_0nMstdev ,'LineStyle', 'n','Color', color_blue, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose/24,100*Study6_data.IR_5nM   ,100*Study6_data.IR_5nMstdev,'LineStyle', 'n','Color', color_green, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose/24,100*Study6_data.IR_10nM  ,100*Study6_data.IR_10nMstdev,'LineStyle', 'n','Color', color_yellow, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose/24,100*Study6_data.IR_100nM ,100*Study6_data.IR_100nMstdev,'LineStyle', 'n','Color', color_red, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)

for i = 0:6
    line([1+2*i-0.1 1+(2*i+0.1)], [0 0],'Color','k','LineWidth',8);
end
ylabel({'Glucose relative fold change' ' to 0nM insulin (%)'})
xlabel('Time (days)');
xlim([1,15])
ylim([0,150])
hold off
grid on

% IR
subplot(2,4,4)
hold on
set(gca,'ytick',0:5:20,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxIR_Study6_100',minIR_Study6_100',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxIR_Study6_10',minIR_Study6_10',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxIR_Study6_5',minIR_Study6_5',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot([0,20],[1,1],'Color', color_blue,'LineWidth',2)
plot(SimStudy6_Vehicle0.time/24,simBestIR_5nM,'Color', color_green,'LineWidth',2)
plot(SimStudy6_Vehicle0.time/24,simBestIR_10nM,'Color', color_yellow,'LineWidth',2)
plot(SimStudy6_Vehicle0.time/24,simBestIR_100nM,'Color', color_red,'LineWidth',2)
for i = 0:6
    line([1+2*i-0.1 1+(2*i+0.1)], [0 0],'Color','k','LineWidth',8);
end
xlabel('Time (days)','FontSmoothing','on');
ylabel({'Hepatic insulin response' ; '(increase from baseline)'},'FontSmoothing','on');
xlim([1,15])
ylim([0,20])
hold off
grid on

%% Conditions

% % legend
%figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'ytick',0:4:12,'xtick',0:12:48,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% plot(SimStudy6_Vehicle0.time-312,simBestG_Vehicle  ,'Color', color_orange,'LineWidth',4)
% plot(SimStudy6_Vehicle100.time-312,simBestG_2xSpheroids0p5Volume,'Color', color_black,'LineWidth',4)
% plot(SimStudy6_Vehicle5.time-312,simBestG_2xSpheroids  ,'Color', color_Lightblue,'LineWidth',4)
% plot(SimStudy6_Vehicle10.time-312,simBestG_0p5Volume ,'Color', color_magenta,'LineWidth',4)
% legend('Control condition', '2xLiver & 0.5xMedium', '2xLiver', '0.5xMedium','Location','North','FontSize',20,'NumColumns',2)
% hold off
% grid on

figure('units','normalized','outerposition',[0 0 1 1])
% Glucose control
subplot(2,3,1)
hold on
set(gca,'ytick',0:4:12,'xtick',0:12:48,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot(SimStudy6_Vehicle0.time-312,simBestG_Vehicle  ,'Color', color_blue,'LineWidth',LineWidthValue)
plot(SimStudy6_Vehicle5.time-312,simBestG_2xSpheroids  ,'Color', color_green,'LineWidth',LineWidthValue)
plot(SimStudy6_Vehicle10.time-312,simBestG_0p5Volume ,'Color', color_yellow,'LineWidth',LineWidthValue)
plot(SimStudy6_Vehicle100.time-312,simBestG_2xSpheroids0p5Volume,'Color', color_red,'LineWidth',LineWidthValue)

[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_Vehicle',minGlucose_Study6_Vehicle',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]-312,[maxTemp', fliplr(minTemp')], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_2xSpheroids',minGlucose_Study6_2xSpheroids',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]-312,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_HalfVolume',minGlucose_Study6_HalfVolume',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]-312,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxGlucose_Study6_2xSpheroidsHalfVolume',minGlucose_Study6_2xSpheroidsHalfVolume',SimStudy6_Vehicle0.time);
fill([timeTemp, fliplr(timeTemp)]-312,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);

errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_vehicle(5:8)   ,Study6_data.G_vehiclestdev(5:8) ,'LineStyle', 'n','Color', color_blue, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_2Spheroids(5:8)   ,Study6_data.G_2Spheroidsstdev(5:8),'LineStyle', 'n','Color', color_green, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_0p5Volume(5:8)  ,Study6_data.G_0p5Volumestdev(5:8),'LineStyle', 'n','Color', color_yellow, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study6_data.timeGlucose(1:4)-24,Study6_data.G_VoS(5:8) ,Study6_data.G_VoSstdev(5:8),'LineStyle', 'n','Color', color_red, 'Marker',marker0, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)

line([-1 1], [0 0],'Color','k','LineWidth',8);
ylabel({'Glucose';'(mM)'},'FontSmoothing','on');
xlabel('Time (h)');
xlim([0,48])
ylim([0,12.5])
legend('Control','2x liver spheroids', '0.5x media volume','2x liver spheroids and 0.5x media volume', 'Location','North','FontSize',15,'NumColumns',4)
hold off
grid on

% Liver functionality
subplot(2,3,2)
hold on
set(gca,'ytick',[1,5,10],'xtick',[1,5,10],'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxLiverFunctionality',minLiverFunctionality',CountLiver);
fill([timeTemp, fliplr(timeTemp)]/1000000,[maxTemp', fliplr(minTemp')], color_gray,'FaceAlpha',0.4,'EdgeAlpha',0.1);
plot(CountLiver/1000000,BestLiverFunctionality,'Color', color_black,'LineWidth',2)
xlabel({'Total cell count (spheroids)'},'FontSmoothing','on');
ylabel({'Metabolic rates' ; '(relative one spheroid)'},'FontSmoothing','on');
xlim([0.9,11])
ylim([0.6,11])
hold off
grid on

