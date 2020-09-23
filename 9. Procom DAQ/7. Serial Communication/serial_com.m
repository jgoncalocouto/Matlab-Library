%% Start-up Routine
datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss:SSS') %Sets resolution to ms in the data table
instrreset %deletes all instrument objects

s = serial('COM10');
set(s,'BaudRate',9600);
s.InputBufferSize=10^5;
s.Timeout=20;
fopen(s);

t_initial=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');

message_id=77;
var1=0;
[message]=procom_write('READ_SWVERSION_MAIN',message_id,var1);
fwrite(s,message);

bout=fread(s);

t_final=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');
%% Get data

[B] = message_extract(bout);

%B stores the messages received one in each line, it also stores the
%initiator and the terminator

%% Treat Data

t_i=datetime(datenum(t_initial,'dd-mmm-yyyy HH:MM:SS:FFF'),'ConvertFrom','datenum');
t_f=datetime(datenum(t_final,'dd-mmm-yyyy HH:MM:SS:FFF'),'ConvertFrom','datenum');
[l_B,~]=size(B);
t=t_i:(seconds(s.Timeout)/(l_B-1)):t_f; t=t';

[data] = log_message(B,t);  


%% End COM
fclose(s);




