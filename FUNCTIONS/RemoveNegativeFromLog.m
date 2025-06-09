function [max,min,time] = RemoveNegativeFromLog(max,min,time)
max(min<=0) = [];
time(min<=0)= [];
min(min<=0) = [];
end

