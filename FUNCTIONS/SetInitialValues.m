function [Lastsimulationend] = SetInitialValues(Glucose, Insulin, Exanitide,Lactate,params,pNames,sNames,Lastsimulationend)

% Function sets state initial values where declaration in mM is converted into amount of substance
Lastsimulationend(ismember(sNames,"Glucose_Medium"))   = Glucose;
Lastsimulationend(ismember(sNames,"Insulin_Medium"))   = Insulin;
Lastsimulationend(ismember(sNames,"Exenatide_Medium")) = Exanitide;
Lastsimulationend(ismember(sNames,"Lactate_Medium"))   = Lactate;

end
