%% Import timetables from .txt files

%% Import file

%Pop-up
[open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv;*.txt',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv,*.txt)'});

filename1 = strcat(open_path1,open_name1);
log=readtable(filename1,'Delimiter',',');
log.t_absolute=datetime(log.t_absolute);
log=table2timetable(log);
