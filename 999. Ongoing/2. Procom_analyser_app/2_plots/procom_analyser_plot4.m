%% Plot4: Power Output & Expected / T water out & T water SP & Water Flow Rate
figure
%Qn Overview
sp1_1=subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
hold on
title('Power Input Overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
yyaxis right
plot(Aggregate.t_relative,Aggregate.Qn,'-k')
hold on
plot(Aggregate.t_relative,Aggregate.Vdot_w,'-c')
legend('Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]','Power Input - [kW]','Water Flow - \dot{V}_{water} - [l/min]')
grid on

%Qn Overview
sp1_2=subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.T_wsp,'-k',Aggregate.t_relative,Aggregate.T_wout,'-r',Aggregate.t_relative,Aggregate.Vdot_w,'-g',Aggregate.t_relative,Aggregate.Expected_T_wout,':r');
hold on
plot(Aggregate.t_relative,Aggregate.T_win,'-b')
title('Water Outlet Overview')
xlabel('Elapsed time - t - [s]')
legend('Water Outlet Temperature: Set-Point - [ºC]', 'Water Outlet Temperature: Actual - [ºC]', 'Water Flow Rate - [l/min]','Expected: Water Outlet Temperature according to SW','Water Inlet Temperature - T_{win} - [ºC]')
grid on

linkaxes([sp1_1 sp1_2],'x')