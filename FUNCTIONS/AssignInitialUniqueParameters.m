function [PersonSpecificParameters] = AssignInitialUniqueParameters()

PersonSpecificParameters.InsulinResistanceTimeDependency(1:7) = 1;
PersonSpecificParameters.IS0(1:7)                             = 1;
PersonSpecificParameters.Fspheroids0(1:7)                     = 1;
PersonSpecificParameters.Fspheroids50(1:7)                    = 1;
PersonSpecificParameters.Fspheroids_hill(1:7)                 = 1;
PersonSpecificParameters.kv(1:7)                              = 1;
PersonSpecificParameters.Fislets50(1:7)                       = 1;
PersonSpecificParameters.Filets_hill(1:7)                     = 1;

PersonSpecificParameters.ExenatideResponse(1:19)               = 1;
PersonSpecificParameters.ExenatideResponse50(1:19)             = 1;
PersonSpecificParameters.Filets0(1:22)                         = 1;

PersonSpecificParameters.ExperimentalInducedStress(1:3)    = 1;
PersonSpecificParameters.EndoCBasal_Uncertainty            = 1; 
PersonSpecificParameters.EndoCStoredInsulin                = 1; 

PersonSpecificParameters.InSpheroInsulinPhases_Uncertainty  = 1; 
PersonSpecificParameters.FlowGSISBasalS                      = 1; 

PersonSpecificParameters.HepaRG_f50(1:5)   = 1;
PersonSpecificParameters.HepaRG_f0(1:5)    = 1;
PersonSpecificParameters.HepaRG_IS(1:5)    = 1;
PersonSpecificParameters.EndoCWashing_Uncertainty = 1;
end

