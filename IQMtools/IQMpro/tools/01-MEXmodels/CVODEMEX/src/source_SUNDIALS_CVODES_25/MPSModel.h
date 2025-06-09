#include "mex.h"

const int NRSTATES = 25;
const int NRPARAMETERS = 68;
const int NRVARIABLES = 70;
const int NRREACTIONS = 0;
const int NREVENTS = 7;

const int hasOnlyNumericICs = 0;
double defaultICs_num[1];
char *defaultICs_nonnum[25] = {
	"G0*V_m_medium","I0*V_m_medium","0","0","Glutamin0*V_m_medium","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0",
	"0","0","0","0","8.8e-09"};

double defaultParam[68] = {
	1,100,0.0025,0.00063,3.24e-05,1,5.5,1,60,1e-09,5e-06,6e-12,6e-08,1e-10,0.5,0.0001,15,0.01,0.1,0.5,
	1,0.5,0.5,0.5,0.5,3e-05,1e-06,40000,0.2,1.7e-06,11,1e-30,2,11,11,11,11,11,11,1e-30,
	1e-30,1e-30,1e-30,1e-30,1e-30,2,2,2,2,2,2,11,1e-30,2,48,96,144,192,240,336,
	288,0.0003,3.4e-06,0.0003,0.0006,0.01,1,1};
char *stateNames[25] = {
	"Glucose_Medium","Insulin_Medium","Lactate_Medium","Albumin_Medium","Glutamin_Medium","Ketones_Medium","Glucose_Liver","PEP_Liver","Serine_Liver","Pyruvate_Liver","Glycin_Liver","Albumin_Liver","AcetylCoA_Liver","Citrate_Liver","TCA_Liver","Glutamin_Liver","OAA_Liver","Ketones_Liver","Lactate_Liver","Insulin_Liver",
	"Glucose_Pancreas","Insulin_Pancreas","GlucoseOverHealthy","Glucose_Pancrease_Delay","V_islets"};
char *parameterNames[68] = {
	"Imax_SI","EC50_SI","d0","r1","r2","kv","G_healthy","Vm_f_islets","Alpha","Glycolysis_k","Glycolysis_ii","GlucoseToSerineLiverK","GlucoseToSerineLiverK_ii","GluconeogenesisK","PEP_Pyruvate_LiverK","Pyruvate_CoA_LiverK","TCA_startK","TCA_rotationK","Citrate_TCA_LiverK","OAA_PEP_LiverK",
	"Pyruvate_OAA_LiverK","Serine_Pyruvate_LiverK","Serine_Glycin_LiverK","Glycin_Albumin_LiverK","Pyruvate_Lactate_LiverK","TCA_Glutamin_LiverK","CoA_Ketones_LiverK","InsulinProductionK","Glucose_Pancrease_DelayK","InsulinClearanceLiverK","G0","I0","Glutamin0","MediumChange_1G","MediumChange_2G","MediumChange_3G","MediumChange_4G","MediumChange_5G","MediumChange_6G","MediumChange_1I",
	"MediumChange_2I","MediumChange_3I","MediumChange_4I","MediumChange_5I","MediumChange_6I","MediumChange_1Glutamin","MediumChange_2Glutamin","MediumChange_3Glutamin","MediumChange_4Glutamin","MediumChange_5Glutamin","MediumChange_6Glutamin","G_GTT","I_GTT","Glutamin_GTT","MediumChange_1_time","MediumChange_2_time","MediumChange_3_time","MediumChange_4_time","MediumChange_5_time","MediumChange_6_time",
	"GTT_time","V_m_liver","V_hep","V_m_pancreas","V_m_medium","Q","CountLiver","CountPancrease"};
char *variableNames[70] = {
	"Glucose_HepaticConcentration","PEP_HepaticConcentration","Pyruvate_HepaticConcentration","AcetylCoA_HepaticConcentration","Citrate_HepaticConcentration","TCA_HepaticConcentration","OAA_HepaticConcentration","Serine_HepaticConcentration","Glycin_HepaticConcentration","Albumin_HepaticConcentration","Lactate_HepaticConcentration","Ketones_HepaticConcentration","Glutamin_HepaticConcentration","Insulin_HepaticConcentration","Glucose_PancreasConcentration","Insulin_PancreasConcentration","Glucose_MediumConcentration","Insulin_MediumConcentration","Lactate_MediumConcentration","Albumin_MediumConcentration",
	"Ketones_MediumConcentration","Glutamin_MediumConcentration","GlucoseOverHealthy_sim","Glucose_Pancrease_Delay_sim","V_islets_sim","InsulinSensitivity","Growth_rate","Death_rate","F_islets","Net_rate","EGP_Pancrease","InsulinMediumToPancrease","U_ip","InsulinPancreaseToMedium","InsulinLiverToMedium","U_il","EGP_Liver","InsulinMediumToLiver","LactateLiverToMedium","LactateMediumToLiver",
	"AlbuminLiverToMedium","AlbuminMediumToLiver","KetonesLiverToMedium","KetonesMediumToLiver","GlutaminMediumToLiver","GlutaminLiverToMedium","InsulinResponse_Liver","Glycolysis","GlucoseToSerineLiver","Gluconeogenesis","InsulinClearanceLiver","PEPtoPyruvate","PyruvateOxi_L","TCA_start","CitrateToTCA_Liver","TCA_rotation","OAAtoPEP","PyruvateToOAA","SerineToPyruvateLiver","SerineToGlycinLiver",
	"GlycinToSerineLiver","GlycinToAlbuminLiver","AlbuminToGlycinLiver","PyruvateToLactateLiver","LactateToPyruvateLiver","CoAToKetonesLiver","KetonesToCoALiver","TCAToGlutaminLiver","GlutaminToTCALiver","InsulinProduction"};
char *variableFormulas[70] = {
	"Glucose_Liver/V_hep","PEP_Liver/V_hep","Pyruvate_Liver/V_hep","AcetylCoA_Liver/V_hep","Citrate_Liver/V_hep","TCA_Liver/V_hep","OAA_Liver/V_hep","Serine_Liver/V_hep","Glycin_Liver/V_hep","Albumin_Liver/V_hep","Lactate_Liver/V_hep","Ketones_Liver/V_hep","Glutamin_Liver/V_hep","Insulin_Liver/V_hep","Glucose_Pancreas/V_islets","Insulin_Pancreas/V_islets","Glucose_Medium/V_m_medium","Insulin_Medium/V_m_medium","Lactate_Medium/V_m_medium","Albumin_Medium/V_m_medium",
	"Ketones_Medium/V_m_medium","Glutamin_Medium/V_m_medium","GlucoseOverHealthy","Glucose_Pancrease_Delay","V_islets","1.0-(Imax_SI*GlucoseOverHealthy)/(EC50_SI+GlucoseOverHealthy)","max(0.0,r1*Glucose_Pancrease_Delay)","max(0.0,r2*pow(Glucose_Pancrease_Delay,2.0))","1.0-((Vm_f_islets*pow(time,2.0))/(pow(Alpha,2.0)+pow(time,2.0)))","kv*(-d0+(Growth_rate-Death_rate))","Q*Glucose_PancreasConcentration*CountPancrease","Q*Insulin_MediumConcentration*CountPancrease","Q*Glucose_MediumConcentration*CountPancrease","Q*Insulin_PancreasConcentration*CountPancrease","Q*Insulin_HepaticConcentration*CountLiver","Q*Glucose_MediumConcentration*CountLiver","Q*Glucose_HepaticConcentration*CountLiver","Q*Insulin_MediumConcentration*CountLiver","Q*Lactate_HepaticConcentration*CountLiver","Q*Lactate_MediumConcentration*CountLiver",
	"Q*Albumin_HepaticConcentration*CountLiver","Q*Albumin_MediumConcentration*CountLiver","Q*Ketones_HepaticConcentration*CountLiver","Q*Ketones_MediumConcentration*CountLiver","Q*Glutamin_MediumConcentration*CountLiver","Q*Glutamin_HepaticConcentration*CountLiver","InsulinSensitivity*Insulin_HepaticConcentration","Glucose_HepaticConcentration*(InsulinResponse_Liver*Glycolysis_k+Glycolysis_ii)*CountLiver","Glucose_HepaticConcentration*(InsulinResponse_Liver*GlucoseToSerineLiverK+GlucoseToSerineLiverK_ii)*CountLiver","PEP_HepaticConcentration*GluconeogenesisK*CountLiver","Insulin_HepaticConcentration*InsulinClearanceLiverK*CountLiver","PEP_HepaticConcentration*PEP_Pyruvate_LiverK*CountLiver","Pyruvate_HepaticConcentration*Pyruvate_CoA_LiverK*CountLiver","(AcetylCoA_Liver*OAA_Liver)/V_hep*TCA_startK*CountLiver","Citrate_HepaticConcentration*Citrate_TCA_LiverK*CountLiver","TCA_HepaticConcentration*TCA_rotationK*CountLiver","OAA_HepaticConcentration*OAA_PEP_LiverK*CountLiver","Pyruvate_HepaticConcentration*Pyruvate_OAA_LiverK*CountLiver","Serine_HepaticConcentration*Serine_Pyruvate_LiverK*CountLiver","Serine_HepaticConcentration*Serine_Glycin_LiverK*CountLiver",
	"Glycin_HepaticConcentration*Serine_Glycin_LiverK*CountLiver","Glycin_HepaticConcentration*Glycin_Albumin_LiverK*CountLiver","Albumin_HepaticConcentration*Glycin_Albumin_LiverK*CountLiver","Pyruvate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver","Lactate_HepaticConcentration*Pyruvate_Lactate_LiverK*CountLiver","AcetylCoA_HepaticConcentration*CoA_Ketones_LiverK*CountLiver","Ketones_HepaticConcentration*CoA_Ketones_LiverK*CountLiver","TCA_HepaticConcentration*TCA_Glutamin_LiverK*CountLiver","Glutamin_HepaticConcentration*TCA_Glutamin_LiverK*CountLiver","max(0.0,V_islets*F_islets*(InsulinProductionK*pow(Glucose_PancreasConcentration,2.0)))*CountPancrease"};
char *reactionNames[1];
char *eventNames[7] = {
	"MediumChange_GTT","MediumChange_1","MediumChange_2","MediumChange_3","MediumChange_4","MediumChange_5","MediumChange_6"};

void model(double time, double *stateVector, double *DDTvector, ParamData *paramdataPtr, int DOflag, double *variableVector, double *reactionVector, double *gout, int *eventVector);
void calc_ic_model(double *icVector, ParamData *paramdataPtr);

void CVODEmex25(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]);
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    CVODEmex25(nlhs, plhs, nrhs, prhs);
}
