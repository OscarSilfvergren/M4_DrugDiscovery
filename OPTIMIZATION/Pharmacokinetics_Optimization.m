function [minCostPS] =Pharmacokinetics_Optimization(seed,MPSpk_data,GaoExenatideConcentrations_data,Sauter2020_data,GaoApe_data,modelName, model,fid,options2)

rng('shuffle') % set the stochastic seed
s=rng;
rng(s.Seed+seed);

%% Animal tested pharmacokinetics

[sNames, ODEs, initialvalues] = IQMstates(model);
[pNames, UnoptimisedParameters] = IQMparameters(model);

load('Pharmacokinetic_params')

factor = 1.5;
lb(1:7)       = log(Pharmacokinetic_params(1:7)*(1/factor));
ub(1:7)       = log(Pharmacokinetic_params(1:7)*(factor));
factor = 1.5;
lb(8:23)       = log(Pharmacokinetic_params(8:23)*(1/factor));
ub(8:23)       = log(Pharmacokinetic_params(8:23)*(factor));

factor = 1.5;
if lb(8) < log(0.75*1/factor)
   lb(8) = log(0.75*1/factor); % b_reaction
end
if ub(8) > log(0.75*factor)
    ub(8) = log(0.75*factor);
end
if lb(9) < log(1*1/factor)
    lb(9) = log(1*1/factor); % b_volume
end
if ub(9) > log(1*factor)
    ub(9) = log(1*factor);
end

lb(10) = log(0.00025); % Degrad - determined from human cell experiments
ub(10) = log(0.0006);

if lb(11) < log(0.4)
    lb(11) = log(0.4); % f_ape
end
if ub(11) > log(1)
    ub(11) = log(1);
end

if lb(12) < log(0.4)
    lb(12) = log(0.4); % f_rat
end
if ub(12) > log(1)
    ub(12) = log(1);
end

% Animal condition alterations
for i = 13:23
    if lb(i) < log(1/4)
    lb(i) = log(1/4);
end
if ub(i) > log(4)
    ub(i) = log(4);
end
end

OptimisedParams = 1:1:length(lb);
func =@(OptimisedParams)Pharmacokinetic_objectivefunction(MPSpk_data,GaoExenatideConcentrations_data,Sauter2020_data,GaoApe_data,OptimisedParams,UnoptimisedParameters,modelName,sNames, pNames,initialvalues,fid);
[Pharmacokinetic_params, minCostPS] = particleswarm(func, length(lb), lb, ub, options2);

Pharmacokinetic_params = exp(Pharmacokinetic_params);
Pharmacokinetic_params(end+1) = minCostPS;
save(['Pharmacokinetic_params' datestr(now, 'yymmdd-HHMMSS')],'Pharmacokinetic_params');


end