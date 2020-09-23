%% Inputs:

% Input-based calculations

if str2double(capacity)==11
    N_inj=15;
elseif str2double(capacity)==14
    N_inj=18;
elseif str2double(capacity)==17
    N_inj=24;
end

D_duct=80*10^-3; %[m]
P_atm=P_altitude(h).*100; %[Pa]
D_inj=Injector_marking/100; %[mm]

Patm=P_atm./100;
rho_air=densityz('Air',T_air,Patm);
rho_gas=densityz(Gastype,T_gas,Patm);
rho_exg=rho_air;
AFR=afr(Gastype,'vol');

%% Import File
% Import file with procom data


[A,A_txt] = xlsread(filename1);% Importing file
[Log] = Procom_load_equivalence(A, capacity);

%% Create vector with absolute time from the file date and time stamps

%Get file date
FileInfo = dir(horzcat(open_path1,open_name1));
File_creation_time = FileInfo.date;
File_creation_time=datetime(datenum(File_creation_time,'dd-mmm-yyyy HH:MM:SS'),'ConvertFrom','datenum');

%Get initial absolute time from .csv
t_absinprocom=split(A_txt(23,2));
t_absinprocom_time=t_absinprocom(2,1);
t_absinprocom_aux=char(t_absinprocom(3,1));

%Build t_absolute vector
aux=0;
for i=1:length(t_absinprocom_aux)
    if isempty(str2num(t_absinprocom_aux(i)))==0
        t_absinprocom_ms(i)=str2num(t_absinprocom_aux(i));
        aux=t_absinprocom_ms(i).*10.^(3-i)+aux;
    end
    
end
t_absinprocom_timedetail=char(strcat(t_absinprocom_time,':',num2str(aux))); %initial time of procom log start in format 'HH:MM:SS:FFF'
t_initial_procom=datenum(t_absinprocom_timedetail,'HH:MM:SS:FFF'); %initial time of procom log start in absolute time
time_inital_procom=datestr(t_initial_procom,'dd-mmm-yyyy HH:MM:SS:FFF');
i=0;
for i=1:length(Log.t_absolute)
    Log.t_absolute(i)=t_initial_procom+datenum(seconds(Log.t_relative(i)));
end

% Assign file date to t_absolute vector
t=datetime(Log.t_absolute,'ConvertFrom','datenum');
t.Year=File_creation_time.Year;
t.Month=File_creation_time.Month;
t.Day=File_creation_time.Day;

%% Agreggate Array

Aggregate=Log;
Aggregate.t_absolute=t;
Aggregate=struct2table(Aggregate);
Aggregate=table2timetable(Aggregate);

[l_atxt,c_atxt]=size(A_txt);

i=0;
for i=23:l_atxt
    if isempty(A_txt{i,11})~=1
        Aggregate.Error(i-22)=hex2dec(A_txt{i,11});
    end
end


%% Analyse procom_data having SW into consideration
universal_procom_sw_analysis


