
EXP_ROOT = 'D:/EXP'

error_tol_ms = 3500;

% Change this if you want additionally preprocess the errors:
%CORRECT = @(x) abs(x);			% analyze absolute values of an error
CORRECT = @(x) x;				% analyze the error itself


EXPERIMENTS = { ...
	struct( ...
		'name', 'Pulse_width_test', ...
		'name_override', 'Effect of cosine pulse width', ...
		'parameter_pattern', 'W=%f', ...
		'parameter_name_override', 'W', ...
		'parameter_scale', 1, ...
		'parameter_units', 'ms' ...
	), ...
	struct( ...
		'name', 'Noise', ...
		'name_override', 'Effect of noise', ...
		'parameter_pattern', 'N=%f', ...
		'parameter_name_override', '\sigma', ...
		'parameter_scale', 1, ...
		'parameter_units', '' ...
	), ...
	struct( ...
		'name', 'Sampling_rate_test', ...
		'name_override', 'Effect sampling step (frequency)', ...
		'parameter_pattern', 'ts=%f', ...
		'parameter_name_override', '\Delta t_s', ...
		'parameter_scale', 1, ...
		'parameter_units', 'ms' ...
	), ...
	struct( ...
		'name', 'Sampling_time_irregularity', ...
		'name_override', 'Effect of sampling step irregularity', ...
		'parameter_pattern', 'dts=%f', ...
		'parameter_name_override', '\Delta\Delta t_s / \Delta t_s', ...
		'parameter_scale', 1, ...
		'parameter_units', '%' ...
	), ...
	struct( ...
		'name', 'Time_drift', ...
		'name_override', 'Effect of time drift', ...
		'parameter_pattern', 'td=%f', ...
		'parameter_name_override', '\Delta t_d / \Delta t', ...
		'parameter_scale', 60*60, ...
		'parameter_units', 's/h' ...
	) ...
};



for n = 1:length(EXPERIMENTS)
	values = {};
	plots = {};
	categories = {};

	experiment_name = EXPERIMENTS{n}.name;
	sweeps = dir(sprintf('%s/%s/*', EXP_ROOT, experiment_name));
	
	first_sweep = true;
	
	% sorting according to the parameter
	sweeps_names = {sweeps.name};
	parameter_values = zeros(1, length(sweeps));
	for k = 1:length(sweeps)
		parameter_value = sscanf(sweeps_names{k}, EXPERIMENTS{n}.parameter_pattern);
		if isempty(parameter_value)
			parameter_value = -100000000;
		end
		parameter_values(k) = parameter_value;
	end
	[~, idx] = sort(parameter_values);
	sweeps = sweeps(idx);

	
	for k = 1:length(sweeps)
		if ~sweeps(k).isdir || (sweeps(k).name(1) == '.')
			continue;
		end
		
		sweep_folder_name = sweeps(k).name;

		try
			t_data = csvread(sprintf('%s/%s/%s/results.csv', EXP_ROOT, experiment_name, sweep_folder_name), 1, 2);
		catch
			continue
		end

		offset_dvs2rs_ideal = t_data(2, :);
		offset_dvs2rs_linear_corr = t_data(3, :);
		offset_dvs2rs_linear_minz = t_data(4, :);
		offset_dvs2rs_cubic_corr = t_data(5, :);
		offset_dvs2rs_cubic_minz = t_data(6, :);
		offset_dvs2rs_sinc_corr = t_data(7, :);
		offset_dvs2rs_sinc_minz = t_data(8, :);

		offset_dvs2lidar_ideal = t_data(9, :);
		offset_dvs2lidar_linear_corr = t_data(10, :);
		offset_dvs2lidar_linear_minz = t_data(11, :);
		offset_dvs2lidar_cubic_corr = t_data(12, :);
		offset_dvs2lidar_cubic_minz = t_data(13, :);
		offset_dvs2lidar_sinc_corr = t_data(14, :);
		offset_dvs2lidar_sinc_minz = t_data(15, :);

		swept_parameter = sscanf(sweep_folder_name, EXPERIMENTS{n}.parameter_pattern);
	
		% not distinguishing between 
		error_dvs2rs_linear = CORRECT(offset_dvs2rs_linear_corr - offset_dvs2rs_ideal);
		error_dvs2rs_cubic = CORRECT(offset_dvs2rs_cubic_corr - offset_dvs2rs_ideal);
		error_dvs2rs_sinc = CORRECT(offset_dvs2rs_cubic_corr - offset_dvs2rs_ideal);
		error_dvs2lidar_linear = CORRECT(offset_dvs2lidar_linear_corr - offset_dvs2lidar_ideal);
		error_dvs2lidar_cubic = CORRECT(offset_dvs2lidar_cubic_corr - offset_dvs2lidar_ideal);
		error_dvs2lidar_sinc = CORRECT(offset_dvs2lidar_sinc_corr - offset_dvs2lidar_ideal);
		
		fprintf('Experiment %s/%s/%s\n', EXP_ROOT, experiment_name, sweep_folder_name)
		
		ti = abs(error_dvs2rs_linear) > error_tol_ms;
		fprintf('error_dvs2rs_linear failed to align in %1.3f %% of cases\n', sum(ti)/length(ti)*100);
		error_dvs2rs_linear = error_dvs2rs_linear(~ti);

		ti = abs(error_dvs2rs_cubic) > error_tol_ms;
		fprintf('error_dvs2rs_cubic failed to align in %1.3f %% of cases\n', sum(ti)/length(ti)*100);
		error_dvs2rs_cubic = error_dvs2rs_cubic(~ti);

		ti = abs(error_dvs2rs_sinc) > error_tol_ms;
		fprintf('error_dvs2rs_sinc failed to align in %1.3f %% of cases\n', sum(ti)/length(ti)*100);
		error_dvs2rs_sinc = error_dvs2rs_sinc(~ti);
		
		ti = abs(error_dvs2lidar_linear) > error_tol_ms;
		fprintf('error_dvs2lidar_linear failed to align in %1.3f %% of cases\n', sum(ti)/length(ti)*100);
		error_dvs2lidar_linear = error_dvs2lidar_linear(~ti);
		
		ti = abs(error_dvs2lidar_cubic) > error_tol_ms;
		fprintf('error_dvs2lidar_cubic failed to align in %1.3f %% of cases\n', sum(ti)/length(ti)*100);
		error_dvs2lidar_cubic = error_dvs2lidar_cubic(~ti);
		
		ti = abs(error_dvs2lidar_sinc) > error_tol_ms;
		fprintf('error_dvs2lidar_sinc failed to align in %1.3f %% of cases\n', sum(ti)/length(ti)*100);
		error_dvs2lidar_sinc = error_dvs2lidar_sinc(~ti);
		
		
		v = {error_dvs2rs_linear, error_dvs2rs_cubic, error_dvs2rs_sinc, error_dvs2lidar_linear, error_dvs2lidar_cubic, error_dvs2lidar_sinc};
		if isempty(plots)
			plots = {'error\_dvs2rs\_linear', ...
				'error\_dvs2rs\_cubic', ...
				'error\_dvs2rs\_sinc', ...
				'error\_dvs2lidar\_linear', ...
				'error\_dvs2lidar\_cubic', ...
				'error\_dvs2lidar\_sinc' ...
			};
		end
		c = sprintf('%s = %1.3f %s', EXPERIMENTS{n}.parameter_name_override, swept_parameter*EXPERIMENTS{n}.parameter_scale, EXPERIMENTS{n}.parameter_units);

		values{end+1} = v;
		categories{end+1} = c;
	end
	
	draw_errorbars_by_category_side_by_side(values, plots, categories);
	ylabel('error, ms');
	title(EXPERIMENTS{n}.name_override);

end


