%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   IMU-Alignment - Signal Processing Systems
%   Author: Dylan Chevalier
%   
%   Calculate different errors
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% error = abs(true value - value obtained)/abs(true value)


%% Correlation Errors in percent

% %RS
% Error_delay_rs_linear_correlation = abs(delayRS-(-deltaLinearCorrRS*ts))/abs(delayRS)*100;
% Error_delay_rs_cubic_correlation = abs(delayRS-(-deltaCubicCorrRS*ts))/abs(delayRS)*100;
% Error_delay_rs_sinc_correlation = abs(delayRS-(-deltaSincCorrRS*ts))/abs(delayRS)*100;
% 
% %LIDAR
% Error_delay_lidar_linear_correlation = abs(delayLIDAR-(-deltaLinearCorrLIDAR*ts))/abs(delayLIDAR)*100;
% Error_delay_lidar_cubic_correlation = abs(delayLIDAR-(-deltaCubicCorrLIDAR*ts))/abs(delayLIDAR)*100;
% Error_delay_lidar_sinc_correlation = abs(delayLIDAR-(-deltaSincCorrLIDAR*ts))/abs(delayLIDAR)*100;
% 
% 
% %% Error Norm Minimization Errors in percent
% 
% % RS
% Error_delay_rs_linear_minimization = abs(delayRS-(-deltaLinearMinRS*ts))/abs(delayRS)*100;
% Error_delay_rs_cubic_minimization = abs(delayRS-(-deltaCubicMinRS*ts))/abs(delayRS)*100;
% Error_delay_rs_sinc_minimization = abs(delayRS-(-deltaSincMinRS*ts))/abs(delayRS)*100;
% 
% % LIDAR
% Error_delay_lidar_linear_minimization = abs(delayLIDAR-(-deltaLinearMinLIDAR*ts))/abs(delayLIDAR)*100;
% Error_delay_lidar_cubic_minimization = abs(delayLIDAR-(-deltaCubicMinLIDAR*ts))/abs(delayLIDAR)*100;
% Error_delay_lidar_sinc_minimization = abs(delayLIDAR-(-deltaSincMinLIDAR*ts))/abs(delayLIDAR)*100;


offset_dvs2rs_ideal = delayRS - delayDVS;
offset_dvs2rs_linear_corr = deltaLinearCorrRS * ts;
offset_dvs2rs_linear_minz = deltaLinearMinRS * ts;
offset_dvs2rs_cubic_corr = deltaCubicCorrRS * ts;
offset_dvs2rs_cubic_minz = deltaCubicMinRS * ts;
offset_dvs2rs_sinc_corr = deltaSincCorrRS * ts;
offset_dvs2rs_sinc_minz = deltaSincMinRS * ts;

offset_dvs2lidar_ideal = delayLIDAR - delayDVS;
offset_dvs2lidar_linear_corr = deltaLinearCorrLIDAR * ts;
offset_dvs2lidar_linear_minz = deltaLinearMinLIDAR * ts;
offset_dvs2lidar_cubic_corr = deltaCubicCorrLIDAR * ts;
offset_dvs2lidar_cubic_minz = deltaCubicMinLIDAR * ts;
offset_dvs2lidar_sinc_corr = deltaSincCorrLIDAR * ts;
offset_dvs2lidar_sinc_minz = deltaSincMinLIDAR * ts;

csv_filename = sprintf('%s/%s/%s/results.csv', EXP_ROOT, EXP_NAME, EXP_SWEEP_NAME);
if ~exist(csv_filename, 'file')
	fileID = fopen(csv_filename, 'w');
	fprintf(fileID, 'exp_n,    dvs2rs_ideal, dvs2rs_linear_corr, dvs2rs_linear_minz, dvs2rs_cubic_corr, dvs2rs_cubic_minz, dvs2rs_sinc_corr, dvs2rs_sinc_minz,    dvs2lidar_ideal, dvs2lidar_linear_corr, dvs2lidar_linear_minz, dvs2lidar_cubic_corr, dvs2lidar_cubic_minz, dvs2lidar_sinc_corr, dvs2lidar_sinc_minz\n');
else
	fileID = fopen(csv_filename, 'a+');
end

fprintf(fileID, '%06d,    %1.3f, %1.3f, %1.3f, %1.3f, %1.3f, %1.3f, %1.3f,    %1.3f, %1.3f, %1.3f, %1.3f, %1.3f, %1.3f, %1.3f\n', ...
	exp_n, ...
	offset_dvs2rs_ideal, offset_dvs2rs_linear_corr, offset_dvs2rs_linear_minz, offset_dvs2rs_cubic_corr, offset_dvs2rs_cubic_minz, offset_dvs2rs_sinc_corr, offset_dvs2rs_sinc_minz, ...
	offset_dvs2lidar_ideal, offset_dvs2lidar_linear_corr, offset_dvs2lidar_linear_minz, offset_dvs2lidar_cubic_corr, offset_dvs2lidar_cubic_minz, offset_dvs2lidar_sinc_corr, offset_dvs2lidar_sinc_minz ...
);


% exp_n
disp('----')
fprintf('dvs2rs ideal = %f\n', offset_dvs2rs_ideal);
fprintf('dvs2rs linear = %f, %f\n', offset_dvs2rs_linear_corr, offset_dvs2rs_linear_minz);
fprintf('dvs2rs cubic = %f, %f\n', offset_dvs2rs_cubic_corr, offset_dvs2rs_cubic_minz);
fprintf('dvs2rs sinc = %f, %f\n', offset_dvs2rs_sinc_corr, offset_dvs2rs_sinc_minz);
disp('----')
fprintf('dvs2lidar ideal = %f\n', offset_dvs2lidar_ideal);
fprintf('dvs2lidar linear = %f, %f\n', offset_dvs2lidar_linear_corr, offset_dvs2lidar_linear_minz);
fprintf('dvs2lidar cubic = %f, %f\n', offset_dvs2lidar_cubic_corr, offset_dvs2lidar_cubic_minz);
fprintf('dvs2lidar sinc = %f, %f\n', offset_dvs2lidar_sinc_corr, offset_dvs2lidar_sinc_minz);



%% Write errors in a file
% fileID = fopen('Errors Report.txt','w');
% 
% fprintf(fileID,"Delays set: \n \t RS: %1.3d ms & LIDAR: %1.3d ms\n \n",delayRS, delayLIDAR);
% 
% fprintf(fileID,"Correlations: \n");
% fprintf(fileID,"\t RS: \n");
% fprintf(fileID,"\t \t Linear (-%1.3d ms): %1.3d %c \n",deltaLinearCorrRS*ts,Error_delay_rs_linear_correlation,'%');
% fprintf(fileID,"\t \t Cubic (-%1.3d ms): %1.3d %c \n",deltaCubicCorrRS*ts,Error_delay_rs_cubic_correlation,'%');
% fprintf(fileID,"\t \t Sinc (-%1.3d ms): %1.3d %c \n \n",deltaSincCorrRS*ts,Error_delay_rs_sinc_correlation,'%');
% 
% fprintf(fileID,"\t LIDAR: \n");
% fprintf(fileID,"\t \t Linear (-%1.3d ms): %1.3d %c \n",deltaLinearCorrLIDAR*ts,Error_delay_lidar_linear_correlation,'%');
% fprintf(fileID,"\t \t Cubic (-%1.3d ms): %1.3d %c \n",deltaCubicCorrLIDAR*ts,Error_delay_lidar_cubic_correlation,'%');
% fprintf(fileID,"\t \t Sinc (-%1.3d ms): %1.3d %c \n \n",deltaSincCorrLIDAR*ts,Error_delay_lidar_sinc_correlation,'%');
% 
% fprintf(fileID,"Error Norm Minimization: \n");
% fprintf(fileID,"\t RS: \n");
% fprintf(fileID,"\t \t Linear (-%1.3d ms): %1.3d %c \n",deltaLinearMinRS*ts,Error_delay_rs_linear_minimization,'%');
% fprintf(fileID,"\t \t Cubic (-%1.3d ms): %1.3d %c \n",deltaCubicMinRS*ts,Error_delay_rs_cubic_minimization,'%');
% fprintf(fileID,"\t \t Sinc (-%1.3d ms): %1.3d %c \n \n",deltaSincMinRS*ts,Error_delay_rs_sinc_minimization,'%');
% 
% fprintf(fileID,"\t LIDAR: \n");
% fprintf(fileID,"\t \t Linear (-%1.3d ms): %1.3d %c \n",deltaLinearMinLIDAR*ts,Error_delay_lidar_linear_minimization,'%');
% fprintf(fileID,"\t \t Cubic (-%1.3d ms): %1.3d %c \n",deltaCubicMinLIDAR*ts,Error_delay_lidar_cubic_minimization,'%');
% fprintf(fileID,"\t \t Sinc (-%1.3d ms): %1.3d %c \n \n",deltaSincMinLIDAR*ts,Error_delay_lidar_sinc_minimization,'%');

fclose(fileID);









