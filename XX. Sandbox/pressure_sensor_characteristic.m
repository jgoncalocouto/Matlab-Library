function [P_measured,Output_signal] = pressure_sensor_characteristic(P_signal,Sensor_type,T_exg,Lifetime_state,limit_sample_position)

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




if strcmp(Sensor_type,'Starwin')==1
    if strcmp(limit_sample_position,'Nominal')==1
        P_measured=P_signal;
        
        Output_signal=interp1(Starwin_characteristic(:,2),Starwin_characteristic(:,1),P_measured,'linear', 'extrap');
        
    elseif strcmp(limit_sample_position,'Upper')==1
        P_measured=P_signal+0.15;
        Output_signal=interp1(Starwin_characteristic(:,2),Starwin_characteristic(:,1),P_measured,'linear', 'extrap');
        
    elseif strcmp(limit_sample_position,'Lower')==1
        P_measured=P_signal-0.15;
        Output_signal=interp1(Starwin_characteristic(:,2),Starwin_characteristic(:,1),P_measured,'linear', 'extrap');
    end
    
    
elseif srtcmp(Sensor_type,'Huba_control')==1
else
end


end