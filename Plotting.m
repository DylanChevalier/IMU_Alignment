%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   IMU-Alignment - Signal Processing Systems
%   Author: Dylan Chevalier
%  
%   Plot different signals
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if Display
    disp('Ploting ...');

    %% Before Alignment
    figure; hold on;
    subplot(4,1,1);
    plot(twanted,s_wanted,'r','LineWidth',2,'DisplayName','ts = 1us');
    title('Physical Event');
    legend();

    subplot(4,1,2); plot(tdvs,s_dvs,'LineWidth',2,'DisplayName','DVS (ts = 1ms)'); hold on;
    plot(twanted,s_dvs_Linear_interpolated,'LineWidth',2,'DisplayName','DVS (Linear - ts = 1us)');
    plot(twanted,s_dvs_Cubic_interpolated,'LineWidth',2,'DisplayName','DVS (Cubic - ts = 1us)');
    plot(twanted,s_dvs_SincFiltering,'LineWidth',2,'DisplayName','DVS (Sinc Filter Uniform - ts = 1us)');
    title('DVS');
    legend();

    subplot(4,1,3); plot(trs,s_rs,'LineWidth',2,'DisplayName','RS (ts = 4ms)'); hold on;
    plot(twanted,s_rs_Linear_interpolated,'LineWidth',2,'DisplayName','RS (Linear - ts = 1us)');
    plot(twanted,s_rs_Cubic_interpolated,'LineWidth',2,'DisplayName','RS (Cubic - ts = 1us)');
    plot(twanted,s_rs_SincFiltering,'LineWidth',2,'DisplayName','RS (Sinc Filter Uniform - ts = 1us)');
    title('RS');
    legend();

    subplot(4,1,4); plot(tlidar,s_lidar,'LineWidth',2,'DisplayName','LIDAR (ts = 10ms)'); hold on;
    plot(twanted,s_lidar_Linear_interpolated,'LineWidth',2,'DisplayName','LIDAR (Linear - ts = 1us)');
    plot(twanted,s_lidar_Cubic_interpolated,'LineWidth',2,'DisplayName','LIDAR (Cubic - ts = 1us)');
    plot(twanted,s_lidar_SincFiltering,'LineWidth',2,'DisplayName','LIDAR (Sinc Filter Uniform - ts = 1us)');
    title('LIDAR');
    legend();
    xlabel('time in ms');

    %% After Alignment

%     if Alignment && Correlation
%         figure; hold on;
% %         subplot(4,1,1);
% 		subplot(2,1,1);
%         plot(twanted,s_wanted,'r','LineWidth',2,'DisplayName','ts = 1us');
%         title('CORRELATION: Physical Event');
%         legend();
% 
% %         subplot(4,1,2);
% 		subplot(2,1,2);
% 		plot(tdvs,s_dvs,'LineWidth',2,'DisplayName','DVS (ts = 1ms)'); hold on;
%         plot(twanted,s_dvs_Linear_interpolated,'LineWidth',2,'DisplayName','DVS (Linear - ts = 1us)');
%         plot(twanted,s_dvs_Cubic_interpolated,'LineWidth',2,'DisplayName','DVS (Cubic - ts = 1us)');
%         plot(twanted,s_dvs_SincFiltering,'LineWidth',2,'DisplayName','DVS (Sinc Filter Uniform - ts = 1us)');
%         title('CORRELATION: DVS');
%         legend();

%         subplot(4,1,3); plot(trs,s_rs,'LineWidth',2,'DisplayName','RS (ts = 4ms)'); hold on;
%         plot(twanted,s_rs_Linear_interpolated_AlignCorr,'LineWidth',2,'DisplayName','RS (Linear - ts = 1us)');
%         plot(twanted,s_rs_Cubic_interpolated_AlignCorr,'LineWidth',2,'DisplayName','RS (Cubic - ts = 1us)');
%         plot(twanted,s_rs_SincFiltering_AlignCorr,'LineWidth',2,'DisplayName','RS (Sinc Filter Uniform - ts = 1us)');
%         title('CORRELATION: RS');
%         legend();
% 
%         subplot(4,1,4); plot(tlidar,s_lidar,'LineWidth',2,'DisplayName','LIDAR (ts = 10ms)'); hold on;
%         plot(twanted,s_lidar_Linear_interpolated_AlignCorr,'LineWidth',2,'DisplayName','LIDAR (Linear - ts = 1us)');
%         plot(twanted,s_lidar_Cubic_interpolated_AlignCorr,'LineWidth',2,'DisplayName','LIDAR (Cubic - ts = 1us)');
%         plot(twanted,s_lidar_SincFiltering_AlignCorr,'LineWidth',2,'DisplayName','LIDAR (Sinc Filter Uniform - ts = 1us)');
%         title('CORRELATION: LIDAR');
%         legend();
%         xlabel('time in ms');
%     end
    
%     if Alignment && ErrorNormMinimization
%         figure; hold on;
%         subplot(4,1,1);
% 		subplot(2,1,1);
%         plot(twanted,s_wanted,'r','LineWidth',2,'DisplayName','ts = 1us');
%         title('ERROR NORM MINIMIZATION: Physical Event');
%         legend();

%         subplot(4,1,2);
% 		subplot(2,1,2);
% 		plot(tdvs,s_dvs,'LineWidth',2,'DisplayName','DVS (ts = 1ms)'); hold on;
%         plot(twanted,s_dvs_Linear_interpolated,'LineWidth',2,'DisplayName','DVS (Linear - ts = 1us)');
%         plot(twanted,s_dvs_Cubic_interpolated,'LineWidth',2,'DisplayName','DVS (Cubic - ts = 1us)');
%         plot(twanted,s_dvs_SincFiltering,'LineWidth',2,'DisplayName','DVS (Sinc Filter Uniform - ts = 1us)');
%         title('ERROR NORM MINIMIZATION: DVS');
%         legend();

%         subplot(4,1,3); plot(trs,s_rs,'LineWidth',2,'DisplayName','RS (ts = 4ms)'); hold on;
%         plot(twanted,s_rs_Linear_interpolated_AlignMin,'LineWidth',2,'DisplayName','RS (Linear - ts = 1us)');
%         plot(twanted,s_rs_Cubic_interpolated_AlignMin,'LineWidth',2,'DisplayName','RS (Cubic - ts = 1us)');
%         plot(twanted,s_rs_SincFiltering_AlignMin,'LineWidth',2,'DisplayName','RS (Sinc Filter Uniform - ts = 1us)');
%         title('ERROR NORM MINIMIZATION: RS');
%         legend();
% 
%         subplot(4,1,4); plot(tlidar,s_lidar,'LineWidth',2,'DisplayName','LIDAR (ts = 10ms)'); hold on;
%         plot(twanted,s_lidar_Linear_interpolated_AlignMin,'LineWidth',2,'DisplayName','LIDAR (Linear - ts = 1us)');
%         plot(twanted,s_lidar_Cubic_interpolated_AlignMin,'LineWidth',2,'DisplayName','LIDAR (Cubic - ts = 1us)');
%         plot(twanted,s_lidar_SincFiltering_AlignMin,'LineWidth',2,'DisplayName','LIDAR (Sinc Filter Uniform - ts = 1us)');
%         title('ERROR NORM MINIMIZATION: LIDAR');
%         legend();
%         xlabel('time in ms');
%     end
end
