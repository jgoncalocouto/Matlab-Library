function [tt_procom] = procom_importer(capacity,varargin)
%procom_importer Create a timetable with data from procom log for C4 KME
%   Function to compute the SW-related variables (C4 KME) together with the sensor
%   variables imported directly from procom logging system and produce a
%   timetable with the synchronized data


if nargin>1
    if strcmp(varargin{1},'path')==1
        filename1=varargin{2};
    else
        error('Path option must be selected in the following way: procom_importer(gastype_parameter,capacity,"path","<actual path>")')
    end
else
    % Import file
    [open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
        'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
    filename1 = strcat(open_path1,open_name1);
end

[A,A_txt] = xlsread(filename1);% Importing file
[Log] = Procom_load_equivalence(A, capacity);

% Create vector with absolute time from the file date and time stamps
datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss.SSS')
%Get file date
FileInfo = dir(filename1);
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

i=0;
for i=1:length(Log.t_absolute)
    Log.t_absolute(i)=t_initial_procom+datenum(seconds(Log.t_relative(i)));
end

Aggregate=Log;
Aggregate.t_absolute=t;
Aggregate=struct2table(Aggregate);
Aggregate=table2timetable(Aggregate);

tt_procom=Aggregate;

end

