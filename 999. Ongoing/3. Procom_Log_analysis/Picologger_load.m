%% Picologger load

[open_name, open_path] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
filename = strcat(open_path,open_name);

B = xlsread(filename);% Importing file

Pico.t_absolute=datestr(B(:,1),'HH:MM:SS:FFF');
Pico.T_venturimeas=B(:,2);