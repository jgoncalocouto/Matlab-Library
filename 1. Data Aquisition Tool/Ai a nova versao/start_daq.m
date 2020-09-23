%% DAQ set-up - DRAFT FOR INTERPOLATION OPTION
instrument_database %Load sensors database
handles.daq_setup={
%     'Dev1', 'ai0', 'Voltage','Micromanometer_dpm','dP_tube', 'Analog','x',0,0,0,0
    'cDAQ1Mod1', 'ai7', 'Voltage','Huba_control_401','dP_filter', 'Analog','x',0,0,0,0
    'cDAQ1Mod1', 'ai15', 'Current','Schmidt_10mps_V_N4875','Velocity', 'Analog','x',0,0,0,0
%     'Dev1', 'ai2', 'Voltage','Huba_control_401','Huba_DT6', 'Analog','x',0,0,0,0
%     'Dev1', 'ai3', 'Voltage','Huba_control_401','Huba_DT7', 'Analog','x',0,0,0,0
%     'Dev1', 'ai4', 'Voltage','Huba_control_401','Huba_DT8', 'Analog','x',0,0,0,0
%     'cDAQ2Mod2', 'ctr0', 'Frequency','Starwin','Starwin_DT5', 'Frequency','x',0,0,0,0
%     'cDAQ2Mod2', 'ctr1', 'Frequency','Starwin','Starwin_DT6', 'Frequency','x',0,0,0,0
%     'cDAQ2Mod2', 'ctr2', 'Frequency','Starwin','Starwin_DT7', 'Frequency','x',0,0,0,0
%     'cDAQ2Mod2', 'ctr3', 'Frequency','Starwin','Starwin_DT8', 'Frequency','x',0,0,0,0
%     'cDAQ2Mod4', 'ai0', 'Voltage','Digital_signal','Logical_Signal', 'Analog','x',0,0,0,0
    };
[daq_lines,daq_cols]=size(handles.daq_setup);
for i=1:daq_lines
    handles.daq_setup{i,7}=sensor_database(4).(handles.daq_setup{i,4});
    handles.daq_setup{i,8}=sensor_database(5).(handles.daq_setup{i,4});
    handles.daq_setup{i,9}=sensor_database(6).(handles.daq_setup{i,4});
    handles.daq_setup{i,10}=sensor_database(7).(handles.daq_setup{i,4});
    handles.daq_setup{i,11}=sensor_database(8).(handles.daq_setup{i,4});
end
% Legend:
% Col.1 - Name of DAQ module
% Col.2 - Name of Channel
% Col.3 - Type of Channel
% Col.4 - Sensor Name
% Col.5 - Variable Name
% Col.6 - Type of DAQ Channel (Analog, Frequency, etc)
% Col.7 - Type of transfer function (Linear, Table, etc)
% Col.8 - m of transfer function or array X of table
% Col.9 - b of transfer function or array Y of table
% Col.10 - m of calibration transfer function
% Col.11 - b of calibration transfer function

handles.rate_daq=4 ; %Aquisition rate in [measurements per second]
handles.dat_avai=4 ; %set number of acquisitions per event 'DataAvailable'


%% Session for DAQ and Input Channels
s = daq.createSession('ni');
handles.s=s;    %save session variable in handles structure
guidata(hObject,handles);   %Update handles structure

for j=1:daq_lines
    if string(handles.daq_setup{j,6})=='Analog'
        s.addAnalogInputChannel(handles.daq_setup{j,1},handles.daq_setup{j,2},handles.daq_setup{j,3}); %add all the channels required as per daq_setup
        s.Rate=handles.rate_daq; %set acquisition rate for the session as equal to the chosen in data aquisition module set-up
        s.NotifyWhenDataAvailableExceeds=handles.dat_avai;%set number of acquisitions per event 'DataAvailable' as equal to the chosen in data aquisition module set-up       
    elseif string(handles.daq_setup{j,6})=='Frequency'
        s.addCounterInputChannel(handles.daq_setup{j,1},handles.daq_setup{j,2},handles.daq_setup{j,3}); %add all the channels required as per daq_setup
        s.Rate=handles.rate_daq; %set acquisition rate for the session as equal to the chosen in data aquisition module set-up
        s.NotifyWhenDataAvailableExceeds=handles.dat_avai;%set number of acquisitions per event 'DataAvailable' as equal to the chosen in data aquisition module set-up
    end
end

%% Storage variables and start of daq
store_space=4*3600;
cla reset;% clear plot data
hold on
handles.Time = zeros(store_space,1);
handles.Data = zeros(store_space,size(handles.daq_setup,1));
handles.axes1 = plot(handles.Time,handles.Data);
handles.counter=1;
color_seq={[0 0 1];[1 0 0];[0 1 0];[1 0 1];[0 1 1];[0.929000000000000 0.694000000000000 0.125000000000000];[0.850000000000000 0.325000000000000 0.0980000000000000];[0.494000000000000 0.184000000000000 0.556000000000000];[0 0 0];[0 0.447000000000000 0.741000000000000];[0.301000000000000 0.745000000000000 0.933000000000000];[0.635000000000000 0.0780000000000000 0.184000000000000];[0.466000000000000 0.674000000000000 0.188000000000000];[1 1 0]};
Leg=cell(size(handles.daq_setup,1),1);
for i=1:size(handles.daq_setup,1)
    handles.axes1(i).XDataSource = 'handles.Time(1:handles.counter+handles.dat_avai-1)';
    handles.axes1(i).YDataSource = ['handles.Data(1:handles.counter+handles.dat_avai-1,',num2str(i),')'];
    set(handles.axes1(i),{'color'},color_seq(i))
    Leg(i)=handles.daq_setup(i,5);
end
legend(Leg,'Location','eastoutside');
s.IsContinuous = true;
guidata(hObject, handles);   %Update handles structure
t_absolute_initial=datetime(now,'ConvertFrom','datenum');
lh = addlistener(handles.s,'DataAvailable', @(src, event)saveandplot(src,event,hObject,eventdata));
title('Continuous Data Aquisition')
ylabel('Pressure - [mbar]')
xlabel('Elapsed time - t - [s]')
s.startBackground()
while s.IsRunning
    pause(0.5);
end

%% Save data and clear variables
handles = guidata(hObject); %Load handles struct
delete(lh)
Time_abs=t_absolute_initial+seconds(handles.Time(1:handles.counter-1));
Time=handles.Time(1:handles.counter-1);
Data=handles.Data(1:handles.counter-1,:);

TableData=array2timetable(Data,'RowTimes',Time_abs);
TableData.Properties.VariableNames=handles.daq_setup(:,5)';

% t=array2table([Time_abs,Data]);
% t.Properties.VariableNames=['Time';handles.daq_setup(:,5)]';

save log.mat Data Time Time_abs TableData

Export_data='Yes';
if strcmp(Export_data,'Yes')==1
    filepath='O:\TTM-Projects\9305 Compact4 KME\10_testing\A_laboratory\59 - Pressure Sensor Evaluation\4. Tests\2. Robustness\R.7_Drop Test\Raw\';
    filename='Droptest_5-8_h800';
    writetable(timetable2table(TableData),horzcat(filepath,filename,'.xls'))
%     
%     DataSum=[['Time';handles.daq_setup(:,5)]';num2cell([Time,Data])];
%     xlswrite(horzcat(filepath,filename,'.xls'),DataSum,'Sheet1','A1');
%     disp('Data Saved')
end
%Clear global variables for next DAQ log
clear all global