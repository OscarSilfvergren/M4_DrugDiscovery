#include "mex.h"

const int NRSTATES = 18;
const int NRPARAMETERS = 42;
const int NRVARIABLES = 63;
const int NRREACTIONS = 0;
const int NREVENTS = 0;

const int hasOnlyNumericICs = 1;
double defaultICs_num[18] = {
	0,0,0,0,0,0,0,0,0.00051,0,0,0,0,0,0,0,0,0};
char *defaultICs_nonnum[1];

double defaultParam[42] = {
	0.728138,284.063,7.61405,309.227,1.73467e-05,447.525,7.13868e-06,0.0388488,3.56717e-06,4.15075e-08,0.690409,0.00108534,0.0933083,0.00132704,0.323574,0.105233,8.10716e-06,1.93581,1.09361e-05,0.94864,
	7.68354,0.00446041,2.85217,0.116164,6.33232e+06,1.05184e+07,3.07919,155567,3.24595,2.11395e-05,1,1,0,0,0,0,0,3.4e-06,0.0006,0,
	0,8.8e-09};
char *stateNames[18] = {
	"Qsto1","Qgut","GlucoseExternalInjectionDelay","Glucose_Medium","Insulin_Medium","Lactate_Medium","Exenatide_Medium","Glucose_Liver","Glycogen_Liver","PEP_Liver","Pyruvate_Liver","OAA_Liver","Lactate_Liver","Insulin_Liver","Glucose_Pancreas","Insulin_Pancreas","GlucoseOverHealthy","Time"};
char *parameterNames[42] = {
	"Imax_SI","EC50_SI","G_healthy","Alpha","InsulinResponse_LiverMax","InsulinResponse_Liver0","Glycolysis_ii","GluconeogenesisK","GlycogenesisK","GlycogenolysisMax","PEP_Pyruvate_LiverK","TCA_startK","OAA_PEP_LiverK","Pyruvate_OAA_LiverK","Pyruvate_Lactate_LiverK","LactateToPyruvateLiverK","PyruvateOutK","InVivoExternalSourceK","ExenatideClearanceK","ExenatideClearanceLiverKexp",
	"ExenatideInsulinMax","ExenatideInsulin0","ExenatideInsulinDecayMax","ExenatideInsulinDecay0","InsulinProductionROC_K","InsulinProductionBaseline_K","InsulinProductionBaseline_K0","InsulinProductionBasal","G_baseline","InsulinClearanceLiverK","CountLiver","CountPancrease","CountAdipocytesMuscle","CountBrain","CountKidneys","CountStomach","carb_flow","V_hep","V_m_medium","ExenatideExternalInjection",
	"GlucoseExternalInjection","V_islets"};
char *variableNames[63] = {
	"GLUT2","PancreticInsulinExocytosis","HepaticInsulinTransportation","LactateMCTs","Glucose_HepaticConcentration","Glycogen_HepaticConcentration","PEP_HepaticConcentration","Pyruvate_HepaticConcentration","OAA_HepaticConcentration","Lactate_HepaticConcentration","Insulin_HepaticConcentration","Glucose_PancreasConcentration","Insulin_PancreasConcentration","Glucose_MediumConcentration","Insulin_MediumConcentration","Lactate_MediumConcentration","Exenatide_MediumConcentration","Exenatide_MediumConcentrationNano","GlucoseOverHealthy_sim","InsulinSensitivity",
	"F_islets","InsulinMediumToPancrease","InsulinPancreaseToMedium","InsulinLiverToMedium","InsulinMediumToLiver","EGP_Pancrease","U_ip","U_il","EGP_Liver","LactateLiverToMedium","LactateMediumToLiver","ExenatideClearance","ExanitideInsulinInterplay","InsulinResponse_Liver","GlycolysisInsulinDependent","GlycolysisInsulinIndependent","Glycolysis","Gluconeogenesis","Glycogenesis","Glycogenolysis",
	"InsulinClearanceLiver","PEPtoPyruvate","TCA_start","OAAtoPEP","PyruvateToOAA","PyruvateToLactateLiver","LactateToPyruvateLiver","PyruvateOut","Ra","Ra_mM","InVivoExternalSource","V_mmax","V_fmax","U_idm","U_idf","U_iib","U","EGP_Kidneys","InsulinClearanceNonLiver","InsulinProductionROC",
	"InsulinProductionBaselineDifference","InsulinProductionBaseline","InsulinProduction"};
char *variableFormulas[63] = {
	"0.0004","0.0015","0.001","0.0002","Glucose_Liver/V_hep","Glycogen_Liver/V_hep","PEP_Liver/V_hep","Pyruvate_Liver/V_hep","OAA_Liver/V_hep","Lactate_Liver/V_hep","Insulin_Liver/V_hep","Glucose_Pancreas/V_islets","Insulin_Pancreas/V_islets","Glucose_Medium/V_m_medium","Insulin_Medium/V_m_medium","Lactate_Medium/V_m_medium","Exenatide_Medium/V_m_medium","Exenatide_MediumConcentration*1000000.0","GlucoseOverHealthy","max(0.0,1.0-(Imax_SI*GlucoseOverHealthy)/(EC50_SI+GlucoseOverHealthy))",
	"max(0.0,1.0-((pow(Time,2.0))/(pow(Alpha,2.0)+pow(Time,2.0))))","PancreticInsulinExocytosis*Insulin_MediumConcentration*CountPancrease","PancreticInsulinExocytosis*Insulin_PancreasConcentration*CountPancrease","HepaticInsulinTransportation*Insulin_HepaticConcentration*CountLiver","HepaticInsulinTransportation*Insulin_MediumConcentration*CountLiver","(GLUT2*Glucose_PancreasConcentration)*CountPancrease","(GLUT2*Glucose_MediumConcentration)*CountPancrease","(GLUT2*Glucose_MediumConcentration)*CountLiver","(GLUT2*Glucose_HepaticConcentration)*CountLiver","LactateMCTs*Lactate_HepaticConcentration*CountLiver","LactateMCTs*Lactate_MediumConcentration*CountLiver","(ExenatideClearanceK*pow(Exenatide_MediumConcentration,ExenatideClearanceLiverKexp))","max(1.0,((ExenatideInsulinMax*Exenatide_MediumConcentrationNano)/(ExenatideInsulin0+Exenatide_MediumConcentrationNano))-((Exenatide_MediumConcentrationNano*ExenatideInsulinDecayMax)/(Exenatide_MediumConcentrationNano+ExenatideInsulinDecay0)))","max(0.0,InsulinSensitivity*(InsulinResponse_LiverMax*Insulin_HepaticConcentration)/(Insulin_HepaticConcentration+InsulinResponse_Liver0))","Glucose_HepaticConcentration*InsulinResponse_Liver*CountLiver","Glucose_HepaticConcentration*Glycolysis_ii*CountLiver","GlycolysisInsulinDependent+GlycolysisInsulinIndependent","PEP_HepaticConcentration*GluconeogenesisK*CountLiver","Glucose_HepaticConcentration*InsulinResponse_Liver*GlycogenesisK*CountLiver","(Glycogen_HepaticConcentration*GlycogenolysisMax)/(30.0+Glycogen_HepaticConcentration)*CountLiver",
	"Insulin_HepaticConcentration*InsulinClearanceLiverK*CountLiver","PEP_HepaticConcentration*PEP_Pyruvate_LiverK*CountLiver","(Pyruvate_Liver*OAA_Liver)/V_hep*TCA_startK*CountLiver","OAA_HepaticConcentration*OAA_PEP_LiverK*CountLiver","Pyruvate_HepaticConcentration*Pyruvate_OAA_LiverK*CountLiver","Pyruvate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver","Lactate_HepaticConcentration*LactateToPyruvateLiverK*CountLiver","Pyruvate_HepaticConcentration*PyruvateOutK*CountLiver","3.348*Qgut*CountStomach","((Ra*1000.0)/(18.0*10.0*V_m_medium))","InVivoExternalSourceK*max(0.0,min(1.0,CountAdipocytesMuscle))*CountLiver","0.8*(2.82*InsulinSensitivity*Insulin_MediumConcentration)","0.2*(2.82*InsulinSensitivity*Insulin_MediumConcentration)","max(0.0,V_mmax*Glucose_MediumConcentration/(12.0+Glucose_MediumConcentration)*CountAdipocytesMuscle)","max(0.0,V_fmax*Glucose_MediumConcentration/(12.0+Glucose_MediumConcentration)*CountAdipocytesMuscle)","1.0*Glucose_MediumConcentration*CountBrain","U_iib+U_idf+U_idm+U_il","0.0","0.25*InsulinClearanceLiver*CountKidneys","InsulinProductionROC_K*max(0.0,3.4*GlucoseExternalInjectionDelay+EGP_Liver+EGP_Pancrease+EGP_Kidneys+Ra_mM-(U_il+U_ip+U_iib+U_idf+U_idm))",
	"max(0.0,(Glucose_PancreasConcentration-G_baseline))","InsulinProductionBaselineDifference*InsulinProductionBaseline_K/(InsulinProductionBaselineDifference+InsulinProductionBaseline_K0)","V_islets*F_islets*ExanitideInsulinInterplay*(InsulinProductionROC+InsulinProductionBaseline+InsulinProductionBasal)*CountPancrease"};
char *reactionNames[1];
char *eventNames[1];

void model(double time, double *stateVector, double *DDTvector, ParamData *paramdataPtr, int DOflag, double *variableVector, double *reactionVector, double *gout, int *eventVector);
void calc_ic_model(double *icVector, ParamData *paramdataPtr);

void CVODEmex25(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]);
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    CVODEmex25(nlhs, plhs, nrhs, prhs);
}
