%% Log vector initialization

log{1,1}='Exhaust Gas Flow Rate - [slpm]';
log{1,2}='Gas Valve Current - [mA]';
log{1,3}='Fan Speed - [RPM]';
log{1,4}='Fan Voltage - [%]';
log{1,5}='Pressure difference in the venturi: PROCOM - [mbar]';
log{1,6}='Pressure difference in the venturi: HUBA - [mbar]';
log{1,7}='Ionisation Current - [\mu A]';
log{1,8}='Burner Pressure - [mbar]';
log{1,9}='CO2 in the ductwork - [%]';
log{1,10}='CO in the ductwork - [ppm]';
log{1,11}='Thermal Efficiency - [%]';
log{1,12}='Water Flow Rate - [l/min]';
log{1,13}='Inlet Water Temperature - [ºC]';
log{1,14}='Outlet Water Temperature - [ºC]';
log{1,15}='Venturi Temperature - [ºC]';
log{1,16}='Measured Flowrate - [slpm]';



log_std{1,1}='Exhaust Gas Flow Rate - [slpm]';
log_std{1,2}='Gas Valve Current - [mA]';
log_std{1,3}='Fan Speed - [RPM]';
log_std{1,4}='Fan Voltage - [%]';
log_std{1,5}='Pressure difference in the venturi: PROCOM - [mA]';
log_std{1,6}='Pressure difference in the venturi: HUBA - [mA]';
log_std{1,7}='Ionisation Current - [\mu A]';
log_std{1,8}='Burner Pressure - [mbar]';
log_std{1,9}='CO2 in the ductwork - [%]';
log_std{1,10}='CO in the ductwork - [ppm]';
log_std{1,11}='Thermal Efficiency - [%]';
log_std{1,12}='Water Flow Rate - [l/min]';
log_std{1,13}='Inlet Water Temperature - [ºC]';
log_std{1,14}='Outlet Water Temperature - [ºC]';
log_std{1,15}='Venturi Temperature - [ºC]';
log_std{1,16}='Measured Flowrate - [slpm]';



%% 

t_daq=0.25;
port='COM20';

s = serial(port);
set(s,'BaudRate',9600);
s.Timeout=10*60;
s.InputBufferSize=10^5;
fopen(s);


prompt = {'Enter variable value'};
dlgtitle = 'Fan Duty';
dims = [1 50];
definput = {'400'};
var2=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));


%% Procom daq script inputs






prompt = {'Enter value'};
dlgtitle ='Fan RPM';
dims = [1 50];
definput = {'0'};
flowrate_command=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));

script_input='intruction_script_roto';
Procom_daq_roto %run procom daq

i=size(log,1);
i=i+1;

%%

log{i,1}=mean(data.Vdot_air_actual(k-40:k));
log{i,2}=mean(data.I_gv(k-40:k));
log{i,3}=mean(data.N_fan(k-40:k));
log{i,4}=mean(data.V_fan(k-40:k));
log{i,5}=mean(data.P_box(k-40:k));

prompt = {'Enter average value'};
dlgtitle = 'P_ref: Input pressure difference value';
dims = [1 50];
definput = {'0'};
log{i,6}=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));

prompt = {'Enter standard deviation value'};
dlgtitle = 'P_ref: Input pressure difference value';
dims = [1 50];
definput = {'0'};
log_std{i,6}=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));


log{i,7}=mean(data.I_ion(k-40:k));

prompt = {'Enter average value'};
dlgtitle = 'Burner Pressure';
dims = [1 50];
definput = {'0'};
log{i,8}=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));

prompt = {'Enter average value'};
dlgtitle = 'CO2 in the ductwork - [%]';
dims = [1 50];
definput = {'0'};
log{i,9}=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));

prompt = {'Enter average value'};
dlgtitle ='CO in the ductwork - [ppm]';
dims = [1 50];
definput = {'0'};
log{i,10}=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));


log{i,11}=0;

log{i,12}=mean(data.Vdot_w(k-40:k));
log{i,13}=mean(data.T_win(k-40:k));
log{i,14}=mean(data.T_wmix(k-40:k));

prompt = {'Enter average value'};
dlgtitle ='Venturi Temperature - [ºC]';
dims = [1 50];
definput = {'0'};
log{i,15}=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));

log{i,16}=sqrt(log{i,6}*(1/(273.15+log{i,15})))*11809;


log_std{i,1}=std(data.Vdot_air_actual(k-40:k));

log_std{i,2}=std(data.I_gv(k-40:k));
log_std{i,3}=std(data.N_fan(k-40:k));
log_std{i,4}=std(data.V_fan(k-40:k));
log_std{i,5}=std(data.P_box(k-40:k));
log_std{i,6}=0;
log_std{i,7}=std(data.I_ion(k-40:k));
log_std{i,8}=0;
log_std{i,9}=0;
log_std{i,10}=0;
log_std{i,11}=0;
log_std{i,12}=std(data.Vdot_w(k-40:k));
log_std{i,13}=std(data.T_win(k-40:k));
log_std{i,14}=std(data.T_wmix(k-40:k));
log_std{i,15}=0;
log_std{i,16}=0;






