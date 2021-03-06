function [yfinal] = SincFilterNonUniform(xs,t,y)
%     Realize a Sinc filter for an uniform axis
%     
%     input:
%         xs: final x-axis
%         t: previous x-axis
%         y: signal to interpolate
%         
% 	output: 
%         yfinal: sinc filtered signal

    % Create a non uniform phase
	K = 1;
    phi_timepoints = (0:(length(t)-1))*(pi/K);
    % Interpolate our phase
    phi_base = interp1(t, phi_timepoints, xs, 'linear');
    yfinal = zeros(size(xs));

    % Filtering the signal
    for n = 1:length(y)
	    %dt = t(n);
        
        % Decrease by pi for a 0 phase at point n
	    phi = phi_base - phi_timepoints(n);
	    sinc = sin(phi)./phi;
	    sinc(phi == 0) = 1;
		yfinal = yfinal + y(n)*sinc/K;
	    %yfinal(~isnan(sinc)) = yfinal(~isnan(sinc)) + y(n)*sinc(~isnan(sinc));
    end       

end


