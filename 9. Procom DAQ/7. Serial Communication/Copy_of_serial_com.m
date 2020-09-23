%% Start-up Routine
datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss:SSS') %Sets resolution to ms in the data table
instrreset %deletes all instrument objects

s = serial('COM20');
set(s,'BaudRate',9600);
fopen(s);
t_initial=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');

message_id=77;

bout=fread(s);


i=1;
k=0;
record=0;
msg_ready=0;
buffer=zeros(44);
B=zeros(5000,44);

    while msg_ready==0
    
    carry=fscanf(mcu_serial,'%c',1);
    
    if carry==123
        buffer(i)=carry;
        i=i+1;
        carry=0;
    elseif carry==123 && buffer(i-1)==123
        buffer(i)=carry;
        record=1;
        i=i+1;
    elseif record==1 && carry==125 && buffer(i-1)==125
        buffer(i)=carry;
        i=i+1;
        record=0;
        msg_ready=1;
        k=k+1;
    elseif record==1
        buffer(i)=carry;
        i=i+1;
    end
    
    if msg_ready==1
        B(k,1:(i-1))=buffer;
        i=0;
    end
        
    end
    
    
    for i=2:length(bout)-1
        if bout(i)==123 && bout(i-1)==123 && strcmp(dec2hex(bout(i+4)),'A0')==1  %cmd_id='broadcast'
            out(1)=123;out(2)=123;
            record=1;
        elseif bout(i)==125 && bout(i+1)==125 && record==1
            out(j)=125;out(j+1)=125;
            record=0;
            k=k+1;
            B(k,1:length(out))=out(1,:);
            clearvars out
            j=3;
        elseif bout(i-1)==125 && bout(i)==0 && record==1
            return
        elseif record==1
            out(j)=bout(i);
            j=j+1;
        end
    end
end

end



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




