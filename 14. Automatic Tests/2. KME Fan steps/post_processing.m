%% Inputs
duct='80mm fixed duct';
% Import file
[open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'},'Select an Evodaq file');
filename = strcat(open_path1,open_name1);
tt_procom = table2timetable(readtable(filename));% Importing file

% Import file
[open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'},'Select an Evodaq file');
filename = strcat(open_path1,open_name1);
daq = table2timetable(readtable(filename));% Importing file

%% Processing
tt=synchronize(tt_procom,daq);
tt=fillmissing(tt,'nearest');

V_profile_factor=0.775518325;
A_duct=0.002463009;
rho_20=1.204587687;
rho_15=1.225489781;


tt.Vdot_measured=((tt.V_20.*rho_20.*A_duct.*V_profile_factor).*60000).*rho_20./rho_15;
tt.Vdot_expected=sqrt(tt.DeltaP_v.*(1./(273.15+tt.T_flue))).*11809;
tt.E_rel=((tt.Vdot_expected-tt.Vdot_measured)./(tt.Vdot_measured)).*100 ;
tt.Measurement_state(tt.Measurement_state>=0.8)=1;
tt.Measurement_state(tt.Measurement_state<0.8)=0;

%Criteria 1: Identifying all the fan duty steps
[patamar] = identifying_steps(tt.V_fan);

[T_err,T_avg,T_median,T_std,details]=patamar_statistics(patamar,tt,'random_uncertainty','average','median','std','patamar_details');


%% Plots

figure

ax1=subplot(2,1,1);
plot(tt.DeltaP_v,tt.Vdot_measured,'k*');
hold on
plot(tt.DeltaP_v,tt.Vdot_expected,'bo');
title(['Assessment: Impact of ductwork diameter at the appliance''s outlet - ' duct])
xlabel('Pressure difference in the venturi - \DeltaP_{venturi} - [mbar]')
ylabel('Volumetric Flowrate @T=15ºC, P=1 atm')
legend('Measured','Expected from Pressure Measurement');

ax2=subplot(2,1,2);
plot(tt.DeltaP_v,tt.E_rel,'r*');
hold on
errorbar(T_median.DeltaP_v,T_median.E_rel,T_err.E_rel,'ko')
title('Relative difference between expected flowrate and actual flowrate')
xlabel('Pressure difference in the venturi - \DeltaP_{venturi} - [mbar]')
ylabel('Relative Error - [%]')
legend('Raw data','Average point');

linkaxes([ax1 ax2],'x')