function [minCostPS] = Gao_Optimization(seed,Gao2011Rat_data,GaoExenatideConcentrations_data,modelName, model, AmountParameterOpti,fid,options2)

[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param] = IQMparameters(model);

rng('shuffle') % set the stochastic seed
s=rng;
rng(s.Seed+seed);

OptimisePS   = 1;
OptimiseMCMC = 0;

%% Pre-Optimization
load('Pharmacokinetic_params')
load('ModelUncertainty_Rat')

factor = 1.5;
lb(1:50)       = log(ModelUncertainty_Rat(1:50)*(1/factor)); %PD
ub(1:50)       = log(ModelUncertainty_Rat(1:50)*(factor));

factor = 1.5;
lb(23-12)       = log(ModelUncertainty_Rat(23-12)*(1/1));      % Exenatide EC50
ub(23-12)       = log(ModelUncertainty_Rat(23-12)*(factor));
lb(26-12)       = log(ModelUncertainty_Rat(26-12)*(1/factor)); % Exenatide IC50
ub(26-12)       = log(ModelUncertainty_Rat(26-12)*(factor));
factor = 1.5;
lb(38-12:39-12)       = log(ModelUncertainty_Rat(38-12:39-12)*(1/factor)); % ROCk och basal
ub(38-12:39-12)       = log(ModelUncertainty_Rat(38-12:39-12)*(factor));
factor = 1.5;
lb(60-12:61-12)       = log(ModelUncertainty_Rat(60-12:61-12)*(1/factor)); % basal och delay
ub(60-12:61-12)       = log(ModelUncertainty_Rat(60-12:61-12)*(factor));

if lb(21-12) < log(2)
    lb(21-12) = log(2); % {'ExenatideInsulinMax'}
end
if ub(21-12) > log(10)
    ub(21-12) = log(10);
end

if lb(22-12) < log(0.2)
    lb(22-12) = log(0.2); % {'Exanitide_IP'}
end
if ub(22-12) > log(0.8)
    ub(22-12) = log(0.8);
end

if lb(24-12) < log(1)
    lb(24-12) = log(1); % ExenatideInsulin_hill
end
if ub(24-12) > log(5)
    ub(24-12) = log(5);
end

if lb(25-12) < log(2)
    lb(25-12) = log(2); % ExenatideInsulinDecayMax
end
if ub(25-12) > log(7)
    ub(25-12) = log(7);
end

if lb(27-12) < log(5)
    lb(27-12) = log(5); % InsulinResponseMax
end
if ub(27-12) > log(20)
    ub(27-12) = log(20);
end

if lb(28-12) < log(500)
    lb(28-12) = log(500); % InsulinResponse50
end
if ub(28-12) > log(1500)
    ub(28-12) = log(1500);
end

if lb(29-12) < log(1)
    lb(29-12) = log(1); % InsulinResponse_hill
end
if ub(29-12) > log(3)
    ub(29-12) = log(3);
end

if lb(33-12) < log(0.7)
    lb(33-12) = log(0.7); % f
end
if ub(33-12) > log(0.99)
    ub(33-12) = log(0.99);
end

if lb(46-12) < log(100)
    lb(46-12) = log(100); % G_b
end
if ub(46-12) > log(350)
    ub(46-12) = log(350);
end

if lb(55-12) < log(0.1)
    lb(55-12) = log(0.1); % Aminoprofile_k
end
if ub(55-12) > log(0.9)
    ub(55-12) = log(0.9);
end

params = 1:1:length(lb);

func =@(params)Gao2011_costfunction(Gao2011Rat_data,GaoExenatideConcentrations_data,params,Pharmacokinetic_params,modelName,sNames, pNames,initialvalues,AmountParameterOpti,1,fid);

%% PS

if OptimisePS
    
    [ModelUncertainty_Rat, minCostPS] = particleswarm(func, length(lb), lb, ub, options2);
    ModelUncertainty_Rat = exp(ModelUncertainty_Rat);
    ModelUncertainty_Rat(end+1) = minCostPS;
    
    save(['ModelUncertainty_Rat' datestr(now, 'yymmdd-HHMMSS')],'ModelUncertainty_Rat');
    
end
%% MCMC

if OptimiseMCMC
    
    theta = (ModelUncertainty_Rat(1:end-1))';     % Startguess
    parameters.min =  exp(lb')    ;
    parameters.max =  exp(ub')    ;
    parameters.number = length(parameters.min);
    optionsPesto = PestoOptions();
    
    optionsPesto.MCMC = PestoSamplingOptions();
    optionsPesto.MCMC.nIterations = 1e5;
    optionsPesto.MCMC.mode = 'text'; %optionsPesto.mode;
    optionsPesto.mode ='text';
    
    optionsPesto.MCMC.PT.nTemps         = 10;    % Initial number of temperatures
    optionsPesto.MCMC.PT.exponentT      = 4;     % The initial temperatures are set by a power law to ^opt.exponentT.
    optionsPesto.MCMC.PT.alpha          = 0.6;  % Parameter which controlls the adaption degeneration
    optionsPesto.MCMC.PT.temperatureNu  = 1000;  % Parameter which controlls the adaption degeneration velocity of
    optionsPesto.MCMC.PT.memoryLength   = 1;     % The higher the value the more it lowers the impact of early adaption steps.
    optionsPesto.MCMC.PT.regFactor      = 1e-06; % Regularization factor for ill conditioned covariance matrices of
    optionsPesto.MCMC.PT.swapsPerIter   = 1;     % The number of swaps between tempered chains per iterations.
    optionsPesto.MCMC.PT.temperatureEta = 100;   % % 100 Scaling factor for temperature adaptation
    optionsPesto.MCMC.PT.maxT           = 50000; % Maximum T
    optionsPesto.MCMC.theta0 = (theta);
    optionsPesto.MCMC.sigma0 = optionsPesto.MCMC.nIterations * eye(numel(theta));
    
    MCMCoutput = getParameterSamples(parameters, func, optionsPesto);
    
    save(['MCMCoutput_GaoPD' datestr(now, 'yymmdd-HHMMSS')],'MCMCoutput');
    
    minCostPS = MCMCoutput.S.logPost(1);
end

end

