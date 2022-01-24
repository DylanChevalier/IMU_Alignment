%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   IMU-Alignment - Signal Processing Systems
%   Author: Dylan Chevalier
%   
%   Save signals in CSV files
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if save
    disp('Saving in CSV files ...');

    %% Original
	
	mkdir('datas/Original');
    csvwrite('datas/Original/PhysicEvent.csv',[twanted' s_wanted']);
    csvwrite('datas/Original/DVS.csv',[tdvs' s_dvs']);
    csvwrite('datas/Original/RS.csv',[trs' s_rs']);
    csvwrite('datas/Original/LIDAR.csv',[tlidar' s_lidar']);
    

 %%
    if ~Alignment
        % Linear Interpolation
        if Linear_Interpolation && save_Linear_Interpolation
			mkdir('datas/Interpolation/Linear');
            csvwrite('datas/Interpolation/Linear/DVS.csv',[twanted' s_dvs_Linear_interpolated']);
            csvwrite('datas/Interpolation/Linear/RS.csv',[twanted' s_rs_Linear_interpolated']);
            csvwrite('datas/Interpolation/Linear/LIDAR.csv',[twanted' s_lidar_Linear_interpolated']);
        end

        % Cubic Interpolation
        if Cubic_Interpolation && save_Cubic_Interpolation
			mkdir('datas/Interpolation/Cubic');
            csvwrite('datas/Interpolation/Cubic/DVS.csv',[twanted' s_dvs_Cubic_interpolated']);
            csvwrite('datas/Interpolation/Cubic/RS.csv',[twanted' s_rs_Cubic_interpolated']);
            csvwrite('datas/Interpolation/Cubic/LIDAR.csv',[twanted' s_lidar_Cubic_interpolated']);
        end

        % Sinc Filter
        if Sinc_Filter_NonUniform && save_Sinc_Filter_NonUniform
			mkdir('datas/Interpolation/SincNonUniform');
            csvwrite('datas/Interpolation/SincNonUniform/DVS.csv',[twanted' s_dvs_SincFiltering']);
            csvwrite('datas/Interpolation/SincNonUniform/RS.csv',[twanted' s_rs_SincFiltering']);
            csvwrite('datas/Interpolation/SincNonUniform/LIDAR.csv',[twanted' s_lidar_SincFiltering']);
        end
    end

%%
    if Alignment
        % Linear Interpolation
        if Linear_Interpolation && save_Linear_Interpolation
            mkdir('datas/Alignment/ResultAlignment/Linear');
			csvwrite('datas/Alignment/ResultAlignment/Linear/RS.csv',[twanted' s_rs_Linear_interpolated_AlignCorr']);
            csvwrite('datas/Alignment/ResultAlignment/Linear/LIDAR.csv',[twanted' s_lidar_Linear_interpolated_AlignCorr']);
        end

        % Cubic Interpolation
        if Cubic_Interpolation && save_Cubic_Interpolation
            mkdir('datas/Alignment/ResultAlignment/Cubic');
			csvwrite('datas/Alignment/ResultAlignment/Cubic/RS.csv',[twanted' s_rs_Cubic_interpolated_AlignCorr']);
            csvwrite('datas/Alignment/ResultAlignment/Cubic/LIDAR.csv',[twanted' s_lidar_Cubic_interpolated_AlignCorr']);
        end

        % Sinc Filter
        if Sinc_Filter_NonUniform && save_Sinc_Filter_NonUniform
			mkdir('datas/Alignment/ResultAlignment/SincNonUniform');
            csvwrite('datas/Alignment/ResultAlignment/SincNonUniform/RS.csv',[twanted' s_rs_SincFiltering_AlignCorr']);
            csvwrite('datas/Alignment/ResultAlignment/SincNonUniform/LIDAR.csv',[twanted' s_lidar_SincFiltering_AlignCorr']);
        end
    end
    
    if save_Correlations && Correlation
        tcorr = (-length(s_lidar_Cubic_correlation)/2:length(s_lidar_Linear_correlation)/2-1).*ts;
        u = find(isnan(s_rs_Linear_correlation)); s_rs_Linear_correlation(u) = 0;
        u = find(isnan(s_rs_Cubic_correlation)); s_rs_Cubic_correlation(u) = 0;
        u = find(isnan(s_rs_Sinc_correlation)); s_rs_Sinc_correlation(u) = 0;
        u = find(isnan(s_lidar_Linear_correlation)); s_lidar_Linear_correlation(u) = 0;
        u = find(isnan(s_lidar_Cubic_correlation)); s_lidar_Cubic_correlation(u) = 0;
        u = find(isnan(s_lidar_Sinc_correlation)); s_lidar_Sinc_correlation(u) = 0;

        mkdir('datas/Alignment/Correlations/Linear');
        csvwrite('datas/Alignment/Correlations/Linear/DVS_RS.csv',[tcorr' s_rs_Linear_correlation']);
        csvwrite('datas/Alignment/Correlations/Linear/DVS_LIDAR.csv',[tcorr' s_lidar_Linear_correlation']);
        
		mkdir('datas/Alignment/Correlations/Cubic');
        csvwrite('datas/Alignment/Correlations/Cubic/DVS_RS.csv',[tcorr' s_rs_Cubic_correlation']);
        csvwrite('datas/Alignment/Correlations/Cubic/DVS_LIDAR.csv',[tcorr' s_lidar_Linear_correlation']);
        
		mkdir('datas/Alignment/Correlations/SincNonUniform');
        csvwrite('datas/Alignment/Correlations/SincNonUniform/DVS_RS.csv',[tcorr' s_rs_Sinc_correlation']);
        csvwrite('datas/Alignment/Correlations/SincNonUniform/DVS_LIDAR.csv',[tcorr' s_lidar_Sinc_correlation']);
    end
    
    if save_ErrorNormMinimization && ErrorNormMinimization
        terror = (-length(s_lidar_Cubic_errornorm)/2:length(s_lidar_Cubic_errornorm)/2-1).*ts;
        
		mkdir('datas/Alignment/ErrorNormMinimization/Linear');
        csvwrite('datas/Alignment/ErrorNormMinimization/Linear/DVS_RS.csv',[terror' s_rs_Linear_errornorm']);
        csvwrite('datas/Alignment/ErrorNormMinimization/Linear/DVS_LIDAR.csv',[terror' s_lidar_Linear_errornorm']);
        
		mkdir('datas/Alignment/ErrorNormMinimization/Cubic');
        csvwrite('datas/Alignment/ErrorNormMinimization/Cubic/DVS_RS.csv',[terror' s_rs_Cubic_errornorm']);
        csvwrite('datas/Alignment/ErrorNormMinimization/Cubic/DVS_LIDAR.csv',[terror' s_lidar_Linear_errornorm']);
        
		mkdir('datas/Alignment/ErrorNormMinimization/SincNonUniform');
        csvwrite('datas/Alignment/ErrorNormMinimization/SincNonUniform/DVS_RS.csv',[terror' s_rs_Sinc_errornorm']);
        csvwrite('datas/Alignment/ErrorNormMinimization/SincNonUniform/DVS_LIDAR.csv',[terror' s_lidar_Sinc_errornorm']);
    end
    
end






