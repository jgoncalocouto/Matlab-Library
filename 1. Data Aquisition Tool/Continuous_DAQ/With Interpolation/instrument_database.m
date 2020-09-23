%% Tables Database
Starwin_characteristic=[
    1840 	0
    1822 	0.2
    1804 	0.4
    1785 	0.6
    1765 	0.8
    1744 	1
    1723 	1.2
    1700 	1.4
    1678 	1.6
    1655 	1.8
    1632 	2
    1610 	2.2
    1588 	2.4
    1566 	2.6
    1546 	2.8
    1526 	3
    1506 	3.2
    1489 	3.4
    1472 	3.6
    1456 	3.8
    1442 	4
    1429 	4.2
    1417 	4.4
    1407 	4.6
    1398 	4.8
    1390 	5];


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
    'FAFE_Patm',{'Absolute Pressure','[V]','[mbar]','Linear',80,800,1,0}
    'FAFE_Pbox',{'Relative Pressure','[mA]','[mbar]','Linear',625,-2.5,1,0}
    'Micromanometer_dpm',{'Relative Pressure','[V]','[mbar]','Linear',2,0,1,0}
    'Ultramat23_CO_MR1',{'CO','[mA]','[ppm]','Linear',31250,-125,1.000625391,3.7523E-05}
    'Ultramat23_CO_MR2',{'CO','[mA]','[ppm]','Linear',156250,-625,1.000625391,3.7523E-05}
    'Ultramat23_CO2_MR1',{'CO2','[mA]','[%]','Linear',312.5,-1.25,1.001878522,1.25235E-05}
    'Ultramat23_CO2_MR2',{'CO2','[mA]','[%]','Linear',1562.5,-6.25,1.001878522,1.25235E-05}
    'Yokogawa_50_N2685',{'Relative Pressure', '[V]','[mbar]','Linear',187.5,-15,1,0}
    'Yokogawa_50_N2686',{'Relative Pressure', '[V]','[mbar]','Linear',187.5,-15,1,0}
    'Schmidt_10mps_T_N4875',{'Temperature','[mA]','[ºC]','Linear', 8750,-55,1,0}
    'Schmidt_10mps_V_N4875',{'Velocity','[mA]','[m/s]','Linear', 625,-2.5,1,0}
    'Digital_signal',{'Logical','[V]','[-]','Linear',0.2,0,1,0}
    'Yokogawa_20_N2715',{'Relative Pressure', '[V]','[mbar]','Linear',-68.75,-5.5,1,0}
    'Yokogawa_20_N2714',{'Relative Pressure', '[V]','[mbar]','Linear',-68.75,-5.5,1,0}
    'Huba_control_401', {'Relative Pressure', '[V]','[mbar]','Linear',1.25,-0.625,1,0}
    'Starwin_frequency', {'Frequency', '[Hz]','[Hz]','Linear',1,0,1,0}
    'FAN_FIME_RPM',{'Frequency','[Hz]','[rpm]','Linear',5,0,1,0}
    'Starwin', {'Frequency', '[Hz]','[mbar]','Table',Starwin_characteristic(:,1),Starwin_characteristic(:,2),0,0}
    };
sensor_database=sensor_database';
sensor_database=struct(sensor_database{:});
% Legend:
% Col.1 - Sensor name
% Col.2 - Measured variable
% Col.3 - Output Signal variable and units
% Col.4 - Units of measured variable
% Col.5 - Type of transfer function (Linear, Table, etc)
% Col.6 - m of transfer function
% Col.7 - b of transfer function
% Col.8 - m of calibration transfer function
% Col.9 - b of calibration transfer function



