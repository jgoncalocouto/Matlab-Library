% Auto-generated by Data Acquisition Toolbox Analog Input Recorder on 01-Mar-2019 16:28:41

%% Create Data Acquisition Session
% Create a session for the specified vendor.
s = daq.createSession('ni');

%% Set Session Properties
% Set properties that are not using default values.
s.DurationInSeconds = 20;

%% Add Channels to Session
% Add channels and set channel properties, if any.
addAnalogInputChannel(s,'Dev1','ai0','Voltage');

%% Acquire Data
% Start the session in foreground.
[data, timestamps, starttime] = startForeground(s);

%% Log Data
% Convert the acquired data and timestamps to a timetable in a workspace variable.
DeltaP = data(:,1).*2;
DAQ_3 = timetable(seconds(timestamps),DeltaP);

%% Plot Data
% Plot the acquired data on labeled axes.
plot(DAQ_3.Time, DAQ_3.Variables)
xlabel('Time')
ylabel('Delta_P')
legend(DAQ_3.Properties.VariableNames)

%% Clean Up
% Clear the session and channels, if any.
clear s

