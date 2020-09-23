%% SW C4 KME - Consulting

gas_type='NG';
capacity='11';
power_input=11;


KME_SW


i=0;
eta=zeros(length(power_input),1);
flowrate_sp=zeros(length(power_input),1);
flowrate_min=zeros(length(power_input),1);
flowrate_max=zeros(length(power_input),1);
rpm_max=zeros(length(power_input),1);
rpm_min=zeros(length(power_input),1);
T_venturi=zeros(length(power_input),1);
T_fire=zeros(length(power_input),1);
valve_current=zeros(length(power_input),1);

for i=1:length(power_input)
eta(i)=interp1_sat(SW_Efficiency.(gas_type)(:,1),SW_Efficiency.(gas_type)(:,2),power_input(i));
flowrate_sp(i)=interp1_sat(SW_Flowrate.(gas_type)(:,1),SW_Flowrate.(gas_type)(:,2),power_input(i));
flowrate_min(i)=interp1_sat(SW_Flowrate.(gas_type)(:,1),SW_Flowrate.(gas_type)(:,2),power_input(i)).*(1+SW_FlowrateLimitLow.(gas_type));
flowrate_max(i)=interp1_sat(SW_Flowrate.(gas_type)(:,1),SW_Flowrate.(gas_type)(:,2),power_input(i)).*(1+SW_FlowrateLimitUp.(gas_type));
rpm_max(i)=interp1_sat(SW_RPMMax.(gas_type)(:,1),SW_RPMMax.(gas_type)(:,2),power_input(i));
rpm_min(i)=interp1_sat(SW_RPMMin.(gas_type)(:,1),SW_RPMMin.(gas_type)(:,2),power_input(i));
T_venturi(i)=interp1_sat(SW_Tventuri.(gas_type)(:,1),SW_Tventuri.(gas_type)(:,2),power_input(i));
T_fire(i)=interp1_sat(SW_Tfire.(gas_type)(:,1),SW_Tfire.(gas_type)(:,2),power_input(i));
valve_current(i)=interp1_sat(SW_ValveCurrent.(gas_type)(:,1),SW_ValveCurrent.(gas_type)(:,2),power_input(i));
end

t_sw=table(power_input,flowrate_sp,flowrate_min,flowrate_max,valve_current,eta,rpm_max,rpm_min,T_venturi,T_fire);




%% Calculations
Flowrate_min=ones(length(SW_Flowrate.(gas_type)(:,2)),1);
Flowrate_min=SW_Flowrate.(gas_type)(:,2)*(1+SW_FlowrateLimitLow.(gas_type));

Flowrate_max=ones(length(SW_Flowrate.(gas_type)(:,2)),1);
Flowrate_max=SW_Flowrate.(gas_type)(:,2)*(1+SW_FlowrateLimitUp.(gas_type));



%% Plot1 - Fan Control Overview: Continuous

figure
hold on
title(horzcat('Fan Control Overview: ',gas_type));
plot(SW_Flowrate.(gas_type)(:,1),SW_Flowrate.(gas_type)(:,2),'k-*')
plot(SW_Flowrate.(gas_type)(:,1),Flowrate_max,'k--')
plot(SW_Flowrate.(gas_type)(:,1),Flowrate_min,'k:')
ylim([0 900]);
xlabel('Power Input - Qn - [kW]')
ylabel('Exhaust Gas Flow Rate - \dot{V}_{exg} - [slpm]');
yyaxis right
ylim([0 2500]);
plot(SW_RPMMax.(gas_type)(:,1),SW_RPMMax.(gas_type)(:,2),'r-*')
ylabel('Fan Rotational Speed - N_{fan} - [RPM]');
plot(SW_RPMMin.(gas_type)(:,1),SW_RPMMin.(gas_type)(:,2),'c-*')
ylabel('Fan Rotational Speed - N_{fan} - [RPM]');
l_p1=[
    "Flowrate Set-point"
    "Flowrate: Max Acceptable"
    "Flowrate: Min Acceptable"
    "C6: RPM Max"
    "RPM Min"
    ];
legend_p1=legend(l_p1);
legend_p1.Location="southeast";

%% Plot2 - Gas Valve Current

figure
hold on
title(horzcat('Gas Valve: ',gas_type));
plot(SW_ValveCurrent.(gas_type)(:,1),SW_ValveCurrent.(gas_type)(:,2),'r-*')
ylim([0 220]);
xlabel('Power Input - Qn - [kW]')
ylabel('Valve Current - I_{GV} - [mA]');
l_p2=[
    "Valve Current"
    ];
legend_p2=legend(l_p2);
legend_p2.Location="southeast";


%% Plot3 - T_venturi

figure
hold on
title(horzcat('Exhaust Gases Temperature: ',gas_type));
plot(SW_Tventuri.(gas_type)(:,1),SW_Tventuri.(gas_type)(:,2),'k-*')
plot(SW_Tfire.(gas_type)(:,1),SW_Tfire.(gas_type)(:,2),'r-*')
ylim([0 250]);
xlabel('Power Input - Qn - [kW]')
ylabel('Exhaust Gases Temperature - T - [ºC]');
l_p3=[
    "Venturi Temperature"
    "A4: Fire Temperature"
    ];
legend_p3=legend(l_p3);
legend_p3.Location="southeast";


%% Plot4 - Thermal Efficiency

figure
hold on
title(horzcat('Thermal Efficiency: ',gas_type));
plot(SW_Efficiency.(gas_type)(:,1),SW_Efficiency.(gas_type)(:,2),'r-*')
ylim([0 100]);
xlabel('Power Input - Qn - [kW]')
ylabel('Thermal Efficiency - \eta_{thermal} - [%]');
l_p4=[
    "Thermal Efficiency"
    ];
legend_p4=legend(l_p4);
legend_p4.Location="southeast";


%% Plot5 - Ignition

figure
hold on
subplot(2,1,1);
title('Air Flow Control')
t=[1:1:5];t=t';
ignition_air_sp=ones(length(t),1).*SW_I_Flowrate.(gas_type);
ignition_air_min=ones(length(t),1).*SW_I_Flowrate.(gas_type).*(1+SW_I_FlowrateLimitLow.(gas_type));
ignition_air_max=ones(length(t),1).*SW_I_Flowrate.(gas_type).*(1+SW_I_FlowrateLimitUp.(gas_type));
plot(t,ignition_air_sp,'-k',t,ignition_air_max,'--k',t,ignition_air_min,':k')
xlabel('Elapsed time - t - [s]');
ylabel('Flowrate - \dot{V}_{air} - [slpm]');
ylim([0 1000])
l_p5_1=[
    "Flowrate Set-point"
    "Flowrate Set-point Acceptance Criteria: Max"
    "Flowrate Set-point Acceptance Criteria: Min"
    ];

legend_p5_1=legend(l_p5_1);
legend_p5_1.Location="southeast";


subplot(2,1,2);
title('Gas Valve Control')
plot(SW_I_ValveCurrentRamp.(gas_type)(:,1),SW_I_ValveCurrentRamp.(gas_type)(:,2),'-r*');
ylim([0 165])
xlabel('Elapsed time - t - [s]');
ylabel('Valve Current - I_{GV} - [mA]');
l_p5_2=[
    "Valve Current"
    ];

legend_p5_2=legend(l_p5_2);
legend_p5_2.Location="southeast";


