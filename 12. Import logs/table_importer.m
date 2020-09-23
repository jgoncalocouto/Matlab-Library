function [imported_table] = table_importer(varargin)
%table_exporter: Export a table or timetable to a specified log file type (.csv/.txt/.xlsx)
%   Additional tools:
%   1. Hability to export from path address instead of pop-up menu: table_exporter("path","<actual path>")
%   2. Hability to export with different file extensions uppon choosing (default=.xls)
%   3. Hability to save with costum name or use a date-based name (default)



path_available=0;
filename_available=0;
name_available=0;
extension_available=0;

if nargin>0
    for i=1:size(varargin,2)
        if strcmp(varargin{i},'path')==1
            path_address=varargin{i+1};
            path_available=1;
        elseif strcmp(varargin{i},'filename')
            filename=varargin{i+1};
            filename_available=1;
        elseif strcmp(varargin{i},'name')
            name=varargin{i+1};
            name_available=1;
    end
    end
end


if filename_available==1
    file_identifier=horzcat(filename);
    file_identifier_available=1;
elseif name_available==1
    date=datestr(now);
    datename=horzcat(date(1:2),'_',date(4:6),'_',date(8:11),'.',date(13:14),'_',date(16:17),'_',date(19:20));
    file_identifier=horzcat(datename,name);
    file_identifier_available=1;
else
    date=datestr(now);
    datename=horzcat(date(1:2),'_',date(4:6),'_',date(8:11),'.',date(13:14),'_',date(16:17),'_',date(19:20));
    file_identifier=horzcat(datename,'test_data');
    file_identifier_available=1;
end


try
    imported_table=readtable(horzcat(path_address,file_identifier));% Importing table
catch
    warning('Problem with path definition. Pop-up menu launched for selection');
    path_available = 0;
end

if path_available==0
    
    [open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
        'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
    filename = strcat(open_path1,open_name1);
    imported_table = readtable(filename);% Importing file
end


end
