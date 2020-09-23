function [tt_evodaq] = evodaq_importer(varargin)
%evodaq_importer Create a timetable with data from pico logger - new version
%   Additional tools:
%   1. Hability to import from path addred instead of pop-up menu: evodaq_importer("path","<actual path>")
%   2. Hability to change the channel names: evodaq_importer("channel naming","<cell with channel names one element for each column>")

path_available=0;
naming_available=0;
if nargin>0
    for i=1:size(varargin,2)
        if strcmp(varargin{i},'path')==1
            filename=varargin{i+1};
            path_available=1;
        elseif strcmp(varargin{i},'channel naming')==1
            channel_names=varargin{i+1};
            naming_available=1;
        end
    end
end



try
    evodaq = readtable(filename,'Sheet','log');% Importing file
catch
    warning('Problem with path definition. Pop-up menu launched for selection');
    path_available = 0;
end

if path_available==0
    % Import file
    [open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
        'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'},'Select an Evodaq file');
    filename = strcat(open_path1,open_name1);
end

evodaq = readtable(filename,'Sheet','log');% Importing file


evodaq.Properties.VariableNames{'TimeStamp_Absolute'} = 't_absolute';
evodaq.Properties.VariableNames{'TimeStamp_Relative'} = 't_relative';
varnames=evodaq.Properties.VariableNames;


evodaq=table2timetable(evodaq);

try
    for i=3:size(varnames,2)
        evodaq.Properties.VariableNames{varnames{i}}=char(channel_names{i-2});
    end
catch
    warning('Problem with channel names list. Names for the complete set of channels must be provided');
    naming_available = 0;
end

tt_evodaq=evodaq;
end
