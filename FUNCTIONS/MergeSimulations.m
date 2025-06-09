function [Sim12] = MergeSimulations(Sim1,Sim2,pNames)

% Could be used to merge simulations. 
% However, if you want to merge many
% simulations together i've found it quicker to not do it in steps, but merge all
% simulations at the same time.

Sim12.time           = [Sim1.time(1:end-1),             Sim2.time];
Sim12.statevalues    = [Sim1.statevalues(1:end-1,:);    Sim2.statevalues];
Sim12.variablevalues = [Sim1.variablevalues(1:end-1,:); Sim2.variablevalues];
Sim12.reactionvalues = [Sim1.reactionvalues(1:end-1,:); Sim2.reactionvalues];
Sim12.states         = [Sim1.states];
Sim12.variables      = [Sim1.variables];
Sim12.reactions      = [Sim1.reactions];
Sim12.pNames         = [pNames];
end

