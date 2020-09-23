function [parameter] = procom_read(port,message_id,command,var1)
%PROCOM_READ Get a specific ADDRESS or PARAMETER value from a defined Serial port
%   Inputs:
%       port - Serial communication port that contains the conection with the appliance
%       message_id - Arbitrary message identification
%       command - 'ADDRESS' or 'PARAMETER'
%       var1 - Depending on the value of command variable: If command='ADDRESS' then var1=<ADDRESS CODE>; If command='PARAMETER' then var1=<PARAMETER NAME>

%% Start-up Routine
datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss:SSS') %Sets resolution to ms in the data table
instrreset %deletes all instrument objects

%% Message_write_and_read

s = serial(port);
[message]=procom_write(horzcat('READ_',command),message_id,var1,1);
set(s,'BaudRate',9600);

s.InputBufferSize=10^5;
s.Timeout=2 ;

t_initial=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');
parameter=0;
fopen(s);
fwrite(s,message);
bout=fread(s);

if strcmp(command,'ADDRESS')==1
[parameter]=read_address(bout);
else
    [parameter]=read_parameter(command,bout);
end


t_final=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');

%% Show Data

if parameter==0
    fprintf(2,'Unable to retrieve requested parameter.');
elseif strcmp(parameter,0)==0 && strcmp(command,'ADDRESS')==1
    fprintf(horzcat('Requested parameter adquired sucessfully. \n ',char(command),':',char(var1),' = ',char(string(parameter))));
else
    fprintf(horzcat('Requested parameter adquired sucessfully. \n ',char(command),' = ',char(string(parameter))));    
end


fclose(s);


end
