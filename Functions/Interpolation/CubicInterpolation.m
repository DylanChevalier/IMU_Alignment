function [yfinal] = CubicInterpolation(xs,t,y)
%     Realize a Cubic Interpolation
%     
%     input:
%         xs: final x-axis
%         t: previous x-axis
%         y: signal to interpolate
%         
% 	output: 
%         yfinal: cubic interpolated signal

    yfinal = interp1(t,y,xs,'cubic');
end

