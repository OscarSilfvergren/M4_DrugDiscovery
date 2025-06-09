#include "stddef.h"
#include "stdarg.h"
#include "math.h"
#include "CVODEmex25.h"
#include "MPSModel.h"
#include "mexsplineaddon.h"
#include "mexmathaddon.h"
#include "kineticformulas.h"

double time;

void model(double time_local, double *stateVector, double *DDTvector, ParamData *paramdataPtr, int DOflag, double *variableVector, double *reactionVector, double *gout, int *eventVector)
{
    double Glucose_Medium,Insulin_Medium,Lactate_Medium,Albumin_Medium,Glutamin_Medium,Ketones_Medium,Glucose_Liver,PEP_Liver,Serine_Liver,Pyruvate_Liver,Glycin_Liver,Albumin_Liver,AcetylCoA_Liver,Citrate_Liver,TCA_Liver,Glutamin_Liver,OAA_Liver,Ketones_Liver,Lactate_Liver,Insulin_Liver;
    double Glucose_Pancreas,Insulin_Pancreas,GlucoseOverHealthy,Glucose_Pancrease_Delay,V_islets;
    double Imax_SI,EC50_SI,d0,r1,r2,kv,G_healthy,Vm_f_islets,Alpha,Glycolysis_k,Glycolysis_ii,GlucoseToSerineLiverK,GlucoseToSerineLiverK_ii,GluconeogenesisK,PEP_Pyruvate_LiverK,Pyruvate_CoA_LiverK,TCA_startK,TCA_rotationK,Citrate_TCA_LiverK,OAA_PEP_LiverK;
    double Pyruvate_OAA_LiverK,Serine_Pyruvate_LiverK,Serine_Glycin_LiverK,Glycin_Albumin_LiverK,Pyruvate_Lactate_LiverK,TCA_Glutamin_LiverK,CoA_Ketones_LiverK,InsulinProductionK,Glucose_Pancrease_DelayK,InsulinClearanceLiverK,G0,I0,Glutamin0,MediumChange_1G,MediumChange_2G,MediumChange_3G,MediumChange_4G,MediumChange_5G,MediumChange_6G,MediumChange_1I;
    double MediumChange_2I,MediumChange_3I,MediumChange_4I,MediumChange_5I,MediumChange_6I,MediumChange_1Glutamin,MediumChange_2Glutamin,MediumChange_3Glutamin,MediumChange_4Glutamin,MediumChange_5Glutamin,MediumChange_6Glutamin,G_GTT,I_GTT,Glutamin_GTT,MediumChange_1_time,MediumChange_2_time,MediumChange_3_time,MediumChange_4_time,MediumChange_5_time,MediumChange_6_time;
    double GTT_time,V_m_liver,V_hep,V_m_pancreas,V_m_medium,Q,CountLiver,CountPancrease;
    double Glucose_HepaticConcentration,PEP_HepaticConcentration,Pyruvate_HepaticConcentration,AcetylCoA_HepaticConcentration,Citrate_HepaticConcentration,TCA_HepaticConcentration,OAA_HepaticConcentration,Serine_HepaticConcentration,Glycin_HepaticConcentration,Albumin_HepaticConcentration,Lactate_HepaticConcentration,Ketones_HepaticConcentration,Glutamin_HepaticConcentration,Insulin_HepaticConcentration,Glucose_PancreasConcentration,Insulin_PancreasConcentration,Glucose_MediumConcentration,Insulin_MediumConcentration,Lactate_MediumConcentration,Albumin_MediumConcentration;
    double Ketones_MediumConcentration,Glutamin_MediumConcentration,GlucoseOverHealthy_sim,Glucose_Pancrease_Delay_sim,V_islets_sim,InsulinSensitivity,Growth_rate,Death_rate,F_islets,Net_rate,EGP_Pancrease,InsulinMediumToPancrease,U_ip,InsulinPancreaseToMedium,InsulinLiverToMedium,U_il,EGP_Liver,InsulinMediumToLiver,LactateLiverToMedium,LactateMediumToLiver;
    double AlbuminLiverToMedium,AlbuminMediumToLiver,KetonesLiverToMedium,KetonesMediumToLiver,GlutaminMediumToLiver,GlutaminLiverToMedium,InsulinResponse_Liver,Glycolysis,GlucoseToSerineLiver,Gluconeogenesis,InsulinClearanceLiver,PEPtoPyruvate,PyruvateOxi_L,TCA_start,CitrateToTCA_Liver,TCA_rotation,OAAtoPEP,PyruvateToOAA,SerineToPyruvateLiver,SerineToGlycinLiver;
    double GlycinToSerineLiver,GlycinToAlbuminLiver,AlbuminToGlycinLiver,PyruvateToLactateLiver,LactateToPyruvateLiver,CoAToKetonesLiver,KetonesToCoALiver,TCAToGlutaminLiver,GlutaminToTCALiver,InsulinProduction;
    double eventassign_1_1,eventassign_1_2,eventassign_1_3,eventassign_1_4,eventassign_1_5,eventassign_1_6,eventassign_2_1,eventassign_2_2,eventassign_2_3,eventassign_2_4,eventassign_2_5,eventassign_2_6,eventassign_3_1,eventassign_3_2,eventassign_3_3,eventassign_3_4,eventassign_3_5,eventassign_3_6,eventassign_4_1,eventassign_4_2;
    double eventassign_4_3,eventassign_4_4,eventassign_4_5,eventassign_4_6,eventassign_5_1,eventassign_5_2,eventassign_5_3,eventassign_5_4,eventassign_5_5,eventassign_5_6,eventassign_6_1,eventassign_6_2,eventassign_6_3,eventassign_6_4,eventassign_6_5,eventassign_6_6,eventassign_7_1,eventassign_7_2,eventassign_7_3,eventassign_7_4;
    double eventassign_7_5,eventassign_7_6;

    time = time_local;

    Glucose_Medium = stateVector[0];
    Insulin_Medium = stateVector[1];
    Lactate_Medium = stateVector[2];
    Albumin_Medium = stateVector[3];
    Glutamin_Medium = stateVector[4];
    Ketones_Medium = stateVector[5];
    Glucose_Liver = stateVector[6];
    PEP_Liver = stateVector[7];
    Serine_Liver = stateVector[8];
    Pyruvate_Liver = stateVector[9];
    Glycin_Liver = stateVector[10];
    Albumin_Liver = stateVector[11];
    AcetylCoA_Liver = stateVector[12];
    Citrate_Liver = stateVector[13];
    TCA_Liver = stateVector[14];
    Glutamin_Liver = stateVector[15];
    OAA_Liver = stateVector[16];
    Ketones_Liver = stateVector[17];
    Lactate_Liver = stateVector[18];
    Insulin_Liver = stateVector[19];
    Glucose_Pancreas = stateVector[20];
    Insulin_Pancreas = stateVector[21];
    GlucoseOverHealthy = stateVector[22];
    Glucose_Pancrease_Delay = stateVector[23];
    V_islets = stateVector[24];
    Imax_SI = paramdataPtr->parametervector[0]; /* 1 */
    EC50_SI = paramdataPtr->parametervector[1]; /* 100 */
    d0 = paramdataPtr->parametervector[2]; /* 0.0025 */
    r1 = paramdataPtr->parametervector[3]; /* 0.00063 */
    r2 = paramdataPtr->parametervector[4]; /* 3.24e-05 */
    kv = paramdataPtr->parametervector[5]; /* 1 */
    G_healthy = paramdataPtr->parametervector[6]; /* 5.5 */
    Vm_f_islets = paramdataPtr->parametervector[7]; /* 1 */
    Alpha = paramdataPtr->parametervector[8]; /* 60 */
    Glycolysis_k = paramdataPtr->parametervector[9]; /* 1e-09 */
    Glycolysis_ii = paramdataPtr->parametervector[10]; /* 5e-06 */
    GlucoseToSerineLiverK = paramdataPtr->parametervector[11]; /* 6e-12 */
    GlucoseToSerineLiverK_ii = paramdataPtr->parametervector[12]; /* 6e-08 */
    GluconeogenesisK = paramdataPtr->parametervector[13]; /* 1e-10 */
    PEP_Pyruvate_LiverK = paramdataPtr->parametervector[14]; /* 0.5 */
    Pyruvate_CoA_LiverK = paramdataPtr->parametervector[15]; /* 0.0001 */
    TCA_startK = paramdataPtr->parametervector[16]; /* 15 */
    TCA_rotationK = paramdataPtr->parametervector[17]; /* 0.01 */
    Citrate_TCA_LiverK = paramdataPtr->parametervector[18]; /* 0.1 */
    OAA_PEP_LiverK = paramdataPtr->parametervector[19]; /* 0.5 */
    Pyruvate_OAA_LiverK = paramdataPtr->parametervector[20]; /* 1 */
    Serine_Pyruvate_LiverK = paramdataPtr->parametervector[21]; /* 0.5 */
    Serine_Glycin_LiverK = paramdataPtr->parametervector[22]; /* 0.5 */
    Glycin_Albumin_LiverK = paramdataPtr->parametervector[23]; /* 0.5 */
    Pyruvate_Lactate_LiverK = paramdataPtr->parametervector[24]; /* 0.5 */
    TCA_Glutamin_LiverK = paramdataPtr->parametervector[25]; /* 3e-05 */
    CoA_Ketones_LiverK = paramdataPtr->parametervector[26]; /* 1e-06 */
    InsulinProductionK = paramdataPtr->parametervector[27]; /* 40000 */
    Glucose_Pancrease_DelayK = paramdataPtr->parametervector[28]; /* 0.2 */
    InsulinClearanceLiverK = paramdataPtr->parametervector[29]; /* 1.7e-06 */
    G0 = paramdataPtr->parametervector[30]; /* 11 */
    I0 = paramdataPtr->parametervector[31]; /* 1e-30 */
    Glutamin0 = paramdataPtr->parametervector[32]; /* 2 */
    MediumChange_1G = paramdataPtr->parametervector[33]; /* 11 */
    MediumChange_2G = paramdataPtr->parametervector[34]; /* 11 */
    MediumChange_3G = paramdataPtr->parametervector[35]; /* 11 */
    MediumChange_4G = paramdataPtr->parametervector[36]; /* 11 */
    MediumChange_5G = paramdataPtr->parametervector[37]; /* 11 */
    MediumChange_6G = paramdataPtr->parametervector[38]; /* 11 */
    MediumChange_1I = paramdataPtr->parametervector[39]; /* 1e-30 */
    MediumChange_2I = paramdataPtr->parametervector[40]; /* 1e-30 */
    MediumChange_3I = paramdataPtr->parametervector[41]; /* 1e-30 */
    MediumChange_4I = paramdataPtr->parametervector[42]; /* 1e-30 */
    MediumChange_5I = paramdataPtr->parametervector[43]; /* 1e-30 */
    MediumChange_6I = paramdataPtr->parametervector[44]; /* 1e-30 */
    MediumChange_1Glutamin = paramdataPtr->parametervector[45]; /* 2 */
    MediumChange_2Glutamin = paramdataPtr->parametervector[46]; /* 2 */
    MediumChange_3Glutamin = paramdataPtr->parametervector[47]; /* 2 */
    MediumChange_4Glutamin = paramdataPtr->parametervector[48]; /* 2 */
    MediumChange_5Glutamin = paramdataPtr->parametervector[49]; /* 2 */
    MediumChange_6Glutamin = paramdataPtr->parametervector[50]; /* 2 */
    G_GTT = paramdataPtr->parametervector[51]; /* 11 */
    I_GTT = paramdataPtr->parametervector[52]; /* 1e-30 */
    Glutamin_GTT = paramdataPtr->parametervector[53]; /* 2 */
    MediumChange_1_time = paramdataPtr->parametervector[54]; /* 48 */
    MediumChange_2_time = paramdataPtr->parametervector[55]; /* 96 */
    MediumChange_3_time = paramdataPtr->parametervector[56]; /* 144 */
    MediumChange_4_time = paramdataPtr->parametervector[57]; /* 192 */
    MediumChange_5_time = paramdataPtr->parametervector[58]; /* 240 */
    MediumChange_6_time = paramdataPtr->parametervector[59]; /* 336 */
    GTT_time = paramdataPtr->parametervector[60]; /* 288 */
    V_m_liver = paramdataPtr->parametervector[61]; /* 0.0003 */
    V_hep = paramdataPtr->parametervector[62]; /* 3.4e-06 */
    V_m_pancreas = paramdataPtr->parametervector[63]; /* 0.0003 */
    V_m_medium = paramdataPtr->parametervector[64]; /* 0.0006 */
    Q = paramdataPtr->parametervector[65]; /* 0.01 */
    CountLiver = paramdataPtr->parametervector[66]; /* 1 */
    CountPancrease = paramdataPtr->parametervector[67]; /* 1 */
    Glucose_HepaticConcentration = Glucose_Liver/V_hep;
    PEP_HepaticConcentration = PEP_Liver/V_hep;
    Pyruvate_HepaticConcentration = Pyruvate_Liver/V_hep;
    AcetylCoA_HepaticConcentration = AcetylCoA_Liver/V_hep;
    Citrate_HepaticConcentration = Citrate_Liver/V_hep;
    TCA_HepaticConcentration = TCA_Liver/V_hep;
    OAA_HepaticConcentration = OAA_Liver/V_hep;
    Serine_HepaticConcentration = Serine_Liver/V_hep;
    Glycin_HepaticConcentration = Glycin_Liver/V_hep;
    Albumin_HepaticConcentration = Albumin_Liver/V_hep;
    Lactate_HepaticConcentration = Lactate_Liver/V_hep;
    Ketones_HepaticConcentration = Ketones_Liver/V_hep;
    Glutamin_HepaticConcentration = Glutamin_Liver/V_hep;
    Insulin_HepaticConcentration = Insulin_Liver/V_hep;
    Glucose_PancreasConcentration = Glucose_Pancreas/V_islets;
    Insulin_PancreasConcentration = Insulin_Pancreas/V_islets;
    Glucose_MediumConcentration = Glucose_Medium/V_m_medium;
    Insulin_MediumConcentration = Insulin_Medium/V_m_medium;
    Lactate_MediumConcentration = Lactate_Medium/V_m_medium;
    Albumin_MediumConcentration = Albumin_Medium/V_m_medium;
    Ketones_MediumConcentration = Ketones_Medium/V_m_medium;
    Glutamin_MediumConcentration = Glutamin_Medium/V_m_medium;
    GlucoseOverHealthy_sim = GlucoseOverHealthy;
    Glucose_Pancrease_Delay_sim = Glucose_Pancrease_Delay;
    V_islets_sim = V_islets;
    InsulinSensitivity = 1.0-(Imax_SI*GlucoseOverHealthy)/(EC50_SI+GlucoseOverHealthy);
    Growth_rate = max(0.0,r1*Glucose_Pancrease_Delay);
    Death_rate = max(0.0,r2*pow(Glucose_Pancrease_Delay,2.0));
    F_islets = 1.0-((Vm_f_islets*pow(time,2.0))/(pow(Alpha,2.0)+pow(time,2.0)));
    Net_rate = kv*(-d0+(Growth_rate-Death_rate));
    EGP_Pancrease = Q*Glucose_PancreasConcentration*CountPancrease;
    InsulinMediumToPancrease = Q*Insulin_MediumConcentration*CountPancrease;
    U_ip = Q*Glucose_MediumConcentration*CountPancrease;
    InsulinPancreaseToMedium = Q*Insulin_PancreasConcentration*CountPancrease;
    InsulinLiverToMedium = Q*Insulin_HepaticConcentration*CountLiver;
    U_il = Q*Glucose_MediumConcentration*CountLiver;
    EGP_Liver = Q*Glucose_HepaticConcentration*CountLiver;
    InsulinMediumToLiver = Q*Insulin_MediumConcentration*CountLiver;
    LactateLiverToMedium = Q*Lactate_HepaticConcentration*CountLiver;
    LactateMediumToLiver = Q*Lactate_MediumConcentration*CountLiver;
    AlbuminLiverToMedium = Q*Albumin_HepaticConcentration*CountLiver;
    AlbuminMediumToLiver = Q*Albumin_MediumConcentration*CountLiver;
    KetonesLiverToMedium = Q*Ketones_HepaticConcentration*CountLiver;
    KetonesMediumToLiver = Q*Ketones_MediumConcentration*CountLiver;
    GlutaminMediumToLiver = Q*Glutamin_MediumConcentration*CountLiver;
    GlutaminLiverToMedium = Q*Glutamin_HepaticConcentration*CountLiver;
    InsulinResponse_Liver = InsulinSensitivity*Insulin_HepaticConcentration;
    Glycolysis = Glucose_HepaticConcentration*(InsulinResponse_Liver*Glycolysis_k+Glycolysis_ii)*CountLiver;
    GlucoseToSerineLiver = Glucose_HepaticConcentration*(InsulinResponse_Liver*GlucoseToSerineLiverK+GlucoseToSerineLiverK_ii)*CountLiver;
    Gluconeogenesis = PEP_HepaticConcentration*GluconeogenesisK*CountLiver;
    InsulinClearanceLiver = Insulin_HepaticConcentration*InsulinClearanceLiverK*CountLiver;
    PEPtoPyruvate = PEP_HepaticConcentration*PEP_Pyruvate_LiverK*CountLiver;
    PyruvateOxi_L = Pyruvate_HepaticConcentration*Pyruvate_CoA_LiverK*CountLiver;
    TCA_start = (AcetylCoA_Liver*OAA_Liver)/V_hep*TCA_startK*CountLiver;
    CitrateToTCA_Liver = Citrate_HepaticConcentration*Citrate_TCA_LiverK*CountLiver;
    TCA_rotation = TCA_HepaticConcentration*TCA_rotationK*CountLiver;
    OAAtoPEP = OAA_HepaticConcentration*OAA_PEP_LiverK*CountLiver;
    PyruvateToOAA = Pyruvate_HepaticConcentration*Pyruvate_OAA_LiverK*CountLiver;
    SerineToPyruvateLiver = Serine_HepaticConcentration*Serine_Pyruvate_LiverK*CountLiver;
    SerineToGlycinLiver = Serine_HepaticConcentration*Serine_Glycin_LiverK*CountLiver;
    GlycinToSerineLiver = Glycin_HepaticConcentration*Serine_Glycin_LiverK*CountLiver;
    GlycinToAlbuminLiver = Glycin_HepaticConcentration*Glycin_Albumin_LiverK*CountLiver;
    AlbuminToGlycinLiver = Albumin_HepaticConcentration*Glycin_Albumin_LiverK*CountLiver;
    PyruvateToLactateLiver = Pyruvate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver;
    LactateToPyruvateLiver = Lactate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver;
    CoAToKetonesLiver = AcetylCoA_HepaticConcentration*CoA_Ketones_LiverK*CountLiver;
    KetonesToCoALiver = Ketones_HepaticConcentration*CoA_Ketones_LiverK*CountLiver;
    TCAToGlutaminLiver = TCA_HepaticConcentration*TCA_Glutamin_LiverK*CountLiver;
    GlutaminToTCALiver = Glutamin_HepaticConcentration*TCA_Glutamin_LiverK*CountLiver;
    InsulinProduction = max(0.0,V_islets*F_islets*(InsulinProductionK*pow(Glucose_PancreasConcentration,2.0)))*CountPancrease;
    eventassign_1_1 = I_GTT*V_m_medium;
    eventassign_1_2 = G_GTT*V_m_medium;
    eventassign_1_3 = 0.0;
    eventassign_1_4 = 0.0;
    eventassign_1_5 = 0.0;
    eventassign_1_6 = Glutamin_GTT*V_m_medium;
    eventassign_2_1 = MediumChange_1I*V_m_medium;
    eventassign_2_2 = MediumChange_1G*V_m_medium;
    eventassign_2_3 = 0.0;
    eventassign_2_4 = 0.0;
    eventassign_2_5 = 0.0;
    eventassign_2_6 = MediumChange_1Glutamin*V_m_medium;
    eventassign_3_1 = MediumChange_2I*V_m_medium;
    eventassign_3_2 = MediumChange_2G*V_m_medium;
    eventassign_3_3 = 0.0;
    eventassign_3_4 = 0.0;
    eventassign_3_5 = 0.0;
    eventassign_3_6 = MediumChange_2Glutamin*V_m_medium;
    eventassign_4_1 = MediumChange_3I*V_m_medium;
    eventassign_4_2 = MediumChange_3G*V_m_medium;
    eventassign_4_3 = 0.0;
    eventassign_4_4 = 0.0;
    eventassign_4_5 = 0.0;
    eventassign_4_6 = MediumChange_3Glutamin*V_m_medium;
    eventassign_5_1 = MediumChange_4I*V_m_medium;
    eventassign_5_2 = MediumChange_4G*V_m_medium;
    eventassign_5_3 = 0.0;
    eventassign_5_4 = 0.0;
    eventassign_5_5 = 0.0;
    eventassign_5_6 = MediumChange_4Glutamin*V_m_medium;
    eventassign_6_1 = MediumChange_5I*V_m_medium;
    eventassign_6_2 = MediumChange_5G*V_m_medium;
    eventassign_6_3 = 0.0;
    eventassign_6_4 = 0.0;
    eventassign_6_5 = 0.0;
    eventassign_6_6 = MediumChange_5Glutamin*V_m_medium;
    eventassign_7_1 = MediumChange_6I*V_m_medium;
    eventassign_7_2 = MediumChange_6G*V_m_medium;
    eventassign_7_3 = 0.0;
    eventassign_7_4 = 0.0;
    eventassign_7_5 = 0.0;
    eventassign_7_6 = MediumChange_6Glutamin*V_m_medium;
    if (DOflag == DOFLAG_DDT) {
    	DDTvector[0] = EGP_Liver+EGP_Pancrease-(U_il+U_ip);
    	DDTvector[1] = InsulinLiverToMedium+InsulinPancreaseToMedium-(InsulinMediumToLiver+InsulinMediumToPancrease);
    	DDTvector[2] = LactateLiverToMedium-(LactateMediumToLiver);
    	DDTvector[3] = AlbuminLiverToMedium-(AlbuminMediumToLiver);
    	DDTvector[4] = GlutaminLiverToMedium-(GlutaminMediumToLiver);
    	DDTvector[5] = KetonesLiverToMedium-(KetonesMediumToLiver);
    	DDTvector[6] = U_il+Gluconeogenesis-(EGP_Liver+Glycolysis+GlucoseToSerineLiver);
    	DDTvector[7] = (Glycolysis+OAAtoPEP)-(PEPtoPyruvate+Gluconeogenesis);
    	DDTvector[8] = GlucoseToSerineLiver+GlycinToSerineLiver-(SerineToPyruvateLiver+SerineToGlycinLiver);
    	DDTvector[9] = (PEPtoPyruvate+SerineToPyruvateLiver+LactateToPyruvateLiver)-(PyruvateOxi_L+PyruvateToOAA+PyruvateToLactateLiver);
    	DDTvector[10] = SerineToGlycinLiver+AlbuminToGlycinLiver-(GlycinToSerineLiver+GlycinToAlbuminLiver);
    	DDTvector[11] = GlycinToAlbuminLiver+AlbuminMediumToLiver-(AlbuminToGlycinLiver+AlbuminLiverToMedium);
    	DDTvector[12] = (PyruvateOxi_L+KetonesToCoALiver)-(TCA_start+CoAToKetonesLiver);
    	DDTvector[13] = (TCA_start*2.0)-(CitrateToTCA_Liver);
    	DDTvector[14] = (CitrateToTCA_Liver+GlutaminToTCALiver)-(TCA_rotation+TCAToGlutaminLiver);
    	DDTvector[15] = GlutaminMediumToLiver+TCAToGlutaminLiver-(GlutaminLiverToMedium+GlutaminToTCALiver);
    	DDTvector[16] = (TCA_rotation+PyruvateToOAA)-(TCA_start+OAAtoPEP);
    	DDTvector[17] = CoAToKetonesLiver+KetonesMediumToLiver-(KetonesToCoALiver+KetonesLiverToMedium);
    	DDTvector[18] = PyruvateToLactateLiver+LactateMediumToLiver-(LactateToPyruvateLiver+LactateLiverToMedium);
    	DDTvector[19] = InsulinMediumToLiver-(InsulinLiverToMedium+InsulinClearanceLiver);
    	DDTvector[20] = U_ip-(EGP_Pancrease);
    	DDTvector[21] = InsulinProduction+InsulinMediumToPancrease-(InsulinPancreaseToMedium);
    	DDTvector[22] = max(0.0,Glucose_Liver/V_hep-G_healthy);
    	DDTvector[23] = Glucose_Pancrease_DelayK*(Glucose_Pancreas/V_islets-Glucose_Pancrease_Delay);
    	DDTvector[24] = Net_rate*V_islets;
    } else if (DOflag == DOFLAG_VARREAC) {
        variableVector[0] = Glucose_HepaticConcentration;
        variableVector[1] = PEP_HepaticConcentration;
        variableVector[2] = Pyruvate_HepaticConcentration;
        variableVector[3] = AcetylCoA_HepaticConcentration;
        variableVector[4] = Citrate_HepaticConcentration;
        variableVector[5] = TCA_HepaticConcentration;
        variableVector[6] = OAA_HepaticConcentration;
        variableVector[7] = Serine_HepaticConcentration;
        variableVector[8] = Glycin_HepaticConcentration;
        variableVector[9] = Albumin_HepaticConcentration;
        variableVector[10] = Lactate_HepaticConcentration;
        variableVector[11] = Ketones_HepaticConcentration;
        variableVector[12] = Glutamin_HepaticConcentration;
        variableVector[13] = Insulin_HepaticConcentration;
        variableVector[14] = Glucose_PancreasConcentration;
        variableVector[15] = Insulin_PancreasConcentration;
        variableVector[16] = Glucose_MediumConcentration;
        variableVector[17] = Insulin_MediumConcentration;
        variableVector[18] = Lactate_MediumConcentration;
        variableVector[19] = Albumin_MediumConcentration;
        variableVector[20] = Ketones_MediumConcentration;
        variableVector[21] = Glutamin_MediumConcentration;
        variableVector[22] = GlucoseOverHealthy_sim;
        variableVector[23] = Glucose_Pancrease_Delay_sim;
        variableVector[24] = V_islets_sim;
        variableVector[25] = InsulinSensitivity;
        variableVector[26] = Growth_rate;
        variableVector[27] = Death_rate;
        variableVector[28] = F_islets;
        variableVector[29] = Net_rate;
        variableVector[30] = EGP_Pancrease;
        variableVector[31] = InsulinMediumToPancrease;
        variableVector[32] = U_ip;
        variableVector[33] = InsulinPancreaseToMedium;
        variableVector[34] = InsulinLiverToMedium;
        variableVector[35] = U_il;
        variableVector[36] = EGP_Liver;
        variableVector[37] = InsulinMediumToLiver;
        variableVector[38] = LactateLiverToMedium;
        variableVector[39] = LactateMediumToLiver;
        variableVector[40] = AlbuminLiverToMedium;
        variableVector[41] = AlbuminMediumToLiver;
        variableVector[42] = KetonesLiverToMedium;
        variableVector[43] = KetonesMediumToLiver;
        variableVector[44] = GlutaminMediumToLiver;
        variableVector[45] = GlutaminLiverToMedium;
        variableVector[46] = InsulinResponse_Liver;
        variableVector[47] = Glycolysis;
        variableVector[48] = GlucoseToSerineLiver;
        variableVector[49] = Gluconeogenesis;
        variableVector[50] = InsulinClearanceLiver;
        variableVector[51] = PEPtoPyruvate;
        variableVector[52] = PyruvateOxi_L;
        variableVector[53] = TCA_start;
        variableVector[54] = CitrateToTCA_Liver;
        variableVector[55] = TCA_rotation;
        variableVector[56] = OAAtoPEP;
        variableVector[57] = PyruvateToOAA;
        variableVector[58] = SerineToPyruvateLiver;
        variableVector[59] = SerineToGlycinLiver;
        variableVector[60] = GlycinToSerineLiver;
        variableVector[61] = GlycinToAlbuminLiver;
        variableVector[62] = AlbuminToGlycinLiver;
        variableVector[63] = PyruvateToLactateLiver;
        variableVector[64] = LactateToPyruvateLiver;
        variableVector[65] = CoAToKetonesLiver;
        variableVector[66] = KetonesToCoALiver;
        variableVector[67] = TCAToGlutaminLiver;
        variableVector[68] = GlutaminToTCALiver;
        variableVector[69] = InsulinProduction;
    } else if (DOflag == DOFLAG_EVENTS) {
        gout[0] = eq(time,GTT_time)-0.5;
        gout[1] = eq(time,MediumChange_1_time)-0.5;
        gout[2] = eq(time,MediumChange_2_time)-0.5;
        gout[3] = eq(time,MediumChange_3_time)-0.5;
        gout[4] = eq(time,MediumChange_4_time)-0.5;
        gout[5] = eq(time,MediumChange_5_time)-0.5;
        gout[6] = eq(time,MediumChange_6_time)-0.5;
    } else if (DOflag == DOFLAG_EVENTASSIGN) {
        if (eventVector[0] == 1 && gout[0] < 0) {
            DDTvector[0] = 1;
            stateVector[1] = eventassign_1_1;
            stateVector[0] = eventassign_1_2;
            stateVector[2] = eventassign_1_3;
            stateVector[5] = eventassign_1_4;
            stateVector[3] = eventassign_1_5;
            stateVector[4] = eventassign_1_6;
        }
        if (eventVector[1] == 1 && gout[1] < 0) {
            DDTvector[0] = 1;
            stateVector[1] = eventassign_2_1;
            stateVector[0] = eventassign_2_2;
            stateVector[2] = eventassign_2_3;
            stateVector[5] = eventassign_2_4;
            stateVector[3] = eventassign_2_5;
            stateVector[4] = eventassign_2_6;
        }
        if (eventVector[2] == 1 && gout[2] < 0) {
            DDTvector[0] = 1;
            stateVector[1] = eventassign_3_1;
            stateVector[0] = eventassign_3_2;
            stateVector[2] = eventassign_3_3;
            stateVector[5] = eventassign_3_4;
            stateVector[3] = eventassign_3_5;
            stateVector[4] = eventassign_3_6;
        }
        if (eventVector[3] == 1 && gout[3] < 0) {
            DDTvector[0] = 1;
            stateVector[1] = eventassign_4_1;
            stateVector[0] = eventassign_4_2;
            stateVector[2] = eventassign_4_3;
            stateVector[5] = eventassign_4_4;
            stateVector[3] = eventassign_4_5;
            stateVector[4] = eventassign_4_6;
        }
        if (eventVector[4] == 1 && gout[4] < 0) {
            DDTvector[0] = 1;
            stateVector[1] = eventassign_5_1;
            stateVector[0] = eventassign_5_2;
            stateVector[2] = eventassign_5_3;
            stateVector[5] = eventassign_5_4;
            stateVector[3] = eventassign_5_5;
            stateVector[4] = eventassign_5_6;
        }
        if (eventVector[5] == 1 && gout[5] < 0) {
            DDTvector[0] = 1;
            stateVector[1] = eventassign_6_1;
            stateVector[0] = eventassign_6_2;
            stateVector[2] = eventassign_6_3;
            stateVector[5] = eventassign_6_4;
            stateVector[3] = eventassign_6_5;
            stateVector[4] = eventassign_6_6;
        }
        if (eventVector[6] == 1 && gout[6] < 0) {
            DDTvector[0] = 1;
            stateVector[1] = eventassign_7_1;
            stateVector[0] = eventassign_7_2;
            stateVector[2] = eventassign_7_3;
            stateVector[5] = eventassign_7_4;
            stateVector[3] = eventassign_7_5;
            stateVector[4] = eventassign_7_6;
        }
    }
}


/* Function for initial condition calculation */
void calc_ic_model(double *icVector, ParamData *paramdataPtr)
{
    double Glucose_Medium,Insulin_Medium,Lactate_Medium,Albumin_Medium,Glutamin_Medium,Ketones_Medium,Glucose_Liver,PEP_Liver,Serine_Liver,Pyruvate_Liver,Glycin_Liver,Albumin_Liver,AcetylCoA_Liver,Citrate_Liver,TCA_Liver,Glutamin_Liver,OAA_Liver,Ketones_Liver,Lactate_Liver,Insulin_Liver;
    double Glucose_Pancreas,Insulin_Pancreas,GlucoseOverHealthy,Glucose_Pancrease_Delay,V_islets;
    double Imax_SI,EC50_SI,d0,r1,r2,kv,G_healthy,Vm_f_islets,Alpha,Glycolysis_k,Glycolysis_ii,GlucoseToSerineLiverK,GlucoseToSerineLiverK_ii,GluconeogenesisK,PEP_Pyruvate_LiverK,Pyruvate_CoA_LiverK,TCA_startK,TCA_rotationK,Citrate_TCA_LiverK,OAA_PEP_LiverK;
    double Pyruvate_OAA_LiverK,Serine_Pyruvate_LiverK,Serine_Glycin_LiverK,Glycin_Albumin_LiverK,Pyruvate_Lactate_LiverK,TCA_Glutamin_LiverK,CoA_Ketones_LiverK,InsulinProductionK,Glucose_Pancrease_DelayK,InsulinClearanceLiverK,G0,I0,Glutamin0,MediumChange_1G,MediumChange_2G,MediumChange_3G,MediumChange_4G,MediumChange_5G,MediumChange_6G,MediumChange_1I;
    double MediumChange_2I,MediumChange_3I,MediumChange_4I,MediumChange_5I,MediumChange_6I,MediumChange_1Glutamin,MediumChange_2Glutamin,MediumChange_3Glutamin,MediumChange_4Glutamin,MediumChange_5Glutamin,MediumChange_6Glutamin,G_GTT,I_GTT,Glutamin_GTT,MediumChange_1_time,MediumChange_2_time,MediumChange_3_time,MediumChange_4_time,MediumChange_5_time,MediumChange_6_time;
    double GTT_time,V_m_liver,V_hep,V_m_pancreas,V_m_medium,Q,CountLiver,CountPancrease;
    double Glucose_HepaticConcentration,PEP_HepaticConcentration,Pyruvate_HepaticConcentration,AcetylCoA_HepaticConcentration,Citrate_HepaticConcentration,TCA_HepaticConcentration,OAA_HepaticConcentration,Serine_HepaticConcentration,Glycin_HepaticConcentration,Albumin_HepaticConcentration,Lactate_HepaticConcentration,Ketones_HepaticConcentration,Glutamin_HepaticConcentration,Insulin_HepaticConcentration,Glucose_PancreasConcentration,Insulin_PancreasConcentration,Glucose_MediumConcentration,Insulin_MediumConcentration,Lactate_MediumConcentration,Albumin_MediumConcentration;
    double Ketones_MediumConcentration,Glutamin_MediumConcentration,GlucoseOverHealthy_sim,Glucose_Pancrease_Delay_sim,V_islets_sim,InsulinSensitivity,Growth_rate,Death_rate,F_islets,Net_rate,EGP_Pancrease,InsulinMediumToPancrease,U_ip,InsulinPancreaseToMedium,InsulinLiverToMedium,U_il,EGP_Liver,InsulinMediumToLiver,LactateLiverToMedium,LactateMediumToLiver;
    double AlbuminLiverToMedium,AlbuminMediumToLiver,KetonesLiverToMedium,KetonesMediumToLiver,GlutaminMediumToLiver,GlutaminLiverToMedium,InsulinResponse_Liver,Glycolysis,GlucoseToSerineLiver,Gluconeogenesis,InsulinClearanceLiver,PEPtoPyruvate,PyruvateOxi_L,TCA_start,CitrateToTCA_Liver,TCA_rotation,OAAtoPEP,PyruvateToOAA,SerineToPyruvateLiver,SerineToGlycinLiver;
    double GlycinToSerineLiver,GlycinToAlbuminLiver,AlbuminToGlycinLiver,PyruvateToLactateLiver,LactateToPyruvateLiver,CoAToKetonesLiver,KetonesToCoALiver,TCAToGlutaminLiver,GlutaminToTCALiver,InsulinProduction;
    Imax_SI = paramdataPtr->parametervector[0]; /* 1 */
    EC50_SI = paramdataPtr->parametervector[1]; /* 100 */
    d0 = paramdataPtr->parametervector[2]; /* 0.0025 */
    r1 = paramdataPtr->parametervector[3]; /* 0.00063 */
    r2 = paramdataPtr->parametervector[4]; /* 3.24e-05 */
    kv = paramdataPtr->parametervector[5]; /* 1 */
    G_healthy = paramdataPtr->parametervector[6]; /* 5.5 */
    Vm_f_islets = paramdataPtr->parametervector[7]; /* 1 */
    Alpha = paramdataPtr->parametervector[8]; /* 60 */
    Glycolysis_k = paramdataPtr->parametervector[9]; /* 1e-09 */
    Glycolysis_ii = paramdataPtr->parametervector[10]; /* 5e-06 */
    GlucoseToSerineLiverK = paramdataPtr->parametervector[11]; /* 6e-12 */
    GlucoseToSerineLiverK_ii = paramdataPtr->parametervector[12]; /* 6e-08 */
    GluconeogenesisK = paramdataPtr->parametervector[13]; /* 1e-10 */
    PEP_Pyruvate_LiverK = paramdataPtr->parametervector[14]; /* 0.5 */
    Pyruvate_CoA_LiverK = paramdataPtr->parametervector[15]; /* 0.0001 */
    TCA_startK = paramdataPtr->parametervector[16]; /* 15 */
    TCA_rotationK = paramdataPtr->parametervector[17]; /* 0.01 */
    Citrate_TCA_LiverK = paramdataPtr->parametervector[18]; /* 0.1 */
    OAA_PEP_LiverK = paramdataPtr->parametervector[19]; /* 0.5 */
    Pyruvate_OAA_LiverK = paramdataPtr->parametervector[20]; /* 1 */
    Serine_Pyruvate_LiverK = paramdataPtr->parametervector[21]; /* 0.5 */
    Serine_Glycin_LiverK = paramdataPtr->parametervector[22]; /* 0.5 */
    Glycin_Albumin_LiverK = paramdataPtr->parametervector[23]; /* 0.5 */
    Pyruvate_Lactate_LiverK = paramdataPtr->parametervector[24]; /* 0.5 */
    TCA_Glutamin_LiverK = paramdataPtr->parametervector[25]; /* 3e-05 */
    CoA_Ketones_LiverK = paramdataPtr->parametervector[26]; /* 1e-06 */
    InsulinProductionK = paramdataPtr->parametervector[27]; /* 40000 */
    Glucose_Pancrease_DelayK = paramdataPtr->parametervector[28]; /* 0.2 */
    InsulinClearanceLiverK = paramdataPtr->parametervector[29]; /* 1.7e-06 */
    G0 = paramdataPtr->parametervector[30]; /* 11 */
    I0 = paramdataPtr->parametervector[31]; /* 1e-30 */
    Glutamin0 = paramdataPtr->parametervector[32]; /* 2 */
    MediumChange_1G = paramdataPtr->parametervector[33]; /* 11 */
    MediumChange_2G = paramdataPtr->parametervector[34]; /* 11 */
    MediumChange_3G = paramdataPtr->parametervector[35]; /* 11 */
    MediumChange_4G = paramdataPtr->parametervector[36]; /* 11 */
    MediumChange_5G = paramdataPtr->parametervector[37]; /* 11 */
    MediumChange_6G = paramdataPtr->parametervector[38]; /* 11 */
    MediumChange_1I = paramdataPtr->parametervector[39]; /* 1e-30 */
    MediumChange_2I = paramdataPtr->parametervector[40]; /* 1e-30 */
    MediumChange_3I = paramdataPtr->parametervector[41]; /* 1e-30 */
    MediumChange_4I = paramdataPtr->parametervector[42]; /* 1e-30 */
    MediumChange_5I = paramdataPtr->parametervector[43]; /* 1e-30 */
    MediumChange_6I = paramdataPtr->parametervector[44]; /* 1e-30 */
    MediumChange_1Glutamin = paramdataPtr->parametervector[45]; /* 2 */
    MediumChange_2Glutamin = paramdataPtr->parametervector[46]; /* 2 */
    MediumChange_3Glutamin = paramdataPtr->parametervector[47]; /* 2 */
    MediumChange_4Glutamin = paramdataPtr->parametervector[48]; /* 2 */
    MediumChange_5Glutamin = paramdataPtr->parametervector[49]; /* 2 */
    MediumChange_6Glutamin = paramdataPtr->parametervector[50]; /* 2 */
    G_GTT = paramdataPtr->parametervector[51]; /* 11 */
    I_GTT = paramdataPtr->parametervector[52]; /* 1e-30 */
    Glutamin_GTT = paramdataPtr->parametervector[53]; /* 2 */
    MediumChange_1_time = paramdataPtr->parametervector[54]; /* 48 */
    MediumChange_2_time = paramdataPtr->parametervector[55]; /* 96 */
    MediumChange_3_time = paramdataPtr->parametervector[56]; /* 144 */
    MediumChange_4_time = paramdataPtr->parametervector[57]; /* 192 */
    MediumChange_5_time = paramdataPtr->parametervector[58]; /* 240 */
    MediumChange_6_time = paramdataPtr->parametervector[59]; /* 336 */
    GTT_time = paramdataPtr->parametervector[60]; /* 288 */
    V_m_liver = paramdataPtr->parametervector[61]; /* 0.0003 */
    V_hep = paramdataPtr->parametervector[62]; /* 3.4e-06 */
    V_m_pancreas = paramdataPtr->parametervector[63]; /* 0.0003 */
    V_m_medium = paramdataPtr->parametervector[64]; /* 0.0006 */
    Q = paramdataPtr->parametervector[65]; /* 0.01 */
    CountLiver = paramdataPtr->parametervector[66]; /* 1 */
    CountPancrease = paramdataPtr->parametervector[67]; /* 1 */
    Glucose_HepaticConcentration = Glucose_Liver/V_hep;
    PEP_HepaticConcentration = PEP_Liver/V_hep;
    Pyruvate_HepaticConcentration = Pyruvate_Liver/V_hep;
    AcetylCoA_HepaticConcentration = AcetylCoA_Liver/V_hep;
    Citrate_HepaticConcentration = Citrate_Liver/V_hep;
    TCA_HepaticConcentration = TCA_Liver/V_hep;
    OAA_HepaticConcentration = OAA_Liver/V_hep;
    Serine_HepaticConcentration = Serine_Liver/V_hep;
    Glycin_HepaticConcentration = Glycin_Liver/V_hep;
    Albumin_HepaticConcentration = Albumin_Liver/V_hep;
    Lactate_HepaticConcentration = Lactate_Liver/V_hep;
    Ketones_HepaticConcentration = Ketones_Liver/V_hep;
    Glutamin_HepaticConcentration = Glutamin_Liver/V_hep;
    Insulin_HepaticConcentration = Insulin_Liver/V_hep;
    Glucose_PancreasConcentration = Glucose_Pancreas/V_islets;
    Insulin_PancreasConcentration = Insulin_Pancreas/V_islets;
    Glucose_MediumConcentration = Glucose_Medium/V_m_medium;
    Insulin_MediumConcentration = Insulin_Medium/V_m_medium;
    Lactate_MediumConcentration = Lactate_Medium/V_m_medium;
    Albumin_MediumConcentration = Albumin_Medium/V_m_medium;
    Ketones_MediumConcentration = Ketones_Medium/V_m_medium;
    Glutamin_MediumConcentration = Glutamin_Medium/V_m_medium;
    GlucoseOverHealthy_sim = GlucoseOverHealthy;
    Glucose_Pancrease_Delay_sim = Glucose_Pancrease_Delay;
    V_islets_sim = V_islets;
    InsulinSensitivity = 1.0-(Imax_SI*GlucoseOverHealthy)/(EC50_SI+GlucoseOverHealthy);
    Growth_rate = max(0.0,r1*Glucose_Pancrease_Delay);
    Death_rate = max(0.0,r2*pow(Glucose_Pancrease_Delay,2.0));
    F_islets = 1.0-((Vm_f_islets*pow(time,2.0))/(pow(Alpha,2.0)+pow(time,2.0)));
    Net_rate = kv*(-d0+(Growth_rate-Death_rate));
    EGP_Pancrease = Q*Glucose_PancreasConcentration*CountPancrease;
    InsulinMediumToPancrease = Q*Insulin_MediumConcentration*CountPancrease;
    U_ip = Q*Glucose_MediumConcentration*CountPancrease;
    InsulinPancreaseToMedium = Q*Insulin_PancreasConcentration*CountPancrease;
    InsulinLiverToMedium = Q*Insulin_HepaticConcentration*CountLiver;
    U_il = Q*Glucose_MediumConcentration*CountLiver;
    EGP_Liver = Q*Glucose_HepaticConcentration*CountLiver;
    InsulinMediumToLiver = Q*Insulin_MediumConcentration*CountLiver;
    LactateLiverToMedium = Q*Lactate_HepaticConcentration*CountLiver;
    LactateMediumToLiver = Q*Lactate_MediumConcentration*CountLiver;
    AlbuminLiverToMedium = Q*Albumin_HepaticConcentration*CountLiver;
    AlbuminMediumToLiver = Q*Albumin_MediumConcentration*CountLiver;
    KetonesLiverToMedium = Q*Ketones_HepaticConcentration*CountLiver;
    KetonesMediumToLiver = Q*Ketones_MediumConcentration*CountLiver;
    GlutaminMediumToLiver = Q*Glutamin_MediumConcentration*CountLiver;
    GlutaminLiverToMedium = Q*Glutamin_HepaticConcentration*CountLiver;
    InsulinResponse_Liver = InsulinSensitivity*Insulin_HepaticConcentration;
    Glycolysis = Glucose_HepaticConcentration*(InsulinResponse_Liver*Glycolysis_k+Glycolysis_ii)*CountLiver;
    GlucoseToSerineLiver = Glucose_HepaticConcentration*(InsulinResponse_Liver*GlucoseToSerineLiverK+GlucoseToSerineLiverK_ii)*CountLiver;
    Gluconeogenesis = PEP_HepaticConcentration*GluconeogenesisK*CountLiver;
    InsulinClearanceLiver = Insulin_HepaticConcentration*InsulinClearanceLiverK*CountLiver;
    PEPtoPyruvate = PEP_HepaticConcentration*PEP_Pyruvate_LiverK*CountLiver;
    PyruvateOxi_L = Pyruvate_HepaticConcentration*Pyruvate_CoA_LiverK*CountLiver;
    TCA_start = (AcetylCoA_Liver*OAA_Liver)/V_hep*TCA_startK*CountLiver;
    CitrateToTCA_Liver = Citrate_HepaticConcentration*Citrate_TCA_LiverK*CountLiver;
    TCA_rotation = TCA_HepaticConcentration*TCA_rotationK*CountLiver;
    OAAtoPEP = OAA_HepaticConcentration*OAA_PEP_LiverK*CountLiver;
    PyruvateToOAA = Pyruvate_HepaticConcentration*Pyruvate_OAA_LiverK*CountLiver;
    SerineToPyruvateLiver = Serine_HepaticConcentration*Serine_Pyruvate_LiverK*CountLiver;
    SerineToGlycinLiver = Serine_HepaticConcentration*Serine_Glycin_LiverK*CountLiver;
    GlycinToSerineLiver = Glycin_HepaticConcentration*Serine_Glycin_LiverK*CountLiver;
    GlycinToAlbuminLiver = Glycin_HepaticConcentration*Glycin_Albumin_LiverK*CountLiver;
    AlbuminToGlycinLiver = Albumin_HepaticConcentration*Glycin_Albumin_LiverK*CountLiver;
    PyruvateToLactateLiver = Pyruvate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver;
    LactateToPyruvateLiver = Lactate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver;
    CoAToKetonesLiver = AcetylCoA_HepaticConcentration*CoA_Ketones_LiverK*CountLiver;
    KetonesToCoALiver = Ketones_HepaticConcentration*CoA_Ketones_LiverK*CountLiver;
    TCAToGlutaminLiver = TCA_HepaticConcentration*TCA_Glutamin_LiverK*CountLiver;
    GlutaminToTCALiver = Glutamin_HepaticConcentration*TCA_Glutamin_LiverK*CountLiver;
    InsulinProduction = max(0.0,V_islets*F_islets*(InsulinProductionK*pow(Glucose_PancreasConcentration,2.0)))*CountPancrease;
    Glucose_Medium = G0*V_m_medium;
    Insulin_Medium = I0*V_m_medium;
    Lactate_Medium = 0.0;
    Albumin_Medium = 0.0;
    Glutamin_Medium = Glutamin0*V_m_medium;
    Ketones_Medium = 0.0;
    Glucose_Liver = 0.0;
    PEP_Liver = 0.0;
    Serine_Liver = 0.0;
    Pyruvate_Liver = 0.0;
    Glycin_Liver = 0.0;
    Albumin_Liver = 0.0;
    AcetylCoA_Liver = 0.0;
    Citrate_Liver = 0.0;
    TCA_Liver = 0.0;
    Glutamin_Liver = 0.0;
    OAA_Liver = 0.0;
    Ketones_Liver = 0.0;
    Lactate_Liver = 0.0;
    Insulin_Liver = 0.0;
    Glucose_Pancreas = 0.0;
    Insulin_Pancreas = 0.0;
    GlucoseOverHealthy = 0.0;
    Glucose_Pancrease_Delay = 0.0;
    V_islets = 8.8e-09;
    icVector[0] = Glucose_Medium;
    icVector[1] = Insulin_Medium;
    icVector[2] = Lactate_Medium;
    icVector[3] = Albumin_Medium;
    icVector[4] = Glutamin_Medium;
    icVector[5] = Ketones_Medium;
    icVector[6] = Glucose_Liver;
    icVector[7] = PEP_Liver;
    icVector[8] = Serine_Liver;
    icVector[9] = Pyruvate_Liver;
    icVector[10] = Glycin_Liver;
    icVector[11] = Albumin_Liver;
    icVector[12] = AcetylCoA_Liver;
    icVector[13] = Citrate_Liver;
    icVector[14] = TCA_Liver;
    icVector[15] = Glutamin_Liver;
    icVector[16] = OAA_Liver;
    icVector[17] = Ketones_Liver;
    icVector[18] = Lactate_Liver;
    icVector[19] = Insulin_Liver;
    icVector[20] = Glucose_Pancreas;
    icVector[21] = Insulin_Pancreas;
    icVector[22] = GlucoseOverHealthy;
    icVector[23] = Glucose_Pancrease_Delay;
    icVector[24] = V_islets;
}

