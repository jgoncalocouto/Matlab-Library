%% PROCOM Load
%% Inputs:
Gastype_parameter='NG'
capacity='11'


%% Import file
[open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
filename1 = strcat(open_path1,open_name1);

[A,A_txt] = xlsread(filename1);% Importing file
[Log] = FT_logger(A, capacity);
profile on
tic
%% Create vector with absolute time from the file date and time stamps

datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss.SSS')
% Get file date
FileInfo = dir(horzcat(open_path1,open_name1));
File_creation_time = FileInfo.date;
File_creation_time=datetime(datenum(File_creation_time,'dd-mmm-yyyy HH:MM:SS'),'ConvertFrom','datenum');

% Get initial absolute time from .csv
t_initial_procom=File_creation_time;

% for i=1:length(Log.t_absolute)
%     Log.t_absolute(i)=datenum(t_initial_procom)+datenum(seconds(Log.t_relative(i)));
% end

 Log.t_absolute=datenum(t_initial_procom)+datenum(seconds(Log.t_relative));

% Assign file date to t_absolute vector
t=datetime(Log.t_absolute,'ConvertFrom','datenum');

%% Agreggate Array

Aggregate=Log;
Aggregate.t_absolute=t;
Aggregate=struct2table(Aggregate);
Aggregate=table2timetable(Aggregate);
%% Analyse procom_data having SW into consideration
universal_procom_sw_analysis

%% Graphs

universal_plots
toc
%% Export .xls file with procom analysis

%Window that asks where you want to save the file
[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',['Procom_analysis' '.xls']);
if FileNameBodeWrite ~=0
    if exist([PathNameBodeWrite FileNameBodeWrite],'file')
        delete([PathNameLachWrite FileNameBodeWrite ]);
    end
    writetable(timetable2table(Aggregate),[PathNameBodeWrite FileNameBodeWrite ])  %table
    
end

profile viewer
