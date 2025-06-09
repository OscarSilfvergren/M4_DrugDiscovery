%% Exp 7.2 ALL
BarWidth     = 0.4;
FillBarWidth = 0.05;
BarPlotVector =[-0.1,0.0,0.1];

% LEGEND
% figure()
% hold on
% set(gca,'ytick',0:500:1500,'xtick',0:1:8,'Xticklabel',{'ULT D0','ULT D10','HC+BSA D7','NC+BSA D7','B27 D7','ULT D7','HC+FCS D10','NC+FCS D10','ULT D10'},'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')
% bar     (-1000,5,BarWidth,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.5)
% bar     (-1000,5,BarWidth,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.5)
% errorbar(-1000,5,1,'LineStyle', 'n','Color', color_black, 'Marker',marker0,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
% errorbar(-1000,5,1,'LineStyle', 'n','Color', color_black, 'Marker',marker16p8,'MarkerSize',MarkerSize16p8,'LineWidth',LineWidthValue)
% errorbar(-1000,5,1 ,'LineStyle', 'n','Color', color_black, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)
% xlim([2000,3000])
% legend('Glucose','Glucose + Exenatide 1 nM','Glucose 0 mM','Glucose 16 mM','Glucose 20 mM','Location','North','FontSize',20,'Orientation','horizontal')
% hold off
% grid on

subplot(2,4,1)
%title({'Day 0: Spheroid batch 4'})
hold on
set(gca,'ytick',0:0.3:1.2,'xtick',3:8,'Xticklabel',{'ULT','Day 7: NC & BSA','Day 7: NC & B27','Day 7: ULT','Day 10: HC & FCS','Day 10: NC & FCS'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')

fill([[-0.1-FillBarWidth, -0.1+FillBarWidth], fliplr([-0.1-FillBarWidth,-0.1+FillBarWidth])]+3,[maxInsulin_Exp8p3GSIS(1), maxInsulin_Exp8p3GSIS(1) , minInsulin_Exp8p3GSIS(1), minInsulin_Exp8p3GSIS(1)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.0-FillBarWidth , 0.0+FillBarWidth] , fliplr([0.0-FillBarWidth,0.0+FillBarWidth])]  +3,[maxInsulin_Exp8p3GSIS(2), maxInsulin_Exp8p3GSIS(2) , minInsulin_Exp8p3GSIS(2), minInsulin_Exp8p3GSIS(2)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.1-FillBarWidth , 0.1+FillBarWidth] , fliplr([0.1-FillBarWidth,0.1+FillBarWidth])]  +3,[maxInsulin_Exp8p3GSIS(3), maxInsulin_Exp8p3GSIS(3) , minInsulin_Exp8p3GSIS(3), minInsulin_Exp8p3GSIS(3)]/1000, color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
bar(BarPlotVector(1)+3,BestInsulin_Exp8p3GSIS(1)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(2)+3,BestInsulin_Exp8p3GSIS(2)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(3)+3,BestInsulin_Exp8p3GSIS(3)/1000,0.05,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.2)
errorbar(BarPlotVector(1)+3, Study12_data.Mean(1)/1000, Study12_data.Stdev(1)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(2)+3, Study12_data.Mean(2)/1000, Study12_data.Stdev(2)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(3)+3, Study12_data.Mean(3)/1000, Study12_data.Stdev(3)/1000    ,'LineStyle', 'n','Color', color_orange, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)

ylabel({'Insulin'; '(nM)'},'FontSmoothing','on');
ylim([0,1.2])
xlim([2.5,3.5])
hold off
grid on

subplot(2,4,2)
%title('Day 7: Spheroid batch 1')
hold on
set(gca,'ytick',0:0.3:1.2,'xtick',4:6,'Xticklabel',{'NC & BSA','NC & B27','ULT'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')

fill([[-0.1-FillBarWidth, -0.1+FillBarWidth], fliplr([-0.1-FillBarWidth,-0.1+FillBarWidth])]+4,[minInsulin_CM2BSA_D7(1), minInsulin_CM2BSA_D7(1) , maxInsulin_CM2BSA_D7(1), maxInsulin_CM2BSA_D7(1)]/1000 , color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.0-FillBarWidth , 0.0+FillBarWidth] , fliplr([0.0-FillBarWidth,0.0+FillBarWidth])]  +4,[minInsulin_CM2BSA_D7(2), minInsulin_CM2BSA_D7(2) , maxInsulin_CM2BSA_D7(2), maxInsulin_CM2BSA_D7(2)]/1000 , color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.1-FillBarWidth , 0.1+FillBarWidth] , fliplr([0.1-FillBarWidth,0.1+FillBarWidth])]  +4,[minInsulin_CM2BSA_D7(3), minInsulin_CM2BSA_D7(3) , maxInsulin_CM2BSA_D7(3), maxInsulin_CM2BSA_D7(3)]/1000 , color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
bar(BarPlotVector(1)+4,BestInsulin_CM2BSA_D7(1)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(2)+4,BestInsulin_CM2BSA_D7(2)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(3)+4,BestInsulin_CM2BSA_D7(3)/1000,0.05,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.2)
errorbar(BarPlotVector(1)+4, Study7_data.ChipGSISmean(1)/1000, Study7_data.ChipGSISstdev(1)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(2)+4, Study7_data.ChipGSISmean(2)/1000, Study7_data.ChipGSISstdev(2)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(3)+4, Study7_data.ChipGSISmean(3)/1000, Study7_data.ChipGSISstdev(3)/1000    ,'LineStyle', 'n','Color', color_orange, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)

fill([[-0.1-FillBarWidth, -0.1+FillBarWidth], fliplr([-0.1-FillBarWidth,-0.1+FillBarWidth])]+5,[minInsulin_CM3_D7(1), minInsulin_CM3_D7(1) , maxInsulin_CM3_D7(1), maxInsulin_CM3_D7(1)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.0-FillBarWidth , 0.0+FillBarWidth] , fliplr([0.0-FillBarWidth,0.0+FillBarWidth])]  +5,[minInsulin_CM3_D7(2), minInsulin_CM3_D7(2) , maxInsulin_CM3_D7(2), maxInsulin_CM3_D7(2)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.1-FillBarWidth , 0.1+FillBarWidth] , fliplr([0.1-FillBarWidth,0.1+FillBarWidth])]  +5,[minInsulin_CM3_D7(3), minInsulin_CM3_D7(3) , maxInsulin_CM3_D7(3), maxInsulin_CM3_D7(3)]/1000, color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
bar(BarPlotVector(1)+5,BestInsulin_CM3_D7(1)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(2)+5,BestInsulin_CM3_D7(2)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(3)+5,BestInsulin_CM3_D7(3)/1000,0.05,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.2)
errorbar(BarPlotVector(1)+5, Study7_data.ChipGSISmean(4)/1000, Study7_data.ChipGSISstdev(4)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(2)+5, Study7_data.ChipGSISmean(5)/1000, Study7_data.ChipGSISstdev(5)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(3)+5, Study7_data.ChipGSISmean(6)/1000, Study7_data.ChipGSISstdev(6)/1000    ,'LineStyle', 'n','Color', color_orange, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)

fill([[-0.1-FillBarWidth, -0.1+FillBarWidth], fliplr([-0.1-FillBarWidth,-0.1+FillBarWidth])]+6,[minInsulin_ULT_d7(1), minInsulin_ULT_d7(1) , maxInsulin_ULT_d7(1), maxInsulin_ULT_d7(1)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.0-FillBarWidth , 0.0+FillBarWidth] , fliplr([0.0-FillBarWidth,0.0+FillBarWidth])]  +6,[minInsulin_ULT_d7(2), minInsulin_ULT_d7(2) , maxInsulin_ULT_d7(2), maxInsulin_ULT_d7(2)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.1-FillBarWidth , 0.1+FillBarWidth] , fliplr([ 0.1-FillBarWidth,0.1+FillBarWidth])] +6,[minInsulin_ULT_d7(3), minInsulin_ULT_d7(3) , maxInsulin_ULT_d7(3), maxInsulin_ULT_d7(3)]/1000, color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
bar(BarPlotVector(1)+6,BestInsulin_ULT_d7(1)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(2)+6,BestInsulin_ULT_d7(2)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(BarPlotVector(3)+6,BestInsulin_ULT_d7(3)/1000,0.05,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.2)
errorbar(BarPlotVector(1)+6, Study7_data.ChipGSISmean(7)/1000, Study7_data.ChipGSISstdev(7)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(2)+6, Study7_data.ChipGSISmean(8)/1000, Study7_data.ChipGSISstdev(8)/1000    ,'LineStyle', 'n','Color', color_blue, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)
errorbar(BarPlotVector(3)+6, Study7_data.ChipGSISmean(9)/1000, Study7_data.ChipGSISstdev(9)/1000  ,'LineStyle', 'n','Color', color_orange, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)

ylabel({'Insulin'; '(nM)'},'FontSmoothing','on');
ylim([0,1.2])
xlim([3.7,6.3])
hold off
grid on

subplot(2,4,3)
%title('Day 10: Spheroid batch 2')
hold on
set(gca,'ytick',0:0.3:1.2,'xtick',7:8,'Xticklabel',{'HC & FCS','NC & FCS'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')

fill([[-0.05-FillBarWidth, -0.05+FillBarWidth], fliplr([-0.05-FillBarWidth,-0.05+FillBarWidth])]+7,[minInsulin_CM1_FCSd10(1), minInsulin_CM1_FCSd10(1) , maxInsulin_CM1_FCSd10(1), maxInsulin_CM1_FCSd10(1)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.05-FillBarWidth, 0.05+FillBarWidth], fliplr([0.05-FillBarWidth,0.05+FillBarWidth])]+7,[minInsulin_CM1_FCSd10(2), minInsulin_CM1_FCSd10(2) , maxInsulin_CM1_FCSd10(2), maxInsulin_CM1_FCSd10(2)]/1000, color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
bar(-0.05+7,BestInsulin_CM1_FCSd10(1)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(0.05+7,BestInsulin_CM1_FCSd10(2)/1000,0.05,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.2)
errorbar([-0.05]+7, Study7_data.ChipGSISmean2(1)/1000, Study7_data.ChipGSISstdev2(1)/1000 ,'LineStyle', 'n','Color', color_blue, 'Marker',marker16p8,'MarkerSize',MarkerSize16p8,'LineWidth',LineWidthValue)
errorbar([0.05] +7, Study7_data.ChipGSISmean2(2)/1000, Study7_data.ChipGSISstdev2(2)/1000 ,'LineStyle', 'n','Color', color_orange, 'Marker',marker16p8,'MarkerSize',MarkerSize16p8,'LineWidth',LineWidthValue)

fill([[-0.05-FillBarWidth, -0.05+FillBarWidth], fliplr([-0.05-FillBarWidth,-0.05+FillBarWidth])]+8,[minInsulin_CM2_FCSd10(1), minInsulin_CM2_FCSd10(1) , maxInsulin_CM2_FCSd10(1), maxInsulin_CM2_FCSd10(1)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
fill([[0.05-FillBarWidth , 0.05+FillBarWidth] , fliplr([0.05-FillBarWidth,0.05+FillBarWidth])]  +8,[minInsulin_CM2_FCSd10(2), minInsulin_CM2_FCSd10(2) , maxInsulin_CM2_FCSd10(2), maxInsulin_CM2_FCSd10(2)]/1000, color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1);
bar(-0.05+8,BestInsulin_CM2_FCSd10(1)/1000,0.05,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar(0.05+8,BestInsulin_CM2_FCSd10(2)/1000,0.05,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.2)
errorbar([-0.05]+8, Study7_data.ChipGSISmean2(3)/1000, Study7_data.ChipGSISstdev2(3)/1000     ,'LineStyle', 'n','Color', color_blue, 'Marker',marker16p8,'MarkerSize',MarkerSize16p8,'LineWidth',LineWidthValue)
errorbar([0.05] +8, Study7_data.ChipGSISmean2(4)/1000, Study7_data.ChipGSISstdev2(4)/1000     ,'LineStyle', 'n','Color', color_orange, 'Marker',marker16p8,'MarkerSize',MarkerSize16p8,'LineWidth',LineWidthValue)

ylabel({'Insulin'; '(nM)'},'FontSmoothing','on');
ylim([0,1.2])
xlim([6.7,8.3])
hold off
grid on

load('BH5ref_data') 

BarWidth     = 0.3;
FillBarWidth = 0.04;
BarPlotSpacing = [-0.1,0,0.1];

BH5ref_data.G0(1:4)     = BH5ref_data.G0(1:4)   * simBH5ref_GSIS.Uncertainty;

subplot(2,4,4)
hold on
%title('ULT: Spheroid batch 5')
set(gca,'ytick',0:15:75,'xtick',0:1:3,'Xticklabel',{'Day 7  ','Day 14 ',' Day 21','  Day 28'},'FontSize', 19,'FontSmoothing','on','fontname','Arial')
%legend
bar     (-1000,5,BarWidth,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.2)
bar     (-1000,5,BarWidth,'FaceColor',color_orange,'LineWidth',1,'FaceAlpha',0.2)
errorbar(-50,5,2,'LineStyle', 'n','Color', color_black, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(-50,5,2,'LineStyle', 'n','Color', color_black, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)
%legend
fill([[BarPlotSpacing(1)-FillBarWidth, BarPlotSpacing(1)+FillBarWidth], fliplr([BarPlotSpacing(1)-FillBarWidth,BarPlotSpacing(1)+FillBarWidth])]+0,[minInsulin_BH5refD0(1), minInsulin_BH5refD0(1) , maxInsulin_BH5refD0(1), maxInsulin_BH5refD0(1)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(2)-FillBarWidth, BarPlotSpacing(2)+FillBarWidth], fliplr([BarPlotSpacing(2)-FillBarWidth,BarPlotSpacing(2)+FillBarWidth])]+0,[minInsulin_BH5refD0(2), minInsulin_BH5refD0(2) , maxInsulin_BH5refD0(2), maxInsulin_BH5refD0(2)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(3)-FillBarWidth, BarPlotSpacing(3)+FillBarWidth], fliplr([BarPlotSpacing(3)-FillBarWidth,BarPlotSpacing(3)+FillBarWidth])]+0,[minInsulin_BH5refD0(3), minInsulin_BH5refD0(3) , maxInsulin_BH5refD0(3), maxInsulin_BH5refD0(3)], color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1)

fill([[BarPlotSpacing(1)-FillBarWidth, BarPlotSpacing(1)+FillBarWidth], fliplr([BarPlotSpacing(1)-FillBarWidth,BarPlotSpacing(1)+FillBarWidth])]+1,[minInsulin_BH5refD14(1), minInsulin_BH5refD14(1) , maxInsulin_BH5refD14(1), maxInsulin_BH5refD14(1)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(2)-FillBarWidth, BarPlotSpacing(2)+FillBarWidth], fliplr([BarPlotSpacing(2)-FillBarWidth,BarPlotSpacing(2)+FillBarWidth])]+1,[minInsulin_BH5refD14(2), minInsulin_BH5refD14(2) , maxInsulin_BH5refD14(2), maxInsulin_BH5refD14(2)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(3)-FillBarWidth, BarPlotSpacing(3)+FillBarWidth], fliplr([BarPlotSpacing(3)-FillBarWidth,BarPlotSpacing(3)+FillBarWidth])]+1,[minInsulin_BH5refD14(3), minInsulin_BH5refD14(3) , maxInsulin_BH5refD14(3), maxInsulin_BH5refD14(3)], color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1)

fill([[BarPlotSpacing(1)-FillBarWidth, BarPlotSpacing(1)+FillBarWidth], fliplr([BarPlotSpacing(1)-FillBarWidth,BarPlotSpacing(1)+FillBarWidth])]+2,[minInsulin_BH5refD21(1), minInsulin_BH5refD21(1) , maxInsulin_BH5refD21(1), maxInsulin_BH5refD21(1)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(2)-FillBarWidth, BarPlotSpacing(2)+FillBarWidth], fliplr([BarPlotSpacing(2)-FillBarWidth,BarPlotSpacing(2)+FillBarWidth])]+2,[minInsulin_BH5refD21(2), minInsulin_BH5refD21(2) , maxInsulin_BH5refD21(2), maxInsulin_BH5refD21(2)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(3)-FillBarWidth, BarPlotSpacing(3)+FillBarWidth], fliplr([BarPlotSpacing(3)-FillBarWidth,BarPlotSpacing(3)+FillBarWidth])]+2,[minInsulin_BH5refD21(3), minInsulin_BH5refD21(3) , maxInsulin_BH5refD21(3), maxInsulin_BH5refD21(3)], color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1)

fill([[BarPlotSpacing(1)-FillBarWidth, BarPlotSpacing(1)+FillBarWidth], fliplr([BarPlotSpacing(1)-FillBarWidth,BarPlotSpacing(1)+FillBarWidth])]+3,[minInsulin_BH5refD28(1), minInsulin_BH5refD28(1) , maxInsulin_BH5refD28(1), maxInsulin_BH5refD28(1)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(2)-FillBarWidth, BarPlotSpacing(2)+FillBarWidth], fliplr([BarPlotSpacing(2)-FillBarWidth,BarPlotSpacing(2)+FillBarWidth])]+3,[minInsulin_BH5refD28(2), minInsulin_BH5refD28(2) , maxInsulin_BH5refD28(2), maxInsulin_BH5refD28(2)], color_blue,'FaceAlpha',0.2,'EdgeAlpha', 0.1)
fill([[BarPlotSpacing(3)-FillBarWidth, BarPlotSpacing(3)+FillBarWidth], fliplr([BarPlotSpacing(3)-FillBarWidth,BarPlotSpacing(3)+FillBarWidth])]+3,[minInsulin_BH5refD28(3), minInsulin_BH5refD28(3) , maxInsulin_BH5refD28(3), maxInsulin_BH5refD28(3)], color_orange,'FaceAlpha',0.2,'EdgeAlpha', 0.1)

errorbar((0:1:3)-0.1,BH5ref_data.G0(1:4)./BH5ref_data.G0(1:4)   ,BH5ref_data.G0stdev(1:4)./BH5ref_data.G0(1:4)   ,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar((0:1:3)    ,BH5ref_data.G20(1:4)./BH5ref_data.G0(1:4)  ,BH5ref_data.G20stdev(1:4)./BH5ref_data.G0(1:4)  ,'LineStyle', 'n','Color', color_blue, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)
errorbar((0:1:3)+0.1,BH5ref_data.G20e1(1:4)./BH5ref_data.G0(1:4),BH5ref_data.G20e1stdev(1:4)./BH5ref_data.G0(1:4),'LineStyle', 'n','Color', color_orange, 'Marker',marker20,'MarkerSize',MarkerSize20,'LineWidth',LineWidthValue)

bar([-0.1,0,0.1],BestInsulin_BH5refD0,BarWidth,'FaceColor', color_black,'LineWidth',1,'FaceAlpha',0.2)
bar([-0.1,0,0.1]+1,BestInsulin_BH5refD14,BarWidth,'FaceColor',color_black,'LineWidth',1,'FaceAlpha',0.2)
bar([-0.1,0,0.1]+2,BestInsulin_BH5refD21,BarWidth,'FaceColor',color_black,'LineWidth',1,'FaceAlpha',0.2)
bar([-0.1,0,0.1]+3,BestInsulin_BH5refD28,BarWidth,'FaceColor',color_black,'LineWidth',1,'FaceAlpha',0.2)

%legend('Glucose','Glucose + 1nM Exenatide','Glucose 0nM','Glucose 20nM','Location','North','FontSize',LegendSize)
ylabel({'Insulin';'(fold change to basal)'},'FontSmoothing','on');
ylim([0,60])
xlim([-0.2,3.2])
hold off
grid on
load('BH5ref_data') 

%%

% Glucose response
figure()
subplot(2,4,1)
hold on
set(gca,'xtick',[0,2.8,5.5,8,11.1,16.8,20.1],'ytick',0:0.25:1,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((0:0.1:25)-100   ,BestInsulin_Study10GR,'Color', color_blue,'LineWidth',2)
plot((0:0.1:25)-100   ,BestInsulin_Study8GR,'Color', color_green,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxInsulin_Study8GR,minInsulin_Study8GR,0:0.1:25);
fill([timeTemp, fliplr(timeTemp)]+0.1,[maxTemp, fliplr(minTemp)]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxInsulin_Study10GR,minInsulin_Study10GR,0:0.1:25);
fill([timeTemp, fliplr(timeTemp)]-0.1,[maxTemp, fliplr(minTemp)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot((0:0.1:25)+0.1    ,BestInsulin_Study8GR/1000,'Color', color_green,'LineWidth',2)
plot((0:0.1:25)-0.1    ,BestInsulin_Study10GR/1000,'Color', color_blue,'LineWidth',2)
errorbar((Study8_data.Glucose)+0.1,Study8_data.Insulin/1000,Study8_data.InsulinSEM/1000,'LineStyle', 'n','Color', color_green, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar((Study10_data.GlucoseR(1:4))-0.1, Study10_data.RInsulinMean(1:4)/1000, Study10_data.RInsulinSEM(1:4)/1000,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
xtickangle(45)
ylabel({'Insulin'; '(nM)'},'FontSmoothing','on');
xlabel({'Glucose (mM)'},'FontSmoothing','on');
legend('EndoC batch 1','EndoC batch 3','Location','North','FontSize',15)
ylim( [0 1])
xlim( [-0.5 21])
hold off
grid on

% Ref data glucose response
subplot(2,4,2)
hold on
set(gca,'xtick',[0,2.8,5.5,8,11.1,16.8],'ytick',0:4:30,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((0:0.1:25)-100    ,BestInsulin_Study8GR,'Color', color_red,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxInsulin_BH5refGR,minInsulin_BH5refGR,0:0.1:25);
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot    (0:0.1:25, BestInsulin_BH5refGR,'Color', color_red,'LineWidth',2)
errorbar(BH5ref_data.GR(1:6), BH5ref_data.InsulinGR(1:6)./BH5ref_data.InsulinGR(1), BH5ref_data.InsulinGRstdev(1:6)./BH5ref_data.InsulinGR(1),'LineStyle', 'n','Color', color_red, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
xtickangle(45)
ylabel({'Insulin ';'(fold change to basal)'},'FontSmoothing','on');
xlabel({'Glucose (mM)'},'FontSmoothing','on');
legend('EndoC batch 5','Location','North','FontSize',15,'Orientation','horizontal')
ylim( [0 16])
xlim( [-0.5 21])
hold off
grid on

%%
figure()

% GSIS exenatide
subplot(2,4,1)
hold on
set(gca,'ytick',0:0.5:1.5,'xtick',0:1:5,'Xticklabel',{'0^ ','10^-^2  ','10^-^1','10^0','10^1','10^2'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((0:1:5)-100    ,BestInsulin_Study10ER/1000,'Color', color_blue,'LineWidth',2)
plot((0:1:5)+100    ,BestInsulin_Study8ER/1000,'Color', color_green,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxInsulin_Study8ER,minInsulin_Study8ER,[0:1:5]);
fill([timeTemp, fliplr(timeTemp)]+0.05,[maxTemp, fliplr(minTemp)]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxInsulin_Study10ER,minInsulin_Study10ER,[0:1:5]);
fill([timeTemp, fliplr(timeTemp)]-0.05,[maxTemp, fliplr(minTemp)]/1000, color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot((0:1:5)+0.05    ,BestInsulin_Study8ER/1000,'Color', color_green,'LineWidth',2)
plot((0:1:5)-0.05    ,BestInsulin_Study10ER/1000,'Color', color_blue,'LineWidth',2)
errorbar((0:1:5)+0.05,Study8_data.Insulin1(1:6)/1000,Study8_data.InsulinSEM1(1:6)/1000   ,'LineStyle', 'n','Color', color_green, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar((0:1:5)-0.05,Study10_data.DRInsulinMean(1:6)/1000, Study10_data.DRInsulinSEM(1:6)/1000,'LineStyle', 'n','Color', color_blue, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
legend('EndoC batch 1','EndoC batch 3','Location','North','FontSize',15)
ylabel({'Insulin '; '(nM)'},'FontSmoothing','on');
xlabel({'Exenatide (nM)'},'FontSmoothing','on');
ylim([0,1.5])
xlim([-0.2,5.2])
hold off
grid on

% Ref data exenatide response
subplot(2,3,2)
hold on
set(gca,'ytick',0:1.5:5,'xtick',0:1:14,'Xticklabel',BH5ref_data.ER(1:15)*1000,'FontSize', 20,'FontSmoothing','on','fontname','Arial')
plot((0:0.1:25)-100    ,BestInsulin_Study8GR,'Color', color_red,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxInsulin_BH5refER,minInsulin_BH5refER,0:1:14');
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot    (0:1:14, simBH5ref_GSIS.ER./simBH5ref_GSIS.ER(1)   ,'LineWidth',2,'Color', color_red)
errorbar(0:1:14, BH5ref_data.InsulinER(1:15)./BH5ref_data.InsulinER(1), BH5ref_data.InsulinERstdev(1:15)./BH5ref_data.InsulinER(1),'LineStyle', 'n','Color', color_red, 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
xtickangle(90)
legend('EndoC batch 5','Location','North','FontSize',15,'Orientation','horizontal')
ylabel({'Insulin ';'(fold change to basal)'},'FontSmoothing','on');
xlabel({'Exenatide (pM)'},'FontSmoothing','on');
ylim([0,4.5])
xlim( [-0.2 14.2])
hold off
grid on

%% Exp 8.3

% % LEGEND
% figure()
% hold on
% set(gca,'ytick',0:500:1500,'xtick',0:1:8,'Xticklabel',{'ULT D0','ULT D10','HC+BSA D7','NC+BSA D7','B27 D7','ULT D7','HC+FCS D10','NC+FCS D10','ULT D10'},'FontSize', TextSize,'FontSmoothing','on','fontname','Arial')
% plot(simExp8p3_Hcontrol.time/24, BestExp8p3_Insulin0/1000   ,'Color', color_green   ,'LineWidth',2)
% plot(simExp8p3_H0p1.time    /24, BestExp8p3_Insulin0p1/1000 ,'Color', color_yellow   ,'LineWidth',2)
% plot(simExp8p3_H10.time     /24, BestExp8p3_Insulin10/1000  ,'Color', color_red   ,'LineWidth',2)
% plot(simExp8p3_Hcontrol.time/24, BestExp8p3_Insulin0/1000   ,'LineStyle', '-','Color', color_black   ,'LineWidth',2)
% plot(simExp8p3_H0p1.time    /24, BestExp8p3_Insulin0p1/1000 ,'LineStyle', ':','Color', color_black   ,'LineWidth',2)
% legend('Vehicle','Exenatide 0.1 nM','Exenatide 10 nM','HC & B27','LC & B27','Location','North','FontSize',20,'Orientation','horizontal')
% hold off
% grid on

figure()

subplot(2,3,1)
hold on
set(gca,'ytick',0:5:15,'xtick',[0,1,3,5,7,9,11,13,16],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Insulin0d,maxStudy11_Insulin0d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Insulin0p1d,maxStudy11_Insulin0p1d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Insulin10d,maxStudy11_Insulin10d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy11_Dcontrol.time/24, BestStudy11_Insulin0d/1000 ,'Color', color_green   ,'LineWidth',2)
plot(simStudy11_D0p1.time    /24, BestStudy11_Insulin0p1d/1000         ,'Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_D10.time     /24, BestStudy11_Insulin10d/1000           ,'Color', color_red   ,'LineWidth',2)
errorbar(Study11_data.timeInsulin/24,Study11_data.dInsulin0,Study11_data.dInsulin0SEM,'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeInsulin/24,Study11_data.dInsulin0p1,Study11_data.dInsulin0p1SEM,'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeInsulin/24,Study11_data.dInsulin10,Study11_data.dInsulin10SEM,'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
ylabel({'Insulin'; '(nM)'},'FontSmoothing','on');
xlabel('Time (days)');
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
ylim([0 18])
xlim([-0.1 9.1])
hold off
grid on

subplot(2,3,2)
hold on
set(gca,'ytick',0:3:12,'xtick',[0,1,3,5,7,9,11,13,16],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Glucose0d,maxStudy11_Glucose0d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Glucose0p1d,maxStudy11_Glucose0p1d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Glucose10d,maxStudy11_Glucose10d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy11_Dcontrol.time/24, BestStudy11_Glucose0d ,'Color', color_green   ,'LineWidth',2)
plot(simStudy11_D0p1.time    /24, BestStudy11_Glucose0p1d    ,'Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_D10.time     /24, BestStudy11_Glucose10d      ,'Color', color_red   ,'LineWidth',2)
errorbar(Study11_data.timeGlucose(1:17)/24,Study11_data.dGlucose0(1:17),Study11_data.dGlucose0SEM(1:17)    ,'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeGlucose(1:17)/24,Study11_data.dGlucose0p1(1:17),Study11_data.dGlucose0p1SEM(1:17),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeGlucose(1:17)/24,Study11_data.dGlucose10(1:17),Study11_data.dGlucose10SEM(1:17)  ,'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
ylabel({'Glucose'; '(mM)'},'FontSmoothing','on');
xlabel('Time (days)');
ylim([0 14])
xlim([-0.1 9.1])
hold off
grid on

subplot(2,3,3)
hold on
set(gca,'ytick',0:3:12,'xtick',[0,1,3,5,7,9,11,13,16],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Lactate0d,minStudy11_Lactate0d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Lactate0p1d,minStudy11_Lactate0p1d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Lactate10d,minStudy11_Lactate10d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy11_Dcontrol.time/24, BestStudy11_Lactate0d           ,'Color', color_green   ,'LineWidth',2)
plot(simStudy11_D0p1.time    /24, BestStudy11_Lactate0p1d         ,'Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_D10.time     /24, BestStudy11_Lactate10d           ,'Color', color_red   ,'LineWidth',2)
errorbar(Study11_data.timeLactate(1:5)/24,Study11_data.dLactate0(1:5),Study11_data.dLactate0SEM(1:5)    ,'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeLactate(1:5)/24,Study11_data.dLactate0p1(1:5),Study11_data.dLactate0p1SEM(1:5),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeLactate(1:5)/24,Study11_data.dLactate10(1:5),Study11_data.dLactate10SEM(1:5)  ,'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
ylabel({'Lactate'; '(mM)'},'FontSmoothing','on');
xlabel('Time (days)');
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
ylim([0 14])
xlim([-0.1 9.1])
hold off
grid on

% GTT
subplot(2,3,4)
hold on
set(gca,'ytick',0:5:15,'xtick',[0,1,3,5,7,9,11,13,16],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Insulin0,maxStudy11_Insulin0,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Insulin0p1,maxStudy11_Insulin0p1,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Insulin10,maxStudy11_Insulin10,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')]/1000, color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy11_Hcontrol.time/24, BestStudy11_Insulin0/1000   ,'LineStyle', ':','Color', color_green   ,'LineWidth',2)
plot(simStudy11_H0p1.time    /24, BestStudy11_Insulin0p1/1000 ,'LineStyle', ':','Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_H10.time     /24, BestStudy11_Insulin10/1000  ,'LineStyle', ':','Color', color_red   ,'LineWidth',2)
errorbar(Study11_data.timeInsulin/24,Study11_data.hInsulin0,Study11_data.hInsulin0SEM,'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeInsulin/24,Study11_data.hInsulin0p1,Study11_data.hInsulin0p1SEM,'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeInsulin/24,Study11_data.hInsulin10,Study11_data.hInsulin10SEM,'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
ylabel({'Insulin'; '(nM)'},'FontSmoothing','on');
xlabel('Time (days)');
ylim([0 18])
xlim([-0.1 9.1])
hold off
grid on

subplot(2,3,5)
hold on
set(gca,'ytick',0:3:12,'xtick',[0,1,3,5,7,9,11,13,16],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Glucose0,maxStudy11_Glucose0,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Glucose0p1,maxStudy11_Glucose0p1,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(minStudy11_Glucose10,maxStudy11_Glucose10,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy11_Hcontrol.time/24, BestStudy11_Glucose0   ,'LineStyle', ':','Color', color_green   ,'LineWidth',2)
plot(simStudy11_H0p1.time    /24, BestStudy11_Glucose0p1 ,'LineStyle', ':','Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_H10.time     /24, BestStudy11_Glucose10  ,'LineStyle', ':','Color', color_red   ,'LineWidth',2)
errorbar(Study11_data.timeGlucose(1:17)/24,Study11_data.hGlucose0(1:17),Study11_data.hGlucose0SEM(1:17)    ,'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeGlucose(1:17)/24,Study11_data.hGlucose0p1(1:17),Study11_data.hGlucose0p1SEM(1:17),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeGlucose(1:17)/24,Study11_data.hGlucose10(1:17),Study11_data.hGlucose10SEM(1:17)  ,'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
ylabel({'Glucose'; '(mM)'},'FontSmoothing','on');
xlabel('Time (days)');
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
ylim([0 14])
xlim([-0.1 9.1])
hold off
grid on

subplot(2,3,6)
hold on
set(gca,'ytick',0:3:12,'xtick',[0,1,3,5,7,9,11,13,16],'FontSize', 20,'FontSmoothing','on','fontname','Arial')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Lactate0,minStudy11_Lactate0,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Lactate0p1,minStudy11_Lactate0p1,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Lactate10,minStudy11_Lactate10,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
plot(simStudy11_Hcontrol.time/24, BestStudy11_Lactate0    ,'LineStyle', ':','Color', color_green   ,'LineWidth',2)
plot(simStudy11_H0p1.time    /24, BestStudy11_Lactate0p1  ,'LineStyle', ':','Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_H10.time     /24,BestStudy11_Lactate10    ,'LineStyle', ':','Color', color_red   ,'LineWidth',2)
errorbar(Study11_data.timeLactate(1:5)/24,Study11_data.hLactate0(1:5),Study11_data.hLactate0SEM(1:5)    ,'CapSize',CapSize,'Color', color_green,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeLactate(1:5)/24,Study11_data.hLactate0p1(1:5),Study11_data.hLactate0p1SEM(1:5),'CapSize',CapSize,'Color', color_yellow,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
errorbar(Study11_data.timeLactate(1:5)/24,Study11_data.hLactate10(1:5),Study11_data.hLactate10SEM(1:5)  ,'CapSize',CapSize,'Color', color_red,'LineStyle', 'n', 'Marker',marker, 'MarkerSize',MarkerSize,'LineWidth',LineWidthValue);
line([-0.075 0.075]+0, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0 0],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0 0],'Color','k','LineWidth',8);
ylabel({'Lactate'; '(mM)'},'FontSmoothing','on');
xlabel('Time (days)');
ylim([0 14])
xlim([-0.1 9.1])
hold off
grid on

figure()
subplot(2,3,4)
hold on
set(gca,'xtick',[0,1,3,5,7,9],'ytick',[0.1,1,10],'FontSize', 20,'FontSmoothing','on','fontname','Arial','YScale','log')
title('PK - Fig. S1')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Exenatide0p1,minStudy11_Exenatide0p1,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Exenatide10,minStudy11_Exenatide10,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);

[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Exenatide0p1d,minStudy11_Exenatide0p1d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_yellow,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxStudy11_Exenatide10d,minStudy11_Exenatide10d,simStudy11_Hcontrol.time);
fill([timeTemp, fliplr(timeTemp)]/24,[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);

plot(simStudy11_D0p1.time    /24,BestStudy11_Exenatide0p1         ,'LineStyle', ':','Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_D10.time     /24,BestStudy11_Exenatide10          ,'LineStyle', ':','Color', color_red   ,'LineWidth',2)
plot(simStudy11_D0p1.time    /24,BestStudy11_Exenatide0p1d        ,'Color', color_yellow   ,'LineWidth',2)
plot(simStudy11_D10.time     /24,BestStudy11_Exenatide10d         ,'Color', color_red   ,'LineWidth',2)
errorbar(Study11_data.ETime(1:8)/24,Study11_data.dE0p1(1:8),Study11_data.dE0p1SEM(1:8),'Color', color_yellow,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study11_data.ETime(1:8)/24,Study11_data.hE0p1(1:8),Study11_data.hE0p1SEM(1:8),'Color', color_yellow,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study11_data.ETime(1:8)/24,Study11_data.dE10(1:8),Study11_data.dE10SEM(1:8)  ,'Color', color_red,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
errorbar(Study11_data.ETime(1:8)/24,Study11_data.hE10(1:8),Study11_data.hE10SEM(1:8)  ,'Color', color_red,'LineStyle', 'n', 'Marker',marker,'MarkerSize',MarkerSize,'LineWidth',LineWidthValue)
ylabel({'Exenatide'; '(nM)'},'FontSmoothing','on');
xlabel({'Time (days)'},'FontSmoothing','on');
xlim( [0 9.1])
ylim( [0.015 20])
line([-0.075 0.075]+0, [0.015 0.015],'Color','k','LineWidth',8);
line([-0.075 0.075]+1, [0.015 0.015],'Color','k','LineWidth',8);
line([-0.075 0.075]+3, [0.015 0.015],'Color','k','LineWidth',8);
line([-0.075 0.075]+5, [0.015 0.015],'Color','k','LineWidth',8);
line([-0.075 0.075]+7, [0.015 0.015],'Color','k','LineWidth',8);
legend('0.1nM','10nM','Media change')
grid on
hold off