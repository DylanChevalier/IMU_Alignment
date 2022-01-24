function [yfinal] = LinearInterpolation(xs,t,y)
%     Realize a Linear Interpolation
%     
%     input:
%         xs: final x-axis
%         t: previous x-axis
%         y: signal to interpolate
%         
% 	output: 
%         yfinal: linear interpolated signal

    yfinal = interp1(t,y,xs,'linear');
      

end

