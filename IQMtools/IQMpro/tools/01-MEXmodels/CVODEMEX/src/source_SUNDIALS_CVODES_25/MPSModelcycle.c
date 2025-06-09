#include "stddef.h"
#include "stdarg.h"
#include "math.h"
#include "CVODEmex25.h"
#include "MPSModelcycle.h"
#include "mexsplineaddon.h"
#include "mexmathaddon.h"
#include "kineticformulas.h"

double time;

void model(double time_local, double *stateVector, double *DDTvector, ParamData *paramdataPtr, int DOflag, double *variableVector, double *reactionVector, double *gout, int *eventVector)
{
    double Qsto1,Qgut,GlucoseExternalInjectionDelay,Glucose_Medium,Insulin_Medium,Lactate_Medium,Exenatide_Medium,Glucose_Liver,Glycogen_Liver,PEP_Liver,Pyruvate_Liver,OAA_Liver,Lactate_Liver,Insulin_Liver,Glucose_Pancreas,Insulin_Pancreas,GlucoseOverHealthy,Time;
    double Imax_SI,EC50_SI,G_healthy,Alpha,InsulinResponse_LiverMax,InsulinResponse_Liver0,Glycolysis_ii,GluconeogenesisK,GlycogenesisK,GlycogenolysisMax,PEP_Pyruvate_LiverK,TCA_startK,OAA_PEP_LiverK,Pyruvate_OAA_LiverK,Pyruvate_Lactate_LiverK,LactateToPyruvateLiverK,PyruvateOutK,InVivoExternalSourceK,ExenatideClearanceK,ExenatideClearanceLiverKexp;
    double ExenatideInsulinMax,ExenatideInsulin0,ExenatideInsulinDecayMax,ExenatideInsulinDecay0,InsulinProductionROC_K,InsulinProductionBaseline_K,InsulinProductionBaseline_K0,InsulinProductionBasal,G_baseline,InsulinClearanceLiverK,CountLiver,CountPancrease,CountAdipocytesMuscle,CountBrain,CountKidneys,CountStomach,carb_flow,V_hep,V_m_medium,ExenatideExternalInjection;
    double GlucoseExternalInjection,V_islets;
    double GLUT2,PancreticInsulinExocytosis,HepaticInsulinTransportation,LactateMCTs,Glucose_HepaticConcentration,Glycogen_HepaticConcentration,PEP_HepaticConcentration,Pyruvate_HepaticConcentration,OAA_HepaticConcentration,Lactate_HepaticConcentration,Insulin_HepaticConcentration,Glucose_PancreasConcentration,Insulin_PancreasConcentration,Glucose_MediumConcentration,Insulin_MediumConcentration,Lactate_MediumConcentration,Exenatide_MediumConcentration,Exenatide_MediumConcentrationNano,GlucoseOverHealthy_sim,InsulinSensitivity;
    double F_islets,InsulinMediumToPancrease,InsulinPancreaseToMedium,InsulinLiverToMedium,InsulinMediumToLiver,EGP_Pancrease,U_ip,U_il,EGP_Liver,LactateLiverToMedium,LactateMediumToLiver,ExenatideClearance,ExanitideInsulinInterplay,InsulinResponse_Liver,GlycolysisInsulinDependent,GlycolysisInsulinIndependent,Glycolysis,Gluconeogenesis,Glycogenesis,Glycogenolysis;
    double InsulinClearanceLiver,PEPtoPyruvate,TCA_start,OAAtoPEP,PyruvateToOAA,PyruvateToLactateLiver,LactateToPyruvateLiver,PyruvateOut,Ra,Ra_mM,InVivoExternalSource,V_mmax,V_fmax,U_idm,U_idf,U_iib,U,EGP_Kidneys,InsulinClearanceNonLiver,InsulinProductionROC;
    double InsulinProductionBaselineDifference,InsulinProductionBaseline,InsulinProduction;

    time = time_local;

    Qsto1 = stateVector[0];
    Qgut = stateVector[1];
    GlucoseExternalInjectionDelay = stateVector[2];
    Glucose_Medium = stateVector[3];
    Insulin_Medium = stateVector[4];
    Lactate_Medium = stateVector[5];
    Exenatide_Medium = stateVector[6];
    Glucose_Liver = stateVector[7];
    Glycogen_Liver = stateVector[8];
    PEP_Liver = stateVector[9];
    Pyruvate_Liver = stateVector[10];
    OAA_Liver = stateVector[11];
    Lactate_Liver = stateVector[12];
    Insulin_Liver = stateVector[13];
    Glucose_Pancreas = stateVector[14];
    Insulin_Pancreas = stateVector[15];
    GlucoseOverHealthy = stateVector[16];
    Time = stateVector[17];
    Imax_SI = paramdataPtr->parametervector[0]; /* 0.728138 */
    EC50_SI = paramdataPtr->parametervector[1]; /* 284.063 */
    G_healthy = paramdataPtr->parametervector[2]; /* 7.61405 */
    Alpha = paramdataPtr->parametervector[3]; /* 309.227 */
    InsulinResponse_LiverMax = paramdataPtr->parametervector[4]; /* 1.73467e-05 */
    InsulinResponse_Liver0 = paramdataPtr->parametervector[5]; /* 447.525 */
    Glycolysis_ii = paramdataPtr->parametervector[6]; /* 7.13868e-06 */
    GluconeogenesisK = paramdataPtr->parametervector[7]; /* 0.0388488 */
    GlycogenesisK = paramdataPtr->parametervector[8]; /* 3.56717e-06 */
    GlycogenolysisMax = paramdataPtr->parametervector[9]; /* 4.15075e-08 */
    PEP_Pyruvate_LiverK = paramdataPtr->parametervector[10]; /* 0.690409 */
    TCA_startK = paramdataPtr->parametervector[11]; /* 0.00108534 */
    OAA_PEP_LiverK = paramdataPtr->parametervector[12]; /* 0.0933083 */
    Pyruvate_OAA_LiverK = paramdataPtr->parametervector[13]; /* 0.00132704 */
    Pyruvate_Lactate_LiverK = paramdataPtr->parametervector[14]; /* 0.323574 */
    LactateToPyruvateLiverK = paramdataPtr->parametervector[15]; /* 0.105233 */
    PyruvateOutK = paramdataPtr->parametervector[16]; /* 8.10716e-06 */
    InVivoExternalSourceK = paramdataPtr->parametervector[17]; /* 1.93581 */
    ExenatideClearanceK = paramdataPtr->parametervector[18]; /* 1.09361e-05 */
    ExenatideClearanceLiverKexp = paramdataPtr->parametervector[19]; /* 0.94864 */
    ExenatideInsulinMax = paramdataPtr->parametervector[20]; /* 7.68354 */
    ExenatideInsulin0 = paramdataPtr->parametervector[21]; /* 0.00446041 */
    ExenatideInsulinDecayMax = paramdataPtr->parametervector[22]; /* 2.85217 */
    ExenatideInsulinDecay0 = paramdataPtr->parametervector[23]; /* 0.116164 */
    InsulinProductionROC_K = paramdataPtr->parametervector[24]; /* 6.33232e+06 */
    InsulinProductionBaseline_K = paramdataPtr->parametervector[25]; /* 1.05184e+07 */
    InsulinProductionBaseline_K0 = paramdataPtr->parametervector[26]; /* 3.07919 */
    InsulinProductionBasal = paramdataPtr->parametervector[27]; /* 155567 */
    G_baseline = paramdataPtr->parametervector[28]; /* 3.24595 */
    InsulinClearanceLiverK = paramdataPtr->parametervector[29]; /* 2.11395e-05 */
    CountLiver = paramdataPtr->parametervector[30]; /* 1 */
    CountPancrease = paramdataPtr->parametervector[31]; /* 1 */
    CountAdipocytesMuscle = paramdataPtr->parametervector[32]; /* 0 */
    CountBrain = paramdataPtr->parametervector[33]; /* 0 */
    CountKidneys = paramdataPtr->parametervector[34]; /* 0 */
    CountStomach = paramdataPtr->parametervector[35]; /* 0 */
    carb_flow = paramdataPtr->parametervector[36]; /* 0 */
    V_hep = paramdataPtr->parametervector[37]; /* 3.4e-06 */
    V_m_medium = paramdataPtr->parametervector[38]; /* 0.0006 */
    ExenatideExternalInjection = paramdataPtr->parametervector[39]; /* 0 */
    GlucoseExternalInjection = paramdataPtr->parametervector[40]; /* 0 */
    V_islets = paramdataPtr->parametervector[41]; /* 8.8e-09 */
    GLUT2 = 0.0004;
    PancreticInsulinExocytosis = 0.0015;
    HepaticInsulinTransportation = 0.001;
    LactateMCTs = 0.0002;
    Glucose_HepaticConcentration = Glucose_Liver/V_hep;
    Glycogen_HepaticConcentration = Glycogen_Liver/V_hep;
    PEP_HepaticConcentration = PEP_Liver/V_hep;
    Pyruvate_HepaticConcentration = Pyruvate_Liver/V_hep;
    OAA_HepaticConcentration = OAA_Liver/V_hep;
    Lactate_HepaticConcentration = Lactate_Liver/V_hep;
    Insulin_HepaticConcentration = Insulin_Liver/V_hep;
    Glucose_PancreasConcentration = Glucose_Pancreas/V_islets;
    Insulin_PancreasConcentration = Insulin_Pancreas/V_islets;
    Glucose_MediumConcentration = Glucose_Medium/V_m_medium;
    Insulin_MediumConcentration = Insulin_Medium/V_m_medium;
    Lactate_MediumConcentration = Lactate_Medium/V_m_medium;
    Exenatide_MediumConcentration = Exenatide_Medium/V_m_medium;
    Exenatide_MediumConcentrationNano = Exenatide_MediumConcentration*1000000.0;
    GlucoseOverHealthy_sim = GlucoseOverHealthy;
    InsulinSensitivity = max(0.0,1.0-(Imax_SI*GlucoseOverHealthy)/(EC50_SI+GlucoseOverHealthy));
    F_islets = max(0.0,1.0-((pow(Time,2.0))/(pow(Alpha,2.0)+pow(Time,2.0))));
    InsulinMediumToPancrease = PancreticInsulinExocytosis*Insulin_MediumConcentration*CountPancrease;
    InsulinPancreaseToMedium = PancreticInsulinExocytosis*Insulin_PancreasConcentration*CountPancrease;
    InsulinLiverToMedium = HepaticInsulinTransportation*Insulin_HepaticConcentration*CountLiver;
    InsulinMediumToLiver = HepaticInsulinTransportation*Insulin_MediumConcentration*CountLiver;
    EGP_Pancrease = (GLUT2*Glucose_PancreasConcentration)*CountPancrease;
    U_ip = (GLUT2*Glucose_MediumConcentration)*CountPancrease;
    U_il = (GLUT2*Glucose_MediumConcentration)*CountLiver;
    EGP_Liver = (GLUT2*Glucose_HepaticConcentration)*CountLiver;
    LactateLiverToMedium = LactateMCTs*Lactate_HepaticConcentration*CountLiver;
    LactateMediumToLiver = LactateMCTs*Lactate_MediumConcentration*CountLiver;
    ExenatideClearance = (ExenatideClearanceK*pow(Exenatide_MediumConcentration,ExenatideClearanceLiverKexp));
    ExanitideInsulinInterplay = max(1.0,((ExenatideInsulinMax*Exenatide_MediumConcentrationNano)/(ExenatideInsulin0+Exenatide_MediumConcentrationNano))-((Exenatide_MediumConcentrationNano*ExenatideInsulinDecayMax)/(Exenatide_MediumConcentrationNano+ExenatideInsulinDecay0)));
    InsulinResponse_Liver = max(0.0,InsulinSensitivity*(InsulinResponse_LiverMax*Insulin_HepaticConcentration)/(Insulin_HepaticConcentration+InsulinResponse_Liver0));
    GlycolysisInsulinDependent = Glucose_HepaticConcentration*InsulinResponse_Liver*CountLiver;
    GlycolysisInsulinIndependent = Glucose_HepaticConcentration*Glycolysis_ii*CountLiver;
    Glycolysis = GlycolysisInsulinDependent+GlycolysisInsulinIndependent;
    Gluconeogenesis = PEP_HepaticConcentration*GluconeogenesisK*CountLiver;
    Glycogenesis = Glucose_HepaticConcentration*InsulinResponse_Liver*GlycogenesisK*CountLiver;
    Glycogenolysis = (Glycogen_HepaticConcentration*GlycogenolysisMax)/(30.0+Glycogen_HepaticConcentration)*CountLiver;
    InsulinClearanceLiver = Insulin_HepaticConcentration*InsulinClearanceLiverK*CountLiver;
    PEPtoPyruvate = PEP_HepaticConcentration*PEP_Pyruvate_LiverK*CountLiver;
    TCA_start = (Pyruvate_Liver*OAA_Liver)/V_hep*TCA_startK*CountLiver;
    OAAtoPEP = OAA_HepaticConcentration*OAA_PEP_LiverK*CountLiver;
    PyruvateToOAA = Pyruvate_HepaticConcentration*Pyruvate_OAA_LiverK*CountLiver;
    PyruvateToLactateLiver = Pyruvate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver;
    LactateToPyruvateLiver = Lactate_HepaticConcentration*LactateToPyruvateLiverK*CountLiver;
    PyruvateOut = Pyruvate_HepaticConcentration*PyruvateOutK*CountLiver;
    Ra = 3.348*Qgut*CountStomach;
    Ra_mM = ((Ra*1000.0)/(18.0*10.0*V_m_medium));
    InVivoExternalSource = InVivoExternalSourceK*max(0.0,min(1.0,CountAdipocytesMuscle))*CountLiver;
    V_mmax = 0.8*(2.82*InsulinSensitivity*Insulin_MediumConcentration);
    V_fmax = 0.2*(2.82*InsulinSensitivity*Insulin_MediumConcentration);
    U_idm = max(0.0,V_mmax*Glucose_MediumConcentration/(12.0+Glucose_MediumConcentration)*CountAdipocytesMuscle);
    U_idf = max(0.0,V_fmax*Glucose_MediumConcentration/(12.0+Glucose_MediumConcentration)*CountAdipocytesMuscle);
    U_iib = 1.0*Glucose_MediumConcentration*CountBrain;
    U = U_iib+U_idf+U_idm+U_il;
    EGP_Kidneys = 0.0;
    InsulinClearanceNonLiver = 0.25*InsulinClearanceLiver*CountKidneys;
    InsulinProductionROC = InsulinProductionROC_K*max(0.0,3.4*GlucoseExternalInjectionDelay+EGP_Liver+EGP_Pancrease+EGP_Kidneys+Ra_mM-(U_il+U_ip+U_iib+U_idf+U_idm));
    InsulinProductionBaselineDifference = max(0.0,(Glucose_PancreasConcentration-G_baseline));
    InsulinProductionBaseline = InsulinProductionBaselineDifference*InsulinProductionBaseline_K/(InsulinProductionBaselineDifference+InsulinProductionBaseline_K0);
    InsulinProduction = V_islets*F_islets*ExanitideInsulinInterplay*(InsulinProductionROC+InsulinProductionBaseline+InsulinProductionBasal)*CountPancrease;
    if (DOflag == DOFLAG_DDT) {
    	DDTvector[0] = ((carb_flow)-(3.348*Qsto1))*CountStomach;
    	DDTvector[1] = ((3.348*Qsto1)-(Ra))*CountStomach;
    	DDTvector[2] = GlucoseExternalInjection-3.4*GlucoseExternalInjectionDelay;
    	DDTvector[3] = 3.4*GlucoseExternalInjectionDelay+EGP_Liver+EGP_Pancrease+EGP_Kidneys+Ra_mM-(U_il+U_ip+U_iib+U_idf+U_idm);
    	DDTvector[4] = InsulinLiverToMedium+InsulinPancreaseToMedium-(InsulinMediumToLiver+InsulinMediumToPancrease+InsulinClearanceNonLiver);
    	DDTvector[5] = LactateLiverToMedium-(LactateMediumToLiver);
    	DDTvector[6] = ExenatideExternalInjection-(ExenatideClearance);
    	DDTvector[7] = U_il+Glycogenolysis+Gluconeogenesis*0.5-(EGP_Liver+Glycolysis+Glycogenesis);
    	DDTvector[8] = Glycogenesis/50000.0-(Glycogenolysis/50000.0);
    	DDTvector[9] = (Glycolysis*2.0+OAAtoPEP)-(PEPtoPyruvate+Gluconeogenesis);
    	DDTvector[10] = (PEPtoPyruvate+LactateToPyruvateLiver+InVivoExternalSource)-(TCA_start+PyruvateToOAA+PyruvateToLactateLiver+PyruvateOut);
    	DDTvector[11] = (PyruvateToOAA+TCA_start*2.0)-(TCA_start+OAAtoPEP);
    	DDTvector[12] = PyruvateToLactateLiver+LactateMediumToLiver-(LactateToPyruvateLiver+LactateLiverToMedium);
    	DDTvector[13] = InsulinMediumToLiver-(InsulinLiverToMedium+InsulinClearanceLiver);
    	DDTvector[14] = U_ip-(EGP_Pancrease);
    	DDTvector[15] = InsulinProduction+InsulinMediumToPancrease-(InsulinPancreaseToMedium);
    	DDTvector[16] = max(0.0,Glucose_Liver/V_hep-G_healthy);
    	DDTvector[17] = 1.0;
    } else if (DOflag == DOFLAG_VARREAC) {
        variableVector[0] = GLUT2;
        variableVector[1] = PancreticInsulinExocytosis;
        variableVector[2] = HepaticInsulinTransportation;
        variableVector[3] = LactateMCTs;
        variableVector[4] = Glucose_HepaticConcentration;
        variableVector[5] = Glycogen_HepaticConcentration;
        variableVector[6] = PEP_HepaticConcentration;
        variableVector[7] = Pyruvate_HepaticConcentration;
        variableVector[8] = OAA_HepaticConcentration;
        variableVector[9] = Lactate_HepaticConcentration;
        variableVector[10] = Insulin_HepaticConcentration;
        variableVector[11] = Glucose_PancreasConcentration;
        variableVector[12] = Insulin_PancreasConcentration;
        variableVector[13] = Glucose_MediumConcentration;
        variableVector[14] = Insulin_MediumConcentration;
        variableVector[15] = Lactate_MediumConcentration;
        variableVector[16] = Exenatide_MediumConcentration;
        variableVector[17] = Exenatide_MediumConcentrationNano;
        variableVector[18] = GlucoseOverHealthy_sim;
        variableVector[19] = InsulinSensitivity;
        variableVector[20] = F_islets;
        variableVector[21] = InsulinMediumToPancrease;
        variableVector[22] = InsulinPancreaseToMedium;
        variableVector[23] = InsulinLiverToMedium;
        variableVector[24] = InsulinMediumToLiver;
        variableVector[25] = EGP_Pancrease;
        variableVector[26] = U_ip;
        variableVector[27] = U_il;
        variableVector[28] = EGP_Liver;
        variableVector[29] = LactateLiverToMedium;
        variableVector[30] = LactateMediumToLiver;
        variableVector[31] = ExenatideClearance;
        variableVector[32] = ExanitideInsulinInterplay;
        variableVector[33] = InsulinResponse_Liver;
        variableVector[34] = GlycolysisInsulinDependent;
        variableVector[35] = GlycolysisInsulinIndependent;
        variableVector[36] = Glycolysis;
        variableVector[37] = Gluconeogenesis;
        variableVector[38] = Glycogenesis;
        variableVector[39] = Glycogenolysis;
        variableVector[40] = InsulinClearanceLiver;
        variableVector[41] = PEPtoPyruvate;
        variableVector[42] = TCA_start;
        variableVector[43] = OAAtoPEP;
        variableVector[44] = PyruvateToOAA;
        variableVector[45] = PyruvateToLactateLiver;
        variableVector[46] = LactateToPyruvateLiver;
        variableVector[47] = PyruvateOut;
        variableVector[48] = Ra;
        variableVector[49] = Ra_mM;
        variableVector[50] = InVivoExternalSource;
        variableVector[51] = V_mmax;
        variableVector[52] = V_fmax;
        variableVector[53] = U_idm;
        variableVector[54] = U_idf;
        variableVector[55] = U_iib;
        variableVector[56] = U;
        variableVector[57] = EGP_Kidneys;
        variableVector[58] = InsulinClearanceNonLiver;
        variableVector[59] = InsulinProductionROC;
        variableVector[60] = InsulinProductionBaselineDifference;
        variableVector[61] = InsulinProductionBaseline;
        variableVector[62] = InsulinProduction;
    } else if (DOflag == DOFLAG_EVENTS) {
    } else if (DOflag == DOFLAG_EVENTASSIGN) {
    }
}


/* Function for initial condition calculation */
void calc_ic_model(double *icVector, ParamData *paramdataPtr)
{
    double Qsto1,Qgut,GlucoseExternalInjectionDelay,Glucose_Medium,Insulin_Medium,Lactate_Medium,Exenatide_Medium,Glucose_Liver,Glycogen_Liver,PEP_Liver,Pyruvate_Liver,OAA_Liver,Lactate_Liver,Insulin_Liver,Glucose_Pancreas,Insulin_Pancreas,GlucoseOverHealthy,Time;
    double Imax_SI,EC50_SI,G_healthy,Alpha,InsulinResponse_LiverMax,InsulinResponse_Liver0,Glycolysis_ii,GluconeogenesisK,GlycogenesisK,GlycogenolysisMax,PEP_Pyruvate_LiverK,TCA_startK,OAA_PEP_LiverK,Pyruvate_OAA_LiverK,Pyruvate_Lactate_LiverK,LactateToPyruvateLiverK,PyruvateOutK,InVivoExternalSourceK,ExenatideClearanceK,ExenatideClearanceLiverKexp;
    double ExenatideInsulinMax,ExenatideInsulin0,ExenatideInsulinDecayMax,ExenatideInsulinDecay0,InsulinProductionROC_K,InsulinProductionBaseline_K,InsulinProductionBaseline_K0,InsulinProductionBasal,G_baseline,InsulinClearanceLiverK,CountLiver,CountPancrease,CountAdipocytesMuscle,CountBrain,CountKidneys,CountStomach,carb_flow,V_hep,V_m_medium,ExenatideExternalInjection;
    double GlucoseExternalInjection,V_islets;
    double GLUT2,PancreticInsulinExocytosis,HepaticInsulinTransportation,LactateMCTs,Glucose_HepaticConcentration,Glycogen_HepaticConcentration,PEP_HepaticConcentration,Pyruvate_HepaticConcentration,OAA_HepaticConcentration,Lactate_HepaticConcentration,Insulin_HepaticConcentration,Glucose_PancreasConcentration,Insulin_PancreasConcentration,Glucose_MediumConcentration,Insulin_MediumConcentration,Lactate_MediumConcentration,Exenatide_MediumConcentration,Exenatide_MediumConcentrationNano,GlucoseOverHealthy_sim,InsulinSensitivity;
    double F_islets,InsulinMediumToPancrease,InsulinPancreaseToMedium,InsulinLiverToMedium,InsulinMediumToLiver,EGP_Pancrease,U_ip,U_il,EGP_Liver,LactateLiverToMedium,LactateMediumToLiver,ExenatideClearance,ExanitideInsulinInterplay,InsulinResponse_Liver,GlycolysisInsulinDependent,GlycolysisInsulinIndependent,Glycolysis,Gluconeogenesis,Glycogenesis,Glycogenolysis;
    double InsulinClearanceLiver,PEPtoPyruvate,TCA_start,OAAtoPEP,PyruvateToOAA,PyruvateToLactateLiver,LactateToPyruvateLiver,PyruvateOut,Ra,Ra_mM,InVivoExternalSource,V_mmax,V_fmax,U_idm,U_idf,U_iib,U,EGP_Kidneys,InsulinClearanceNonLiver,InsulinProductionROC;
    double InsulinProductionBaselineDifference,InsulinProductionBaseline,InsulinProduction;
    Imax_SI = paramdataPtr->parametervector[0]; /* 0.728138 */
    EC50_SI = paramdataPtr->parametervector[1]; /* 284.063 */
    G_healthy = paramdataPtr->parametervector[2]; /* 7.61405 */
    Alpha = paramdataPtr->parametervector[3]; /* 309.227 */
    InsulinResponse_LiverMax = paramdataPtr->parametervector[4]; /* 1.73467e-05 */
    InsulinResponse_Liver0 = paramdataPtr->parametervector[5]; /* 447.525 */
    Glycolysis_ii = paramdataPtr->parametervector[6]; /* 7.13868e-06 */
    GluconeogenesisK = paramdataPtr->parametervector[7]; /* 0.0388488 */
    GlycogenesisK = paramdataPtr->parametervector[8]; /* 3.56717e-06 */
    GlycogenolysisMax = paramdataPtr->parametervector[9]; /* 4.15075e-08 */
    PEP_Pyruvate_LiverK = paramdataPtr->parametervector[10]; /* 0.690409 */
    TCA_startK = paramdataPtr->parametervector[11]; /* 0.00108534 */
    OAA_PEP_LiverK = paramdataPtr->parametervector[12]; /* 0.0933083 */
    Pyruvate_OAA_LiverK = paramdataPtr->parametervector[13]; /* 0.00132704 */
    Pyruvate_Lactate_LiverK = paramdataPtr->parametervector[14]; /* 0.323574 */
    LactateToPyruvateLiverK = paramdataPtr->parametervector[15]; /* 0.105233 */
    PyruvateOutK = paramdataPtr->parametervector[16]; /* 8.10716e-06 */
    InVivoExternalSourceK = paramdataPtr->parametervector[17]; /* 1.93581 */
    ExenatideClearanceK = paramdataPtr->parametervector[18]; /* 1.09361e-05 */
    ExenatideClearanceLiverKexp = paramdataPtr->parametervector[19]; /* 0.94864 */
    ExenatideInsulinMax = paramdataPtr->parametervector[20]; /* 7.68354 */
    ExenatideInsulin0 = paramdataPtr->parametervector[21]; /* 0.00446041 */
    ExenatideInsulinDecayMax = paramdataPtr->parametervector[22]; /* 2.85217 */
    ExenatideInsulinDecay0 = paramdataPtr->parametervector[23]; /* 0.116164 */
    InsulinProductionROC_K = paramdataPtr->parametervector[24]; /* 6.33232e+06 */
    InsulinProductionBaseline_K = paramdataPtr->parametervector[25]; /* 1.05184e+07 */
    InsulinProductionBaseline_K0 = paramdataPtr->parametervector[26]; /* 3.07919 */
    InsulinProductionBasal = paramdataPtr->parametervector[27]; /* 155567 */
    G_baseline = paramdataPtr->parametervector[28]; /* 3.24595 */
    InsulinClearanceLiverK = paramdataPtr->parametervector[29]; /* 2.11395e-05 */
    CountLiver = paramdataPtr->parametervector[30]; /* 1 */
    CountPancrease = paramdataPtr->parametervector[31]; /* 1 */
    CountAdipocytesMuscle = paramdataPtr->parametervector[32]; /* 0 */
    CountBrain = paramdataPtr->parametervector[33]; /* 0 */
    CountKidneys = paramdataPtr->parametervector[34]; /* 0 */
    CountStomach = paramdataPtr->parametervector[35]; /* 0 */
    carb_flow = paramdataPtr->parametervector[36]; /* 0 */
    V_hep = paramdataPtr->parametervector[37]; /* 3.4e-06 */
    V_m_medium = paramdataPtr->parametervector[38]; /* 0.0006 */
    ExenatideExternalInjection = paramdataPtr->parametervector[39]; /* 0 */
    GlucoseExternalInjection = paramdataPtr->parametervector[40]; /* 0 */
    V_islets = paramdataPtr->parametervector[41]; /* 8.8e-09 */
    GLUT2 = 0.0004;
    PancreticInsulinExocytosis = 0.0015;
    HepaticInsulinTransportation = 0.001;
    LactateMCTs = 0.0002;
    Glucose_HepaticConcentration = Glucose_Liver/V_hep;
    Glycogen_HepaticConcentration = Glycogen_Liver/V_hep;
    PEP_HepaticConcentration = PEP_Liver/V_hep;
    Pyruvate_HepaticConcentration = Pyruvate_Liver/V_hep;
    OAA_HepaticConcentration = OAA_Liver/V_hep;
    Lactate_HepaticConcentration = Lactate_Liver/V_hep;
    Insulin_HepaticConcentration = Insulin_Liver/V_hep;
    Glucose_PancreasConcentration = Glucose_Pancreas/V_islets;
    Insulin_PancreasConcentration = Insulin_Pancreas/V_islets;
    Glucose_MediumConcentration = Glucose_Medium/V_m_medium;
    Insulin_MediumConcentration = Insulin_Medium/V_m_medium;
    Lactate_MediumConcentration = Lactate_Medium/V_m_medium;
    Exenatide_MediumConcentration = Exenatide_Medium/V_m_medium;
    Exenatide_MediumConcentrationNano = Exenatide_MediumConcentration*1000000.0;
    GlucoseOverHealthy_sim = GlucoseOverHealthy;
    InsulinSensitivity = max(0.0,1.0-(Imax_SI*GlucoseOverHealthy)/(EC50_SI+GlucoseOverHealthy));
    F_islets = max(0.0,1.0-((pow(Time,2.0))/(pow(Alpha,2.0)+pow(Time,2.0))));
    InsulinMediumToPancrease = PancreticInsulinExocytosis*Insulin_MediumConcentration*CountPancrease;
    InsulinPancreaseToMedium = PancreticInsulinExocytosis*Insulin_PancreasConcentration*CountPancrease;
    InsulinLiverToMedium = HepaticInsulinTransportation*Insulin_HepaticConcentration*CountLiver;
    InsulinMediumToLiver = HepaticInsulinTransportation*Insulin_MediumConcentration*CountLiver;
    EGP_Pancrease = (GLUT2*Glucose_PancreasConcentration)*CountPancrease;
    U_ip = (GLUT2*Glucose_MediumConcentration)*CountPancrease;
    U_il = (GLUT2*Glucose_MediumConcentration)*CountLiver;
    EGP_Liver = (GLUT2*Glucose_HepaticConcentration)*CountLiver;
    LactateLiverToMedium = LactateMCTs*Lactate_HepaticConcentration*CountLiver;
    LactateMediumToLiver = LactateMCTs*Lactate_MediumConcentration*CountLiver;
    ExenatideClearance = (ExenatideClearanceK*pow(Exenatide_MediumConcentration,ExenatideClearanceLiverKexp));
    ExanitideInsulinInterplay = max(1.0,((ExenatideInsulinMax*Exenatide_MediumConcentrationNano)/(ExenatideInsulin0+Exenatide_MediumConcentrationNano))-((Exenatide_MediumConcentrationNano*ExenatideInsulinDecayMax)/(Exenatide_MediumConcentrationNano+ExenatideInsulinDecay0)));
    InsulinResponse_Liver = max(0.0,InsulinSensitivity*(InsulinResponse_LiverMax*Insulin_HepaticConcentration)/(Insulin_HepaticConcentration+InsulinResponse_Liver0));
    GlycolysisInsulinDependent = Glucose_HepaticConcentration*InsulinResponse_Liver*CountLiver;
    GlycolysisInsulinIndependent = Glucose_HepaticConcentration*Glycolysis_ii*CountLiver;
    Glycolysis = GlycolysisInsulinDependent+GlycolysisInsulinIndependent;
    Gluconeogenesis = PEP_HepaticConcentration*GluconeogenesisK*CountLiver;
    Glycogenesis = Glucose_HepaticConcentration*InsulinResponse_Liver*GlycogenesisK*CountLiver;
    Glycogenolysis = (Glycogen_HepaticConcentration*GlycogenolysisMax)/(30.0+Glycogen_HepaticConcentration)*CountLiver;
    InsulinClearanceLiver = Insulin_HepaticConcentration*InsulinClearanceLiverK*CountLiver;
    PEPtoPyruvate = PEP_HepaticConcentration*PEP_Pyruvate_LiverK*CountLiver;
    TCA_start = (Pyruvate_Liver*OAA_Liver)/V_hep*TCA_startK*CountLiver;
    OAAtoPEP = OAA_HepaticConcentration*OAA_PEP_LiverK*CountLiver;
    PyruvateToOAA = Pyruvate_HepaticConcentration*Pyruvate_OAA_LiverK*CountLiver;
    PyruvateToLactateLiver = Pyruvate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver;
    LactateToPyruvateLiver = Lactate_HepaticConcentration*LactateToPyruvateLiverK*CountLiver;
    PyruvateOut = Pyruvate_HepaticConcentration*PyruvateOutK*CountLiver;
    Ra = 3.348*Qgut*CountStomach;
    Ra_mM = ((Ra*1000.0)/(18.0*10.0*V_m_medium));
    InVivoExternalSource = InVivoExternalSourceK*max(0.0,min(1.0,CountAdipocytesMuscle))*CountLiver;
    V_mmax = 0.8*(2.82*InsulinSensitivity*Insulin_MediumConcentration);
    V_fmax = 0.2*(2.82*InsulinSensitivity*Insulin_MediumConcentration);
    U_idm = max(0.0,V_mmax*Glucose_MediumConcentration/(12.0+Glucose_MediumConcentration)*CountAdipocytesMuscle);
    U_idf = max(0.0,V_fmax*Glucose_MediumConcentration/(12.0+Glucose_MediumConcentration)*CountAdipocytesMuscle);
    U_iib = 1.0*Glucose_MediumConcentration*CountBrain;
    U = U_iib+U_idf+U_idm+U_il;
    EGP_Kidneys = 0.0;
    InsulinClearanceNonLiver = 0.25*InsulinClearanceLiver*CountKidneys;
    InsulinProductionROC = InsulinProductionROC_K*max(0.0,3.4*GlucoseExternalInjectionDelay+EGP_Liver+EGP_Pancrease+EGP_Kidneys+Ra_mM-(U_il+U_ip+U_iib+U_idf+U_idm));
    InsulinProductionBaselineDifference = max(0.0,(Glucose_PancreasConcentration-G_baseline));
    InsulinProductionBaseline = InsulinProductionBaselineDifference*InsulinProductionBaseline_K/(InsulinProductionBaselineDifference+InsulinProductionBaseline_K0);
    InsulinProduction = V_islets*F_islets*ExanitideInsulinInterplay*(InsulinProductionROC+InsulinProductionBaseline+InsulinProductionBasal)*CountPancrease;
    Qsto1 = 0.0;
    Qgut = 0.0;
    GlucoseExternalInjectionDelay = 0.0;
    Glucose_Medium = 0.0;
    Insulin_Medium = 0.0;
    Lactate_Medium = 0.0;
    Exenatide_Medium = 0.0;
    Glucose_Liver = 0.0;
    Glycogen_Liver = 0.00051;
    PEP_Liver = 0.0;
    Pyruvate_Liver = 0.0;
    OAA_Liver = 0.0;
    Lactate_Liver = 0.0;
    Insulin_Liver = 0.0;
    Glucose_Pancreas = 0.0;
    Insulin_Pancreas = 0.0;
    GlucoseOverHealthy = 0.0;
    Time = 0.0;
    icVector[0] = Qsto1;
    icVector[1] = Qgut;
    icVector[2] = GlucoseExternalInjectionDelay;
    icVector[3] = Glucose_Medium;
    icVector[4] = Insulin_Medium;
    icVector[5] = Lactate_Medium;
    icVector[6] = Exenatide_Medium;
    icVector[7] = Glucose_Liver;
    icVector[8] = Glycogen_Liver;
    icVector[9] = PEP_Liver;
    icVector[10] = Pyruvate_Liver;
    icVector[11] = OAA_Liver;
    icVector[12] = Lactate_Liver;
    icVector[13] = Insulin_Liver;
    icVector[14] = Glucose_Pancreas;
    icVector[15] = Insulin_Pancreas;
    icVector[16] = GlucoseOverHealthy;
    icVector[17] = Time;
}

