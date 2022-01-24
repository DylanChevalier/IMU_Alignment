function y = cos_pulse(t,t0,t1)
% 	Create a cosinus pulsation with a width of t1-t0
% 	Input:    
%         t: abcisse
%         t0: begining of the pulse (ms)
%         t1: end of the pulse (ms)
%  	Ouput:    
%         y: cosinus pulse
    
    y = heaviside(t-t0).*(1-heaviside(t-t1)).*(1-cos((2*pi)/(t1-t0)*(t-t0)))/2;
end

