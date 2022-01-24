%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   IMU-Alignment - Signal Processing Systems
%   Author: Dylan Chevalier
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%close all; clear all; clc;
%addpath('./Functions');
%addpath('./Functions/Interpolation');
%addpath('./Functions/Alignment');

%% Parameters

% all time values are in ms !!!
start = -2000;        % Starting point of our simulation (ms)
stop = 2000;          % Ending point of our simulation (ms)

hmin = 0.5;         % Minimum amplitude
hmax = 2;           % Maximim amplitude
wmin = 5;           % Minimum width
wmax = 10;          % Maximum width
ts = 1e-3;          % Timestamp desired in ms (high-frequency interpolated)
ts_dvs = 1;         % DVS' time sampling in ms
ts_rs = 10;%4;          % RS' time sampling in ms
ts_lidar = 100;%10;      % LIDAR's time sampling in ms

delayRS = -5.2;     % Delay RS in ms
delayLIDAR = -6.3;    % Delay LIDAR in ms

twanted = linspace(start,stop,floor((stop-start)/ts)+1);
tdvs = linspace(start,stop,floor((stop-start)/ts_dvs)+1);
trs = linspace(start,stop,floor((stop-start)/ts_rs)+1);
tlidar = linspace(start,stop,floor((stop-start)/ts_lidar)+1);

%% Permissions

Permissions

%% Create DVS, RS and LIDAR signals

CreateSignals

return

%% Interpolations

UpSampling

%% Alignment 

if Alignment && Correlation
    disp('Cross Correlation ...');
    [deltaLinearCorrRS,s_rs_Linear_correlation] = correlation(s_dvs_Linear_interpolated,s_rs_Linear_interpolated);
    [deltaCubicCorrRS,s_rs_Cubic_correlation] = correlation(s_dvs_Cubic_interpolated,s_rs_Cubic_interpolated);
    [deltaSincCorrRS,s_rs_Sinc_correlation] = correlation(s_dvs_SincFiltering,s_rs_SincFiltering);
    
    [deltaLinearCorrLIDAR,s_lidar_Linear_correlation] = correlation(s_dvs_Linear_interpolated,s_lidar_Linear_interpolated);
    [deltaCubicCorrLIDAR,s_lidar_Cubic_correlation] = correlation(s_dvs_Cubic_interpolated,s_lidar_Cubic_interpolated);
    [deltaSincCorrLIDAR,s_lidar_Sinc_correlation] = correlation(s_dvs_SincFiltering,s_lidar_SincFiltering);
    
    s_rs_Linear_interpolated_AlignCorr = AlignmentSignal(s_rs_Linear_interpolated,deltaLinearCorrRS);
    s_rs_Cubic_interpolated_AlignCorr = AlignmentSignal(s_rs_Cubic_interpolated,deltaCubicCorrRS);
    s_rs_SincFiltering_AlignCorr = AlignmentSignal(s_rs_SincFiltering,deltaSincCorrRS);
    
    s_lidar_Linear_interpolated_AlignCorr = AlignmentSignal(s_lidar_Linear_interpolated,deltaLinearCorrLIDAR);
    s_lidar_Cubic_interpolated_AlignCorr = AlignmentSignal(s_lidar_Cubic_interpolated,deltaCubicCorrLIDAR);
    s_lidar_SincFiltering_AlignCorr = AlignmentSignal(s_lidar_SincFiltering,deltaSincCorrLIDAR); 
end

if Alignment && ErrorNormMinimization
    disp('Error Norm Minimization ...');
    [deltaLinearMinRS,s_rs_Linear_errornorm] = ErrorNormMin(s_dvs_Linear_interpolated,s_rs_Linear_interpolated);
    [deltaCubicMinRS,s_rs_Cubic_errornorm] = ErrorNormMin(s_dvs_Cubic_interpolated,s_rs_Cubic_interpolated);
    [deltaSincMinRS,s_rs_Sinc_errornorm] = ErrorNormMin(s_dvs_SincFiltering,s_rs_SincFiltering);
    
    [deltaLinearMinLIDAR,s_lidar_Linear_errornorm] = ErrorNormMin(s_dvs_Linear_interpolated,s_lidar_Linear_interpolated);
    [deltaCubicMinLIDAR,s_lidar_Cubic_errornorm] = ErrorNormMin(s_dvs_Cubic_interpolated,s_lidar_Cubic_interpolated);
    [deltaSincMinLIDAR,s_lidar_Sinc_errornorm] = ErrorNormMin(s_dvs_SincFiltering,s_lidar_SincFiltering);
    
    s_rs_Linear_interpolated_AlignMin = AlignmentSignal(s_rs_Linear_interpolated,deltaLinearMinRS);
    s_rs_Cubic_interpolated_AlignMin = AlignmentSignal(s_rs_Cubic_interpolated,deltaCubicMinRS);
    s_rs_SincFiltering_AlignMin = AlignmentSignal(s_rs_SincFiltering,deltaSincMinRS);
    
    s_lidar_Linear_interpolated_AlignMin = AlignmentSignal(s_lidar_Linear_interpolated,deltaLinearMinLIDAR);
    s_lidar_Cubic_interpolated_AlignMin = AlignmentSignal(s_lidar_Cubic_interpolated,deltaCubicMinLIDAR);
    s_lidar_SincFiltering_AlignMin = AlignmentSignal(s_lidar_SincFiltering,deltaSincMinLIDAR); 
    
end

%% Error Calculation

Errors

%% Save in CSV

SaveCSV

%% Display

Plotting








