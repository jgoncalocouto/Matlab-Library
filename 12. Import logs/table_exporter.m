function [] = table_exporter(table2export,varargin)
%table_exporter: Export a table or timetable to a specified log file type (.csv/.txt/.xlsx)
%   Additional tools:
%   1. Hability to export from path address instead of pop-up menu: table_exporter("path","<actual path>")
%   2. Hability to export with different file extensions uppon choosing (default=.xls)
%   3. Hability to save with costum name or use a date-based name (default)

    if strcmp(class(table2export),'timetable')==1
        table2export=timetable2table(table2export);
    elseif strcmp(class(table2export),'double')==1
        table2export=table(table2export);
    end


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
        elseif strcmp(varargin{i},'extension')
            extension=varargin{i+1};
            extension_available=1;
        end
    end
end


if extension_available==1
else
    extension='.xls';
end

if filename_available==1
    file_identifier=horzcat(filename,extension);
    file_identifier_available=1;
elseif name_available==1
    date=datestr(now);
    datename=horzcat(date(1:2),'_',date(4:6),'_',date(8:11),'.',date(13:14),'_',date(16:17),'_',date(19:20));
    file_identifier=horzcat(datename,name,extension);
    file_identifier_available=1;
else
    date=datestr(now);
    datename=horzcat(date(1:2),'_',date(4:6),'_',date(8:11),'.',date(13:14),'_',date(16:17),'_',date(19:20));
    file_identifier=horzcat(datename,'test_data',extension);
    file_identifier_available=1;
end


try
    writetable(table2export,horzcat(path_address,file_identifier));% Exporting file
catch
    warning('Problem with path definition. Pop-up menu launched for selection');
    path_available = 0;
end

if path_available==0
    % Export file
[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',[file_identifier]);
if FileNameBodeWrite ~=0
    if exist([PathNameBodeWrite FileNameBodeWrite],'file')
        delete([PathNameLachWrite FileNameBodeWrite ]);
    end
    
    if strcmp(class(table2export),'timetable')==1
        table2export=timetable2table(table2export);
    elseif strcmp(class(table2export),'double')==1
        table2export=table(table2export);
    end

      writetable(table2export,[PathNameBodeWrite datename FileNameBodeWrite ])  % Exporting file
end


end
