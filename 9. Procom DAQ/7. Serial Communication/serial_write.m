%% Start-up Routine
datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss:SSS') %Sets resolution to ms in the data table
instrreset %deletes all instrument objects


%% Message_write_and_read


message_id=11;
value=89;
[message]=procom_write('SET_DESIRED_VALVECURRENT',message_id,value,1);

s = serial('COM20');
set(s,'BaudRate',9600);
s.InputBufferSize=10^5;
s.Timeout=2 ;
t_initial=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');

fopen(s);
fwrite(s,message);
bout=fread(s);
[parameter]=read_parameter('VALVECURRENT',bout)

t_final=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');

%% Get data

[SW_INFO] = procom_sw_version_extract(bout);

%B stores the messages received one in each line, it also stores the
%initiator and the terminator






fclose(s);
