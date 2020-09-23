%% Inputs

appliance.capacity='14';
appliance.gas_type='NG';
criteria=85;

%% Import
[tt_procom] = procom_importer(appliance.capacity);


%% Calc
m = movmax(tt_procom.Vdot_w,[seconds(10) 0],'SamplePoints',tt_procom.t_absolute);

burner_off=zeros(size(tt_procom,1),1);
T_predicted=zeros(size(tt_procom,1),1);
for i=1:size(tt_procom,1)
    T_sp=tt_procom.T_wsp(i);
    T_win=tt_procom.T_win(i);
    T_wout=tt_procom.T_wout(i);
    [burner_off(i),T_predicted(i)] = burner_off_predictor_simplified(criteria,appliance,m(i),tt_procom.Vdot_w(i),T_win,T_sp,T_wout);
end

burner_off(tt_procom.Vdot_w==0)=0;
T_predicted(tt_procom.Vdot_w==0)=0;

%% Plots

figure
sp1=subplot(2,1,1);
plot(tt_procom.t_relative,tt_procom.T_wout)
xlabel('Relative Time - t - [s]')
ylabel('Temperature - T - [ºC]')
hold on
plot(tt_procom.t_relative,tt_procom.T_wsp)
plot(tt_procom.t_relative,tt_procom.T_amb)
yline(criteria,'r-')
plot(tt_procom.t_relative,T_predicted)
plot(tt_procom.t_relative,tt_procom.T_win)
legend('Outlet Water Temperature','Set-point','Outlet Water Temperature - Predicted by control','Outlet Water Temperature - Peaks Prediction Strategy','Inlet Water Temperature - [ºC]')

sp2=subplot(2,1,2);
plot(tt_procom.t_relative,tt_procom.Vdot_w)
hold on
xlabel('Relative Time - t - [s]')
ylabel('Water Flowrate - [l/min]')
plot(tt_procom.t_relative,m)
yyaxis right
ylabel('Ionisation Current - [\muA]')
plot(tt_procom.t_relative,tt_procom.I_ion)
legend('Water Flowrate','Water Flowrate - Maximum of last 10s','Ionisation Current - [\muA]')

linkaxes([sp1 sp2],'x') 