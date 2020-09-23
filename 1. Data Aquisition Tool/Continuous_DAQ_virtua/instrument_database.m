%% Sensor database
% This section includes all the sensors that can be used in DAQ session
% using this script.
% Example of Transfer function [mbar]  =m*[V] + b
% The readings can be corrected using a calibration transfer function
% (columns 8 and 9)
% Example for a corrected current analog input:
% I_{corrected} = I_{measured} * m + b
% Warning: Every sensor must have a calibration curve, even if it is just m=1,b=0;
sensor_database={
    'FAFE_Patm',{'Absolute Pressure','[V]','[mbar]',80,800,1,0}
    'FAFE_Pbox',{'Relative Pressure','[mA]','[mbar]',625,-2.5,1,0}
    'Micromanometer_dpm',{'Relative Pressure','[V]','[mbar]',2,0,1,0}
    'Ultramat23_CO_MR1',{'CO','[mA]','[ppm]',31250,-125,1.000625391,3.7523E-05}
    'Ultramat23_CO_MR2',{'CO','[mA]','[ppm]',156250,-625,1.000625391,3.7523E-05}
    'Ultramat23_CO2_MR1',{'CO2','[mA]','[%]',312.5,-1.25,1.001878522,1.25235E-05}
    'Ultramat23_CO2_MR2',{'CO2','[mA]','[%]',1562.5,-6.25,1.001878522,-620} %Remeber to fix calibration xanatz
    'Yokogawa_50_N2685',{'Relative Pressure', '[V]','[mbar]',187.5,-15,1,0}
    'Yokogawa_50_N2686',{'Relative Pressure', '[V]','[mbar]',187.5,-15,1,0}
    'Schmidt_10mps_T_N4875',{'Temperature','[mA]','[ºC]', 8750,-55,1,0}
    'Schmidt_10mps_V_N4875',{'Velocity','[mA]','[m/s]', 625,-2.5,1,0}
    'Digital_signal',{'Logical','[V]','[-]',0.2,0,1,0}
    'Yokogawa_20_N2715',{'Relative Pressure', '[V]','[mbar]',-68.75,-5.5,1,0}
    'Yokogawa_20_N2714',{'Relative Pressure', '[V]','[mbar]',-68.75,-5.5,1,0}
    'Huba_control_401', {'Relative Pressure', '[V]','[mbar]',1.25,-0.625,1,0}
    'Starwin_frequency', {'Frequency', '[Hz]','[Hz]',1,0,1,0}
    'FAN_FIME_RPM',{'Frequency','[Hz]','[rpm]',5,0,1,0}
    'banca_14_Psensor70',{'Relative Pressure','[V]','[mbar]',7,0,1,0}
    'banca_14_Psensor100',{'Relative Pressure','[V]','[mbar]',10,0,1,0}
    };
sensor_database=sensor_database';
sensor_database=struct(sensor_database{:});
% Legend:
% Col.1 - Sensor name
% Col.2 - Measured variable
% Col.3 - Output Signal variable and units
% Col.4 - Units of measured variable
% Col.5 - m of transfer function
% Col.6 - b of transfer function
% Col.7 - m of calibration transfer function
% Col.8 - b of calibration transfer function




