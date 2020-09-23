function [SW] = KME_SW_calc(capacity)
%% SW Constants
Current_Version= string('KMAF_0077');

%% 1. Combustion Air Control: Exhaust Gas Flow Rate

if strcmp(capacity,'11')==1
    
    SW.Flowrate.NG=[
        8	300
        9	315
        11	315
        16	550
        18	650
        20	775
        22	775
        ];
    
    
    SW.Flowrate.LPG=[
        8	305
        9	305
        11	330
        16	520
        18	600
        20	700
        22	700
        ];
    
elseif strcmp(capacity,'14')==1
    
    SW.Flowrate.NG=[
        10	350
        11	350
        14	400
        17	600
        22	800
        24	800
        28	900
        ];
    
    
    SW.Flowrate.LPG=[
        10	400
        11	400
        14	550
        17	680
        22	760
        24	800
        28	930
        ];
    
end
%% 2. Combustion Air Control:T_{venturi} vs Qn calculation

if strcmp(capacity,'11')==1
    SW.Tventuri.NG=[
        8	105
        11	128
        18	186
        22	216
        ];
    
    SW.Tventuri.LPG=[
        8	85
        11	120
        18	180
        22	200
        ];
elseif strcmp(capacity,'14')==1
    
    SW.Tventuri.NG=[
        10	98
        14	142
        17	160
        28	219
        ];
    
    SW.Tventuri.LPG=[
        10	94
        14	116
        17	132
        28	186
        ];
end


%% 3. Combustion Air Control: Acceptance Interval for Deviation from Exhaust Flow Rate Set-point
if strcmp(capacity,'11')==1
    SW.FlowrateLimitLow.NG=-0.2;
    SW.FlowrateLimitLow.LPG=-0.2;
    
    SW.FlowrateLimitUp.NG=0.05;
    SW.FlowrateLimitUp.LPG=0.05;
    
elseif strcmp(capacity,'14')==1
    
    SW.FlowrateLimitLow.NG=-0.2;
    SW.FlowrateLimitLow.LPG=-0.2;
    
    SW.FlowrateLimitUp.NG=0.05;
    SW.FlowrateLimitUp.LPG=0.05;
end


%% 4. Combustion Gas Control: Gas Valve Current
if strcmp(capacity,'11')==1
    SW.ValveCurrent.NG=[
        8	39
        9	60
        11	70
        16	94
        18	103
        20	111
        22	131
        ];
    
    SW.ValveCurrent.LPG=[
        8	48
        9	79
        11	93
        16	122
        18	130
        20	138
        22	165
        ];
elseif strcmp(capacity,'14')==1
    
    SW.ValveCurrent.NG=[
        10	37
        11	57
        14	68
        17	80
        22	98
        24	118
        28	160
        ];
    
    SW.ValveCurrent.LPG=[
        10	40
        11	73
        14	90
        17	105
        22	125
        24	131
        28	166
        ];
    
end

%%  5. Thermostatic Mode Control: Efficiency

if strcmp(capacity,'11')==1
    
    SW.Efficiency.NG=[
        5.5	90.5
        8	88
        11	87.1
        14	86.7
        18	86.1
        20	86.1
        22	86.1
        ];
    
    SW.Efficiency.LPG=[
        5.5	90.5
        8	88
        11	87.1
        14	86.7
        18	86.1
        20	86.1
        22	86.1
        ];
    
elseif strcmp(capacity,'14')
    SW.Efficiency.NG=[
        10	90.5
        11	88
        14	87.1
        17	86.7
        22	86.1
        24	86.1
        28	86.1
        ];
    
    SW.Efficiency.LPG=[
        10	90.5
        11	88
        14	87.1
        17	86.7
        22	86.1
        24	86.1
        28	86.1
        ];
end


%% 6. Minimum Fan Speed Admissible

if strcmp(capacity,'11')==1
    
    SW.RPMMin.NG=[
        8	480
        9	480
        11	510
        16	840
        18	840
        20	840
        22	840
        ];
    
    SW.RPMMin.LPG=[
        8	420
        9	420
        11	480
        16	780
        18	780
        20	780
        22	780
        ];
    
elseif strcmp(capacity,'14')==1
    
    SW.RPMMin.NG=[
        10	360
        11	360
        14	360
        17	360
        22	360
        24	360
        28	360
        ];
    
    SW.RPMMin.LPG=[
        10	540
        11	540
        14	780
        17	1020
        22	1200
        24	1260
        28	1560
        ];
    
end


%% 7. Maximum Fan Speed Admissible

if strcmp(capacity,'11')==1
    
    SW.RPMMax.NG=[
        8	1960
        9	1985
        11	2050
        16	2300
        18	2350
        20	2500
        22	2500
        ];
    
    SW.RPMMax.LPG=[
        8	1710
        9	1770
        11	1890
        16	2130
        18	2190
        20	2250
        22	2280
        ];
    
elseif strcmp(capacity,'14')==1
    
    SW.RPMMax.NG=[
        10	1860
        11	1980
        14	1980
        17	2160
        22	2520
        24	2580
        28	2700
        ];
    
    SW.RPMMax.LPG=[
        10	1500
        11	1500
        14	1740
        17	1920
        22	2100
        24	2160
        28	2460
        ];
    
end


%% 8. Maximum Exhaust Gas Temperature

if strcmp(capacity,'11')==1
    
    SW.Tfire.NG=[
        8	190
        11	220
        18	220
        22	220
        ];
    
    SW.Tfire.LPG=[
        8	170
        11	200
        18	220
        22	220
        ];
    
elseif strcmp(capacity,'14')==1
    
    SW.Tfire.NG=[
        10	190
        14	220
        17	220
        28	220
        ];
    
    SW.Tfire.LPG=[
        10	190
        14	220
        17	220
        28	220
        ];
    
end

%% 9. Ignition: Maximum Fan Speed allowed in Ignition

if strcmp(capacity,'11')==1
    SW.I_RPMMax.NG=[
        5	2341
        15	2469
        22	2500
        35	2520
        45	2520
        72.5	2520
        ];
    
    SW.I_RPMMax.LPG=[
        5	2045
        15	2100
        22	2175
        35	2230
        45	2290
        72.5	2360
        ];
elseif strcmp(capacity,'14')==1
    SW.I_RPMMax.NG=[
        5	1840
        22	1930
        35	2020
        45	2140
        60	2220
        72.5	2220
        ];
    
    SW.I_RPMMax.LPG=[
        5	1290
        15	1370
        22	1450
        35	1490
        45	1610
        72.5	1610
        ];
end


%% 10. Ignition: Exhaust Flow Rate at Ignition

if strcmp(capacity,'11')==1
    SW.I_Flowrate.NG=600;
    SW.I_Flowrate.LPG=600;
elseif strcmp(capacity,'14')==1
    SW.I_Flowrate.NG=500;
    SW.I_Flowrate.LPG=500;
end


%% 11.Ignition: Exhaust Flow Rate at Ignition - Acceptance Interval for Deviation from Exhaust Flow Rate Set-point

if strcmp(capacity,'11')==1
    
    SW.I_FlowrateLimitLow.NG=-0.05;
    SW.I_FlowrateLimitLow.LPG=-0.05;
    
    SW.I_FlowrateLimitUp.NG=0.2;
    SW.I_FlowrateLimitUp.LPG=0.2;
    
elseif strcmp(capacity,'14')==1
    
    SW.I_FlowrateLimitLow.NG=-0.05;
    SW.I_FlowrateLimitLow.LPG=-0.05;
    
    SW.I_FlowrateLimitUp.NG=0.05;
    SW.I_FlowrateLimitUp.LPG=0.05;
    
end

%% 12. Ignition: Gas Valve Current Ramp

if strcmp(capacity,'11')==1
    
    SW.I_ValveCurrentRamp.NG=[
        0 90
        5 115
        ];
    
    SW.I_ValveCurrentRamp.LPG=[
        0 125
        5 145
        ];
elseif strcmp(capacity,'14')==1
    
    SW.I_ValveCurrentRamp.NG=[
        0 73
        5 100
        ];
    
    SW.I_ValveCurrentRamp.LPG=[
        0 99
        5 123
        ];
end
    
    %% 0. Sensors Characteristic Curves
    
    % Pressure Sensor: Starwin
    SW.Starwin_characteristic=[
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
    

end

