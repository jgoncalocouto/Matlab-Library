%% Plot5: Efficiency Overview

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
plot(Aggregate.t_relative,Aggregate.Vdot_air_actual,'-c')
title('Combustion Actuators overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]', 'Actual Exhaust Gas Flow Rate - [l/min]')
grid on
