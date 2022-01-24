%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   IMU-Alignment - Signal Processing Systems
%   Author: Dylan Chevalier
% 
%   Realize different interpolation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if Interpolation
    disp('Interpolating ...');

    if(Linear_Interpolation)
        disp('Linear Interpolating ...');
        s_dvs_Linear_interpolated = LinearInterpolation(twanted, tdvs,s_dvs);
        s_rs_Linear_interpolated = LinearInterpolation(twanted, trs,s_rs);
        s_lidar_Linear_interpolated = LinearInterpolation(twanted, tlidar,s_lidar);
    end

    if(Cubic_Interpolation)
        disp('Cubic Interpolating ...');
        s_dvs_Cubic_interpolated = CubicInterpolation(twanted, tdvs,s_dvs);
        s_rs_Cubic_interpolated = CubicInterpolation(twanted, trs,s_rs); 
        s_lidar_Cubic_interpolated = CubicInterpolation(twanted, tlidar,s_lidar);
    end

    if(Sinc_Filter_NonUniform)
        disp('Sinc Filtering Non Uniform ...');
        s_dvs_SincFiltering = SincFilterNonUniform(twanted, tdvs,s_dvs);
        s_rs_SincFiltering  = SincFilterNonUniform(twanted, trs,s_rs);%
        s_lidar_SincFiltering  = SincFilterNonUniform(twanted, tlidar,s_lidar);%
    end
end
