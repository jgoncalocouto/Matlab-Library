%% Inputs
GV_NAME='GV01';

%% Import Data

tt_daq=evodaq_importer();
tt_auto=table2timetable(table_importer());
tt=synchronize(tt_auto,tt_daq);
tt=fillmissing(tt,'nearest');

%% Check #1: Irregularities in Test Baselines
tt.Properties.VariableNames{'GVCurrentMikuni_mA_I1_AMP_Front__'} = 'I_GV_MEASURED';
tt.Properties.VariableNames{'Huba_50_01_mbar_AI1_10V_'} = 'P_BURNER_MEASURED';

tt.marker=[0;diff(tt.I_GV_MEASURED)];
tt.marker_avg=movmean(tt.marker,60);
tt.dif=movmean(abs(tt.marker-tt.marker_avg),60);



figure
suptitle('Check #1: Are there non-intended irregularities in the test profile?')

ax1=subplot(3,1,1);
title('Test Profile: Intensity of current')
ylabel('Intensity of current - [mA]')
xlabel('Index - [-]')
plot(tt.I_GV_MEASURED);
ylim([0 250]);
ax2=subplot(3,1,2);
title('1st Derivative: Intensity of current')
ylabel('1st Derivative: Intensity of current - [mA/s]')
xlabel('Index - [-]')
plot(tt.marker,'r*')
hold on
plot(tt.marker_avg,'-k')
title('Moving Average of 1st Derivative (60s period): Intensity of current')
ylabel('Moving Average of 1st Derivative: Intensity of current - [mA/s]')
xlabel('Index - [-]')
ylim([-1000 1000])
ax3=subplot(3,1,3);
plot(tt.dif,'ko')
linkaxes([ax1 ax2 ax3],'x')

%% Check #2: Did the irregularities haven been removed?

tt(tt.dif>0.25,:)=[];
 
figure
ax1=subplot(3,1,1);
plot(tt.I_GV_MEASURED);
ylim([0 250]);
ax2=subplot(3,1,2);
plot(tt.marker,'r*')
hold on
plot(tt.marker_avg,'-k')
ylim([-1000 1000])
ax3=subplot(3,1,3);
plot(tt.dif,'ko')
linkaxes([ax1 ax2 ax3],'x')



%% Check 3 - Determine Direction of Current Variation

tt.direction_aux=[0;movmean(diff(tt.I_GV_MEASURED),100)];

tt.direction=zeros(size(tt.direction_aux,1),1);
tt.direction(tt.direction_aux>0)=ones(size(tt.direction(tt.direction_aux>0),1),1);
tt.direction(tt.direction_aux<0)=ones(size(tt.direction(tt.direction_aux<0),1),1).*2;
tt(tt.I_GV_MEASURED<42,:)=[];

figure
plot(tt.t_absolute,tt.I_GV_MEASURED,'-k')
hold on
plot(tt.t_absolute(tt.direction==1),tt.I_GV_MEASURED(tt.direction==1),'r*')
plot(tt.t_absolute(tt.direction==2),tt.I_GV_MEASURED(tt.direction==2),'bo')

%% Check 4 - Analyse only data on the baselines

[patamar] = identifying_steps(tt.I_GV_MEASURED,'1st_derivative',3);
[T_err,T_avg,T_median,T_std,details]=patamar_statistics(patamar,tt,'random_uncertainty','average','median','std','patamar_details');
statistics.T_err=T_err;statistics.T_avg=T_avg;statistics.T_median=T_median;statistics.T_std=T_std;statistics.details=details;
    

%% Check 5 - Eliminate data from regions where the valve is truncated

[statistics.T_median.dPB_dGV] = partial_diff(statistics.T_median.P_BURNER_MEASURED,statistics.T_median.I_GV_MEASURED);

statistics.T_median(statistics.T_median.dPB_dGV<0.05,:)=[];

T_median=statistics.T_median;

%%
figure
hold on
scatter(tt.I_GV_MEASURED(tt.direction==1),tt.P_BURNER_MEASURED(tt.direction==1),'k*')
scatter(tt.I_GV_MEASURED(tt.direction==2),tt.P_BURNER_MEASURED(tt.direction==2),'k+')
scatter(T_median.I_GV_MEASURED(T_median.direction==1),T_median.P_BURNER_MEASURED(T_median.direction==1),'ro')
scatter(T_median.I_GV_MEASURED(T_median.direction==2),T_median.P_BURNER_MEASURED(T_median.direction==2),'bo')

data.(GV_NAME).log=tt;
data.(GV_NAME).statistics=statistics;
data.(GV_NAME).UP.I_GV=T_median.I_GV_MEASURED(T_median.direction==1);
data.(GV_NAME).UP.P_BURNER=T_median.P_BURNER_MEASURED(T_median.direction==1);
data.(GV_NAME).DOWN.I_GV=T_median.I_GV_MEASURED(T_median.direction==2);
data.(GV_NAME).DOWN.P_BURNER=T_median.P_BURNER_MEASURED(T_median.direction==2);

[data.(GV_NAME).UP.P_BURNER_FIT, data.(GV_NAME).UP.FIT_METRICS] = fit(data.(GV_NAME).UP.I_GV,data.(GV_NAME).UP.P_BURNER,'poly2');
[data.(GV_NAME).DOWN.P_BURNER_FIT, data.(GV_NAME).DOWN.FIT_METRICS] = fit(data.(GV_NAME).DOWN.I_GV,data.(GV_NAME).DOWN.P_BURNER,'poly2');

plot(sort(data.(GV_NAME).UP.I_GV),sort(data.(GV_NAME).UP.P_BURNER_FIT(data.(GV_NAME).UP.I_GV)),'-r')
plot(sort(data.(GV_NAME).DOWN.I_GV),sort(data.(GV_NAME).DOWN.P_BURNER_FIT(data.(GV_NAME).DOWN.I_GV)),'-b')


%%

save(horzcat('O:\TTM-Projects\9305 Compact4 KME\10_testing\A_laboratory\79 - Confort Tests\02_Valve_controller_improvement\1. Test_logs\GV_Characterization\',GV_NAME,'.mat'))