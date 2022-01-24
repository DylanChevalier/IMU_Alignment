%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   IMU-Alignment - Signal Processing Systems
%   Author: Dylan Chevalier
% 
%   Define permissions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Interpolations
Interpolation = true;           % Allow Interpolation in general
Linear_Interpolation = true;    % Allow Linear Interpolation
Cubic_Interpolation = true;     % Allow Cubic Interpolation
Sinc_Filter_NonUniform = true;  % Allow Sinc Filter


% Align signals
Alignment = true;               % Allow Alignment
Correlation = true;             % Allow Cross-Correlation calculation
ErrorNormMinimization = true;   % Allow Error Norm Minimization

% Save in CSV files
save = false;                       % General save
save_Linear_Interpolation = true;   % save Linear interpolation
save_Cubic_Interpolation = true;    % save Cubic interpolation
save_Sinc_Filter_NonUniform = true; % save sinc filter
save_Correlations = true;           % save correlation
save_ErrorNormMinimization = true;  % save error norm minimization


% Ploting
Display = true;




