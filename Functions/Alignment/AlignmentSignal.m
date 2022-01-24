function yfinal = AlignmentSignal(y,delta)
%     Shift a signal
%     
%     input:
%         y: signal
%         delta: shifting in number of points
%         
% 	output: 
%         yfinal: signal shifted
        
    yfinal = zeros(1,length(y));
    N = abs(delta);
    
    % Shift y
    if delta < 0
       yfinal(N+1:end) = y(1:end-N);
    elseif delta > 0
         yfinal(1:length(y)-N) = y(N+1:end);
    else 
        yfinal = y;
    end
    
end

