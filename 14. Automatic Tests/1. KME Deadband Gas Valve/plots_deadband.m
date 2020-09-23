function [] = plots_deadband(tt,statistics,name)
%% Figures; Eyeball Test
%Eyeball Test #1: Check for the correctness of baseline definition
figure
ax1=subplot(3,1,1);
plot(tt.I_GV,'-k');
hold on
plot(statistics.details.patamar_start,statistics.T_median.I_GV,'r*')
plot(statistics.details.patamar_end,statistics.T_median.I_GV,'ro')
title([name ':' 'Eyeball Test #1: Check for the correctness of baseline definition'])
ylabel('Intensity of current - [mA]')
legend('Untreated data','Median @ baseline start','Median @ baseline end')


ax2=subplot(3,1,2);
errorbar(statistics.details.patamar_midpoint,statistics.T_median.P_burner_dpm,statistics.T_err.P_burner_dpm,'b*')
hold on
errorbar(statistics.details.patamar_midpoint,statistics.T_median.P_burner_dpm,statistics.T_err.P_burner_huba,'r*')
plot(tt.P_burner_dpm,'-b')
plot(tt.P_burner_huba,'-r')
legend('DPM Sensor','DPM Sensor - Median Value','Huba Sensor','Huba Sensor - Median')
xlabel('Relative Time')
ylabel('Burner Pressure - [mbar]')

%Eyeball Test #2: Check for excessive inlet pressure variation during each specific baseline
ax3=subplot(3,1,3); 
errorbar(statistics.details.patamar_midpoint,statistics.T_median.P_in,statistics.T_err.P_in,'ko');
hold on
plot(tt.P_in,'-r')
title([name ' :' 'Eyeball Test #2: Check for excessive inlet pressure variation during each specific baseline'])
ylabel('Inlet Pressure - [mbar]')
xlabel('Relative time - t - [s]')
legend('Error bar for Inlet Pressure for each baseline')

linkaxes([ax1 ax2 ax3],'x')

end

