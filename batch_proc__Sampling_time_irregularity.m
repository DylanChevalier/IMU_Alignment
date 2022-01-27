
close all; clear all; clc;
addpath('./Functions');
addpath('./Functions/Interpolation');
addpath('./Functions/Alignment');

EXP_ROOT = 'D:/EXP'
mkdir(EXP_ROOT);

EXP_NAME = 'Sampling_time_irregularity'
SWEEP_VALUES = [0 0.1 0.25 0.5 1 2 5 10]

EXP_NAME_PRINTABLE = strrep(EXP_NAME, '_', '\_');

SIGNAL_PARAMETERS = struct( ...
	'main_pulse_width', 1000, ...
...	% ------------- side pulse, before the main pulse -------------
	'add_side_pulse', true, ...
	'side_pulse_shift_interval', [0.25, 0.75], ...
    'cos_ratio_amplitude_interval', [0.25, 0.5], ...
    'cos_ratio_width_interval', [0.25, 1.5], ...
	'side_pulse_roundness_interval', [0.2, 0.4], ...
...	% ------------- oscillations -------------
	'add_left_oscillations', true, ...
	'left_oscillations_ratio_amplitude_interval', [0.01, 0.1], ...
    'left_oscillations_ratio_width_interval', [0.25, 1], ...
	'left_oscillations_env_roundness_interval', [1, 1], ...
	'left_oscillations_freq_ratio_interval', [5, 10], ...
...	% ------------- oscillations -------------
	'add_right_oscillations', true, ...
	'right_oscillations_ratio_amplitude_interval', [0.01, 0.1], ...
    'right_oscillations_ratio_width_interval', [0.25, 1], ...
	'right_oscillations_env_roundness_interval', [1, 1], ...
	'right_oscillations_freq_ratio_interval', [5, 10], ...
...	% ------------- interference (common for all sensors) -------------
    'NbInterference_interval', [0 0], ... %[20, 40], ...
	'interference_height_interval', [0.01, 0.2], ...
    'interference_width_interval', [50, 500], ...
... % ------------- sensor-specific parameters -------------
	'dvs', struct( ...
		'sensor_name', 'dvs', ...
		'ts', 1, ...					% in ms
		'time_drift', 0, ...				% specify 0 for no time drift
		'd', 0, ...								% Axis time error pourcentage (%)
		'NbInterference_interval', [0, 0], ... %[20, 40], ...
		'interference_height_interval', [0.01, 0.05], ...
		'interference_width_interval', [10, 500], ...
		'noise_sigma', 0 ...					% specify 0 for no noise
	), ...
	'rs', struct( ...
		'sensor_name', 'rs', ...
		'ts', 10, ...					% in ms
		'time_drift', 0, ...				% specify 0 for no time drift
		'd', 0, ...								% Axis time error pourcentage (%)
		'NbInterference_interval', [0, 0], ... %[20, 40], ...
		'interference_height_interval', [0.01, 0.05], ...
		'interference_width_interval', [10, 500], ...
		'noise_sigma', 0 ...					% specify 0 for no noise
	), ...
	'lidar', struct( ...
		'sensor_name', 'dvs', ...
		'ts', 100, ...					% in ms
		'time_drift', 0, ...				% specify 0 for no time drift
		'd', 0, ...								% Axis time error pourcentage (%)
		'NbInterference_interval', [0, 0], ... %[20, 40], ...
		'interference_height_interval', [0.01, 0.05], ...
		'interference_width_interval', [10, 500], ...
		'noise_sigma', 0 ...					% specify 0 for no noise
	) ...
);


for exp_n = 1:100
	% parameters change
	
	for k = 1:length(SWEEP_VALUES)
		clearvars -except EXP_ROOT EXP_NAME EXP_NAME_PRINTABLE SWEEP_VALUES SIGNAL_PARAMETERS exp_n k

		sweep_value = SWEEP_VALUES(k);
        SIGNAL_PARAMETERS.rs.d = sweep_value;
        SIGNAL_PARAMETERS.lidar.d = sweep_value;
		EXP_SWEEP_NAME = sprintf('dts=%1.3f', sweep_value);
		EXP_PATH = sprintf('%s/%s/%s/%06d', EXP_ROOT, EXP_NAME, EXP_SWEEP_NAME, exp_n);
		mkdir(EXP_PATH);

		% Performing the job:
		main
		drawnow;

		% There should be a figure, which we save!
		hfig = figure(1);
		% Maximize this figure:
		frame_h = get(handle(hfig), 'JavaFrame'); set(frame_h,'Maximized',1);
		saveas(hfig, sprintf('%s/interpolation.fig', EXP_PATH));
		print(sprintf('%s/interpolation.pdf', EXP_PATH), '-dpdf', '-fillpage');
		close(hfig);

		% Plotting another axis with original and aligned signals:
		hfig = figure;
		subplot(2,1,1);
		plot(twanted, s_wanted, 'k-');
		hold on;
		plot(tdvs, s_dvs, 'r-');
		plot(trs, s_rs, 'g-');
		plot(tlidar, s_lidar, 'b-');
		title(sprintf('original signals: %s/%s/%06d', EXP_NAME_PRINTABLE, EXP_SWEEP_NAME, exp_n));
		legend('ideal (no delay)', 'dvs (with random delay)', 'rs (with random delay)', 'lidar (with random delay)');
		xlabel('time, ms');
		ylabel('simulated IMU signal');

% 		subplot(1,3,2);
% 		plot(twanted, s_wanted, 'k-');
% 		hold on;
% 		plot(tdvs - delayDVS, s_dvs, 'r-');
% 		plot(trs - delayRS, s_rs, 'g-');
% 		plot(tlidar - delayLIDAR, s_lidar, 'b-');
% 		title(sprintf('ideally aligned signals: %s/%s/%06d', EXP_NAME, EXP_SWEEP_NAME, exp_n));
% 		legend('ideal (no delay)', 'dvs (no delay)', 'rs (no delay)', 'lidar (no delay)');
% 		xlabel('time, ms');

		subplot(2,1,2);
		plot(twanted, s_wanted, 'k-');
		hold on;
		plot(tdvs - delayDVS, s_dvs, 'r-');
		dvs2rs_avg = mean([offset_dvs2rs_linear_corr, offset_dvs2rs_linear_minz, offset_dvs2rs_cubic_corr, offset_dvs2rs_cubic_minz, offset_dvs2rs_sinc_corr, offset_dvs2rs_sinc_minz]);
		plot(trs - delayRS - dvs2rs_avg, s_rs, 'g-');
		dvs2lidar = mean([offset_dvs2lidar_linear_corr, offset_dvs2lidar_linear_minz, offset_dvs2lidar_cubic_corr, offset_dvs2lidar_cubic_minz, offset_dvs2lidar_sinc_corr, offset_dvs2lidar_sinc_minz]);
		plot(tlidar - delayLIDAR, s_lidar, 'b-');
		title(sprintf('aligned signals: %s/%s/%06d', EXP_NAME_PRINTABLE, EXP_SWEEP_NAME, exp_n));
		legend('ideal (no delay)', 'dvs (no delay)', 'rs (aligned)', 'lidar (aligned)');
		xlabel('time, ms');

		% Maximize this figure:
		frame_h = get(handle(hfig), 'JavaFrame'); set(frame_h,'Maximized',1);
		saveas(hfig, sprintf('%s/alignment.fig', EXP_PATH));
		print(sprintf('%s/alignment.pdf', EXP_PATH), '-dpdf', '-fillpage');
		close(hfig);

		% save results (workspace)
		save(sprintf('%s/variables.mat', EXP_PATH));

	end
end



