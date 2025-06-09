function [minCostPS] = Gao_Optimization(seed,Gao2011Rat_data,GaoExenatideConcentrations_data,modelName, model,fid,options2)

[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, param] = IQMparameters(model);

rng('shuffle') % set the stochastic seed
s=rng;
rng(s.Seed+seed);


%% Pre-Optimization
load('Pharmacokinetic_params')
load('ModelUncertainty_Rat')
% ModelUncertainty_Rat = param(16:70);
% ModelUncertainty_Rat(51-15) = 120; %G_b
% 
% ModelUncertainty_Rat(28-15) = 2;  % ExenatideInsulinDecayMax
% ModelUncertainty_Rat(25-15) = 5;  % ExenatideInsulinMax
% ModelUncertainty_Rat(26-15) = 0.5; % Exenatide EC50
% ModelUncertainty_Rat(29-15) = 3;   % Exenatide EC50
% 
% ModelUncertainty_Rat(33-15) = 2; % InsulinResponse_hill

factor = 3;
lb(1:70-15)       = log(ModelUncertainty_Rat(1:70-15)*(1/factor)); %PD
ub(1:70-15)       = log(ModelUncertainty_Rat(1:70-15)*(factor));

factor = 5;
lb(17-15)       = log(ModelUncertainty_Rat(17-15)*(1/factor)); %U_id
ub(17-15)       = log(ModelUncertainty_Rat(17-15)*(factor));
lb(47-15)       = log(ModelUncertainty_Rat(47-15)*(1/factor)); %K
ub(47-15)       = log(ModelUncertainty_Rat(47-15)*(factor));
lb(48-15)       = log(ModelUncertainty_Rat(48-15)*(1/factor)); %S_b
ub(48-15)       = log(ModelUncertainty_Rat(48-15)*(factor));
lb(66-15)       = log(ModelUncertainty_Rat(66-15)*(1/factor)); %beta
ub(66-15)       = log(ModelUncertainty_Rat(66-15)*(factor));

factor = 1.01;
lb(34-15:42-15)       = log(param(34:42)*(1/factor)); %PD
ub(34-15:42-15)       = log(param(34:42)*(factor));

factor = 2;
lb(26-15)       = log(ModelUncertainty_Rat(26-15)*(1/factor)); % Exenatide EC50
ub(26-15)       = log(ModelUncertainty_Rat(26-15)*(factor));
lb(29-15)       = log(ModelUncertainty_Rat(29-15)*(1/factor)); % Exenatide IC50
ub(29-15)       = log(ModelUncertainty_Rat(29-15)*(factor));


if lb(19-15) < log(0.6)
    lb(19-15) = log(0.6); % {'{'U_ratio'}'}
end
if ub(19-15) > log(0.8)
    ub(19-15) = log(0.8);
end

if lb(25-15) < log(2)
    lb(25-15) = log(2); % {'ExenatideInsulinMax'}
end
if ub(25-15) > log(10)
    ub(25-15) = log(10);
end

if lb(26-15) < log(0.1)
    lb(26-15) = log(0.1); % {'EC50'}
end
if ub(26-15) > log(1)
    ub(26-15) = log(1);
end

if lb(27-15) < log(2)
    lb(27-15) = log(2); % ExenatideInsulin_hill
end
if ub(27-15) > log(6)
    ub(27-15) = log(6);
end

if lb(28-15) < log(2)
    lb(28-15) = log(2); % ExenatideInsulinDecayMax
end
if ub(28-15) > log(7)
    ub(28-15) = log(7);
end

if lb(29-15) < log(1)
    lb(29-15) = log(1); % {'IC50'}
end
if ub(29-15) > log(10)
    ub(29-15) = log(10);
end

if lb(30-15) < log(0.01)
    lb(30-15) = log(0.01); % {'Exanitide_IP'}
end
if ub(30-15) > log(0.8)
    ub(30-15) = log(0.8);
end

if lb(31-15) < log(5)
    lb(31-15) = log(5); % InsulinResponseMax
end
if ub(31-15) > log(20)
    ub(31-15) = log(20);
end
    

if lb(33-15) < log(2)
    lb(33-15) = log(2); % InsulinResponse_hill
end
if ub(33-15) > log(4)
    ub(33-15) = log(4);
end

if lb(42-15) < log(0.8)
    lb(42-15) = log(0.8); % f
end
if ub(42-15) > log(0.9)
    ub(42-15) = log(0.9);
end

if lb(51-15) < log(0.1)
    lb(51-15) = log(0.1); % G_b
end
if ub(51-15) > log(200)
    ub(51-15) = log(200);
end

if lb(60-15) < log(0.1)
    lb(60-15) = log(0.1); % Aminoprofile_k
end
if ub(60-15) > log(0.9)
    ub(60-15) = log(0.9);
end

params = 1:1:length(lb);

func =@(params)Gao2011_costfunction(Gao2011Rat_data,GaoExenatideConcentrations_data,params,Pharmacokinetic_params,modelName,sNames, pNames,initialvalues,1,fid);

%% PS

[ModelUncertainty_Rat, minCostPS] = particleswarm(func, length(lb), lb, ub, options2);
ModelUncertainty_Rat = exp(ModelUncertainty_Rat);
ModelUncertainty_Rat(end+1) = minCostPS;

save(['ModelUncertainty_Rat' datestr(now, 'yymmdd-HHMMSS')],'ModelUncertainty_Rat');


end

