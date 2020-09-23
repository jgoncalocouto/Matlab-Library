%% Plot2: Air Flow / RPM
%Flow Rate Control

figure
sp2_1=subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_FlowrateNom,'-g',Aggregate.t_relative,Aggregate.SW_FlowrateUp,'--g',Aggregate.t_relative,Aggregate.SW_FlowrateLow,':g',Aggregate.t_relative,Aggregate.Vdot_air_actual,'-k',Aggregate.t_relative,Aggregate.Vdot_air_desired,'--k')
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
legend('SW: Actual RPM: Nominal', 'SW: Actual RPM: Upper Limit', 'SW: Actual RPM: Lower Limit','Maximum RPM allowed: C6 or C2','Minimum allowed RPM during continous operation','Fan Duty Cycle')
linkaxes([sp2_1,sp2_2],'x');
grid on