function [tt_pico] = pico_importer(varargin)
%pico_importer Create a timetable with data from pico logger - new version
%   Additional tools:
%   1. Hability to import from path addred instead of pop-up menu: pico_importer("path","<actual path>")
%   2. Hability to change the channel names: pico_importer("channel naming","<cell with channel names one element for each column>")

path_available=0;
naming_available=0;
convert2num=0;
if nargin>0
    for i=1:size(varargin,2)
        if strcmp(varargin{i},'path')==1
            filename=varargin{i+1};
            path_available=1;
        elseif strcmp(varargin{i},'channel naming')==1
            channel_names=varargin{i+1};
            naming_available=1;
        elseif strcmp(varargin{i},'str2num')==1
            convert2num=1;
        end
    end
end



try
    Pico = readtable(filename);% Importing file
catch
    warning('Problem with path definition. Pop-up menu launched for selection');
    path_available = 0;
end

if path_available==0
    % Import file
    [open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
        'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
    filename = strcat(open_path1,open_name1);
    Pico = readtable(filename);% Importing file
end



varnames=Pico.Properties.VariableNames;
Pico.(varnames{1})=datenum(Pico.(varnames{1}),'yyyy-mm-ddTHH:MM:SS');
Pico.(varnames{1})=datetime(Pico.(varnames{1}),'ConvertFrom','datenum');
Pico.Properties.VariableNames{varnames{1}} = 't_absolute';


for i=2:size(varnames,2)
    if convert2num==1
        Pico.(varnames{i})=char(Pico.(varnames{i}));
        Pico.(varnames{i})=str2num(Pico.(varnames{i}));
    end
end

if naming_available==1
    try
        for i=2:size(varnames,2)
            Pico.Properties.VariableNames{varnames{i}}=char(channel_names{i-1});
        end
    catch
        warning('Problem with channel names list. Names for the complete set of channels must be provided');
        for i=2:size(varnames,2)
            Pico.Properties.VariableNames{varnames{i}}=horzcat('T_',num2str(i-1));
        end
    end
else
    for i=2:size(varnames,2)
        Pico.Properties.VariableNames{varnames{i}}=horzcat('T_',num2str(i-1));
    end
end

tt_pico=table2timetable(Pico);
end
