%% Study15 cell assays
figure()

% % legend
% figure()
% hold on
% set(gca,'ytick',0:4:12,'xtick',[0,2,4,6,8,10,12,14],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% ylabel('Glucose (mM)')
% xlabel('Time (days)');
% errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_0(1:12),Study15_data.Glucose_0stdev(1:12),'CapSize',CapSize,'Color', color_blue,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
% errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_0p1(1:12),Study15_data.Glucose_0p1stdev(1:12),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
% errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_10(1:12),Study15_data.Glucose_10stdev(1:12),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
% errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_1000(1:12),Study15_data.Glucose_1000stdev(1:12),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
% legend('Vehicle','Exenatide 0.1 nM','Exenatide 10 nM','Exenatide 1000 nM','Orientation','horizontal')
% hold off


% InSphero GSIS exenatide
subplot(2,2,1)
hold on
set(gca,'ytick',0:100:300,'xtick',2:8,'Xticklabel',{'0^ ','10^-^2','10^-^1','10^0','10^1','10^2','10^3'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title('Fig. S3A')
errorbar(2:8, Study15_data.Mean(9:15), Study15_data.Stdev(9:15),'LineStyle', 'n','Color', color_black, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Insulin';'(mU/L)'})
xlabel({'Exenatide (nM)'},'FontSmoothing','on');
ylim([0,300])
xlim([1.8,8.2])
hold off
grid on

% Study1 Glucose
subplot(2,2,3)
hold on
set(gca,'ytick',0:2:12,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title('Fig. S3B')
ylabel({'Glucose';'(mM)'})
xlabel('Time (days)');
errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_0(1:12),Study15_data.Glucose_0stdev(1:12),'CapSize',CapSize,'Color', color_blue,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_0p1(1:12),Study15_data.Glucose_0p1stdev(1:12),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_10(1:12),Study15_data.Glucose_10stdev(1:12),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study15_data.time(1:12)/24,Study15_data.Glucose_1000(1:12),Study15_data.Glucose_1000stdev(1:12),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0 0],'Color','k','LineWidth',8);
ylim([0 12])
xlim([-0.1 15.2])
hold off
grid on

% Study1 Insulin
subplot(2,2,4)
hold on
set(gca,'ytick',0:2:10,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title('Fig. S3B')
ylabel({'Insulin';'(nM)'})
xlabel('Time (days)');
errorbar(Study15_data.time(1:12)/24   ,Study15_data.Insulin_0(1:12),Study15_data.Insulin_0stdev(1:12),'CapSize',CapSize,'Color', color_blue,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study15_data.time(1:12)/24   ,Study15_data.Insulin_0p1(1:12),Study15_data.Insulin_0p1stdev(1:12),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study15_data.time(1:12)/24   ,Study15_data.Insulin_10(1:12),Study15_data.Insulin_10stdev(1:12),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study15_data.time(1:12)/24   ,Study15_data.Insulin_1000(1:12),Study15_data.Insulin_1000stdev(1:12),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0 0],'Color','k','LineWidth',8);
ylim([0 6])
xlim([-0.1 15.2])
hold off
grid on

%% Study 16 Co-cultures

% % legend
% figure()
% hold on
% set(gca,'ytick',0:4:12,'xtick',[0,2,4,6,8,10,12,14],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
% ylabel('Glucose (mM)')
% xlabel('Time (days)');
% errorbar(Study16_data.time(1:15)/24,Study16_data.GlucoseHCHG_0(1:15),Study16_data.GlucoseHCHG_0stdev(1:15),'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
% errorbar(Study16_data.time(1:15)/24,Study16_data.GlucoseHCHG_1(1:15),Study16_data.GlucoseHCHG_1stdev(1:15),'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
% errorbar(Study16_data.time(1:15)/24,Study16_data.GlucoseLCLG_0(1:15),Study16_data.GlucoseLCLG_0stdev(1:15),'CapSize',CapSize,'Color', color_blue,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
% plot(Study16_data.time(4:6)/24,Study16_data.GlucoseLCLG_0(4:6),'-','Color', color_black, 'MarkerSize',MarkerSize,'LineWidth',1);
% legend('Vehicle (HC+HG+FCS)','Exenatide 1 nM (HC+HG+FCS)','Control (LC+LG+FCS)','Linear regression','Orientation','horizontal')
% hold off

figure()
% Study1 Glucose
subplot(2,2,1)
hold on
set(gca,'ytick',0:4:12,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title('Fig. S4')
ylabel({'Glucose';'(mM)'})
xlabel('Time (days)');
errorbar(Study16_data.time(1:3)/24,Study16_data.GlucoseHCHG_0(1:3),Study16_data.GlucoseHCHG_0stdev(1:3),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(1:3)/24,Study16_data.GlucoseHCHG_1(1:3),Study16_data.GlucoseHCHG_1stdev(1:3),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(1:3)/24,Study16_data.GlucoseLCLG_0(1:3),Study16_data.GlucoseLCLG_0stdev(1:3),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(4:6)/24,Study16_data.GlucoseHCHG_0(4:6),Study16_data.GlucoseHCHG_0stdev(4:6),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(4:6)/24,Study16_data.GlucoseHCHG_1(4:6),Study16_data.GlucoseHCHG_1stdev(4:6),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(4:6)/24,Study16_data.GlucoseLCLG_0(4:6),Study16_data.GlucoseLCLG_0stdev(4:6),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(7:9)/24,Study16_data.GlucoseHCHG_0(7:9),Study16_data.GlucoseHCHG_0stdev(7:9),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(7:9)/24,Study16_data.GlucoseHCHG_1(7:9),Study16_data.GlucoseHCHG_1stdev(7:9),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(7:9)/24,Study16_data.GlucoseLCLG_0(7:9),Study16_data.GlucoseLCLG_0stdev(7:9),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(10:12)/24,Study16_data.GlucoseHCHG_0(10:12),Study16_data.GlucoseHCHG_0stdev(10:12),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(10:12)/24,Study16_data.GlucoseHCHG_1(10:12),Study16_data.GlucoseHCHG_1stdev(10:12),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(10:12)/24,Study16_data.GlucoseLCLG_0(10:12),Study16_data.GlucoseLCLG_0stdev(10:12),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(13:15)/24,Study16_data.GlucoseHCHG_0(13:15),Study16_data.GlucoseHCHG_0stdev(13:15),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(13:15)/24,Study16_data.GlucoseHCHG_1(13:15),Study16_data.GlucoseHCHG_1stdev(13:15),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(13:15)/24,Study16_data.GlucoseLCLG_0(13:15),Study16_data.GlucoseLCLG_0stdev(13:15),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

line([-0.075 0.075]+0, [-1 -1],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [-1 -1],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [-1 -1],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [-1 -1],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [-1 -1],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [-1 -1],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [-1 -1],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [-1 -1],'Color','k','LineWidth',8);
ylim([-1 12])
xlim([-0.1 15.2])
hold off
grid on

% Study1 Insulin
subplot(2,2,2)
hold on
set(gca,'ytick',0:10:30,'xtick',[0,1,3,5,7,9,11,13,15],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
title('Fig. S4')
ylabel({'Insulin';'(nM)'})
xlabel('Time (days)');
errorbar(Study16_data.time(1:3)/24   ,Study16_data.InsulinHCHG_0(1:3),Study16_data.InsulinHCHG_0stdev(1:3),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(1:3)/24   ,Study16_data.InsulinHCHG_1(1:3),Study16_data.InsulinHCHG_1stdev(1:3),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(1:3)/24   ,Study16_data.InsulinLCLG_0(1:3),Study16_data.InsulinLCLG_0stdev(1:3),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(4:6)/24   ,Study16_data.InsulinHCHG_0(4:6),Study16_data.InsulinHCHG_0stdev(4:6),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(4:6)/24   ,Study16_data.InsulinHCHG_1(4:6),Study16_data.InsulinHCHG_1stdev(4:6),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(4:6)/24   ,Study16_data.InsulinLCLG_0(4:6),Study16_data.InsulinLCLG_0stdev(4:6),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(7:9)/24   ,Study16_data.InsulinHCHG_0(7:9),Study16_data.InsulinHCHG_0stdev(7:9),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(7:9)/24   ,Study16_data.InsulinHCHG_1(7:9),Study16_data.InsulinHCHG_1stdev(7:9),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(7:9)/24   ,Study16_data.InsulinLCLG_0(7:9),Study16_data.InsulinLCLG_0stdev(7:9),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(10:12)/24   ,Study16_data.InsulinHCHG_0(10:12),Study16_data.InsulinHCHG_0stdev(10:12),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(10:12)/24   ,Study16_data.InsulinHCHG_1(10:12),Study16_data.InsulinHCHG_1stdev(10:12),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(10:12)/24   ,Study16_data.InsulinLCLG_0(10:12),Study16_data.InsulinLCLG_0stdev(10:12),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

errorbar(Study16_data.time(13:15)/24   ,Study16_data.InsulinHCHG_0(13:15),Study16_data.InsulinHCHG_0stdev(13:15),'CapSize',CapSize,'Color', color_green, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(13:15)/24   ,Study16_data.InsulinHCHG_1(13:15),Study16_data.InsulinHCHG_1stdev(13:15),'CapSize',CapSize,'Color', color_red, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);
errorbar(Study16_data.time(13:15)/24   ,Study16_data.InsulinLCLG_0(13:15),Study16_data.InsulinLCLG_0stdev(13:15),'CapSize',CapSize,'Color', color_blue, 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',1);

line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+9, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+11, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+13, [0 0],'Color','k','LineWidth',8);
ylim([0 30])
xlim([-0.1 15.2])
hold off
grid on