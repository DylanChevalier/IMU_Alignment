function [y,t] = SignalWithArbitraryDelay(s_wanted,twanted,ts,ts_signal,delay)
%	Create a signal
%	Input: 
%         s_wanted: physical event
%         twanted: x-axis
%         delay: time to shift (ms)
%	Output:
%         y: signal wanted
    
    % Delay in term of points
    delayPoints = floor(abs(delay)/ts); 
    
    % Number of inter points
    NInterPoints = floor(ts_signal/ts);
    
    % Shift physical signal
    s_wanted_shifted = zeros(1,length(s_wanted));
    
    if(delay<0)
        s_wanted_shifted(delayPoints+1:end) = s_wanted(1:end-delayPoints);
    elseif(delay>0)
        s_wanted_shifted(1:end-delayPoints) = s_wanted(delayPoints+1:end);
    else 
        s_wanted_shifted = s_wanted;
    end
        
    % Sample the signal
    y = s_wanted(1:NInterPoints:end);
    t = twanted(1:NInterPoints:end)-delay;
       
end

