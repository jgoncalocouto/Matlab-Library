%% PROCOM Load
%% Inputs:
Gastype='G31';
Gastype_parameter='LPG'
capacity='11'
P_atm=101325; %[Pa]

T_air=15;
h=0;
L_duct=0.5;
D_duct=80*10^-3;
N_elbows=0;
Min_tuning=4.5;
Max_tuning=20;
Injector_marking=65;
N_inj=15;
D_inj=0.62;
T_gas=15;
P_in=37; %Inlet Gas Pressure -> Considered equal to Nominal as Default


% Input-based calculations
Patm=P_atm./100;
rho_air=densityz('Air',15,Patm);
rho_gas=densityz(Gastype,15,Patm);
rho_exg=rho_air;
AFR=afr(1,1,Gastype,'vol');





%% Agreggate Array

Aggregate=data;

Aggregate.Properties.VariableNames{'burner_power'} = 'Qn';
Aggregate.Qn=(Aggregate.Qn./100)*22;
Aggregate.Properties.VariableNames{'N_fan'} = 'N_fanhz';
Aggregate.N_fanhz=Aggregate.N_fanhz./60;
Aggregate.Properties.VariableNames{'T_win'} = 'T_waterin';
Aggregate.Properties.VariableNames{'T_wout'} = 'T_waterout';
Aggregate.Properties.VariableNames{'Vdot_w'} = 'Vdot_water';
Aggregate.Properties.VariableNames{'P_box'} = 'DeltaP_sensor';
Aggregate.Properties.VariableNames{'Vdot_air_actual'} = 'Vdot_exg_actual';
Aggregate.Properties.VariableNames{'Vdot_air_desired'} = 'Vdot_exg_desired';
Aggregate.Properties.VariableNames{'T_wsp'} = 'T_watersp';
Aggregate.Properties.VariableNames{'error'} = 'Failure';

%% Treat Aggregate Array
%Fill missing values with linear interpolation from the neighborhood
% Aggregate=fillmissing(Aggregate,'linear');

%% PROCOM data treatment - Including SW Related Variables
KME_SW

i=0;


%Initialization of variables
Aggregate.RPMNom=zeros(length(Aggregate.t_relative),1);
Aggregate.RPMUp=zeros(length(Aggregate.t_relative),1);
Aggregate.RPMLow=zeros(length(Aggregate.t_relative),1);
Aggregate.Pn=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_FlowrateNom=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_FlowrateLow=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_FlowrateUp=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_ValveCurrent=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_Efficiency=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_TVenturi=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_RPMMin=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_RPMMax=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_Tfire=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_ExpectedPn=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vgas_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vgas_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vgas_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Qn_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Qn_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Qn_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Pburner_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Pburner_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Pburner_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vair_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vair_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vair_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_lambda_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_lambda_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_lambda_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_CO2_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_CO2_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_CO2_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Efficiency_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Efficiency_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Efficiency_low=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_TVenturi_calc=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_T_waterout=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A4=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A5=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A6=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A9=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_AC=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_C2=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_C6=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_C7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_CC=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_CF=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_CE=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E0=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E1=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E4=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_EC=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E8=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E9=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_EA=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_F7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_FA=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_F9=zeros(length(Aggregate.t_relative),1);


% Compute variables
for i=1:length(Aggregate.t_relative)
    
    if isempty(Aggregate.Qn(i,1))==1
        Aggregate.Qn(i,1)=0;
    elseif isnan(Aggregate.Qn(i,1))==1
        Aggregate.Qn(i,1)=0;
    end
    
    Aggregate.RPMNom(i,1)=Aggregate.N_fanhz(i,1).*60;
    Aggregate.RPMUp(i,1)=(Aggregate.N_fanhz(i,1)+0.49).*60;
    Aggregate.RPMLow(i,1)=(Aggregate.N_fanhz(i,1)-0.51).*60;
    rho_w=XSteam('rhoL_T',(Aggregate.T_waterin(i,1)+Aggregate.T_waterout(i,1))/2);
    cp_w=XSteam('CpL_T',(Aggregate.T_waterin(i,1)+Aggregate.T_waterout(i,1))/2);
    Aggregate.Pn(i,1)=(Aggregate.Vdot_water(i,1)./60000)*rho_w*cp_w*(Aggregate.T_waterout(i,1)-Aggregate.T_waterin(i,1));
    
    

    
    
    
    
    if Aggregate.I_ion(i,1)>0
        Aggregate.SW_FlowrateNom(i,1)=interp1_sat(SW_Flowrate.(Gastype_parameter)(:,1),SW_Flowrate.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_FlowrateLow(i,1)=(SW_FlowrateLimitLow.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_FlowrateUp(i,1)=(SW_FlowrateLimitUp.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_ValveCurrent(i,1)=interp1_sat(SW_ValveCurrent.(Gastype_parameter)(:,1),SW_ValveCurrent.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_Efficiency(i,1)=interp1_sat(SW_Efficiency.(Gastype_parameter)(:,1),SW_Efficiency.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_TVenturi(i,1)=interp1_sat(SW_Tventuri.(Gastype_parameter)(:,1),SW_Tventuri.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_RPMMin(i,1)=interp1_sat(SW_RPMMin.(Gastype_parameter)(:,1),SW_RPMMin.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_RPMMax(i,1)=interp1_sat(SW_RPMMax.(Gastype_parameter)(:,1),SW_RPMMax.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_Tfire(i,1)=interp1_sat(SW_Tfire.(Gastype_parameter)(:,1),SW_Tfire.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_ExpectedPn(i,1)=(Aggregate.SW_Efficiency(i,1)/100)*Aggregate.Qn(i,1);
        
       
        
        Aggregate.SW_TVenturi_calc(i,1)=-273.15+(((11809.^2)*Aggregate.DeltaP_sensor(i,1))./(Aggregate.Vdot_exg_actual(i,1).^2));
        
        Aggregate.Expected_T_waterout(i,1)=((Aggregate.Qn(i,1).*Aggregate.SW_Efficiency(i,1).*0.01)./(Aggregate.Vdot_water(i,1).*(1/60000).*rho_w.*cp_w))+Aggregate.T_waterin(i,1);
        
        
        
    else
        Aggregate.SW_FlowrateNom(i,1)=0;
        Aggregate.SW_FlowrateUp(i,1)=0;
        Aggregate.SW_FlowrateLow(i,1)=0;
        Aggregate.SW_ValveCurrent(i,1)=0;
        Aggregate.SW_Efficiency(i,1)=0;
        Aggregate.SW_TVenturi(i,1)=Aggregate.T_flue(i,1);
        Aggregate.SW_RPMMin(i,1)=0;
        Aggregate.SW_RPMMax(i,1)=0;
        Aggregate.SW_Tfire(i,1)=0;
        Aggregate.SW_ExpectedPn(i,1)=0;
        Aggregate.SW_TVenturi_calc(i,1)=0;
        
        
        
        

        Aggregate.Expected_T_waterout(i,1)=0;
        
        
        
    end
    
end



%% Treat Aggregate Array
%Fill missing values with linear interpolation from the neighborhood

% Aggregate=fillmissing(Aggregate,'linear');

%% Graphs


%Plot1: Air Flow / Qn /I_{GV} /I_{ion}
%Flow Rate Control

figure
sp1_1=subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_FlowrateNom,'-g',Aggregate.t_relative,Aggregate.SW_FlowrateUp,'--g',Aggregate.t_relative,Aggregate.SW_FlowrateLow,':g',Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-k',Aggregate.t_relative,Aggregate.Vdot_exg_desired,'--k',Aggregate.t_relative,movmean(Aggregate.Vdot_exg_actual,4),'-r')
title('Flow Rate Control Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Flow Rate @15ºC, 1 at - [l/min]')
ylim([0 1000]);
legend('Flow Rate Set-point', 'Acceptance Criteria: Flow Rate Max','Acceptance Criteria: Flow Rate Min','SW: Actual Flow Rate','SW: Desired Flow Rate','Moving Average Actual Flow Rate')
grid on



%Qn Overview
sp1_2=subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
hold on
title('Power Input Overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);

yyaxis right
plot(Aggregate.t_relative,Aggregate.Qn,'-k')
legend('Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]','Power Input - [kW]')
grid on

linkaxes([sp1_1,sp1_2],'x');


%Plot2: Air Flow / RPM
%Flow Rate Control

figure
sp2_1=subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_FlowrateNom,'-g',Aggregate.t_relative,Aggregate.SW_FlowrateUp,'--g',Aggregate.t_relative,Aggregate.SW_FlowrateLow,':g',Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-k',Aggregate.t_relative,Aggregate.Vdot_exg_desired,'--k')
title('Flow Rate Control Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Flow Rate @15ºC, 1 at - [l/min]')
ylim([0 1000]);
legend('Flow Rate Set-point', 'Acceptance Criteria: Flow Rate Max','Acceptance Criteria: Flow Rate Min','SW: Actual Flow Rate','SW: Desired Flow Rate')
grid on

sp2_2=subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.RPMNom,'-k',Aggregate.t_relative,Aggregate.RPMUp,'--k',Aggregate.t_relative,Aggregate.RPMLow,':k',Aggregate.t_relative,Aggregate.SW_RPMMax,'-b',Aggregate.t_relative,Aggregate.SW_RPMMin,'-r');
title('Fan RPM Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Fan Rotational Speed - [rpm]')
ylim([0 3000])
hold on
yyaxis right
ylabel('Fan Duty Cycle - [%]')
plot(Aggregate.t_relative,Aggregate.V_fan)
legend('SW: Actual RPM: Nominal', 'SW: Actual RPM: Upper Limit', 'SW: Actual RPM: Lower Limit','C6: Maximum RPM allowed during continuous operation','Minimum allowed RPM during continous operation','Fan Duty Cycle')
linkaxes([sp2_1,sp2_2],'x');
grid on

%Plot3: T_fire / Qn /I_{GV} /I_{ion}
%Exhaust Gas Temperature
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.T_flue,'-k',Aggregate.t_relative,Aggregate.SW_Tfire,'-r')
title('A4: Exhaust Gas Temperature Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Exhaust Gas Temperature - [ºC]')
ylim([0 250])
legend('Maximum allowed temperature for exhaust gases', 'Exhaust Gases Temperature')
grid on

%Qn Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
title('Power Input Overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]')
grid on


%Plot4: Power Output & Expected / T water out & T water SP & Water Flow Rate

%Power Output
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.Pn,'-k',Aggregate.t_relative,Aggregate.SW_ExpectedPn,'-b')
title('Power Output Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Power Output - P_n - [kW]')
ylim([0 22]);
legend('Actual Power Output', 'Expected Power Output according to SW curves')
grid on

%Qn Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.T_watersp,'-k',Aggregate.t_relative,Aggregate.T_waterout,'-r',Aggregate.t_relative,Aggregate.Vdot_water,'-b',Aggregate.t_relative,Aggregate.Expected_T_waterout,':r');
title('Water Outlet Overview')
xlabel('Elapsed time - t - [s]')
legend('Water Outlet Temperature: Set-Point - [ºC]', 'Water Outlet Temperature: Actual - [ºC]', 'Water Flow Rate - [l/min]','Expected: Water Outlet Temperature according to SW')
grid on



%Plot7: Efficiency Overview

figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.Expected_Efficiency_nom,'-b',Aggregate.t_relative,Aggregate.Expected_Efficiency_up,'--b',Aggregate.t_relative,Aggregate.Expected_Efficiency_low,':b',Aggregate.t_relative,Aggregate.SW_Efficiency,'-k')
title('Efficiency Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Thermal Efficiency - \eta - [%]')
ylim([0 100]);
legend('Efficiency considering calculated CO2 - Nominal GV','Efficiency considering calculated CO2 - Upper Limit GV', 'Efficiency considering calculated CO2 - Lower Limit GV', 'SW: Efficiency')
grid on

%Combustion Actuators Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
yyaxis right
plot(Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-c')
title('Combustion Actuators overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]', 'Actual Exhaust Gas Flow Rate - [l/min]')
grid on




%Plot9: Tventuri calc
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_TVenturi,':k',Aggregate.t_relative,Aggregate.SW_TVenturi_calc,'-k',Aggregate.t_relative,Aggregate.T_flue,'-r');
title('Temperature in the Venturi Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Temperature - T - [ºC]')
legend('Temperature in the venturi - f(Qn) - [ºC]', 'Temperature in the venturi - Calculated from \Delta P and Flow Rate - [ºC]', 'Flue Temperature - measured by the sensor - [ºC]');
grid on

subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
yyaxis right
plot(Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-c')
title('Combustion Actuators overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]', 'Actual Exhaust Gas Flow Rate - [l/min]')
grid on


%% Nieh
n=zeros(length(Aggregate.Failure),1);
i=0;
for i=1:length(Aggregate.Failure)
if Aggregate.Failure(i)==199
    n(i)=1;
end
end
%% Export .xls file with procom analysis




%Window that asks where you want to save the file
[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',['Procom_analysis' '.xls']);
if FileNameBodeWrite ~=0
    if exist([PathNameBodeWrite FileNameBodeWrite],'file')
        delete([PathNameLachWrite FileNameBodeWrite ]);
    end
    writetable(timetable2table(Aggregate),[PathNameBodeWrite FileNameBodeWrite ])  %table
    
end

