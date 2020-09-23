%% Data Aquisition Tool
% This script intends to fullfill the need for a flexible data aquisition
% tool connected directly to matlab. The tool includes a sensor database
% and the option to calibrate the transfer function of such sensors. Other
% editable parameters include the time for data aquisition, and the
% aquisition rate.

%% Sensor database
% This section includes all the sensors that can be used in DAQ session
% using this script.
% Example of Transfer function [mbar]  =m*[V] + b
sensor_database={
    'FAFE_Patm','Absolute Pressure','[V]','[mbar]',80,800,0.01
    'FAFE_Pbox','Relative Pressure','[mA]','[mbar]',625,-2.5,0.01
    'Micromanometer_dpm','Relative Pressure','[V]','[mbar]',2,0,0.01
    'Ultramat23_CO_MR1','CO','[mA]','[ppm]',31250,-125,0.01
    'Ultramat23_CO_MR2','CO','[mA]','[ppm]',156250,-625,0.01
    'Ultramat23_CO2_MR1','CO2','[mA]','[%]',312.5,-1.25,0.01
    'Ultramat23_CO2_MR2','CO2','[mA]','[%]',1562.5,-6.25,0.01
    'Yokogawa_50_N2685','Relative Pressure', '[V]','[mbar]',187.5,-15,0
    'Yokogawa_50_N2686','Relative Pressure', '[V]','[mbar]',187.5,-15,0
    'Schmidt_10mps_T_N4875','Temperature','[mA]','[ºC]', 8750,-55,0
    'Schmidt_10mps_V_N4875','Velocity','[mA]','[m/s]', 625,-2.5,0
    'Digital_signal','Logical','[V]','[-]',0.2,0,0
    'Yokogawa_20_N2715','Relative Pressure', '[V]','[mbar]',-68.75,-5.5,0
    'Yokogawa_20_N2714','Relative Pressure', '[V]','[mbar]',-68.75,-5.5,0
    'Huba_control_401', 'Relative Pressure', '[V]','[mbar]',1.25,-0.625,0
    'Starwin_frequency', 'Frequency', '[Hz]','[Hz]',1,0,0
    'FAN_FIME_RPM','Frequency','[Hz]','[rpm]',5,0,0
    };
% Legend:
% Col.1 - Sensor name
% Col.2 - Measured variable
% Col.3 - Output Signal variable and units
% Col.4 - Units of measured variable
% Col.5 - m of transfer function
% Col.6 - b of transfer function
% Col.7 - Relative Uncertainty of sensor



%% Calibration
% This section allows the correction of the sensor transfer function based
% on the application of calibration transfer function:
% Example for a corrected current analog input:
% I_{corrected} = I_{measured} * m + b
% Warning: Every sensor must have a calibration curve, even if it is just m=1,b=0;

calibration_database={
    'FAFE_Patm','Absolute Pressure','[V]','[mbar]',1,0,0
    'FAFE_Pbox','Relative Pressure','[mA]','[mbar]',1,0,0
    'Micromanometer_dpm','Relative Pressure','[V]','[mbar]',1,0,0
    'Ultramat23_CO_MR1','CO','[mA]','[ppm]',1.000625391,3.7523E-05,0
    'Ultramat23_CO_MR2','CO','[mA]','[ppm]',1.000625391,3.7523E-05,0
    'Ultramat23_CO2_MR1','CO2','[mA]','[%]',1.001878522,1.25235E-05,0
    'Ultramat23_CO2_MR2','CO2','[mA]','[%]',1.001878522,1.25235E-05,0
    'Yokogawa_50_N2685','Relative Pressure', '[mA]','[mbar]',1,0,0
    'Yokogawa_50_N2686','Relative Pressure', '[mA]','[mbar]',1,0,0
    'Schmidt_10mps_T_N4875','Temperature','[mA]','[ºC]', 1,0,0
    'Schmidt_10mps_V_N4875','Velocity','[mA]','[m/s]', 1,0,0
    'Digital_signal','Logical','[V]','[-]',1,0,0
    'Yokogawa_20_N2715','Relative Pressure', '[V]','[mbar]',1,0,0
    'Yokogawa_20_N2714','Relative Pressure', '[V]','[mbar]',1,0,0
    'Huba_control_401', 'Relative Pressure', '[V]','[mbar]',1,0,0
    'Starwin_frequency', 'Frequency', '[Hz]','[Hz]',1,0,0
    'FAN_FIME_RPM','Frequency','[Hz]','[rpm]',1,0,0
    };

% Legend:
% Col.1 - Sensor name
% Col.2 - Measured variable
% Col.3 - Output Signal variable and units
% Col.4 - Units of measured variable
% Col.5 - m of transfer function
% Col.6 - b of transfer function
% Col.7 - Unused

%% Data aquisition module (DAQ) set-up
daq_setup={
%     'Dev1','ai0','Voltage','Micromanometer_dpm','P_ref', 'Analog'
%     'Dev1','ai1','Voltage','Huba_control_401','Huba_Press_S27', 'Analog'
%     'Dev1','ai2','Voltage','Huba_control_401','Huba_Press_C05', 'Analog'
%     'Dev1','ai3','Voltage','Huba_control_401','Huba_Press_C03', 'Analog'
%     'Dev1','ai4','Voltage','Huba_control_401','Huba_Press_C04', 'Analog'
%     'Dev1','ai5','Voltage','Digital_signal','Logical_Signal', 'Analog'
    'cDAQ2Mod2','ctr0','Frequency','Starwin_frequency','Starwin_Freq_S13', 'Frequency'
    'cDAQ2Mod2','ctr1','Frequency','Starwin_frequency','Starwin_Freq_S14', 'Frequency'
    'cDAQ2Mod2','ctr2','Frequency','Starwin_frequency','Starwin_Freq_S15', 'Frequency'
    'cDAQ2Mod2','ctr3','Frequency','Starwin_frequency','Starwin_Freq_S16', 'Frequency'
    };

% Legend:
% Col.1 - Name of DAQ module
% Col.2 - Name of Channel
% Col.3 - Type of Channel
% Col.4 - Sensor Name
% Col.5 - Variable Name
% Col.6 - Type of DAQ Channel (Analog, Frequency, etc)

t_daq=5; %Aquisition time in [seconds]
rate_daq=4 ; %Aquisition rate in [measurements per second]


%% Struct Creation
%Code to create struct that will store each measured variable's name, t[[s}] and measured variable in specific units
[daq_lines,daq_cols]=size(daq_setup);
C=cell(daq_lines,2);
for i=1:daq_lines
    C{i,1}=daq_setup{i,5};
    C{i,2}=ones(1,t_daq.*rate_daq);
end
Ct=C';
data_daq=struct(Ct{:});

%%  DAQ data treatment
% Code to add daq channels, start data aquisition and store it in struct

sensor_pos=zeros(daq_lines,2); % creates an empty matrix that will allocate the position of the range of selected sensors in the sensor database
data_sens=zeros(daq_lines,t_daq.*rate_daq); %creates an empty matrix that will allocate the variables measured per channel for the correspondent daq time
Aux_matrix=zeros(daq_lines+1,t_daq.*rate_daq); %Aux matrix useful to struct variables assignment
devices=daq.getDevices; %create a list of daq devices
s=daq.createSession('ni'); %initiate measurement session

for j=1:daq_lines
    if string(daq_setup{j,6})=='Analog'
        s.addAnalogInputChannel(daq_setup{j,1},daq_setup{j,2},daq_setup{j,3}); %add all the channels required as per daq_setup
        s.Rate=rate_daq; %set aquisition rate for the session as equal to the chosen in data aquisition module set-up
        s.DurationInSeconds=t_daq; %set daq duration for the session as equal to the chosen in data aquisition module set-up
        [sensor_pos(j,1),sensor_pos(j,2)]=ind2sub(size(sensor_database),find(strcmp(sensor_database,daq_setup{j,4}))); %updates the matriz with the position of the range of selected sensors in the sensor database
    elseif string(daq_setup{j,6})=='Frequency'
        s.addCounterInputChannel(daq_setup{j,1},daq_setup{j,2},daq_setup{j,3}); %add all the channels required as per daq_setup
        s.Rate=rate_daq; %set aquisition rate for the session as equal to the chosen in data aquisition module set-up
        s.DurationInSeconds=t_daq; %set daq duration for the session as equal to the chosen in data aquisition module set-up
        [sensor_pos(j,1),sensor_pos(j,2)]=ind2sub(size(sensor_database),find(strcmp(sensor_database,daq_setup{j,4}))); %updates the matriz with the position of the range of selected sensors in the sensor database
    end
end


s.addAnalogInputChannel('cDAQ2Mod4','ai0','Current');

disp('Start of Acquisition')
[data,time,triggertime]=s.startForeground(); %time produces a matriz (1 x t_daq) with the time of aquisition and data produces a matriz with (daq_lines x t_daq) with the output signals from the channels used

Aux_matrix(1,:)=time;  %Aux_matrix stores the time vector (1st line) + a vector per variable measured (additional lines until t_daq+1 line)
data_t=transpose(data);
for k=1:daq_lines
    data_sens(k,:)=(data_t(k,:).*calibration_database{sensor_pos(k,1),5}+calibration_database{sensor_pos(k,1),6}).*sensor_database{sensor_pos(k,1),5}+sensor_database{sensor_pos(k,1),6}; %Multiplication of measured signal with sensor's characteristic curve
    Aux_matrix(k+1,:)=data_sens(k,:); %store measured variable's data in Aux_matrix
    data_daq.(daq_setup{k,5})=transpose(Aux_matrix(k+1,:)); %Store measured variable's data in a struct with all the variables measured. Each variable's measured data is place in the field value correpondent to each variable's fieldname
end

date_start=datestr(datenum(triggertime),'dd-mmm-yyyy HH:MM:SS.FFF'); %Start date of the aquisition session

system_time=string(ones(length(time),1)); %Create a vector of ones that will allocate the date's correspondent to which measured variable point
for w=1: length(time)
    system_time(w,1)=string(datestr(triggertime+w.*seconds(1./rate_daq),'dd-mmm-yyyy HH:MM:SS.FFF')); %Store each measured point date in a vector - System Time
end


data_daq.('time')=time
data_daq.('system_time')=system_time

% Outputs:
% time - Vector with the relative time for the complete daq measurement session - integer
% system_time -  Vector with the system data for each measured point - string
% data_daq - Struct with the measured variables, each field is a different variable. FieldName= Variable Name; FieldValue= Vector with measured data

    %% Virtual Channels - Auxilary variables
    % This section allows the definition of auxiliary variables which, even
    % though are not directly measured, can be inferred from the measurement of
    % other variables. Ex: Gas Flow Rate calculation from a measured Burner
    % Pressure

    T_air=5;
    KME_SW;

    data_daq.Starwin_Press_S13=interp1(Starwin_characteristic(:,1),Starwin_characteristic(:,2),data_daq.Starwin_Freq_S13,'linear','extrap');
    data_daq.Starwin_Press_S14=interp1(Starwin_characteristic(:,1),Starwin_characteristic(:,2),data_daq.Starwin_Freq_S14,'linear','extrap');
    data_daq.Starwin_Press_S15=interp1(Starwin_characteristic(:,1),Starwin_characteristic(:,2),data_daq.Starwin_Freq_S15,'linear','extrap');
    data_daq.Starwin_Press_S16=interp1(Starwin_characteristic(:,1),Starwin_characteristic(:,2),data_daq.Starwin_Freq_S16,'linear','extrap');




%% Plot DAQ data
% Code to create a figure per measured varible and plot the measured data
F_1=fieldnames(data_daq);
for w=1:length(fieldnames(data_daq))
    if strcmp(F_1{w},'time')==1 || strcmp(F_1{w},'system_time')
    else
        figure
        plot(time,data_daq.(F_1{w}))
        grid on
        xlabel('Elapsed time [s]')
        ylabel(F_1{w});
        s.release()
    end
end

%% Export data to xls

Export_data='No'

if strcmp(Export_data,'Yes')==1
    
    F_2=F_1;
    
    i=0;
    j=0;
    A=zeros(length(time),length(data_daq));
    for i=1:length(F_2)
        if strcmp(F_1{i},'system_time')==1
            F_2{1}='system_time';
            A(:,1)=data_daq.system_time;
            j=j+1;
        elseif strcmp(F_1{i},'time')==1
            F_2{2}='time';
            A(:,2)=data_daq.time;
            j=j+1;
        else
            F_2{i+2-j}=F_1{i};
            A(:,i+2-j)=data_daq.(F_1{i});
        end
    end

    
    C_titles=transpose(F_2);
    C_data=cell(1);
    C_data{1}=A;
    C_systemtime=cell(length(system_time),1);
    
    i=0;
    for i=1:length(system_time)
        C_systemtime{i,1}=char(system_time(i,1));
    end
    
    filepath='C:\Users\BTJ1AV\Desktop\DAQ\';
    filename='Test_without';
    
    xlswrite(horzcat(filepath,filename,'.xls'),C_titles,'Sheet1','A1')
    xlswrite(horzcat(filepath,filename,'.xls'),C_data{1},'Sheet1','A2')
    xlswrite(horzcat(filepath,filename,'.xls'),C_systemtime,'Sheet1','A2')
    
end




