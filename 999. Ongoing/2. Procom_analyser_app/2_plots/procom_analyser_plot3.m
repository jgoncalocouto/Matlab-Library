%% Plot3: T_fire / Qn /I_{GV} /I_{ion}
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
