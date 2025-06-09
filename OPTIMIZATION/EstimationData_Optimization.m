function [Cost_model] = EstimationData_Optimization(seed,Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,modelName, model,ParametersInformation, AmountParameterOpti,LiverSpecificParameters,fid,options2)

rng('shuffle') % set the stochastic seed
s=rng;
rng(s.Seed+seed);

OptimisePS   = 1;
OptimiseMCMC = 0;
%% Create bounds and declare objective function (cost)

[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, UnoptimisedParameters] = IQMparameters(model);
[PersonSpecificParameters] = AssignInitialUniqueParameters();

load('ModelUncertainty_params')

factor = 1.2; % Liver
lb = log(ModelUncertainty_params(1:17)*(1/factor));
ub = log(ModelUncertainty_params(1:17)*(factor));
if lb(2) < log(1/1.2)
    lb(2) = log(1/1.2); % IS0
end
if ub(2) > log(1.2)
    ub(2) = log(1.2);
end
if lb(5) < log(180)
    lb(5) = log(180); % Fspheroids50
end
if ub(5) > log(280)
    ub(5) = log(280);
end
if lb(6) < log(1/1.2)
    lb(6) = log(1/1.2); % Fspheroids0
end
if ub(6) > log(1.2)
    ub(6) = log(1.2);
end
if lb(7) < log(2)
    lb(7) = log(2); % Fspheroids_hill
end
if ub(7) > log(5)
    ub(7) = log(5);
end
if lb(8) < log(5)
    lb(8) = log(5); % InsulinResponseMax
end
if ub(8) > log(18)
    ub(8) = log(18);
end
if lb(9) < log(0.3)
    lb(9) = log(0.3); % InsulinResponseLactateK
end
if ub(9) > log(0.85)
    ub(9) = log(0.85);
end
if lb(11) < log(2)
    lb(11) = log(2); % InsulinResponse_hill
end
if ub(11) > log(4.5)
    ub(11) = log(4.5);
end
if lb(17) < log(0.3)
    lb(17) = log(0.3); % AllometricLiverScalingK
end
if ub(17) > log(0.85)
    ub(17) = log(0.85);
end

factor = 1.2; % EndoC
lb(18:44) = log(ModelUncertainty_params(18:44)*(1/factor));
ub(18:44) = log(ModelUncertainty_params(18:44)*(factor));
if lb(18) < log(0.3)
    lb(18) = log(0.3); % AllometricScaling
end
if ub(18) > log(0.8)
    ub(18) = log(0.8);
end
if lb(19) < log(250)
    lb(19) = log(250); % Fislets50
end
if ub(19) > log(350)
    ub(19) = log(350);
end
if lb(20) < log(1/1.2)
    lb(20) = log(1/1.2); % Filets0
end
if ub(20) > log(1.2)
    ub(20) = log(1.2);
end
if lb(21) < log(2)
    lb(21) = log(2); % Filets_hill
end
if ub(21) > log(4)
    ub(21) = log(4);
end
% Proliferation
if lb(22) < log(0.001)
    lb(22) = log(0.001); % d0
end
if ub(22) > log(0.005)
    ub(22) = log(0.005);
end
if lb(23) < log(0.003)
    lb(23) = log(0.003); % r1
end
if ub(23) > log(0.004)
    ub(23) = log(0.004);
end
if lb(24) < log(0.014)
    lb(24) = log(0.014); % r2
end
if ub(24) > log(0.021)
    ub(24) = log(0.021);
end
if lb(28) < log(1.3)
    lb(28) = log(1.3); % ExenatideInsulinMax                               
end
if ub(28) > log(3.5)
    ub(28) = log(3.5);
end
if lb(29) < log(0.1)
    lb(29) = log(0.1); % Exanitide_IP
end
if ub(26) > log(0.9)
    ub(26) = log(0.9);
end
if lb(31) < log(1.2)
    lb(31) = log(1.2); % ExenatideInsulin_hill
end
if ub(31) > log(5)
    ub(31) = log(5);
end
if lb(40) < log(0.5)
    lb(40) = log(0.5); % IP_BaselineK
end
if ub(40) > log(2)
    ub(40) = log(2);
end
if lb(42) < log(1.1)
    lb(42) = log(1.1); % IP_gdBaselineHill
end
if ub(42) > log(3)
    ub(42) = log(3);
end

factor = 1.2; % MT islets
lb(45:65) = log(ModelUncertainty_params(45:65)*(1/factor));
ub(45:65) = log(ModelUncertainty_params(45:65)*(factor));
if lb(45) < log(0.3)
    lb(45) = log(0.3); % AllometricScaling
end
if ub(45) > log(0.8)
    ub(45) = log(0.8);
end
if lb(46) < log(300)
    lb(46) = log(300); % Fislets50
end
if ub(46) > log(400)
    ub(46) = log(400);
end
if lb(47) < log(1/1.2)
    lb(47) = log(1/1.2); % Filets0
end
if ub(47) > log(1.2)
    ub(47) = log(1.2);
end
if lb(48) < log(2)
    lb(48) = log(2); % Filets_hill
end
if ub(48) > log(6.5)
    ub(48) = log(6.5);
end
if lb(51) < log(1.1)
    lb(51) = log(1.1); % ExenatideInsulinMax                               
end
if ub(51) > log(3.5)
    ub(51) = log(3.5);
end
if lb(52) < log(0.35)
    lb(52) = log(0.35); % Exanitide_IP
end
if ub(52) > log(0.8)
    ub(52) = log(0.8);
end
if lb(54) < log(1.1)
    lb(54) = log(1.1); % ExenatideInsulin_hill
end
if ub(54) > log(5)
    ub(54) = log(5);
end
if lb(61) < log(0.1)
    lb(61) = log(0.1); % IP_BaselineK
end
if ub(61) > log(2.23)
    ub(61) = log(2.23);
end
if lb(63) < log(1.5)
    lb(63) = log(1.5); % IP_gdBaselineHill
end
if ub(63) > log(4.5)
    ub(63) = log(4.5);
end

% Liver
factor = 1.1; % Liver variability
lb(66:80) = log(ModelUncertainty_params(66:80)*(1/factor));
ub(66:80) = log(ModelUncertainty_params(66:80)*(factor));
factor = 1.1; % Liver media variability
lb(81:100) = log(ModelUncertainty_params(81:100)*(1/factor));
ub(81:100) = log(ModelUncertainty_params(81:100)*(factor));

% pancreatic media
factor = 1.1;
lb(101:126) = log(ModelUncertainty_params(101:126)*(1/factor));
ub(101:126) = log(ModelUncertainty_params(101:126)*(factor));
if lb(118) < log(1)
    lb(118) = log(1); % F0 HIMM
end
if ub(118) > log(3)
    ub(118) = log(3);
end

if lb(124) < log(1)
    lb(124) = log(1); % f0 ULT
end
if ub(124) > log(3)
    ub(124) = log(3);
end

% pancreatic conditions
% Exenatide response
factor = 1.1; % EndoC parameters
lb(127:138) = log(ModelUncertainty_params(127:138)*(1/factor));
ub(127:138) = log(ModelUncertainty_params(127:138)*(factor));
% Exenatide 50 response
factor = 1.1; % EndoC parameters
lb(139:150) = log(ModelUncertainty_params(139:150)*(1/factor));
ub(139:150) = log(ModelUncertainty_params(139:150)*(factor));
% functionality 0
factor = 1.1; % EndoC parameters
lb(151:165) = log(ModelUncertainty_params(151:165)*(1/factor));
ub(151:165) = log(ModelUncertainty_params(151:165)*(factor));
% Uncertainty
factor = 1.1; % Shared media
lb(166:172) = log(ModelUncertainty_params(166:172)*(1/factor));
ub(166:172) = log(ModelUncertainty_params(166:172)*(factor));
%  EndoCBasal_Uncertainty
if lb(166) < log(1)
    lb(166) = log(1);
end
if ub(166) > log(3)
    ub(166) = log(3);
end
% EndoCWashing
if lb(168) < log(0.93)
    lb(168) = log(0.93);
end
if ub(168) > log(0.999)
    ub(168) = log(0.999);
end
% InSpheroInsulinPhases_Uncertainty
if lb(171) < log(0.9)
    lb(171) = log(0.9);
end
if ub(171) > log(1.5)
    ub(171) = log(1.5);
end
% FlowGSISBasalS
if lb(172) < log(2)
    lb(172) = log(2);
end
if ub(172) > log(4.5)
    ub(172) = log(4.5);
end

% shared media
factor = 1.1;
lb(173:194) = log(ModelUncertainty_params(173:194)*(1/factor));
ub(173:194) = log(ModelUncertainty_params(173:194)*(factor));

params = 1:1:length(lb);
func   =@(params)EstimationData_ObjectFunction(Study1_data,BH5ref_data,Study3_data,Study4_data,Study5_data,Study6_data, Study7_data,Study8_data,Study9_data,Study10_data,Study11_data,Study12_data,InSpheroInsulinPhases_data,Study14_data,Study13_data,params,PersonSpecificParameters,modelName,sNames, pNames,initialvalues,AmountParameterOpti,1,fid);

%% Particle swarm

if OptimisePS 
[ModelUncertainty_params, Cost_model] = particleswarm(func, length(lb), lb, ub, options2);

ModelUncertainty_params = exp(ModelUncertainty_params);
ModelUncertainty_params(end+1) = Cost_model;

save(['ModelUncertainty_params' datestr(now, 'yymmdd-HHMMSS')],'ModelUncertainty_params');

end

%% MCMC

if OptimiseMCMC

theta = (ModelUncertainty_params(1:end-1))';
parameters.min =  exp(lb')    ;
parameters.max =  exp(ub')    ;
parameters.number = length(parameters.min);

optionsPesto = PestoOptions();
% Building a struct covering all sampling options:
optionsPesto.MCMC = PestoSamplingOptions();
optionsPesto.MCMC.nIterations = 1e4 ;%1e5 ;%2e4; %% This is the most important setting, covering how many iterations to be performed, here i think the minimum is 1e5 and above, especially now, as we only want the really good (i.e significant) parameter vectors
optionsPesto.MCMC.mode = 'text'; %optionsPesto.mode;
optionsPesto.mode ='text';

optionsPesto.MCMC.PT.nTemps         = 10;    % Initial number of temperatures
optionsPesto.MCMC.PT.exponentT      = 4;     % The initial temperatures are set by a power law to ^opt.exponentT.
optionsPesto.MCMC.PT.alpha          = 0.51;  % Parameter which controlls the adaption degeneration
optionsPesto.MCMC.PT.temperatureNu  = 1000;  % Parameter which controlls the adaption degeneration velocity of
optionsPesto.MCMC.PT.memoryLength   = 1;     % The higher the value the more it lowers the impact of early adaption steps.
optionsPesto.MCMC.PT.regFactor      = 1e-06; % Regularization factor for ill conditioned covariance matrices of
optionsPesto.MCMC.PT.swapsPerIter   = 1;     % The number of swaps between tempered chains per iterations.
optionsPesto.MCMC.PT.temperatureEta = 100;   % % 100 Scaling factor for temperature adaptation
optionsPesto.MCMC.PT.maxT           = 50000; % Maximum T

optionsPesto.MCMC.theta0 = (theta);
optionsPesto.MCMC.sigma0 = optionsPesto.MCMC.nIterations * eye(numel(theta));
MCMCresults = getParameterSamples(parameters, func, optionsPesto);

MCMCresults = [MCMCresults.S.par', MCMCresults.S.logPost ];
save(['MCMCresults' datestr(now, 'yymmdd-HHMMSS')],'MCMCresults');

Cost_model = '';
end

end


