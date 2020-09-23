%% Plot1: Air Flow / Qn /I_{GV} /I_{ion}
%Flow Rate Control

figure
sp1_1=subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_FlowrateNom,'-g',Aggregate.t_relative,Aggregate.SW_FlowrateUp,'--g',Aggregate.t_relative,Aggregate.SW_FlowrateLow,':g',Aggregate.t_relative,Aggregate.Vdot_air_actual,'-k',Aggregate.t_relative,Aggregate.Vdot_air_desired,'--k',Aggregate.t_relative,movmean(Aggregate.Vdot_air_actual,4),'-r')
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
hold on
plot(Aggregate.t_relative,Aggregate.Vdot_w)
legend('Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]','Power Input - [kW]','Water Flowrate - [slpm]')
grid on

linkaxes([sp1_1,sp1_2],'x');