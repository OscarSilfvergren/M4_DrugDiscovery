LoadAll
[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param] = IQMparameters(model);

%% Index parameters
% Where index 1=HC, 2=LC , 3=FCS , 4=B27 , 5=BSA , 6=SM, ULT=7

load('ModelUncertainty_paramsFull')
[row column] = size(ModelUncertainty_params);
CostIndex = ModelUncertainty_params(:,column);
CostSize = 1./(CostIndex./max(CostIndex)).^13;

[ParameterIndexEndoC,ParameterIndexInSphero,ParameterIndex] = ReStrucOptimisedParams (ModelUncertainty_params(:,1:column-1),AmountParameterOpti,pNames(1:AmountParameterOpti));

%% LEGENDS

% batch-batch variability legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% plot([0],[1],'LineStyle', 'n','Color', color_1, 'Marker','.','MarkerSize',30)
% plot([0],[0],'LineStyle', 'n','Color', color_2, 'Marker','.','MarkerSize',30)
% plot([0],[0],'LineStyle', 'n','Color', color_3, 'Marker','.','MarkerSize',30)
% plot([0],[0],'LineStyle', 'n','Color', color_4, 'Marker','.','MarkerSize',30)
% plot([0],[0],'LineStyle', 'n','Color', color_6, 'Marker','.','MarkerSize',30)
% legend('1','2','3','4','5','FontSize',15,'Orientation','horizontal','NumColumns',6)
% hold off
% grid on


%Human islets donor-donor variability legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'XTick',[0.1,1,10],'YTick',1:1:3,'YTickLabel',{'Exenatide ECmax','Exenatide EC50','Initial functionality'},'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
% plot(0.000001,0.000001,'Color', color_3b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001, 'Color', color_4b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_5b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_6b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_7b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_8b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_9b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_10b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_11b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% plot(0.000001,0.000001,'Color', color_12b, 'Marker','.','MarkerSize',30,'LineStyle', 'n')
% legend('1','2','3','4','5','6','7','8','9','10','FontSize',15,'NumColumns',5,'Orientation','horizontal')
% hold off
% grid on

% %batch-batch variability legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% plot([1,1],[1,1],'Color', color_1,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_2,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_3,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_4,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_6,'LineWidth',24)
% legend('1','2','3','4','5','FontSize',15,'Orientation','horizontal','NumColumns',6)
% hold off
% grid on


% %Human islets donor-donor variability legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'XTick',[0.1,1,10],'YTick',1:1:3,'YTickLabel',{'Exenatide ECmax','Exenatide EC50','Initial functionality'},'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
% plot([1,1],[1,1],'Color', color_3b,'LineWidth',24)
% plot([1,1],[1,1], 'Color', color_4b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_5b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_6b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_7b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_8b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_9b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_10b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_11b,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_12b,'LineWidth',24)
% legend('1','2','3','4','5','6','7','8','9','10','FontSize',15,'NumColumns',5,'Orientation','horizontal')
% hold off
% grid on

% % Media legend human islets
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'XTick',[0.1,0.5,1,2,10],'YTick',1:1:11,'YTickLabel',yaxisLabels,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
% plot([1,1],[1,1],'Color', color_8,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_blue*0.6 ,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_red*1  ,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_4,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_6,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_7,'LineWidth',24)
% legend('SM','HC', 'LC','FCS','B27','BSA','FontSize',LegendSize,'NumColumns',4)
% hold off
% grid on
 
% % Media legend EndoC
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'XTick',[0.1,0.5,1,2,10],'YTick',1:1:11,'YTickLabel',yaxisLabels,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
% plot([1,1],[1,1],'Color', color_9,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_blue*1.1 ,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_red*1.5 ,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_4,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_6,'LineWidth',24)
% plot([1,1],[1,1],'Color', color_7,'LineWidth',24)
% legend('SM','HC', 'LC','FCS','B27','BSA','FontSize',LegendSize,'NumColumns',4)
% hold off
% grid on

% % Media legend HepaRG
% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,2,1)
% hold on
% set(gca,'XTick',[0.1,0.5,1,2,10],'YTick',1:1:11,'YTickLabel',yaxisLabels,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
%  plot([1,1],[1,1],'Color', color_green*1.2  ,'LineWidth',24)
%  plot([1,1],[1,1],'Color', color_green*0.6,'LineWidth',24)
%  plot([1,1],[1,1],'Color', color_4,'LineWidth',24)
%  plot([1,1],[1,1],'Color', color_6,'LineWidth',24)% Legend
% legend('HC', 'LC','FCS','B27','FontSize',LegendSize,'NumColumns',4)
% ylim([0.5,5.5])
% xlim([0.1,10])
% hold off
% grid on

% Insulin resistance: legend
% figure('units','normalized','outerposition',[0 0 1 1])
% set(gca,'ytick',0:5:25,'xtick',1:1:4,'XTickLabel',{'HC','LC','FCS','B27'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
% hold on
% plot([0,1],[0,1],'Color', color_green,'LineWidth',4)
% plot([0,1],[0,1],'Color', color_yellow,'LineWidth',4)
% plot([0,1],[0,1],'Color', color_red,'LineWidth',4)
% legend('Initial','Glucose-time dependent','Condition-time dependent','NumColumns',3)
% grid on
% hold off

% Media impact on metabolic variables: legend
% subplot(2,3,1)
% hold on
% set(gca,'XTick',[0.1,1,10],'YTick',[0.7,1.3,2,3,4,5,6,7],'YTickLabel',yaxisLabels,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
% xlabel({'LC is higher                            HC is higher'},'FontSmoothing','on');
%     plot(HepaRGFunctionality50_cortesol(1),2.9,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',30,'LineWidth',LineWidthValue)
%     plot(HumanFunctionality50_cortesol(1),3,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',30,'LineWidth',LineWidthValue)
%     plot(EndoCFunctionality50_cortesol(1),3.1,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',30,'LineWidth',LineWidthValue)
%     plot(EndoCFunctionality50_cortesol(1),3.1,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',30,'LineWidth',LineWidthValue)
%  legend('HepaRG','EndoC-BH5','Human islets','Both EndoC-BH5 and human islets','NumColumns',4)
% hold off

% %human donor-donor legend
% figure('units','normalized','outerposition',[0 0 1 1])
% hold on
% set(gca,'XTick',[0.1,1,10],'YTick',1:1:3,'YTickLabel',{'Exenatide ECmax','Exenatide EC50','Initial functionality'},'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
% plot([0,1],[0,1],'Color', color_green,'LineWidth',6)
% plot([0,1],[0,1],'Color', color_red,'LineWidth',6)
% plot([0,1],[0,1],'Color', color_blue,'LineWidth',6)
% legend('HepaRG', 'EndoC-BH5','Human islets','FontSize',LegendSize,'NumColumns',5)
% hold off
% grid on
%% Fig 7B

clear EC100min_EndoC
clear EC100min_HumanMT

Exenatide_x = logspace(-2,3,500);
[row column] = size(ParameterIndex.InSphero_params);

for j = 1:row
    params_tempHumanMT =    ParameterIndex.InSphero_params(j,1:column-1);
    params_tempEndoC   =    ParameterIndex.EndoC_params(j,1:column-1);
    
    % EndoC - batch 1-5 & media
    Exenatide_hill   = Exenatide_x.^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill"));
    
            if j == 1
            maxEndoCFixedEffect  = 1 + (((params_tempEndoC(ismember(pNames,"ExenatideInsulinMax")).*Exenatide_hill./(( params_tempEndoC(ismember(pNames,"ExenatideInsulin50")).^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill")))+Exenatide_hill)) - (Exenatide_hill.*params_tempEndoC(ismember(pNames,"ExenatideInsulinDecayMax"))./(Exenatide_hill+(params_tempEndoC(ismember(pNames,"ExenatideInsulinDecay50")).^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill")))))));
            minEndoCFixedEffect  = maxEndoCFixedEffect;
            BestEndoCFixedEffect = maxEndoCFixedEffect;
            end
        NewEndoCFixedEffect  = (((params_tempEndoC(ismember(pNames,"ExenatideInsulinMax")).*Exenatide_hill./(( params_tempEndoC(ismember(pNames,"ExenatideInsulin50")).^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill")))+Exenatide_hill)) - (Exenatide_hill.*params_tempEndoC(ismember(pNames,"ExenatideInsulinDecayMax"))./(Exenatide_hill+(params_tempEndoC(ismember(pNames,"ExenatideInsulinDecay50")).^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill")))))));
        maxEndoCFixedEffect  = max(maxEndoCFixedEffect,NewEndoCFixedEffect);
        minEndoCFixedEffect  = min(minEndoCFixedEffect,NewEndoCFixedEffect);
        EC50min_EndoC(j)  = min(Exenatide_x(NewEndoCFixedEffect > 0.50*max(NewEndoCFixedEffect)));
        EC75min_EndoC(j)  = min(Exenatide_x(NewEndoCFixedEffect > 0.75*max(NewEndoCFixedEffect)));
        EC100min_EndoC(j) = min(Exenatide_x(NewEndoCFixedEffect ==   1*max(NewEndoCFixedEffect)));

        
    for i = 1:19
        EndoC_Emax     = params_tempEndoC(ismember(pNames,"ExenatideInsulinMax"))            * ParameterIndexEndoC.ExenatideResponse(j,i);
        EndoC_Emin     = params_tempEndoC(ismember(pNames,"ExenatideInsulinDecayMax"))       * ParameterIndexEndoC.ExenatideResponse(j,i);
        EndoC_Emax50   = params_tempEndoC(ismember(pNames,"ExenatideInsulin50"))             * ParameterIndexEndoC.ExenatideResponse50(j,i);
        EndoC_Emin50   = params_tempEndoC(ismember(pNames,"ExenatideInsulinDecay50"))        * ParameterIndexEndoC.ExenatideResponse50(j,i);
        if j == 1
            maxEndoC(i,:)  = 1 + ((Exenatide_hill.*EndoC_Emax)./(Exenatide_hill +(EndoC_Emax50.^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill"))))) ...
                - ((Exenatide_hill.*EndoC_Emin)./(Exenatide_hill +(EndoC_Emin50.^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill")))));
            minEndoC(i,:)  = maxEndoC(i,:);
            BestEndoC(i,:) = maxEndoC(i,:);
        end
        NewEndoC  = 1 + ((Exenatide_hill.*EndoC_Emax)./(Exenatide_hill +(EndoC_Emax50.^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill"))))) ...
            - ((Exenatide_hill.*EndoC_Emin)./(Exenatide_hill +(EndoC_Emin50.^params_tempEndoC(ismember(pNames,"ExenatideInsulin_hill")))));
        maxEndoC(i,:)  = max(maxEndoC(i,:),NewEndoC);
        minEndoC(i,:)  = min(minEndoC(i,:),NewEndoC);
    end
    
    % HumanMT - Donors 3-8 & media
    Exenatide_hill   = Exenatide_x.^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill"));
            if j == 1
            maxHumanMTFixedEffect  = 1 + (((params_tempHumanMT(ismember(pNames,"ExenatideInsulinMax")).*Exenatide_hill./(( params_tempHumanMT(ismember(pNames,"ExenatideInsulin50")).^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill")))+Exenatide_hill)) - (Exenatide_hill.*params_tempHumanMT(ismember(pNames,"ExenatideInsulinDecayMax"))./(Exenatide_hill+(params_tempHumanMT(ismember(pNames,"ExenatideInsulinDecay50")).^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill")))))));
            minHumanMTFixedEffect  = maxHumanMTFixedEffect;
            BestHumanMTFixedEffect= maxHumanMTFixedEffect;
            end
        NewHumanMTFixedEffect  = (((params_tempHumanMT(ismember(pNames,"ExenatideInsulinMax")).*Exenatide_hill./(( params_tempHumanMT(ismember(pNames,"ExenatideInsulin50")).^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill")))+Exenatide_hill)) - (Exenatide_hill.*params_tempHumanMT(ismember(pNames,"ExenatideInsulinDecayMax"))./(Exenatide_hill+(params_tempHumanMT(ismember(pNames,"ExenatideInsulinDecay50")).^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill")))))));
        maxHumanMTFixedEffect  = max(maxHumanMTFixedEffect,NewHumanMTFixedEffect);
        minHumanMTFixedEffect  = min(minHumanMTFixedEffect,NewHumanMTFixedEffect);
        EC50min_HumanMT(j)  = min(Exenatide_x(NewHumanMTFixedEffect > 0.50*max(NewHumanMTFixedEffect)));
        EC75min_HumanMT(j)  = min(Exenatide_x(NewHumanMTFixedEffect > 0.75*max(NewHumanMTFixedEffect)));
        EC100min_HumanMT(j) = min(Exenatide_x(NewHumanMTFixedEffect ==   1*max(NewHumanMTFixedEffect)));
        
            for i = 1:14
        HumanMT_Emax     = params_tempHumanMT(ismember(pNames,"ExenatideInsulinMax"))            * ParameterIndexInSphero.ExenatideResponse(j,i);
        HumanMT_Emin     = params_tempHumanMT(ismember(pNames,"ExenatideInsulinDecayMax"))       * ParameterIndexInSphero.ExenatideResponse(j,i);
        HumanMT_Emax50   = params_tempHumanMT(ismember(pNames,"ExenatideInsulin50"))             * ParameterIndexInSphero.ExenatideResponse50(j,i);
        HumanMT_Emin50   = params_tempHumanMT(ismember(pNames,"ExenatideInsulinDecay50"))        * ParameterIndexInSphero.ExenatideResponse50(j,i);
        if j == 1
            maxHumanMT(i,:)  = 1 + ((Exenatide_hill.*HumanMT_Emax)./(Exenatide_hill +(HumanMT_Emax50.^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill"))))) ...
                - ((Exenatide_hill.*HumanMT_Emin)./(Exenatide_hill +(HumanMT_Emin50.^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill")))));
            minHumanMT(i,:)  = maxHumanMT(i,:);
            BestHumanMT(i,:) = maxHumanMT(i,:);
        end
            NewHumanMT  = 1 + ((Exenatide_hill.*HumanMT_Emax)./(Exenatide_hill +(HumanMT_Emax50.^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill"))))) ...
            - ((Exenatide_hill.*HumanMT_Emin)./(Exenatide_hill +(HumanMT_Emin50.^params_tempHumanMT(ismember(pNames,"ExenatideInsulin_hill")))));
        maxHumanMT(i,:)  = max(maxHumanMT(i,:),NewHumanMT);
        minHumanMT(i,:)  = min(minHumanMT(i,:),NewHumanMT);
    end
end
ECBest_EndoC.EC50   = EC50min_EndoC(1);
EC_EndoC.EC50    = [min(EC50min_EndoC), max(EC50min_EndoC)];
ECBest_HumanMT.EC50 = EC50min_HumanMT(1);
EC_HumanMT.EC50  = [min(EC50min_HumanMT), max(EC50min_HumanMT)];
ECBest_EndoC.EC75   = EC75min_EndoC(1);
EC_EndoC.EC75    = [min(EC75min_EndoC), max(EC75min_EndoC)];
ECBest_HumanMT.EC75 = EC75min_HumanMT(1);
EC_HumanMT.EC75  = [min(EC75min_HumanMT), max(EC75min_HumanMT)];
ECBest_EndoC.EC100   = EC100min_EndoC(1);
EC_EndoC.EC100    = [min(EC100min_EndoC), max(EC100min_EndoC)];
ECBest_HumanMT.EC100 = EC100min_HumanMT(1);
EC_HumanMT.EC100  = [min(EC100min_HumanMT), max(EC100min_HumanMT)];

load('EC_Rat')      % RatEC100 is calc in script 'PlotGao'
load('ECBest_Rat')  % RatEC100 is calc in script 'PlotGao'
     
% Plot: Exenatide dose response
figure('units','normalized','outerposition',[0 0 1 1])
% Media
subplot(2,3,1)
hold on
set(gca,'xtick',[0.01,1,100],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
%title('Human MT - media')
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(1,:), fliplr(minHumanMT(1,:))], color_blue*0.6,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(2,:), fliplr(minHumanMT(2,:))], color_red*1,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(3,:), fliplr(minHumanMT(3,:))], color_4,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(4,:), fliplr(minHumanMT(4,:))], color_6,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(5,:), fliplr(minHumanMT(5,:))], color_7,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(6,:), fliplr(minHumanMT(6,:))], color_8,'FaceAlpha',0.6,'EdgeAlpha',0.5);
plot(Exenatide_x,BestHumanMTFixedEffect,'Color', color_black,'LineWidth',3)
%legend('HC', 'LC','FCS','B27','BSA','SM','Population response','FontSize',LegendSize)
xlim( [0.01 300])
ylim( [0 11])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(fold change to basal)'},'FontSmoothing','on');
hold off
grid on

% donors
subplot(2,3,4)
hold on
set(gca,'xtick',[0.01,1,100],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
%title('Human MT - donors')
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(8,:), fliplr(minHumanMT(8,:))] , color_3b,'FaceAlpha',0.8,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(9,:), fliplr(minHumanMT(9,:))] , color_4b,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(10,:), fliplr(minHumanMT(10,:))], color_5b,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(11,:), fliplr(minHumanMT(11,:))], color_6b,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(12,:), fliplr(minHumanMT(12,:))], color_7b,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(13,:), fliplr(minHumanMT(13,:))], color_8b,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxHumanMT(14,:), fliplr(minHumanMT(14,:))], color_9b,'FaceAlpha',0.6,'EdgeAlpha',0.5);
plot(Exenatide_x,BestHumanMTFixedEffect,'Color', color_black,'LineWidth',3)
% legend('Donor 1', 'Donor 2','Donor 3','Donor 4','Donor 5','Donor 6','Donor 7','Donor 8','Donor 9','Population response','FontSize',LegendSize)
xlim( [0.01 300])
ylim( [0 11])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(fold change to basal)'},'FontSmoothing','on');
hold off
grid on

subplot(2,3,2)
hold on
set(gca,'xtick',[0.01,1,100],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
%title('EndoC-BH5 - Media')
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(1,:), fliplr(minEndoC(1,:))], color_blue*1.1,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(2,:), fliplr(minEndoC(2,:))], color_red*1.5,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(3,:), fliplr(minEndoC(3,:))], color_4,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(4,:), fliplr(minEndoC(4,:))], color_6,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(5,:), fliplr(minEndoC(5,:))], color_7,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(7,:), fliplr(minEndoC(7,:))], color_9,'FaceAlpha',0.6,'EdgeAlpha',0.5);
plot(Exenatide_x,BestEndoCFixedEffect,'Color', color_black,'LineWidth',3)
xlim( [0.01 300])
ylim( [0 11])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(fold change to basal)'},'FontSmoothing','on');
hold off
grid on


subplot(2,3,5)
hold on
set(gca,'xtick',[0.01,1,100],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
%title('EndoC-BH5 - batch')
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(15,:), fliplr(minEndoC(15,:))], color_1,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(16,:), fliplr(minEndoC(16,:))], color_2,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(17,:), fliplr(minEndoC(17,:))], color_3,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(18,:), fliplr(minEndoC(18,:))], color_4,'FaceAlpha',0.6,'EdgeAlpha',0.5);
fill([Exenatide_x, fliplr(Exenatide_x)],[maxEndoC(19,:), fliplr(minEndoC(19,:))], color_6,'FaceAlpha',0.6,'EdgeAlpha',0.5);
plot(Exenatide_x,BestEndoCFixedEffect,'Color', color_black,'LineWidth',3)
xlim( [0.01 300])
ylim( [0 11])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(fold change to basal)'},'FontSmoothing','on');
hold off
grid on
  
% potency
subplot(2,3,6)
set(gca,'XTick',[0.01,1,100],'YTick',1:1:3,'YTickLabel',{'EndoC-BH5','Human islets','Rat'},'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
hold on
FillBarWidth = 0.2;
% legend
fill([min(EC_EndoC.EC50)  , min(EC_EndoC.EC50)   , max(EC_EndoC.EC50)  , max(EC_EndoC.EC50)] -10000 ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1, color_green,'FaceAlpha',0.5,'EdgeAlpha', 0.5);
fill([min(EC_Rat.EC75)    , min(EC_Rat.EC75)     , max(EC_Rat.EC75)    , max(EC_Rat.EC75)]   -10000 ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3, color_yellow,'FaceAlpha',0.5,'EdgeAlpha', 0.5);
fill([min(EC_Rat.EC100)   , min(EC_Rat.EC100)    , max(EC_Rat.EC100)   , max(EC_Rat.EC100)]  -10000  ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3, color_red,'FaceAlpha',0.5,'EdgeAlpha', 0.5);
% legend
fill([min(EC_EndoC.EC50)  , min(EC_EndoC.EC50)   , max(EC_EndoC.EC50)  , max(EC_EndoC.EC50)]  ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1, color_green,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([min(EC_HumanMT.EC50), min(EC_HumanMT.EC50) , max(EC_HumanMT.EC50), max(EC_HumanMT.EC50)],[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2, color_green,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([min(EC_Rat.EC50)    , min(EC_Rat.EC50)     , max(EC_Rat.EC50)    , max(EC_Rat.EC50)]    ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3, color_green,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
 plot(ECBest_EndoC.EC50  ,1,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)
 plot(ECBest_HumanMT.EC50  ,2,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)
 plot(ECBest_Rat.EC50  ,3,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)

fill([min(EC_EndoC.EC75)  , min(EC_EndoC.EC75)   , max(EC_EndoC.EC75)  , max(EC_EndoC.EC75)]  ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1, color_yellow,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([min(EC_HumanMT.EC75), min(EC_HumanMT.EC75) , max(EC_HumanMT.EC75), max(EC_HumanMT.EC75)],[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2, color_yellow,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([min(EC_Rat.EC75)    , min(EC_Rat.EC75)     , max(EC_Rat.EC75)    , max(EC_Rat.EC75)]    ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3, color_yellow,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
 plot(ECBest_EndoC.EC75  ,1,'LineStyle', 'n','Color', color_yellow, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)
 plot(ECBest_HumanMT.EC75  ,2,'LineStyle', 'n','Color', color_yellow, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)
 plot(ECBest_Rat.EC75  ,3,'LineStyle', 'n','Color', color_yellow, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)

 fill([min(EC_EndoC.EC100)  , min(EC_EndoC.EC100)   , max(EC_EndoC.EC100)  , max(EC_EndoC.EC100)]  ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1, color_red,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([min(EC_HumanMT.EC100), min(EC_HumanMT.EC100) , max(EC_HumanMT.EC100), max(EC_HumanMT.EC100)],[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2, color_red,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([min(EC_Rat.EC100)    , min(EC_Rat.EC100)     , max(EC_Rat.EC100)    , max(EC_Rat.EC100)]    ,[-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3, color_red,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
 plot(ECBest_EndoC.EC100  ,1,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)
 plot(ECBest_HumanMT.EC100  ,2,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)
 plot(ECBest_Rat.EC100  ,3,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',26,'LineWidth',LineWidthValue)
legend('EC50','EC75','EC100','FontSize',15,'NumColumns',3)
xlabel({'Exenatide potency'},'FontSmoothing','on');
xlim( [0.01 300])
ylim([0.5,3.6])
grid on
hold off
 
%% Fig 4C: Insulin resistance

load('ModelUncertainty_paramsFull')
[row column] = size(ModelUncertainty_params);
GlucoseVector  = 0:0.1:16;

[PersonSpecificParameters] = AssignInitialUniqueParameters();
for j = 1:row
    params_temp =    ModelUncertainty_params(j,1:column-1);
    [simEndoC,simHuman,simHepaRG] = SimulateMediaFunctionality(model,params_temp,PersonSpecificParameters,initialvalues,sNames,pNames,AmountParameterOpti,1);
    UncertaintyMediaFunctionality
end

BarWidth     = 0.2;
FillBarWidth = 0.2;

IS0 = [BestHepaRG_ISHC(1), minHepaRG_ISHC(1), maxHepaRG_ISHC(1);
    BestHepaRG_ISLC(1), minHepaRG_ISLC(1), maxHepaRG_ISLC(1);
    BestHepaRG_ISFCS(1), minHepaRG_ISFCS(1), maxHepaRG_ISFCS(1);
    BestHepaRG_ISB27(1), minHepaRG_ISB27(1), maxHepaRG_ISB27(1)];

IS16 = [BestHepaRG_ISHC(384), minHepaRG_ISHC(384), maxHepaRG_ISHC(384);
    BestHepaRG_ISLC(384), minHepaRG_ISLC(384), maxHepaRG_ISLC(384);
    BestHepaRG_ISFCS(384), minHepaRG_ISFCS(384), maxHepaRG_ISFCS(384);
    BestHepaRG_ISB27(384), minHepaRG_ISB27(384), maxHepaRG_ISB27(384)];

figure('units','normalized','outerposition',[0 0 1 1])
% HepaRG f
subplot(3,3,1)
set(gca,'ytick',0:5:25,'xtick',1:1:4,'XTickLabel',{'HC','LC','FCS','B27'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
hold on
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1,[IS0(1,2), IS0(1,2) , IS0(1,3), IS0(1,3)], color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2,[IS0(2,2), IS0(2,2) , IS0(2,3), IS0(2,3)], color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3,[IS0(3,2), IS0(3,2) , IS0(3,3), IS0(3,3)], color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+4,[IS0(4,2), IS0(4,2) , IS0(4,3), IS0(4,3)], color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
bar(1:4,[IS0(1,1),IS0(2,1),IS0(3,1),IS0(4,1)],BarWidth,'stacked', 'FaceColor',color_gray,'LineWidth',1,'FaceAlpha',0.9);
ylabel({'Insulin response EC50';'(multiplication)'},'FontSmoothing','on');
xlabel({'Initial'},'FontSmoothing','on');
xlim([0,5])
ylim([0,17])
grid on
hold off

% HepaRG f
subplot(3,3,2)
set(gca,'ytick',0:5:25,'xtick',1:1:4,'XTickLabel',{'HC','LC','FCS','B27'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
hold on
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1,[IS16(1,2), IS16(1,2) , IS16(1,3), IS16(1,3)]            , color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2,[IS16(2,2), IS16(2,2) , IS16(2,3), IS16(2,3)]            , color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+3,[IS16(3,2), IS16(3,2) , IS16(3,3), IS16(3,3)]            , color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+4,[IS16(4,2), IS16(4,2) , IS16(4,3), IS16(4,3)]            , color_gray,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
bar(1:4,[BestHepaRG_ISHC(384),BestHepaRG_ISLC(384),BestHepaRG_ISFCS(384),BestHepaRG_ISB27(384)],BarWidth,'stacked', 'FaceColor',color_gray,'LineWidth',1,'FaceAlpha',0.9);
ylabel({'Insulin response EC50';'(multiplication)'},'FontSmoothing','on');
xlabel({'15 days of culture'},'FontSmoothing','on');
xlim([0,5])
ylim([0,17])
grid on
hold off

% HepaRG f
subplot(3,3,3)
set(gca,'ytick',0.99:0.002:1.11,'xtick',0:4:16,'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
hold on
fill([GlucoseVector, fliplr(GlucoseVector)],(100+[maxGlucoseOverHealthy, fliplr(minGlucoseOverHealthy)])/100, color_gray,'FaceAlpha',0.2,'EdgeAlpha',0.5);
plot(GlucoseVector, (100+BestGlucoseOverHealthy)/100           ,'Color', color_black   ,'LineWidth',2)
ylabel({'Insulin response EC50';'(multiplication/h)'},'FontSmoothing','on');
xlabel({'Hepatic glucose (mM)'},'FontSmoothing','on');
xlim([0,16])
ylim([0.9995,1.004])
grid on
hold off

%% Fig. 4A

% Liver tests LC vs HC
HepaRGInsulinResistanceTime_cortesol = ParameterIndexEndoC.InsulinResistanceTimeDependency(:,1)./ParameterIndexEndoC.InsulinResistanceTimeDependency(:,2);
HepaRGInsulinResistance0_cortesol = ParameterIndexEndoC.IS0(:,1)./ParameterIndexEndoC.IS0(:,2);
HepaRGFunctionality0_cortesol = ParameterIndexEndoC.Fspheroids0(:,1)./ParameterIndexEndoC.Fspheroids0(:,2);
HepaRGFunctionality50_cortesol = ParameterIndexEndoC.Fspheroids50(:,1)./ParameterIndexEndoC.Fspheroids50(:,2);
HepaRGFunctionalitySlope_cortesol = ParameterIndexEndoC.Fspheroids_hill(:,1)./ParameterIndexEndoC.Fspheroids_hill(:,2);
% EndoC LC vs HC
EndoCkv_cortesol = ParameterIndexEndoC.kv(:,1)./ParameterIndexEndoC.kv(:,2);
EndoCExenatideResponse_cortesol = ParameterIndexEndoC.ExenatideResponse(:,1)./ParameterIndexEndoC.ExenatideResponse(:,2);
EndoCExenatideResponse50_cortesol = ParameterIndexEndoC.ExenatideResponse50(:,1)./ParameterIndexEndoC.ExenatideResponse50(:,2);
EndoCFunctionality0_cortesol = ParameterIndexEndoC.Filets0(:,1)./ParameterIndexEndoC.Filets0(:,2);
EndoCFunctionality50_cortesol = ParameterIndexEndoC.Fislets50(:,1)./ParameterIndexEndoC.Fislets50(:,2);
EndoCFunctionalitySlope_cortesol = ParameterIndexEndoC.Filets_hill(:,1)./ParameterIndexEndoC.Filets_hill(:,2);
% Human MT LC vs HC
Humankv_cortesol                  = ParameterIndexInSphero.kv(:,1)./ParameterIndexInSphero.kv(:,2);
HumanExenatideResponse_cortesol   = ParameterIndexInSphero.ExenatideResponse(:,1)./ParameterIndexInSphero.ExenatideResponse(:,2);
HumanExenatideResponse50_cortesol = ParameterIndexInSphero.ExenatideResponse50(:,1)./ParameterIndexInSphero.ExenatideResponse50(:,2);
HumanFunctionality0_cortesol      = ParameterIndexInSphero.Filets0(:,1)./ParameterIndexInSphero.Filets0(:,2);
HumanFunctionality50_cortesol     = ParameterIndexInSphero.Fislets50(:,1)./ParameterIndexInSphero.Fislets50(:,2);
HumanFunctionalitySlope_cortesol  = ParameterIndexInSphero.Filets_hill(:,1)./ParameterIndexInSphero.Filets_hill(:,2);

% Liver tests FCS vs B27
HepaRGInsulinResistanceTime_supplement = ParameterIndexEndoC.InsulinResistanceTimeDependency(:,4)./ParameterIndexEndoC.InsulinResistanceTimeDependency(:,3);
HepaRGInsulinResistance0_supplement = ParameterIndexEndoC.IS0(:,4)./ParameterIndexEndoC.IS0(:,3);
HepaRGFunctionality0_supplement = ParameterIndexEndoC.Fspheroids0(:,4)./ParameterIndexEndoC.Fspheroids0(:,3);
HepaRGFunctionality50_supplement = ParameterIndexEndoC.Fspheroids50(:,4)./ParameterIndexEndoC.Fspheroids50(:,3);
HepaRGFunctionalitySlope_supplement = ParameterIndexEndoC.Fspheroids_hill(:,4)./ParameterIndexEndoC.Fspheroids_hill(:,3);
% EndoC FCS vs B27
EndoCkv_supplement = ParameterIndexEndoC.kv(:,4)./ParameterIndexEndoC.kv(:,3);
EndoCExenatideResponse_supplement = ParameterIndexEndoC.ExenatideResponse(:,4)./ParameterIndexEndoC.ExenatideResponse(:,3);
EndoCExenatideResponse50_supplement = ParameterIndexEndoC.ExenatideResponse50(:,4)./ParameterIndexEndoC.ExenatideResponse50(:,3);
EndoCFunctionality0_supplement = ParameterIndexEndoC.Filets0(:,4)./ParameterIndexEndoC.Filets0(:,3);
EndoCFunctionality50_supplement = ParameterIndexEndoC.Fislets50(:,4)./ParameterIndexEndoC.Fislets50(:,3);
EndoCFunctionalitySlope_supplement = ParameterIndexEndoC.Filets_hill(:,4)./ParameterIndexEndoC.Filets_hill(:,3);
% Human MT FCS vs B27
Humankv_supplement                  = ParameterIndexInSphero.kv(:,4)./ParameterIndexInSphero.kv(:,3);
HumanExenatideResponse_supplement   = ParameterIndexInSphero.ExenatideResponse(:,4)./ParameterIndexInSphero.ExenatideResponse(:,3);
HumanExenatideResponse50_supplement = ParameterIndexInSphero.ExenatideResponse50(:,4)./ParameterIndexInSphero.ExenatideResponse50(:,3);
HumanFunctionality0_supplement      = ParameterIndexInSphero.Filets0(:,4)./ParameterIndexInSphero.Filets0(:,3);
HumanFunctionality50_supplement     = ParameterIndexInSphero.Fislets50(:,4)./ParameterIndexInSphero.Fislets50(:,3);
HumanFunctionalitySlope_supplement  = ParameterIndexInSphero.Filets_hill(:,4)./ParameterIndexInSphero.Filets_hill(:,3);

% EndoC - Co-Culture vs SM
COkv_EndoC                  = mean([ParameterIndexEndoC.kv(:,1),ParameterIndexEndoC.kv(:,2),ParameterIndexEndoC.kv(:,3),ParameterIndexEndoC.kv(:,4)],2);
COExenatideResponse_EndoC   = mean([ParameterIndexEndoC.ExenatideResponse(:,1),ParameterIndexEndoC.ExenatideResponse(:,2),ParameterIndexEndoC.ExenatideResponse(:,3),ParameterIndexEndoC.ExenatideResponse(:,4)],2);
COExenatideResponse50_EndoC = mean([ParameterIndexEndoC.ExenatideResponse50(:,1),ParameterIndexEndoC.ExenatideResponse50(:,2),ParameterIndexEndoC.ExenatideResponse50(:,3),ParameterIndexEndoC.ExenatideResponse50(:,4)],2);
COFunctionality0_EndoC      = mean([ParameterIndexEndoC.Filets0(:,1),ParameterIndexEndoC.Filets0(:,2),ParameterIndexEndoC.Filets0(:,3),ParameterIndexEndoC.Filets0(:,4)],2);
COFunctionality50_EndoC     = mean([ParameterIndexEndoC.Fislets50(:,1),ParameterIndexEndoC.Fislets50(:,2),ParameterIndexEndoC.Fislets50(:,3),ParameterIndexEndoC.Fislets50(:,4)],2);
COFunctionalitySlope_EndoC  = mean([ParameterIndexEndoC.Filets_hill(:,1),ParameterIndexEndoC.Filets_hill(:,2),ParameterIndexEndoC.Filets_hill(:,3),ParameterIndexEndoC.Filets_hill(:,4)],2);
COkv_EndoC                  = ParameterIndexEndoC.kv(:,7)./COkv_EndoC;
COExenatideResponse_EndoC   = ParameterIndexEndoC.ExenatideResponse(:,7)./COExenatideResponse_EndoC;
COExenatideResponse50_EndoC = ParameterIndexEndoC.ExenatideResponse50(:,7)./COExenatideResponse50_EndoC;
COFunctionality0_EndoC      = ParameterIndexEndoC.Filets0(:,7)./COFunctionality0_EndoC;
COFunctionality50_EndoC     = ParameterIndexEndoC.Fislets50(:,7)./COFunctionality50_EndoC;
COFunctionalitySlope_EndoC  = ParameterIndexEndoC.Filets_hill(:,7)./COFunctionalitySlope_EndoC;
% Human MT - Co-Culture vs SM
COkv_Human                  = mean([ParameterIndexInSphero.kv(:,1),ParameterIndexInSphero.kv(:,2),ParameterIndexInSphero.kv(:,3),ParameterIndexInSphero.kv(:,4)],2);
COExenatideResponse_Human   = mean([ParameterIndexInSphero.ExenatideResponse(:,1),ParameterIndexInSphero.ExenatideResponse(:,2),ParameterIndexInSphero.ExenatideResponse(:,3),ParameterIndexInSphero.ExenatideResponse(:,4)],2);
COExenatideResponse50_Human = mean([ParameterIndexInSphero.ExenatideResponse50(:,1),ParameterIndexInSphero.ExenatideResponse50(:,2),ParameterIndexInSphero.ExenatideResponse50(:,3),ParameterIndexInSphero.ExenatideResponse50(:,4)],2);
COFunctionality0_Human      = mean([ParameterIndexInSphero.Filets0(:,1),ParameterIndexInSphero.Filets0(:,2),ParameterIndexInSphero.Filets0(:,3),ParameterIndexInSphero.Filets0(:,4)],2);
COFunctionality50_Human     = mean([ParameterIndexInSphero.Fislets50(:,1),ParameterIndexInSphero.Fislets50(:,2),ParameterIndexInSphero.Fislets50(:,3),ParameterIndexInSphero.Fislets50(:,4)],2);
COFunctionalitySlope_Human  = mean([ParameterIndexInSphero.Filets_hill(:,1),ParameterIndexInSphero.Filets_hill(:,2),ParameterIndexInSphero.Filets_hill(:,3),ParameterIndexInSphero.Filets_hill(:,4)],2);
COkv_Human                  = ParameterIndexInSphero.kv(:,6)./COkv_Human;
COExenatideResponse_Human   = ParameterIndexInSphero.ExenatideResponse(:,6)./COExenatideResponse_Human;
COExenatideResponse50_Human = ParameterIndexInSphero.ExenatideResponse50(:,6)./COExenatideResponse50_Human;
COFunctionality0_Human      = ParameterIndexInSphero.Filets0(:,6)./COFunctionality0_Human;
COFunctionality50_Human     = ParameterIndexInSphero.Fislets50(:,6)./COFunctionality50_Human;
COFunctionalitySlope_Human  = ParameterIndexInSphero.Filets_hill(:,6)./COFunctionalitySlope_Human;

yaxisLabels = {'Insulin resistance development',
    'Initial Insulin resistance',
    'Initial functionality',
    'Functionality stability',
    'Functionality decay rate',
    'Volume stability',
    'Exenatide response',
    'Exenatide potency'};
figure('units','normalized','outerposition',[0 0 1 1])

% Liver
subplot(2,3,1)
hold on
set(gca,'XTick',[0.1,1,10],'YTick',0:7,'YTickLabel',yaxisLabels,'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
%title('LC compared to HC')
xlabel({'LC is higher                            HC is higher'},'FontSmoothing','on');
fill([0.1, 10, 10, 0.1],[-0.5,-0.5, 0.5,0.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([0.1, 10, 10, 0.1],[1.5, 1.5, 2.5, 2.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([0.1, 10, 10, 0.1],[3.5, 3.5, 4.5, 4.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([0.1, 10, 10, 0.1],[5.5, 5.5, 6.5, 6.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
for i=1:row
    plot(HepaRGInsulinResistanceTime_cortesol(i),0,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGInsulinResistance0_cortesol(i),1,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGFunctionality0_cortesol(i),1.9,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HumanFunctionality0_cortesol(i),2,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(EndoCFunctionality0_cortesol(i),2.1,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGFunctionality50_cortesol(i),2.9,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HumanFunctionality50_cortesol(i),3,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(EndoCFunctionality50_cortesol(i),3.1,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGFunctionalitySlope_cortesol(i),3.9,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HumanFunctionalitySlope_cortesol(i),4,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(EndoCFunctionalitySlope_cortesol(i),4.1,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(1/Humankv_cortesol(i),5,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HumanExenatideResponse_cortesol(i),5.95,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(EndoCExenatideResponse_cortesol(i),6.05,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(1./HumanExenatideResponse50_cortesol(i),6.95,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(1./EndoCExenatideResponse50_cortesol(i),7.05,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
end
ylim([-0.5,7.5])
xlim([0.1,10])
hold off
grid on

% Liver
subplot(2,3,2)
hold on
set(gca,'XTick',[0.1,1,10],'YTick',0:7,'YTickLabel',[],'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
xlabel({'FCS is higher                          B27 is higher'},'FontSmoothing','on');
fill([0.1, 10, 10, 0.1],[-0.5,-0.5, 0.5,0.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([0.1, 10, 10, 0.1],[1.5 1.5, 2.5, 2.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([0.1, 10, 10, 0.1],[3.5 3.5, 4.5, 4.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([0.1, 10, 10, 0.1],[5.5 5.5, 6.5, 6.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
for i=1:row
    plot(HepaRGInsulinResistanceTime_supplement(i),0,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGInsulinResistance0_supplement(i),1,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGFunctionality0_supplement(i),1.9,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HumanFunctionality0_supplement(i),2.1,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGFunctionality50_supplement(i),2.9,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HumanFunctionality50_supplement(i),3.1,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRGFunctionalitySlope_supplement(i),3.9,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HumanFunctionalitySlope_supplement(i),4.1,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(1/Humankv_supplement(i),5,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HumanExenatideResponse_supplement(i),6,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(1./HumanExenatideResponse50_supplement(i),7,'LineStyle', 'n','Color', color_black, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
end
ylim([-0.5,7.5])
xlim([0.1,10])
hold off
grid on

% Liver
subplot(2,3,3)
hold on
set(gca,'XTick',[0.1,1,10],'YTick',0:7,'YTickLabel',[],'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
xlabel({'Co-culture is higher             SM is higher'},'FontSmoothing','on');
fill([0.1, 10, 10, 0.1],[-0.5,-0.5, 0.5,0.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([1/30, 30, 30, 1/30],[1.5 1.5, 2.5, 2.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([1/30, 30, 30, 1/30],[3.5 3.5, 4.5, 4.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
fill([1/30, 30, 30, 1/30],[5.5 5.5, 6.5, 6.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
for i=1:row

    plot(COFunctionality0_EndoC(i),1.9,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(COFunctionality0_Human(i),2.1,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(COFunctionality50_EndoC(i),2.9,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(COFunctionality50_Human(i),3.1,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(COFunctionalitySlope_EndoC(i),3.9,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(COFunctionalitySlope_Human(i),4.1,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(1/COkv_EndoC(i),4.9,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(1/COkv_Human(i),5.1,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(COExenatideResponse_EndoC(i),5.9,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(COExenatideResponse_Human(i),6.1,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(1./COExenatideResponse50_EndoC(i),6.9,'LineStyle', 'n','Color', color_red, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(1./COExenatideResponse50_Human(i),7.1,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
end
ylim([-0.5,7.5])
xlim([0.1,10])
hold off
grid on

%% Fig. 4B: donor and batch variability
figure('units','normalized','outerposition',[0 0 1 1])

load('ModelUncertainty_paramsFull')
ModelUncertainty_paramsLOG = log(ModelUncertainty_params);
[ParameterIndexEndoC_log,ParameterIndexInSphero_log,ParameterIndex_log] = ReStrucOptimisedParams (ModelUncertainty_paramsLOG(:,1:column-1),AmountParameterOpti,pNames(1:AmountParameterOpti));

% HepaRG batch-batch variability
HepaRG_f50(:,:) = ParameterIndex.HepaRG_f50(:,:).*ParameterIndex.EndoC_params(:,ismember(pNames,"Fspheroids50"))./ParameterIndex.EndoC_params(1,ismember(pNames,"Fspheroids50"));
HepaRG_f0(:,:)  = ParameterIndex.HepaRG_f0(:,:).*ParameterIndex.EndoC_params(:,ismember(pNames,"Fspheroids0"))./ParameterIndex.EndoC_params(1,ismember(pNames,"Fspheroids0"));
HepaRG_IS(:,:)  = ParameterIndex.HepaRG_IS(:,:).*ParameterIndex.EndoC_params(:,ismember(pNames,"ISk"))./ParameterIndex.EndoC_params(1,ismember(pNames,"ISk"));
subplot(2,3,1)
hold on
title('HepaRG batch variability')
set(gca,'XTick',[0.1,1,10],'YTick',1:1:3,'YTickLabel',{'Functionality stability','Initial functionality','Diabetes resistance'},'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
xlabel({'Lower                 Average                 Higher'},'FontSmoothing','on');
fill([0.1, 10, 10, 0.1],[0.5 0.5, 1.5, 1.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.HepaRG_f50(1,:))),1);
sigma = round(exp(std(ParameterIndex_log.HepaRG_f50(1,:))),1);
text(4.5,1.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,1.2,("\mu = " + mu),'FontSize', 13)
fill([0.1, 10, 10, 0.1],[2.5 2.5, 3.5, 3.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.HepaRG_f0(1,:))),1);
sigma = round(exp(std(ParameterIndex_log.HepaRG_f0(1,:))),1);
text(4.5,2.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,2.2,("\mu = " + mu),'FontSize', 13)
fill([0.1, 10, 10, 0.1],[4.5 4.5, 5.5, 5.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.HepaRG_IS(1,:))),1);
sigma = round(exp(std(ParameterIndex_log.HepaRG_IS(1,:))),1);
text(4.5,3.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,3.2,("\mu = " + mu),'FontSize', 13)
for i=1:row
    plot(HepaRG_f50(i,1)  ,1-0.2,'LineStyle', 'n','Color', color_1, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f50(i,2)  ,1-0.1,'LineStyle', 'n','Color', color_2  , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f50(i,3)  ,1+0.0,'LineStyle', 'n','Color', color_3 , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f50(i,4)  ,1+0.1,'LineStyle', 'n','Color', color_4, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f50(i,5)  ,1+0.2,'LineStyle', 'n','Color', color_6, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRG_f0(i,1)  ,2-0.2,'LineStyle', 'n','Color', color_1, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,2)  ,2-0.1,'LineStyle', 'n','Color', color_2  , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,3)  ,2+0.0,'LineStyle', 'n','Color', color_3 , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,4)  ,2+0.1,'LineStyle', 'n','Color', color_4, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,5)  ,2+0.2,'LineStyle', 'n','Color', color_6, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(HepaRG_IS(i,1)  ,3-0.2,'LineStyle', 'n','Color', color_1, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_IS(i,2)  ,3-0.1,'LineStyle', 'n','Color', color_2  , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_IS(i,3)  ,3+0.0,'LineStyle', 'n','Color', color_3 , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_IS(i,4)  ,3+0.1,'LineStyle', 'n','Color', color_4, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_IS(i,5)  ,3+0.2,'LineStyle', 'n','Color', color_6, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)

end
ylim([0.5,4])
xlim([0.1,10])
hold off
grid on

% Human donor variability
ExenatideResponse(:,:)   = ParameterIndex.ExenatideResponse(:,:)  .*ParameterIndex.InSphero_params(:,ismember(pNames,"ExenatideInsulinMax"))./ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinMax"));
ExenatideResponse50(:,:) = ParameterIndex.ExenatideResponse50(:,:).*ParameterIndex.InSphero_params(:,ismember(pNames,"ExenatideInsulin50")) ./ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulin50"));
Filets0(:,:)             = ParameterIndex.Filets0(:,:)            .*ParameterIndex.InSphero_params(:,ismember(pNames,"Filets0"))            ./ParameterIndex.InSphero_params(1,ismember(pNames,"Filets0"));
subplot(2,3,2)
hold on
title('Human islet donor variability')
set(gca,'XTick',[0.1,1,10],'YTick',1:1:3,'YTickLabel',{'Exenatide ECmax','Exenatide EC50','Initial functionality'},'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
xlabel({'Lower                 Average                 Higher'},'FontSmoothing','on');
fill([0.1, 10, 10, 0.1],[0.5 0.5, 1.5, 1.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.ExenatideResponse(1,8:14))),1);
sigma = round(exp(std(ParameterIndex_log.ExenatideResponse(1,8:14))),1);
text(4.5,1.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,1.2,("\mu = " + mu),'FontSize', 13)
fill([0.1, 10, 10, 0.1],[2.5 2.5, 3.5, 3.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.ExenatideResponse50(1,8:14))),1);
sigma = round(exp(std(ParameterIndex_log.ExenatideResponse50(1,8:14))),1);
text(4.5,2.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,2.2,("\mu = " + mu),'FontSize', 13)
fill([0.1, 10, 10, 0.1],[4.5 4.5, 5.5, 5.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.Filets0(1,8:17))),1);
sigma = round(exp(std(ParameterIndex_log.Filets0(1,8:17))),1);
text(4.5,3.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,3.2,("\mu = " + mu),'FontSize', 13)
for i=1:row
    plot(ExenatideResponse(i,8)   ,1-0.2,'LineStyle', 'n','Color', color_3b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,9)   ,1-0.1,'LineStyle', 'n','Color', color_4b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,10)  ,1+0.0,'LineStyle', 'n','Color', color_5b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,11)  ,1+0.1,'LineStyle', 'n','Color', color_6b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,12)  ,1+0.2,'LineStyle', 'n','Color', color_7b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,13)  ,1+0.3,'LineStyle', 'n','Color', color_8b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,14)  ,1+0.4,'LineStyle', 'n','Color', color_9b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(ExenatideResponse50(i,8)   ,2-0.2,'LineStyle', 'n','Color', color_3b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,9)   ,2-0.1,'LineStyle', 'n','Color', color_4b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,10)  ,2+0.0,'LineStyle', 'n','Color', color_5b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,11)  ,2+0.1,'LineStyle', 'n','Color', color_6b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,12)  ,2+0.2,'LineStyle', 'n','Color', color_7b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,13)  ,2+0.3,'LineStyle', 'n','Color', color_8b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,14)  ,2+0.4,'LineStyle', 'n','Color', color_9b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
   
    plot(Filets0(i,8)  ,3-0.4,'LineStyle', 'n','Color', color_3b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,9)  ,3-0.3,'LineStyle', 'n','Color', color_4b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,10)   ,3-0.2,'LineStyle', 'n','Color', color_5b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,11)   ,3-0.1,'LineStyle', 'n','Color', color_6b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,12)  ,3+0.0,'LineStyle', 'n','Color', color_7b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,13)  ,3+0.1,'LineStyle', 'n','Color', color_8b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,14)  ,3+0.2,'LineStyle', 'n','Color', color_9b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,15)  ,3+0.3,'LineStyle', 'n','Color', color_10b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,16)  ,3+0.4,'LineStyle', 'n','Color', color_11b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,17)  ,3+0.5,'LineStyle', 'n','Color', color_12b, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
end
ylim([0.5,4])
xlim([0.1,10])
hold off
grid on

% EndoC-BH5 batch-batch variability
ExenatideResponse(:,:)   = ParameterIndex.ExenatideResponse(:,:)  .*ParameterIndex.EndoC_params(:,ismember(pNames,"ExenatideInsulinMax"))./ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinMax"));
ExenatideResponse50(:,:) = ParameterIndex.ExenatideResponse50(:,:).*ParameterIndex.EndoC_params(:,ismember(pNames,"ExenatideInsulin50")) ./ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulin50"));
Filets0(:,:)             = ParameterIndex.Filets0(:,:)            .*ParameterIndex.EndoC_params(:,ismember(pNames,"Filets0"))            ./ParameterIndex.EndoC_params(1,ismember(pNames,"Filets0"));
subplot(2,3,3)
hold on
title('EndoC-BH5 batch variability')
set(gca,'XTick',[0.1,1,10],'YTick',1:1:3,'YTickLabel',[],'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
xlabel({'Lower                 Average                 Higher'},'FontSmoothing','on');
fill([0.1, 10, 10, 0.1],[0.5 0.5, 1.5, 1.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.ExenatideResponse(1,15:19))),1);
sigma = round(exp(std(ParameterIndex_log.ExenatideResponse(1,15:19))),1);
text(4.5,1.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,1.2,("\mu = " + mu),'FontSize', 13)
fill([0.1, 10, 10, 0.1],[2.5 2.5, 3.5, 3.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.ExenatideResponse50(1,15:19))),1);
sigma = round(exp(std(ParameterIndex_log.ExenatideResponse50(1,15:19))),1);
text(4.5,2.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,2.2,("\mu = " + mu),'FontSize', 13)
fill([0.1, 10, 10, 0.1],[4.5 4.5, 5.5, 5.5],color_black,'FaceAlpha',0.1,'EdgeAlpha', 0);
mu = round(exp(mean(ParameterIndex_log.Filets0(1,18:22))),1);
sigma = round(exp(std(ParameterIndex_log.Filets0(1,18:22))),1);
text(4.5,3.4,("\sigma = " + sigma),'FontSize', 13)
text(4.5,3.2,("\mu = " + mu),'FontSize', 13)

for i=1:row
    plot(ExenatideResponse(i,15)  ,1-0.2,'LineStyle', 'n','Color', color_1, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,16)  ,1-0.1,'LineStyle', 'n','Color', color_2, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,17)  ,1+0.0,'LineStyle', 'n','Color', color_3, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,18)  ,1+0.1,'LineStyle', 'n','Color', color_4, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse(i,19)  ,1+0.2,'LineStyle', 'n','Color', color_6, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
    plot(ExenatideResponse50(i,15)  ,2-0.2,'LineStyle', 'n','Color', color_1, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,16)  ,2-0.1,'LineStyle', 'n','Color', color_2, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,17)  ,2+0.0,'LineStyle', 'n','Color', color_3, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,18)  ,2+0.1,'LineStyle', 'n','Color', color_4, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(ExenatideResponse50(i,19)  ,2+0.2,'LineStyle', 'n','Color', color_6, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
   
    plot(Filets0(i,18)  ,3-0.2,'LineStyle', 'n','Color', color_1, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,19)  ,3-0.1,'LineStyle', 'n','Color', color_2, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,20)  ,3+0.0,'LineStyle', 'n','Color', color_3, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,21)  ,3+0.1,'LineStyle', 'n','Color', color_4, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,22)  ,3+0.2,'LineStyle', 'n','Color', color_6, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)

end
ylim([0.5,4])
xlim([0.1,10])
hold off
grid on

%% Fig. 5C ii
figure('units','normalized','outerposition',[0 0 1 1])

Filets0(:,:)   = ParameterIndex.Filets0(:,:)  .*ParameterIndex.InSphero_params(:,ismember(pNames,"Filets0"))    ./ParameterIndex.InSphero_params(1,ismember(pNames,"Filets0"));
HepaRG_f0(:,:) = ParameterIndex.HepaRG_f0(:,:).*ParameterIndex.InSphero_params(:,ismember(pNames,"Fspheroids0"))./ParameterIndex.InSphero_params(1,ismember(pNames,"Fspheroids0"));
subplot(2,3,3)
hold on
title('Calibration result')
set(gca,'XTick',[0.1,1,10],'YTick',1:2,'YTickLabel',{'Islet functionality','Liver spheroid functionality'},'FontSize', 15,'FontSmoothing','on','fontname','Arial','XScale','log')
xlabel({'Lower                 Average                 Higher'},'FontSmoothing','on');
for i=1:row
    plot(Filets0(i,8)  ,1-0.25,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(3           ,1-0,'LineStyle', 'n','Color', color_blue, 'Marker','.','MarkerSize',CostSize(1),'LineWidth',LineWidthValue)
     plot(0.5             ,2+0.025,'LineStyle', 'n','Color', color_green, 'Marker','.','MarkerSize',CostSize(1),'LineWidth',LineWidthValue)
     plot(Filets0(i,9)  ,1-0.20,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,10) ,1-0.15,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,11) ,1-0.10,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,12) ,1-0.05,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,13) ,1+0.05,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,14) ,1+0.10,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,15) ,1+0.15,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,16) ,1+0.20,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(Filets0(i,17) ,1+0.25,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)

    plot(HepaRG_f0(i,1)  ,2-0.125,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,2)  ,2-0.075,'LineStyle', 'n','Color', color_gray  , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,3)  ,2-0.025,'LineStyle', 'n','Color', color_gray , 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,4)  ,2+0.075,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    plot(HepaRG_f0(i,5)  ,2+0.125,'LineStyle', 'n','Color', color_gray, 'Marker','.','MarkerSize',CostSize(i),'LineWidth',LineWidthValue)
    
end
fill([0.1, 10, 10, 0.1],[0.5 0.5, 1.5, 1.5],color_black,'FaceAlpha',0.05,'EdgeAlpha', 0);
legend('Previous studies (Fig. 4B)','New islet donor','New liver spheroid batch','FontSize',15,'NumColumns',1)
ylim([0.5,3])
xlim([0.1,10])
hold off
grid on
%% Fig. S1A ii

x = 0:0.1:25;
[row column] = size(ParameterIndex.InSphero_params);
for j = 1:row
    params_tempHumanMT =    ParameterIndex.InSphero_params(j,1:column-1);
    params_tempEndoC   =    ParameterIndex.EndoC_params(j,1:column-1);
    
    d0 = ParameterIndex.InSphero_params(j,ismember(pNames,"d0"));
    r1 = ParameterIndex.InSphero_params(j,ismember(pNames,"r1"));
    r2 = ParameterIndex.InSphero_params(j,ismember(pNames,"r2"));
    for i = 1:7
        KvIndex   = params_tempHumanMT(ismember(pNames,"kv")) .* ParameterIndexInSphero.kv(j,i);
        Kv        = params_tempHumanMT(ismember(pNames,"kv"));
        GrowthRate    = r1*x;
        DeathRate     = d0 + (r2*x).^2;
        
        if j == 1
            maxHumanProliferation  = Kv*(GrowthRate - DeathRate);
            minHumanProliferation  = maxHumanProliferation;
            BestHumanProliferation= maxHumanProliferation;
            
            maxHumanProliferationIndex(i,:)  = KvIndex.*(GrowthRate - DeathRate);
            minHumanProliferationIndex(i,:)  = maxHumanProliferationIndex(i,:);
            BestHumanProliferationIndex(i,:) = maxHumanProliferationIndex(i,:);
        end
        
        NewHumanProliferation  = Kv*(GrowthRate - DeathRate);
        maxHumanProliferation = max(maxHumanProliferation,NewHumanProliferation);
        minHumanProliferation  = min(minHumanProliferation,NewHumanProliferation);
        
        NewHumanProliferationIndex  = KvIndex.*(GrowthRate - DeathRate);
        maxHumanProliferationIndex(i,:)  = max(maxHumanProliferationIndex(i,:),NewHumanProliferationIndex);
        minHumanProliferationIndex(i,:)  = min(minHumanProliferationIndex(i,:),NewHumanProliferationIndex);
    end
end

figure('units','normalized','outerposition',[0 0 1 1])

% PancreticCells
subplot(2,4,3)
hold on
set(gca,'ytick',-1:0.5:1,'xtick',0:5:25,'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
fill([x, fliplr(x)],[maxHumanProliferationIndex(1,:), fliplr(minHumanProliferationIndex(1,:))],color_1,'FaceAlpha',0.4,'EdgeAlpha', 0.5);
fill([x, fliplr(x)],[maxHumanProliferationIndex(2,:), fliplr(minHumanProliferationIndex(2,:))],color_2,'FaceAlpha',0.4,'EdgeAlpha', 0.5);
fill([x, fliplr(x)],[maxHumanProliferationIndex(3,:), fliplr(minHumanProliferationIndex(3,:))],color_3,'FaceAlpha',0.4,'EdgeAlpha', 0.5);
fill([x, fliplr(x)],[maxHumanProliferationIndex(4,:), fliplr(minHumanProliferationIndex(4,:))],color_4,'FaceAlpha',0.4,'EdgeAlpha', 0.5);
fill([x, fliplr(x)],[maxHumanProliferationIndex(6,:), fliplr(minHumanProliferationIndex(6,:))],color_6,'FaceAlpha',0.6,'EdgeAlpha', 0.5);
plot(x,BestHumanProliferation,'Color', color_black,'LineWidth',2)
legend('HC ', 'LC ','FCS','B27','SM','Base parameters','FontSize',15,'NumColumns',6)
ylabel({'B-cell volume change'; '(%/h)'},'FontSmoothing','on');
xlabel({'Glucose (mM)'},'FontSmoothing','on');
xlim([0,20])
ylim([-1,1])
grid on
hold off

Exenatide_x = logspace(-2,3,500);
[row column] = size(ParameterIndex.InSphero_params);

for j = 1:row
    params_tempHumanMT =    ParameterIndex.InSphero_params(j,1:column-1);
    E_stab     = params_tempHumanMT(ismember(pNames,"Exanitide_StabilisationMax"));
    EC50_stab     = params_tempHumanMT(ismember(pNames,"Exanitide_StabilisationEC50"));
    if j == 1
        maxExanitide_Stabilisation  = 1 + (E_stab.*Exenatide_x)./(Exenatide_x + EC50_stab);
        minExanitide_Stabilisation  = maxExanitide_Stabilisation;
        BestExanitide_Stabilisation= maxExanitide_Stabilisation;
    end
    NewExanitide_Stabilisation  = 1 + (E_stab.*Exenatide_x)./(Exenatide_x + EC50_stab);
    maxExanitide_Stabilisation = max(maxExanitide_Stabilisation,NewExanitide_Stabilisation);
    minExanitide_Stabilisation  = min(minExanitide_Stabilisation,NewExanitide_Stabilisation);
end

% PancreticCells
subplot(2,4,4)
hold on
set(gca,'ytick',1:0.001:1.004,'xtick',[0.01,1,100],'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
fill([Exenatide_x, fliplr(Exenatide_x)],[maxExanitide_Stabilisation, fliplr(1 + 0*minExanitide_Stabilisation)],color_black,'FaceAlpha',0.2,'EdgeAlpha', 1);
plot(Exenatide_x,BestExanitide_Stabilisation,'Color', color_black,'LineWidth',2)
ylabel({'B-cell growth rate'; '(fold change to basal)'},'FontSmoothing','on');
xlabel({'Exenatide (nM)'},'FontSmoothing','on');
xlim( [0.01 300])
ylim([0.9995,1.004])
grid on
hold off

%% Fig. 4D
figure('units','normalized','outerposition',[0 0 1 1])

Spheroidfactor = logspace(0,1,2);

maxLiverScaling  = max(ParameterIndex.InSphero_params(:,ismember(pNames,"Fspheroids0")).*Spheroidfactor.^ParameterIndex.InSphero_params(:,ismember(pNames,"AllometricLiverScalingK")));
minLiverScaling  = min(ParameterIndex.InSphero_params(:,ismember(pNames,"Fspheroids0")).*Spheroidfactor.^ParameterIndex.InSphero_params(:,ismember(pNames,"AllometricLiverScalingK")));
maxHumanScaling  = max(ParameterIndex.InSphero_params(:,ismember(pNames,"Filets0")).*Spheroidfactor.^ParameterIndex.InSphero_params(:,ismember(pNames,"AllometricScalingK")));
minHumanScaling  = min(ParameterIndex.InSphero_params(:,ismember(pNames,"Filets0")).*Spheroidfactor.^ParameterIndex.InSphero_params(:,ismember(pNames,"AllometricScalingK")));
maxEndoCScaling  = max(ParameterIndex.EndoC_params(:,ismember(pNames,"Filets0")).*Spheroidfactor.^ParameterIndex.EndoC_params(:,ismember(pNames,"AllometricScalingK")));
minEndoCScaling  = min(ParameterIndex.EndoC_params(:,ismember(pNames,"Filets0")).*Spheroidfactor.^ParameterIndex.EndoC_params(:,ismember(pNames,"AllometricScalingK")));

% Liver functionality
subplot(2,3,1)
hold on
set(gca,'ytick',[1,5,10],'xtick',[1,5,10],'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log','YScale','log')
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxLiverScaling',minLiverScaling',Spheroidfactor);
fill([timeTemp, fliplr(timeTemp)],[maxTemp', fliplr(minTemp')], color_green,'FaceAlpha',0.6,'EdgeAlpha',0.3);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxHumanScaling',minHumanScaling',Spheroidfactor);
fill([timeTemp, fliplr(timeTemp)],[maxTemp', fliplr(minTemp')], color_blue,'FaceAlpha',0.5,'EdgeAlpha',0.3);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxEndoCScaling',minEndoCScaling',Spheroidfactor);
fill([timeTemp, fliplr(timeTemp)],[maxTemp', fliplr(minTemp')], color_red,'FaceAlpha',0.5,'EdgeAlpha',0.3);

xlabel({'Total number of cells'; '(relative one spheroid/islet)'},'FontSmoothing','on');
ylabel({'Metabolic rates' ; '(relative one spheroid/islet)'},'FontSmoothing','on');
xlim([0.7,12])
ylim([0.7,10])
hold off
grid on

% Phase-I/Phase-II overtime
[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param] = IQMparameters(model);
FillBarWidth = 0.3;
load('ModelUncertainty_paramsFull')
[row column] = size(ModelUncertainty_params);
for j = 1:row
    params_temp =    ModelUncertainty_params(j,1:column-1);
    [simExp8p3_H10,SimExp6p2_10] = CompareSecretionPhases(model,params_temp,initialvalues,sNames,pNames);
    UncertaintySecretionPhase
    
end
subplot(2,3,2)
set(gca,'ytick',0:0.5:2,'xtick',0:6:24,'FontSize', 20,'FontSmoothing','on','fontname','Arial')%,'YScale','log')
hold on
fill([simExp8p3_H10.time, fliplr(simExp8p3_H10.time)],[maxEndoCphases', fliplr(minEndoCphases')],color_red,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
fill([SimExp6p2_10.time, fliplr(SimExp6p2_10.time)] ,[maxHumanphases', fliplr(minHumanphases')],color_blue,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
plot((simExp8p3_H10.time), BestEndoCphases    ,'Color', color_red   ,'LineWidth',3)
plot((SimExp6p2_10.time) , BestHumanphases    ,'Color', color_blue   ,'LineWidth',3)
ylabel({'Insulin secreted';'(relative endpoint)'},'FontSmoothing','on');
xlabel({'Time (h)'},'FontSmoothing','on');
xlim([0,24])
ylim([0,2])
grid on
hold off

% Phase-I/Phase-II ratio
maxEndoCExanitide_IP = max(ParameterIndex.EndoC_params(:,ismember(pNames,"Exanitide_IP")));
minEndoCExanitide_IP = min(ParameterIndex.EndoC_params(:,ismember(pNames,"Exanitide_IP")));
maxHumanExanitide_IP = max(ParameterIndex.InSphero_params(:,ismember(pNames,"Exanitide_IP")));
minHumanExanitide_IP = min(ParameterIndex.InSphero_params(:,ismember(pNames,"Exanitide_IP")));
subplot(2,3,3)
set(gca,'XTick',1:2,'YTick',0:25:100,'XTickLabel',{'EndoC-BH5','Human islets'},'FontSize', 20,'FontSmoothing','on','fontname','Arial')
hold on
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+1 ,100*[minEndoCExanitide_IP, minEndoCExanitide_IP , maxEndoCExanitide_IP, maxEndoCExanitide_IP], color_red,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
bar(1 ,100*ParameterIndex.EndoC_params(1,ismember(pNames,"Exanitide_IP")),0.2,'FaceColor',color_red','LineWidth',1,'FaceAlpha',0.5)
fill([-FillBarWidth, FillBarWidth, FillBarWidth,-FillBarWidth]+2 ,100*[maxHumanExanitide_IP, maxHumanExanitide_IP , minHumanExanitide_IP, minHumanExanitide_IP], color_blue,'FaceAlpha',0.3,'EdgeAlpha', 0.5);
bar(2 ,100*ParameterIndex.InSphero_params(1,ismember(pNames,"Exanitide_IP")),0.2,'FaceColor',color_blue,'LineWidth',1,'FaceAlpha',0.5)
ylabel({'Phase-I/Phase-II';'Exenatide effect (%)'},'FontSmoothing','on');
xlim([0.5,2.5])
ylim([0,100])
grid on
hold off

HumanCellPhase.EndoC = 100*[ParameterIndex.EndoC_params(1,ismember(pNames,"Exanitide_IP")),maxEndoCExanitide_IP,minEndoCExanitide_IP];
HumanCellPhase.Human = 100*[ParameterIndex.InSphero_params(1,ismember(pNames,"Exanitide_IP")),maxHumanExanitide_IP,minHumanExanitide_IP];
% save(['HumanCellPhase'],'HumanCellPhase');

 %% Extract parameters for human predictions population method
load('ModelUncertainty_paramsFull')

ModelUncertainty_paramsLOG = log(ModelUncertainty_params);
[ParameterIndexEndoC_log,ParameterIndexInSphero_log,ParameterIndex_log] = ReStrucOptimisedParams (ModelUncertainty_paramsLOG(:,1:column-1),AmountParameterOpti,pNames(1:AmountParameterOpti));

mu    = mean(ParameterIndexEndoC_log.ExenatideResponse50(1,15:19));
sigma = std(ParameterIndexEndoC_log.ExenatideResponse50(1,15:19));
ExenatideParamMatrix.ExenatideInsulin50(1,1) = exp(mu)          * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulin50")) ;
ExenatideParamMatrix.ExenatideInsulin50(1,2) = exp(mu -2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulin50"));
ExenatideParamMatrix.ExenatideInsulin50(1,3) = exp(mu +2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulin50"));
mu    = round(mean(ParameterIndexInSphero_log.ExenatideResponse50(1,8:14)),2);
sigma = round(std(ParameterIndexInSphero_log.ExenatideResponse50(1,8:14)),2);
ExenatideParamMatrix.ExenatideInsulin50(2,1) = exp(mu)          * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulin50")) ;
ExenatideParamMatrix.ExenatideInsulin50(2,2) = exp(mu -2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulin50"));
ExenatideParamMatrix.ExenatideInsulin50(2,3) = exp(mu +2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulin50"));

mu    = mean(ParameterIndexEndoC_log.ExenatideResponse(1,15:19));
sigma = std(ParameterIndexEndoC_log.ExenatideResponse(1,15:19));
ExenatideParamMatrix.ExenatideInsulinMax(1,1) = exp(mu)          * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinMax")) ;
ExenatideParamMatrix.ExenatideInsulinMax(1,2) = exp(mu -2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinMax"));
ExenatideParamMatrix.ExenatideInsulinMax(1,3) = exp(mu +2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinMax"));
mu    = round(mean(ParameterIndexInSphero_log.ExenatideResponse(1,8:14)),2);
sigma = round(std(ParameterIndexInSphero_log.ExenatideResponse(1,8:14)),2);
ExenatideParamMatrix.ExenatideInsulinMax(2,1) = exp(mu)          * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinMax")) ;
ExenatideParamMatrix.ExenatideInsulinMax(2,2) = exp(mu -2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinMax"));
ExenatideParamMatrix.ExenatideInsulinMax(2,3) = exp(mu +2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinMax"));

ExenatideParamMatrix.Exanitide_IP(1,1) = ParameterIndex.EndoC_params(1,ismember(pNames,"Exanitide_IP")) ;
ExenatideParamMatrix.Exanitide_IP(1,2) = min(ParameterIndex.EndoC_params(:,ismember(pNames,"Exanitide_IP")));
ExenatideParamMatrix.Exanitide_IP(1,3) = max(ParameterIndex.EndoC_params(:,ismember(pNames,"Exanitide_IP")));
ExenatideParamMatrix.Exanitide_IP(2,1) = ParameterIndex.InSphero_params(1,ismember(pNames,"Exanitide_IP")) ;
ExenatideParamMatrix.Exanitide_IP(2,2) = min(ParameterIndex.InSphero_params(:,ismember(pNames,"Exanitide_IP")));
ExenatideParamMatrix.Exanitide_IP(2,3) = max(ParameterIndex.InSphero_params(:,ismember(pNames,"Exanitide_IP")));

ExenatideParamMatrix.ExenatideInsulin_hill(1,1) = ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulin_hill")) ;
ExenatideParamMatrix.ExenatideInsulin_hill(1,2) = min(ParameterIndex.EndoC_params(:,ismember(pNames,"ExenatideInsulin_hill")));
ExenatideParamMatrix.ExenatideInsulin_hill(1,3) = max(ParameterIndex.EndoC_params(:,ismember(pNames,"ExenatideInsulin_hill")));
ExenatideParamMatrix.ExenatideInsulin_hill(2,1) = ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulin_hill")) ;
ExenatideParamMatrix.ExenatideInsulin_hill(2,2) = min(ParameterIndex.InSphero_params(:,ismember(pNames,"ExenatideInsulin_hill")));
ExenatideParamMatrix.ExenatideInsulin_hill(2,3) = max(ParameterIndex.InSphero_params(:,ismember(pNames,"ExenatideInsulin_hill")));

mu    = mean(ParameterIndexEndoC_log.ExenatideResponse(1,15:19));
sigma = std(ParameterIndexEndoC_log.ExenatideResponse(1,15:19));
ExenatideParamMatrix.ExenatideInsulinDecayMax(1,1) = exp(mu)          * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinDecayMax")) ;
ExenatideParamMatrix.ExenatideInsulinDecayMax(1,2) = exp(mu -2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinDecayMax"));
ExenatideParamMatrix.ExenatideInsulinDecayMax(1,3) = exp(mu +2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinDecayMax"));
mu    = round(mean(ParameterIndexInSphero_log.ExenatideResponse(1,8:14)),2);
sigma = round(std(ParameterIndexInSphero_log.ExenatideResponse(1,8:14)),2);
ExenatideParamMatrix.ExenatideInsulinDecayMax(2,1) = exp(mu)          * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinDecayMax")) ;
ExenatideParamMatrix.ExenatideInsulinDecayMax(2,2) = exp(mu -2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinDecayMax"));
ExenatideParamMatrix.ExenatideInsulinDecayMax(2,3) = exp(mu +2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinDecayMax"));

mu    = mean(ParameterIndexEndoC_log.ExenatideResponse50(1,15:19));
sigma = std(ParameterIndexEndoC_log.ExenatideResponse50(1,15:19));
ExenatideParamMatrix.ExenatideInsulinDecay50(1,1) = exp(mu)          * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinDecay50")) ;
ExenatideParamMatrix.ExenatideInsulinDecay50(1,2) = exp(mu -2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinDecay50"));
ExenatideParamMatrix.ExenatideInsulinDecay50(1,3) = exp(mu +2*sigma) * ParameterIndex.EndoC_params(1,ismember(pNames,"ExenatideInsulinDecay50"));
mu    = round(mean(ParameterIndexInSphero_log.ExenatideResponse50(1,8:14)),2);
sigma = round(std(ParameterIndexInSphero_log.ExenatideResponse50(1,8:14)),2);
ExenatideParamMatrix.ExenatideInsulinDecay50(2,1) = exp(mu)          * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinDecay50")) ;
ExenatideParamMatrix.ExenatideInsulinDecay50(2,2) = exp(mu -2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinDecay50"));
ExenatideParamMatrix.ExenatideInsulinDecay50(2,3) = exp(mu +2*sigma) * ParameterIndex.InSphero_params(1,ismember(pNames,"ExenatideInsulinDecay50"));

ExenatideParamMatrix.InVitroPDbest  = [mean(ExenatideParamMatrix.ExenatideInsulinMax(1:2,1)),mean(ExenatideParamMatrix.ExenatideInsulinDecayMax(1:2,1)), mean(ExenatideParamMatrix.ExenatideInsulin50(1:2,1)), mean(ExenatideParamMatrix.ExenatideInsulinDecay50(1:2,1)), mean(ExenatideParamMatrix.ExenatideInsulin_hill(1:2,1))];
try
ExenatideParamMatrix.InVitroPD      = combvec(mean(ExenatideParamMatrix.ExenatideInsulinMax(1:2,2:3)),mean(ExenatideParamMatrix.ExenatideInsulinDecayMax(1:2,2:3)), mean(ExenatideParamMatrix.ExenatideInsulin50(1:2,2:3)), mean(ExenatideParamMatrix.ExenatideInsulinDecay50(1:2,2:3)), mean(ExenatideParamMatrix.ExenatideInsulin_hill(1:2,2:3)))';
catch error
    disp('Deep learning toolbox is not installed')
end
%save(['ExenatideParamMatrix_population'],'ExenatideParamMatrix');

%% Plot the exenatide pd above
load('ExenatideParamMatrix_population')

Exenatide_x = logspace(-3,2,500);
  
for j = 1:3
    
    % EndoC
    Emax     = ExenatideParamMatrix.ExenatideInsulinMax(1,j);
    Emin     = ExenatideParamMatrix.ExenatideInsulinDecayMax(1,j);
    Emax50   = ExenatideParamMatrix.ExenatideInsulin50(1,j);
    Emin50   = ExenatideParamMatrix.ExenatideInsulinDecay50(1,j);
    Ehill    = ExenatideParamMatrix.ExenatideInsulin_hill(1,j);
    
    if j == 1
        maxEffectEndoC  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
        minEffectEndoC  = maxEffectEndoC;
        BestEffectEndoC = maxEffectEndoC;
    end
    NewEffectEndoC  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
        maxEffectEndoC = max(maxEffectEndoC,NewEffectEndoC);
        minEffectEndoC  = min(minEffectEndoC,NewEffectEndoC);
end

for j = 1:3
    
    % Human
    Emax     = ExenatideParamMatrix.ExenatideInsulinMax(2,j);
    Emin     = ExenatideParamMatrix.ExenatideInsulinDecayMax(2,j);
    Emax50   = ExenatideParamMatrix.ExenatideInsulin50(2,j);
    Emin50   = ExenatideParamMatrix.ExenatideInsulinDecay50(2,j);
    Ehill    = ExenatideParamMatrix.ExenatideInsulin_hill(2,j);
    if j == 1
        maxEffectHuman  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
        minEffectHuman  = maxEffectHuman;
        BestEffectHuman = maxEffectHuman;
    end
    NewEffectHuman  = 1 + ((Emax.*(Exenatide_x.^Ehill))./((Emax50^Ehill)+Exenatide_x.^Ehill) - (Emin.*(Exenatide_x.^Ehill))./((Emin50^Ehill)+Exenatide_x.^Ehill));
        maxEffectHuman = max(maxEffectHuman,NewEffectHuman);
        minEffectHuman  = min(minEffectHuman,NewEffectHuman);
end

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
hold on
set(gca,'xtick',[0.001,0.01,0.1],'ytick',0:3:9,'FontSize', 20,'FontSmoothing','on','fontname','Arial','XScale','log')
plot(Exenatide_x,BestEffectEndoC,'Color', color_red,'LineWidth',2)
plot(Exenatide_x,BestEffectHuman,'Color', color_blue,'LineWidth',2)
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxEffectEndoC,minEffectEndoC,Exenatide_x);
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_red,'FaceAlpha',0.2,'EdgeAlpha',0.1);
[maxTemp,minTemp,timeTemp] = RemoveNegativeFromLog(maxEffectHuman,minEffectHuman,Exenatide_x);
fill([timeTemp, fliplr(timeTemp)],[maxTemp, fliplr(minTemp)], color_blue,'FaceAlpha',0.2,'EdgeAlpha',0.1);
xlim( [0.001 0.3])
ylim( [0 11])
xlabel("Exenatide (nM)");
ylabel({'Insulin secretion' ; '(fold change to basal)'},'FontSmoothing','on');
legend('EndoC-BH5','Human islets','FontSize',15,'NumColumns',5)
hold off
grid on

%%
function [ParameterIndexEndoC,ParameterIndexInSphero,ParameterIndex] = ReStrucOptimisedParams (OptimisedParam,AmountParameterOpti,pNames)


%% Add parameters that there is only one of
params(:, 	1	) = 	OptimisedParam(:, 	1	)	;%	ISk                               
params(:, 	2	) = 	OptimisedParam(:, 	2	)	;%	IS0                               
params(:, 	3	) = 	OptimisedParam(:, 	3	)	;%	InsulinResistanceUpperlimit       
params(:, 	4	) = 	OptimisedParam(:, 	4	)	;%	InsulinResistanceTimeDependency   
params(:, 	5	) = 	OptimisedParam(:, 	5	)	;%	Fspheroids50                    
params(:, 	6	) = 	OptimisedParam(:, 	6	)	;%	Fspheroids0                     
params(:, 	7	) = 	OptimisedParam(:, 	7	)	;%	Fspheroids_hill                 
params(:, 	8	) = 	OptimisedParam(:, 	8	)	;%	InsulinResponseMax              
params(:, 	9	) = 	OptimisedParam(:, 	9	)	;%	InsulinResponseLactateK         
params(:, 	10	) = 	OptimisedParam(:, 	10	)	;%	InsulinResponse50                
params(:, 	11	) = 	OptimisedParam(:, 	11	)	;%	InsulinResponse_hill            
params(:, 	12	) = 	OptimisedParam(:, 	12	)	;%	Uil_iiK                         
params(:, 	13	) = 	OptimisedParam(:, 	13	)	;%	InsulinClearanceLiverK          
params(:, 	14	) = 	OptimisedParam(:, 	14	)	;%	LactateProductionK              
params(:, 	15	) = 	OptimisedParam(:, 	15	)	;%	GoutK                           
params(:, 	16	) = 	OptimisedParam(:, 	16	)	;%	LactateUk                       
params(:, 	17	) = 	OptimisedParam(:, 	17	)	;%	AllometricLiverScalingK
params(:, 	18	) = 	OptimisedParam(:, 	18	)	;%	AllometricScalingK              
params(:, 	19	) = 	OptimisedParam(:, 	19	)	;%	Fislets50                       
params(:, 	20	) = 	OptimisedParam(:, 	20	)	;%	Filets0                         
params(:, 	21	) = 	OptimisedParam(:, 	21	)	;%	Filets_hill                     
params(:, 	22	) = 	OptimisedParam(:, 	22	)	;%	d0                              
params(:, 	23	) = 	OptimisedParam(:, 	23	)	;%	r1                              
params(:, 	24	) = 	OptimisedParam(:, 	24	)	;%	r2                              
params(:, 	25	) = 	OptimisedParam(:, 	25	)	;%	kv                              
params(:, 	26	) = 	OptimisedParam(:, 	26	)	;%	GlucoseIsletsMediumDiffusion                      
params(:, 	27	) = 	OptimisedParam(:, 	27	)	;%	ExenatideDegradiationK                            
params(:, 	28	) = 	OptimisedParam(:, 	28	)	;%	ExenatideInsulinMax                               
params(:, 	29	) = 	OptimisedParam(:, 	29	)	;%	Exanitide_IP                                      
params(:, 	30	) = 	OptimisedParam(:, 	30	)	;%	ExenatideInsulin50                                
params(:, 	31	) = 	OptimisedParam(:, 	31	)	;%	ExenatideInsulin_hill                             
params(:, 	32	) = 	OptimisedParam(:, 	32	)	;%	ExenatideInsulinDecayMax                          
params(:, 	33	) = 	OptimisedParam(:, 	33	)	;%	ExenatideInsulinDecay50                           
params(:, 	34	) = 	OptimisedParam(:, 	34	)	;%	Exanitide_StabilisationMax                        
params(:, 	35	) = 	OptimisedParam(:, 	35	)	;%	Exanitide_StabilisationIC50                       
params(:, 	36	) = 	OptimisedParam(:, 	36	)	;%	IP_basalK                           
params(:, 	37	) = 	OptimisedParam(:, 	37	)	;%	IP_gdROCk                           
params(:, 	38	) = 	OptimisedParam(:, 	38	)	;%	IP_gdROC_delayK                     
params(:, 	39	) = 	OptimisedParam(:, 	39	)	;%	IP_gdBaselineMax                      
params(:, 	40	) = 	OptimisedParam(:, 	40	)	;%	IP_BaselineK                          
params(:, 	41	) = 	OptimisedParam(:, 	41	)	;%	IP_gdBaseline50                       
params(:, 	42	) = 	OptimisedParam(:, 	42	)	;%	IP_gdBaselineHill                     
params(:, 	43	) = 	OptimisedParam(:, 	43	)	;%	S_max  
params(:, 	44	) = 	OptimisedParam(:, 	44	)	;%	S50    
params(:, 	45	) = 	OptimisedParam(:, 	1	)	;%	ISk                               
params(:, 	46	) = 	OptimisedParam(:, 	2	)	;%	IS0                               
params(:, 	47	) = 	OptimisedParam(:, 	3	)	;%	InsulinResistanceUpperlimit       
params(:, 	48	) = 	OptimisedParam(:, 	4	)	;%	InsulinResistanceTimeDependency   
params(:, 	49	) = 	OptimisedParam(:, 	5	)	;%	Fspheroids50                    
params(:, 	50	) = 	OptimisedParam(:, 	6	)	;%	Fspheroids0                     
params(:, 	51	) = 	OptimisedParam(:, 	7	)	;%	Fspheroids_hill                 
params(:, 	52	) = 	OptimisedParam(:, 	8	)	;%	InsulinResponseMax              
params(:, 	53	) = 	OptimisedParam(:, 	9	)	;%	InsulinResponseLactateK         
params(:, 	54	) = 	OptimisedParam(:, 	10	)	;%	InsulinResponse50                
params(:, 	55	) = 	OptimisedParam(:, 	11	)	;%	InsulinResponse_hill            
params(:, 	56	) = 	OptimisedParam(:, 	12	)	;%	Uil_iiK                         
params(:, 	57	) = 	OptimisedParam(:, 	13	)	;%	InsulinClearanceLiverK          
params(:, 	58	) = 	OptimisedParam(:, 	14	)	;%	LactateProductionK              
params(:, 	59	) = 	OptimisedParam(:, 	15	)	;%	GoutK                           
params(:, 	60	) = 	OptimisedParam(:, 	16	)	;%	LactateUk                       
params(:, 	61	) = 	OptimisedParam(:, 	17	)	;%	AllometricLiverScalingK
params(:, 	62	) = 	OptimisedParam(:, 	45	)	;%	AllometricScalingK              
params(:, 	63	) = 	OptimisedParam(:, 	46	)	;%	Fislets50                       
params(:, 	64	) = 	OptimisedParam(:, 	47	)	;%	Filets0                         
params(:, 	65	) = 	OptimisedParam(:, 	48	)	;%	Filets_hill                     
params(:, 	66	) = 	OptimisedParam(:, 	22	)	;%	d0                              
params(:, 	67	) = 	OptimisedParam(:, 	23	)	;%	r1                              
params(:, 	68	) = 	OptimisedParam(:, 	24	)	;%	r2                              
params(:, 	69	) = 	OptimisedParam(:, 	49	)	;%	kv                              
params(:, 	70	) = 	OptimisedParam(:, 	50	)	;%	GlucoseIsletsMediumDiffusion                      
params(:, 	71	) = 	OptimisedParam(:, 	27	)	;%	ExenatideDegradiationK                            
params(:, 	72	) = 	OptimisedParam(:, 	51	)	;%	ExenatideInsulinMax                               
params(:, 	73	) = 	OptimisedParam(:, 	52	)	;%	Exanitide_IP                                      
params(:, 	74	) = 	OptimisedParam(:, 	53	)	;%	ExenatideInsulin50                                
params(:, 	75	) = 	OptimisedParam(:, 	54	)	;%	ExenatideInsulin_hill                             
params(:, 	76	) = 	OptimisedParam(:, 	55	)	;%	ExenatideInsulinDecayMax                          
params(:, 	77	) = 	OptimisedParam(:, 	56	)	;%	ExenatideInsulinDecay50                           
params(:, 	78	) = 	OptimisedParam(:, 	34	)	;%	Exanitide_StabilisationMax                        
params(:, 	79	) = 	OptimisedParam(:, 	35	)	;%	Exanitide_StabilisationIC50                       
params(:, 	80	) = 	OptimisedParam(:, 	57	)	;%	IP_basalK                           
params(:, 	81	) = 	OptimisedParam(:, 	58	)	;%	IP_gdROCk                           
params(:, 	82	) = 	OptimisedParam(:, 	59	)	;%	IP_gdROC_delayK                     
params(:, 	83	) = 	OptimisedParam(:, 	60	)	;%	IP_gdBaselineMax                      
params(:, 	84	) = 	OptimisedParam(:, 	61	)	;%	IP_BaselineK                          
params(:, 	85	) = 	OptimisedParam(:, 	62	)	;%	IP_gdBaseline50                       
params(:, 	86	) = 	OptimisedParam(:, 	63	)	;%	IP_gdBaselineHill                     
params(:, 	87	) = 	OptimisedParam(:, 	64	)	;%	S_max  
params(:, 	88	) = 	OptimisedParam(:, 	65	)	;%	S50    
params(:, 	89	) = 	OptimisedParam(:, 	66	)	;%	HepaRG_f50(:, 1)   
params(:, 	90	) = 	OptimisedParam(:, 	67	)	;%	HepaRG_f50(:, 2) 
params(:, 	91	) = 	OptimisedParam(:, 	68	)	;%	HepaRG_f50(:, 3)
params(:, 	92	) = 	OptimisedParam(:, 	69	)	;%	HepaRG_f50(:, 4)
params(:, 	93	) = 	OptimisedParam(:, 	70	)	;%	HepaRG_f50(:, 5)
params(:, 	94	) = 	OptimisedParam(:, 	71	)	;%	HepaRG_f0(:, 1)                            
params(:, 	95	) = 	OptimisedParam(:, 	72	)	;%	HepaRG_f0(:, 2)  
params(:, 	96	) = 	OptimisedParam(:, 	73	)	;%	HepaRG_f0(:, 3)  
params(:, 	97	) = 	OptimisedParam(:, 	74	)	;%	HepaRG_f0(:, 4)  
params(:, 	98	) = 	OptimisedParam(:, 	75	)	;%	HepaRG_f0(:, 5)  
params(:, 	99	) = 	OptimisedParam(:, 	76	)	;%	HepaRG_IS(:, 1)  
params(:, 	100	) = 	OptimisedParam(:, 	77	)	;%	HepaRG_IS(:, 2)  
params(:, 	101	) = 	OptimisedParam(:, 	78	)	;%	HepaRG_IS(:, 3)  
params(:, 	102	) = 	OptimisedParam(:, 	79	)	;%	HepaRG_IS(:, 4)  
params(:, 	103	) = 	OptimisedParam(:, 	80	)	;%	HepaRG_IS(:, 5)  
params(:, 	104	) = 	OptimisedParam(:, 	81	)	;%	InsulinResistanceTimeDependency(:, 1) 
params(:, 	105	) = 	OptimisedParam(:, 	82	)	;%	IS0(:, 1)
params(:, 	106	) = 	OptimisedParam(:, 	83	)	;%	Fspheroids0(:, 1)
params(:, 	107	) = 	OptimisedParam(:, 	84	)	;%	Fspheroids50(:, 1)
params(:, 	108	) = 	OptimisedParam(:, 	85	)	;%	Fspheroids_hill(:, 1)
params(:, 	109	) = 	OptimisedParam(:, 	86	)	;%	InsulinResistanceTimeDependency(:, 2) 
params(:, 	110	) = 	OptimisedParam(:, 	87	)	;%	IS0(:, 2)                             
params(:, 	111	) = 	OptimisedParam(:, 	88	)	;%	Fspheroids0(:, 2)                     
params(:, 	112	) = 	OptimisedParam(:, 	89	)	;%	Fspheroids50(:, 2)                    
params(:, 	113	) = 	OptimisedParam(:, 	90	)	;%	Fspheroids_hill(:, 2)                 
params(:, 	114	) = 	OptimisedParam(:, 	91	)	;%	InsulinResistanceTimeDependency(:, 3)
params(:, 	115	) = 	OptimisedParam(:, 	92	)	;%	IS0(:, 3)
params(:, 	116	) = 	OptimisedParam(:, 	93	)	;%	Fspheroids0(:, 3)
params(:, 	117	) = 	OptimisedParam(:, 	94	)	;%	Fspheroids50(:, 3)
params(:, 	118	) = 	OptimisedParam(:, 	95	)	;%	Fspheroids_hill(:, 3)
params(:, 	119	) = 	OptimisedParam(:, 	96	)	;%	InsulinResistanceTimeDependency(:, 4)
params(:, 	120	) = 	OptimisedParam(:, 	97	)	;%	IS0(:, 4)
params(:, 	121	) = 	OptimisedParam(:, 	98	)	;%	Fspheroids0(:, 4)
params(:, 	122	) = 	OptimisedParam(:, 	99	)	;%	Fspheroids50(:, 4)
params(:, 	123	) = 	OptimisedParam(:, 	100	)	;%	Fspheroids_hill(:, 4)
params(:, 	124	) = 	OptimisedParam(:, 	101	)	;%	kv(:, 3)                              
params(:, 	125	) = 	OptimisedParam(:, 	102	)	;%	ExenatideResponse(:, 3)               
params(:, 	126	) = 	OptimisedParam(:, 	103	)	;%	ExenatideResponse50(:, 3)             
params(:, 	127	) = 	OptimisedParam(:, 	104	)	;%	Filets0(:, 3)                         
params(:, 	128	) = 	OptimisedParam(:, 	105	)	;%	Fislets50(:, 3)                       
params(:, 	129	) = 	OptimisedParam(:, 	106	)	;%	Filets_hill(:, 3)                     
params(:, 	130	) = 	OptimisedParam(:, 	107	)	;%	kv(:, 4)                              
params(:, 	131	) = 	OptimisedParam(:, 	108	)	;%	ExenatideResponse(:, 4)               
params(:, 	132	) = 	OptimisedParam(:, 	109	)	;%	ExenatideResponse50(:, 4)             
params(:, 	133	) = 	OptimisedParam(:, 	110	)	;%	Filets0(:, 4)                         
params(:, 	134	) = 	OptimisedParam(:, 	111	)	;%	Fislets50(:, 4)                       
params(:, 	135	) = 	OptimisedParam(:, 	112	)	;%	Filets_hill(:, 4)                     
params(:, 	136	) = 	OptimisedParam(:, 	113	)	;%	ExenatideResponse(:, 5)               
params(:, 	137	) = 	OptimisedParam(:, 	114	)	;%	Fislets50(:, 5)                       
params(:, 	138	) = 	OptimisedParam(:, 	115	)	;%	PersonSpecificParametersInSphero.kv(:, 6)                              
params(:, 	139	) = 	OptimisedParam(:, 	116	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 6)               
params(:, 	140	) = 	OptimisedParam(:, 	117	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 6)             
params(:, 	141	) = 	OptimisedParam(:, 	118	)	;%	PersonSpecificParametersInSphero.Filets0(:, 6)                         
params(:, 	142	) = 	OptimisedParam(:, 	119	)	;%	PersonSpecificParametersInSphero.Fislets50(:, 6)                       
params(:, 	143	) = 	OptimisedParam(:, 	120	)	;%	PersonSpecificParametersInSphero.Filets_hill(:, 6)                     
params(:, 	144	) = 	OptimisedParam(:, 	121	)	;%	PersonSpecificParametersEndoC.kv(:, 7)                              
params(:, 	145	) = 	OptimisedParam(:, 	122	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 7)               
params(:, 	146	) = 	OptimisedParam(:, 	123	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 7)             
params(:, 	147	) = 	OptimisedParam(:, 	124	)	;%	PersonSpecificParametersEndoC.Filets0(:, 7)                         
params(:, 	148	) = 	OptimisedParam(:, 	125	)	;%	PersonSpecificParametersEndoC.Fislets50(:, 7)                       
params(:, 	149	) = 	OptimisedParam(:, 	126	)	;%	PersonSpecificParametersEndoC.Filets_hill(:, 7)                     
params(:, 	150	) = 	OptimisedParam(:, 	127	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 8)              
params(:, 	151	) = 	OptimisedParam(:, 	128	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 9)              
params(:, 	152	) = 	OptimisedParam(:, 	129	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 10)             
params(:, 	153	) = 	OptimisedParam(:, 	130	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 11)             
params(:, 	154	) = 	OptimisedParam(:, 	131	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 12)             
params(:, 	155	) = 	OptimisedParam(:, 	132	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 13)             
params(:, 	156	) = 	OptimisedParam(:, 	133	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 14)             
params(:, 	157	) = 	OptimisedParam(:, 	134	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 15)             
params(:, 	158	) = 	OptimisedParam(:, 	135	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 16)             
params(:, 	159	) = 	OptimisedParam(:, 	136	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 17)             
params(:, 	160	) = 	OptimisedParam(:, 	137	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 18)             
params(:, 	161	) = 	OptimisedParam(:, 	138	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 19)             
params(:, 	162	) = 	OptimisedParam(:, 	139	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 8)            
params(:, 	163	) = 	OptimisedParam(:, 	140	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 9)            
params(:, 	164	) = 	OptimisedParam(:, 	141	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 10)           
params(:, 	165	) = 	OptimisedParam(:, 	142	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 11)           
params(:, 	166	) = 	OptimisedParam(:, 	143	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 12)           
params(:, 	167	) = 	OptimisedParam(:, 	144	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 13)           
params(:, 	168	) = 	OptimisedParam(:, 	145	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 14)           
params(:, 	169	) = 	OptimisedParam(:, 	146	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 15)           
params(:, 	170	) = 	OptimisedParam(:, 	147	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 16)           
params(:, 	171	) = 	OptimisedParam(:, 	148	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 17)           
params(:, 	172	) = 	OptimisedParam(:, 	149	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 18)           
params(:, 	173	) = 	OptimisedParam(:, 	150	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 19)           
params(:, 	174	) = 	OptimisedParam(:, 	151	)	;%	PersonSpecificParametersInSphero.Filets0(:, 8)                        
params(:, 	175	) = 	OptimisedParam(:, 	152	)	;%	PersonSpecificParametersInSphero.Filets0(:, 9)                        
params(:, 	176	) = 	OptimisedParam(:, 	153	)	;%	PersonSpecificParametersInSphero.Filets0(:, 10)                       
params(:, 	177	) = 	OptimisedParam(:, 	154	)	;%	PersonSpecificParametersInSphero.Filets0(:, 11)                       
params(:, 	178	) = 	OptimisedParam(:, 	155	)	;%	PersonSpecificParametersInSphero.Filets0(:, 12)                       
params(:, 	179	) = 	OptimisedParam(:, 	156	)	;%	PersonSpecificParametersInSphero.Filets0(:, 13)                       
params(:, 	180	) = 	OptimisedParam(:, 	157	)	;%	PersonSpecificParametersInSphero.Filets0(:, 14)                       
params(:, 	181	) = 	OptimisedParam(:, 	158	)	;%	PersonSpecificParametersInSphero.Filets0(:, 15)                        
params(:, 	182	) = 	OptimisedParam(:, 	159	)	;%	PersonSpecificParametersInSphero.Filets0(:, 16)                        
params(:, 	183	) = 	OptimisedParam(:, 	160	)	;%	PersonSpecificParametersInSphero.Filets0(:, 17)                        
params(:, 	184	) = 	OptimisedParam(:, 	161	)	;%	PersonSpecificParametersEndoC.Filets0(:, 18)                       
params(:, 	185	) = 	OptimisedParam(:, 	162	)	;%	PersonSpecificParametersEndoC.Filets0(:, 19)                       
params(:, 	186	) = 	OptimisedParam(:, 	163	)	;%	PersonSpecificParametersEndoC.Filets0(:, 20)                       
params(:, 	187	) = 	OptimisedParam(:, 	164	)	;%	PersonSpecificParametersEndoC.Filets0(:, 21)                       
params(:, 	188	) = 	OptimisedParam(:, 	165	)	;%	PersonSpecificParametersEndoC.Filets0(:, 22)                       
params(:, 	189	) = 	OptimisedParam(:, 	166	)	;%	PersonSpecificParametersEndoC.EndoCBasal_Uncertainty            
params(:, 	190	) = 	OptimisedParam(:, 	167	)	;%	PersonSpecificParametersEndoC.EndoCStoredInsulin                
params(:, 	191	) = 	OptimisedParam(:, 	168	)	;%	WashingUncertainty EndoC  
params(:, 	192	) = 	OptimisedParam(:, 	169	)	;%	PersonSpecificParametersInSphero.ExperimentalInducedStress(:, 1)   
params(:, 	193	) = 	OptimisedParam(:, 	170	)	;%	PersonSpecificParametersEndoC.ExperimentalInducedStress(:, 3)   
params(:, 	194	) = 	OptimisedParam(:, 	171	)	;%	PersonSpecificParametersInSphero.InSpheroInsulinPhases_Uncertainty  
params(:, 	195	) = 	OptimisedParam(:, 	172	)	;%	PersonSpecificParametersInSphero.FlowGSISBasalS  
params(:, 	196	) = 	OptimisedParam(:, 	173	)	;%	PersonSpecificParametersEndoC.kv(:, 1)                              
params(:, 	197	) = 	OptimisedParam(:, 	174	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 1)               
params(:, 	198	) = 	OptimisedParam(:, 	175	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 1)             
params(:, 	199	) = 	OptimisedParam(:, 	176	)	;%	PersonSpecificParametersEndoC.Filets0(:, 1)                         
params(:, 	200	) = 	OptimisedParam(:, 	177	)	;%	PersonSpecificParametersEndoC.Fislets50(:, 1)                       
params(:, 	201	) = 	OptimisedParam(:, 	178	)	;%	PersonSpecificParametersEndoC.Filets_hill(:, 1)                     
params(:, 	202	) = 	OptimisedParam(:, 	179	)	;%	PersonSpecificParametersEndoC.kv(:, 2)                              
params(:, 	203	) = 	OptimisedParam(:, 	180	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(:, 2)               
params(:, 	204	) = 	OptimisedParam(:, 	181	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(:, 2)             
params(:, 	205	) = 	OptimisedParam(:, 	182	)	;%	PersonSpecificParametersEndoC.Filets0(:, 2)                         
params(:, 	206	) = 	OptimisedParam(:, 	183	)	;%	PersonSpecificParametersEndoC.Fislets50(:, 2)                       
params(:, 	207	) = 	OptimisedParam(:, 	184	)	;%	PersonSpecificParametersEndoC.Filets_hill(:, 2)                     
params(:, 	208	) = 	OptimisedParam(:, 	173	)	;%	PersonSpecificParametersInSphero.kv(:, 1)                              
params(:, 	209	) = 	OptimisedParam(:, 	185	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 1)               
params(:, 	210	) = 	OptimisedParam(:, 	186	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 1)             
params(:, 	211	) = 	OptimisedParam(:, 	187	)	;%	PersonSpecificParametersInSphero.Filets0(:, 1)                         
params(:, 	212	) = 	OptimisedParam(:, 	188	)	;%	PersonSpecificParametersInSphero.Fislets50(:, 1)                       
params(:, 	213	) = 	OptimisedParam(:, 	189	)	;%	PersonSpecificParametersInSphero.Filets_hill(:, 1)                     
params(:, 	214	) = 	OptimisedParam(:, 	179	)	;%	PersonSpecificParametersInSphero.kv(:, 2)                              
params(:, 	215	) = 	OptimisedParam(:, 	190	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(:, 2)               
params(:, 	216	) = 	OptimisedParam(:, 	191	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(:, 2)             
params(:, 	217	) = 	OptimisedParam(:, 	192	)	;%	PersonSpecificParametersInSphero.Filets0(:, 2)                         
params(:, 	218	) = 	OptimisedParam(:, 	193	)	;%	PersonSpecificParametersInSphero.Fislets50(:, 2)                       
params(:, 	219	) = 	OptimisedParam(:, 	194	)	;%	PersonSpecificParametersInSphero.Filets_hill(:, 2)

%%
ParameterIndex.EndoC_params   (:, 1:44) = params(:, 1:44);  % EndoC
ParameterIndex.InSphero_params(:, 1:44) = params(:, 45:88); % Human MT
%% HepaRG

ParameterIndex.HepaRG_f50(:, 1)    = params(:, 88+1); % Batch 1
ParameterIndex.HepaRG_f50(:, 2)    = params(:, 88+2); % Batch 2
ParameterIndex.HepaRG_f50(:, 3)    = params(:, 88+3); % Batch 3
ParameterIndex.HepaRG_f50(:, 4)    = params(:, 88+4); % Batch 4
ParameterIndex.HepaRG_f50(:, 5)    = params(:, 88+5); % Batch 5

ParameterIndex.HepaRG_f0(:, 1)    = params(:, 88+6); % Batch 1
ParameterIndex.HepaRG_f0(:, 2)    = params(:, 88+7); % Batch 2
ParameterIndex.HepaRG_f0(:, 3)    = params(:, 88+8); % Batch 3
ParameterIndex.HepaRG_f0(:, 4)    = params(:, 88+9); % Batch 4
ParameterIndex.HepaRG_f0(:, 5)    = params(:, 88+10); % Batch 5

ParameterIndex.HepaRG_IS(:, 1)    = params(:, 88+11);  % Batch 1
ParameterIndex.HepaRG_IS(:, 2)    = params(:, 88+12); % Batch 2
ParameterIndex.HepaRG_IS(:, 3)    = params(:, 88+13); % Batch 3
ParameterIndex.HepaRG_IS(:, 4)    = params(:, 88+14); % Batch 4
ParameterIndex.HepaRG_IS(:, 5)    = params(:, 88+15); % Batch 5

% HC
ParameterIndex.InsulinResistanceTimeDependency(:, 1) = params(:, 103+1);
ParameterIndex.IS0(:, 1)                             = params(:, 103+2);
ParameterIndex.Fspheroids0(:, 1)                     = params(:, 103+3); 
ParameterIndex.Fspheroids50(:, 1)                    = params(:, 103+4); 
ParameterIndex.Fspheroids_hill(:, 1)                 = params(:, 103+5);

% NC
ParameterIndex.InsulinResistanceTimeDependency(:, 2) = params(:, 103+5+1);
ParameterIndex.IS0(:, 2)                             = params(:, 103+5+2);
ParameterIndex.Fspheroids0(:, 2)                     = params(:, 103+5+3); 
ParameterIndex.Fspheroids50(:, 2)                    = params(:, 103+5+4); 
ParameterIndex.Fspheroids_hill(:, 2)                 = params(:, 103+5+5);

% FCS
ParameterIndex.InsulinResistanceTimeDependency(:, 3) = params(:, 103+10+1);
ParameterIndex.IS0(:, 3)                             = params(:, 103+10+2);
ParameterIndex.Fspheroids0(:, 3)                     = params(:, 103+10+3); 
ParameterIndex.Fspheroids50(:, 3)                    = params(:, 103+10+4); 
ParameterIndex.Fspheroids_hill(:, 3)                 = params(:, 103+10+5);

% B27
ParameterIndex.InsulinResistanceTimeDependency(:, 4) = params(:, 103+15+1);
ParameterIndex.IS0(:, 4)                             = params(:, 103+15+2);
ParameterIndex.Fspheroids0(:, 4)                     = params(:, 103+15+3); 
ParameterIndex.Fspheroids50(:, 4)                    = params(:, 103+15+4); 
ParameterIndex.Fspheroids_hill(:, 4)                 = params(:, 103+15+5);


%% Both

% FCS
ParameterIndex.kv(:, 3)                              = params(:, 123+1); 
ParameterIndex.ExenatideResponse(:, 3)               = params(:, 123+2); 
ParameterIndex.ExenatideResponse50(:, 3)             = params(:, 123+3); 
ParameterIndex.Filets0(:, 3)                         = params(:, 123+4); 
ParameterIndex.Fislets50(:, 3)                       = params(:, 123+5); 
ParameterIndex.Filets_hill(:, 3)                     = params(:, 123+6); 

% B27
ParameterIndex.kv(:, 4)                              = params(:, 123+6+1); 
ParameterIndex.ExenatideResponse(:, 4)               = params(:, 123+6+2); 
ParameterIndex.ExenatideResponse50(:, 4)             = params(:, 123+6+3); 
ParameterIndex.Filets0(:, 4)                         = params(:, 123+6+4); 
ParameterIndex.Fislets50(:, 4)                       = params(:, 123+6+5); 
ParameterIndex.Filets_hill(:, 4)                     = params(:, 123+6+6); 

% BSA
ParameterIndex.kv(:, 5)                              = 1; 
ParameterIndex.ExenatideResponse(:, 5)               = params(:, 136);
ParameterIndex.ExenatideResponse50(:, 5)             = 1;
ParameterIndex.Filets0(:, 5)                         = 1; 
ParameterIndex.Fislets50(:, 5)                       = params(:, 137); 
ParameterIndex.Filets_hill(:, 5)                     = 1; 

% SM
ParameterIndex.InsulinResistanceTimeDependency(:, 6) = 1;
ParameterIndex.IS0(:, 6)                             = 1;
ParameterIndex.Fspheroids0(:, 6)                     = 1; 
ParameterIndex.Fspheroids50(:, 6)                    = 1; 
ParameterIndex.Fspheroids_hill(:, 6)                 = 1;
ParameterIndex.kv(:, 6)                              = params(:, 137+1); 
ParameterIndex.ExenatideResponse(:, 6)               = params(:, 137+2); 
ParameterIndex.ExenatideResponse50(:, 6)             = params(:, 137+3); 
ParameterIndex.Filets0(:, 6)                         = params(:, 137+4); 
ParameterIndex.Fislets50(:, 6)                       = params(:, 137+5);
ParameterIndex.Filets_hill(:, 6)                     = params(:, 137+6); 

% ULT
ParameterIndex.InsulinResistanceTimeDependency(:, 7) = 1;
ParameterIndex.IS0(:, 7)                             = 1;
ParameterIndex.Fspheroids0(:, 7)                     = 1; 
ParameterIndex.Fspheroids50(:, 7)                    = 1; 
ParameterIndex.Fspheroids_hill(:, 7)                 = 1; 
ParameterIndex.kv(:, 7)                              = params(:, 143+1); 
ParameterIndex.ExenatideResponse(:, 7)               = params(:, 143+2); 
ParameterIndex.ExenatideResponse50(:, 7)             = params(:, 143+3); 
ParameterIndex.Filets0(:, 7)                         = params(:, 143+4); 
ParameterIndex.Fislets50(:, 7)                       = params(:, 143+5);
ParameterIndex.Filets_hill(:, 7)                     = params(:, 143+6); 

%% Exenatide response

% Donor-donor with exenatide
ParameterIndex.ExenatideResponse(:, 8)              = params(:, 149+1);   %Donor 1 Exp6.2
ParameterIndex.ExenatideResponse(:, 9)              = params(:, 149+2);   %Donor 2 ExpS
ParameterIndex.ExenatideResponse(:, 10)             = params(:, 149+3);   %Donor 3 ExpS
ParameterIndex.ExenatideResponse(:, 11)             = params(:, 149+4);   %Donor 4 ExpInSphero 1
ParameterIndex.ExenatideResponse(:, 12)             = params(:, 149+5);   %Donor 5 ExpInSphero 2
ParameterIndex.ExenatideResponse(:, 13)             = params(:, 149+6);   %Donor 6 ExpInSphero 3
ParameterIndex.ExenatideResponse(:, 14)             = params(:, 149+7);   %Donor 7 ExpInSphero 4
% EndoC-BH5 batch-batch
ParameterIndex.ExenatideResponse(:, 15)             = params(:, 149+8);  % Batch 1 7p2 7.3
ParameterIndex.ExenatideResponse(:, 16)             = params(:, 149+9);  % Batch 2 Exp8.1 8p3
ParameterIndex.ExenatideResponse(:, 17)             = params(:, 149+10);  % Batch 3 ref
ParameterIndex.ExenatideResponse(:, 18)             = params(:, 149+11);  % Batch 3 ref
ParameterIndex.ExenatideResponse(:, 19)             = params(:, 149+12);  % Batch 3 ref

%% Exenatide response 50

% Donor-donor with exenatide
ParameterIndex.ExenatideResponse50(:, 8)            = params(:, 161+1);   %Donor 1 Exp6.2
ParameterIndex.ExenatideResponse50(:, 9)            = params(:, 161+2);   %Donor 2 ExpS
ParameterIndex.ExenatideResponse50(:, 10)           = params(:, 161+3);  %Donor 3 ExpS
ParameterIndex.ExenatideResponse50(:, 11)           = params(:, 161+4);  %Donor 4 ExpInSphero 1
ParameterIndex.ExenatideResponse50(:, 12)           = params(:, 161+5);  %Donor 5 ExpInSphero 2
ParameterIndex.ExenatideResponse50(:, 13)           = params(:, 161+6);  %Donor 6 ExpInSphero 3
ParameterIndex.ExenatideResponse50(:, 14)           = params(:, 161+7);  %Donor 7 ExpInSphero 4
% EndoC-BH5 batch-batch
ParameterIndex.ExenatideResponse50(:, 15)           = params(:, 161+8);  % Batch 1 7p2 7.3
ParameterIndex.ExenatideResponse50(:, 16)           = params(:, 161+9);  % Batch 2 Exp8.1 8p3
ParameterIndex.ExenatideResponse50(:, 17)           = params(:, 161+10);  % Batch 3 ref
ParameterIndex.ExenatideResponse50(:, 18)           = params(:, 161+11);  % Batch 2 Exp8.1 8p3
ParameterIndex.ExenatideResponse50(:, 19)           = params(:, 161+12);  % Batch 3 ref

%% Initial functionality

% Donor-donor 
ParameterIndex.Filets0(:, 8)                        = params(:, 173+1);  %Donor 1 Exp6.2
ParameterIndex.Filets0(:, 9)                        = params(:, 173+2);  %Donor 2 ExpS
ParameterIndex.Filets0(:, 10)                       = params(:, 173+3);  %Donor 3 ExpS
ParameterIndex.Filets0(:, 11)                       = params(:, 173+4);  %Donor 4 ExpInSphero 1
ParameterIndex.Filets0(:, 12)                       = params(:, 173+5);  %Donor 5 ExpInSphero 2
ParameterIndex.Filets0(:, 13)                       = params(:, 173+6);  %Donor 6 ExpInSphero 3
ParameterIndex.Filets0(:, 14)                       = params(:, 173+7);  %Donor 7 ExpInSphero 4
ParameterIndex.Filets0(:, 15)                       = params(:, 173+8);  % Batch 1 7.3
ParameterIndex.Filets0(:, 16)                       = params(:, 173+9);  % Batch 2 Exp8.1 8p3
ParameterIndex.Filets0(:, 17)                       = params(:, 173+10);  % Batch 3 7p2

% Donor-donor wo exenatide
ParameterIndex.Filets0(:, 18)                        = params(:, 173+11);  %Donor 8 Exp3.2
ParameterIndex.Filets0(:, 19)                        = params(:, 173+12);      %Donor 9 Exp3.5
ParameterIndex.Filets0(:, 20)                        = params(:, 173+13);      %Donor 10 ExpS
ParameterIndex.Filets0(:, 21)                        = params(:, 173+14);      %Donor 9 Exp3.5
ParameterIndex.Filets0(:, 22)                        = params(:, 173+15);      %Donor 10 ExpS

%% Uncertainties

% Uncertainties
ParameterIndex.EndoCBasal_Uncertainty            = params(:, 188+1);  %measurment uncertainty in ref data
ParameterIndex.EndoCStoredInsulin                = params(:, 188+2);  % all exp
ParameterIndex.EndoCWashing_Uncertainty          = params(:, 188+3);  % EndoCWashing_Uncertainty
ParameterIndex.ExperimentalInducedStress(:, 1)      = params(:, 188+4);   %Exp 6p2
ParameterIndex.ExperimentalInducedStress(:, 3)       = params(:, 188+5);  %Exp 7p3
ParameterIndex.InSpheroInsulinPhases_Uncertainty  = params(:, 188+6);  %SimulateInsulinPhases
ParameterIndex.FlowGSISBasalS                     = params(:, 188+7);  %FlowGSISBasalS

%% Overlaping values HC and NC
ParameterIndexEndoC = ParameterIndex;
% HC
ParameterIndexEndoC.kv(:, 1)                              = params(:, 195+1);
ParameterIndexEndoC.ExenatideResponse(:, 1)               = params(:, 195+2); 
ParameterIndexEndoC.ExenatideResponse50(:, 1)             = params(:, 195+3); 
ParameterIndexEndoC.Filets0(:, 1)                         = params(:, 195+4); 
ParameterIndexEndoC.Fislets50(:, 1)                       = params(:, 195+5); 
ParameterIndexEndoC.Filets_hill(:, 1)                     = params(:, 195+6); 
% NC
ParameterIndexEndoC.kv(:, 2)                              = params(:, 201+1); 
ParameterIndexEndoC.ExenatideResponse(:, 2)               = params(:, 201+2); 
ParameterIndexEndoC.ExenatideResponse50(:, 2)             = params(:, 201+3); 
ParameterIndexEndoC.Filets0(:, 2)                         = params(:, 201+4); 
ParameterIndexEndoC.Fislets50(:, 2)                       = params(:, 201+5); 
ParameterIndexEndoC.Filets_hill(:, 2)                     = params(:, 201+6); 

ParameterIndexInSphero = ParameterIndex;
% HC
ParameterIndexInSphero.kv(:, 1)                              = params(:, 207+1);
ParameterIndexInSphero.ExenatideResponse(:, 1)               = params(:, 207+2); 
ParameterIndexInSphero.ExenatideResponse50(:, 1)             = params(:, 207+3); 
ParameterIndexInSphero.Filets0(:, 1)                         = params(:, 207+4); 
ParameterIndexInSphero.Fislets50(:, 1)                       = params(:, 207+5); 
ParameterIndexInSphero.Filets_hill(:, 1)                     = params(:, 207+6); 
% NC
ParameterIndexInSphero.kv(:, 2)                              = params(:, 207+7); 
ParameterIndexInSphero.ExenatideResponse(:, 2)               = params(:, 207+8); 
ParameterIndexInSphero.ExenatideResponse50(:, 2)             = params(:, 207+9); 
ParameterIndexInSphero.Filets0(:, 2)                         = params(:, 207+10); 
ParameterIndexInSphero.Fislets50(:, 2)                       = params(:, 207+11); 
ParameterIndexInSphero.Filets_hill(:, 2)                     = params(:, 207+12); 
end