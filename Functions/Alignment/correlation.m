function [deltaPoint,CrossCorr] = correlation(x,y)
%	Calculate the cross corelation
%	Input: 
%         x: curve 1
%         y: curve 2
%	Output:
%         deltaPoint: number of points to shift
%         CrossCorr: curve of the cross correlation

    CrossCorr = xcorr(y,x); % Cross correlation between x and y
    AutoCorr = xcorr(x,x);  % Auto correlation with x
    peakCross = find(CrossCorr == max(CrossCorr));  % Find the maximum of the cross correlation
    peakAuto = find(AutoCorr == max(AutoCorr));     % Find the maximum of the auto correlation
   
    % Find the difference
    deltaPoint = peakCross - peakAuto;
end

