function InterferenceVector = CreateInterference(NbInterference,maximum,ts,start,stop)
%	Create a signal
%	Input: 
%         NbInterference: time sampling in ms
%         maximum: final time sampling (ms)
%         ts: final time sampling
%         start: beginning of the simulation
%         stop: end of the simulation
%	Output:
%         InterferenceVector: interferences

    
    t = linspace(start,stop,(stop-start)/ts+1);
    InterferenceVector = zeros(1,length(t));
    
    % x NbInterference
    for i = 1:NbInterference
        h = unifrnd(0.1,maximum);       % Random amplitude
        delta = unifrnd(0.2,1.1);       % Random width
        u = randi([1 length(t)],1,1);   % Randomly on the t-axis
        t0 = t(u);                      
        t1 = t0 + delta;
        
        % Add the cosin pulse
        InterferenceVector = InterferenceVector + h*cos_pulse(t, t0, t1);
    end
    
end

