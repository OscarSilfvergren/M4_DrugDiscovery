function [params] = MediaConditionScaling(params,pNames,PersonSpecificParameters,Index)
% Where index 1=HC, 2=NC , 3=FCS , 4=B27 , 5=BSA , 6=SM, ULT=7

params(ismember(pNames,"InsulinResistanceTimeDependency"))    = params(ismember(pNames,"InsulinResistanceTimeDependency"))* PersonSpecificParameters.InsulinResistanceTimeDependency(Index);
params(ismember(pNames,"IS0"))                                = params(ismember(pNames,"IS0"))                            * PersonSpecificParameters.IS0(Index);
params(ismember(pNames,"Fspheroids0"))                        = params(ismember(pNames,"Fspheroids0"))                    * PersonSpecificParameters.Fspheroids0(Index);
params(ismember(pNames,"Fspheroids50"))                       = params(ismember(pNames,"Fspheroids50"))                   * PersonSpecificParameters.Fspheroids50(Index);
params(ismember(pNames,"Fspheroids_hill"))                    = params(ismember(pNames,"Fspheroids_hill"))                * PersonSpecificParameters.Fspheroids_hill(Index);
params(ismember(pNames,"kv"))                                 = params(ismember(pNames,"kv"))                             * PersonSpecificParameters.kv(Index);
params(ismember(pNames,"ExenatideInsulinMax"))                = params(ismember(pNames,"ExenatideInsulinMax"))            * PersonSpecificParameters.ExenatideResponse(Index);
params(ismember(pNames,"ExenatideInsulinDecayMax"))           = params(ismember(pNames,"ExenatideInsulinDecayMax"))       * PersonSpecificParameters.ExenatideResponse(Index);
params(ismember(pNames,"ExenatideInsulin50"))                 = params(ismember(pNames,"ExenatideInsulin50"))             * PersonSpecificParameters.ExenatideResponse50(Index);
params(ismember(pNames,"ExenatideInsulinDecay50"))            = params(ismember(pNames,"ExenatideInsulinDecay50"))        * PersonSpecificParameters.ExenatideResponse50(Index);
params(ismember(pNames,"Filets0"))                            = params(ismember(pNames,"Filets0"))                        * PersonSpecificParameters.Filets0(Index);
params(ismember(pNames,"Fislets50"))                          = params(ismember(pNames,"Fislets50"))                      * PersonSpecificParameters.Fislets50(Index);
params(ismember(pNames,"Filets_hill"))                        = params(ismember(pNames,"Filets_hill"))                    * PersonSpecificParameters.Filets_hill(Index);

end

