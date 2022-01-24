function [deltaPoint,error_values] = ErrorNormMin(s1,s2)
%	Calculate the error norm minimization
%	Input: 
%         s1: curve 1
%         s2: curve 2
%	Output:
%         deltaPoint: number of points to shift
%         error_values: curve of the error norm minimization

    % Delate 'NaN' value in s1 and s2
    u = find(isnan(s1)); s1(u) = 0;
    u = find(isnan(s2)); s2(u) = 0;
    
    A = norm(s1) ^ 2; % Calculate s1's Norm
    B = xcorr(s1,s2); % Calculate correlation
    C = norm(s2) ^ 2; % Calculate s2's Norm

    k = B / C;

    % Error Norm curve
    error_values = A - 2*k .* B + k.^2 * C;
    % Number of points to shift
    deltaPoint = round(length(error_values)/2- find(error_values == min(error_values)));
end

