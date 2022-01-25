function [s,t] = SignalWithArbitraryDelay(SIGNAL_PARAMETERS, parts, time_limits, ts, delay)

time_min = time_limits(1);
time_max = time_limits(2);

t_pos = 0:ts:time_max;
t_neg = (-ts):(-ts):time_min;

t = [fliplr(t_neg), t_pos];
t = t * (1+SIGNAL_PARAMETERS.time_drift) + uniform_random([-ts*SIGNAL_PARAMETERS.d/100, +ts*SIGNAL_PARAMETERS.d/100], size(t)); 

s = zeros(size(t));

for n = 1:length(parts)
	part = parts{n};
	if strcmp(part.item, 'raised_cos')
		s = s + part.parameters.h * (cos_pulse(t-delay, part.parameters.tcenter-part.parameters.w/2, part.parameters.tcenter+part.parameters.w/2) .^ (part.parameters.roundness));
	elseif strcmp(part.item, 'oscillations')
		s = s + part.parameters.env_h * (cos_pulse(t-delay, part.parameters.env_tcenter-part.parameters.env_w/2, part.parameters.env_tcenter+part.parameters.env_w/2) .^ (part.parameters.env_roundness)) .* sin(2*pi*part.parameters.freq_ratio/part.parameters.env_w * (t-delay-part.parameters.env_tcenter));
	end
end


% interferences specific to this sensor
for i = 1:round(uniform_random(SIGNAL_PARAMETERS.NbInterference_interval))
    h = uniform_random(SIGNAL_PARAMETERS.interference_height_interval);
    w = uniform_random(SIGNAL_PARAMETERS.interference_width_interval);       % Random width
    tcenter = uniform_random([time_min, time_max]);

	s = s + h * cos_pulse(t-delay, tcenter-w/2, tcenter+w/2);
end


s = s + randn(size(s)) * SIGNAL_PARAMETERS.noise_sigma;




end

