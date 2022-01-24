function [output_value] = uniform_random(range_interval, varargin)

if length(varargin) >= 1
	output_value = unifrnd(range_interval(1), range_interval(2), varargin{1});
else
	output_value = unifrnd(range_interval(1), range_interval(2));
end

end