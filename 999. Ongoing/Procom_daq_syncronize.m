%% Start-up Analysis: C4 KME LPG Endurance

% Load data and synchronize
load data_daq.mat TableData
Procom_only()
close all
clearvars -except TableData Aggregate

log=synchronize(Aggregate,TableData,'union','nearest');



% Check for time offsets and define it
time_offset=0.75; %Positive offset applied to sensor data


%% Calculation of global lambda


log.P_ref(log.P_ref<0)=0;


% Inputs
capacity=11; %[-]
gas_type='G30'; %[-]
marking=62; %[-]
T_gas=15; %[ºC]
h=0; %[m]
P_burner=log.P_ref;


% Calculations

C4_KME_capacity_injectors=[ 
    11 15
    14 18
    17 24
    ];

N=C4_KME_capacity_injectors((C4_KME_capacity_injectors(:,1)==11),2);
mu=viscosityd(gas_type,T_gas);
P_atm=P_altitude(h);
D_inj=(marking/100)/1000;
appliance_type='C4 KME';
rho=densityz(gas_type,T_gas,P_atm);
A_inj=pi()*0.25*N*(D_inj)^2;

for i=1:size(P_burner,1)
CD(i,1) =cd_model(appliance_type,marking,rho,mu,N,P_burner(i,1));
V_gas(i,1)=vgas_calc(CD(i,1),rho,P_burner(i,1),A_inj);
Hi=heatingvalues(gas_type,'Hi');
Qn(i,1)=V_gas(i)*Hi*1000;
end

%Outputs

V_gasslpm=V_gas.*60000;
log.Qn_calc=Qn;
log.Vgas_calc=V_gasslpm; %[slpm]


%% Plots

%Plot1: Power Output & Expected / T water out & T water SP & Water Flow Rate
SP_int=1;
figure
sp1_1=subplot(2,1,1);
plot(log.t_absolute,log.Qn,'--k',log.t_absolute,log.Qn_calc,'-k');
ylabel('Power Input - Q - [kW]')
yyaxis right
ylabel('Intensity of current - I - [mA]')
hold on
plot(log.t_absolute,log.I_gv,'-b')
title('Power Input Overview')
xlabel('Absolute time')
ylim([0 100]);
legend('Power Input Expected SW - [kW]', 'Power Input Measured - [kW]', 'Gas Valve Current - [mA]')
grid on
%Qn Overview
sp1_2=subplot(2,1,2);
plot(log.t_absolute,log.T_wsp,'-k',log.t_absolute,log.T_wout,'-r',log.t_absolute,log.Vdot_w,'-b',log.t_absolute,log.Expected_T_wout,':r',log.t_absolute,log.T_wsp_plus,'--k',log.t_absolute,log.T_wsp_minus,':k');
title('Water Outlet Overview')
xlabel('Absolute time')
legend('Water Outlet Temperature: Set-Point - [ºC]', 'Water Outlet Temperature: Actual - [ºC]', 'Water Flow Rate - [l/min]','Expected: Water Outlet Temperature according to SW')
grid on
linkaxes([sp1_1,sp1_2],'x');

%% Export and save

%Window that asks where you want to save the file
[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.txt';'*.csv'},'Save As...',['Procom_analysis' '.txt']);
if FileNameBodeWrite ~=0
    if exist([PathNameBodeWrite FileNameBodeWrite],'file')
        delete([PathNameLachWrite FileNameBodeWrite ]);
    end
    writetable(timetable2table(log),[PathNameBodeWrite FileNameBodeWrite ])  %table
    
end


