function [outputArg1,outputArg2] = draw_errorbars_by_category_side_by_side(values, plots, categories)
% Input:
%
%  values = {{vector1L, vector1R, ...}, {vector2L, vector2R, ...}, {vector3L, vector3R, ...}, ....}
%  plots = {name of errorbarL, name of errorbarR, ...}
%  categories = {name1, name2, name3, ...);
%

% parameters:
boxWidth = 1/10;
boxSeparator = 0.01;

figure;
hold on;

errorbars_colors = { ...
	[0, 0.5, 0], [0, 0.75, 0], [0, 1, 0], ...
	[0.5, 0.1, 0], [0.75, 0.1, 0], [1, 0.1, 0] ...
};

for n = 1:length(values)
	if ~isempty(values{n})
		N_plots = length(values{1});
		break;
	end
end

if rem(N_plots, 2) == 0
	% even
	boxShift = -(boxWidth+boxSeparator)/2;
else
	% odd
	boxShift = 0;
end
boxStart = boxShift - (boxWidth+boxSeparator) * floor((N_plots-1)/2);

xes = cell(1, N_plots);
averages = cell(1, N_plots);
medians = cell(1, N_plots);

for n = 1:N_plots
	averages{n} = [];
	medians{n} = [];
end


for n = 1:length(values)
	big_val = values{n};
	name = categories{n};
	
	if isempty(big_val) || isempty(name)
		% separators
		for k = 1:N_plots
			xes{k} = [xes{k}, n];
			averages{k} = [averages{k}, NaN];
			medians{k} = [medians{k}, NaN];
		end
		continue
	end


	for k = 1:N_plots
		val = big_val{k};
		val = val(:);
		val = val(~isnan(val));
		
		if isempty(val)
			% separator
			xes{k} = [xes{k}, n];
			averages{k} = [averages{k}, NaN];
			medians{k} = [medians{k}, NaN];
			continue;
		end
	
		tavg = mean(val);
		tmin = min(val);
		tmax = max(val);
		tqL = quantile(val, 3, 1);
		tQ1 = tqL(1);
		tmed = tqL(2);
		tQ3 = tqL(3);

		xes{k} = [xes{k}, n + boxStart + (boxWidth+boxSeparator)*(k-1)];
		averages{k} = [averages{k}, tavg];
		medians{k} = [medians{k}, tmed];

		% drawing:
		i = n + boxStart + (boxWidth+boxSeparator)*(k-1);
		errorbars_color = errorbars_colors{k};
		rectangle('Position', [i-boxWidth/2, tQ1, boxWidth, (tQ3-tQ1)], 'FaceColor', 0.75 + errorbars_color*0.25, 'EdgeColor', errorbars_color);
		line([i i],[tmin tQ1], 'color', errorbars_color)
		line([i i],[tQ3 tmax], 'color', errorbars_color)
		line([i-boxWidth/2 i+boxWidth/2],[tmax tmax],'color', errorbars_color, 'LineWidth', 2);
		line([i-boxWidth/2 i+boxWidth/2],[tmin tmin],'color', errorbars_color, 'LineWidth', 2);
		line([i-boxWidth/2 i+boxWidth/2],[tmed tmed],'color', errorbars_color, 'LineWidth', 3);
		
	end
end

handles = zeros(1, N_plots);
legend_names = {};

for k = 1:N_plots
	handles(k) = plot(nan, nan, '-', 'Color', errorbars_colors{k}, 'LineWidth', 4);
	legend_names{end+1} = plots{k};
end

for k = 1:N_plots
	x = xes{k};
	y = averages{k};
	hpavg = plot(x, y, '-', 'MarkerSize', 14, 'LineWidth', 1, 'Color', errorbars_colors{k});
% 	y = medians{k};
% 	hpmed = plot(x, y, 'b.-.', 'MarkerSize', 14, 'LineWidth', 2);
end

handles = [handles, hpavg];
legend_names{end+1} = 'average values';
% handles = [handles, hpmed];
% legend_names{end+1} = 'median values';
legend(handles, legend_names); %, 'Location', 'southwest');

% Polynomial fitting possibility:
% fit_x = linspace(min(x), max(x), 100);
% fit_y = polyval(polyfit(x, y, 2), fit_x);
% plot(fit_x, fit_y, 'k--');

set(gca, 'XTickMode', 'manual');
set(gca, 'TickLabelInterpreter', 'tex', 'XTickLabelRotation', 45);
xt = 1:length(values);
xl = categories;
set(gca, 'XTick', xt, 'XTickLabel', xl);

grid on;
hold off;

end

