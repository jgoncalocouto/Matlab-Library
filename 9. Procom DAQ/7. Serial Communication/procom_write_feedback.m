function [parameter,status] = procom_write_feedback(port,message_id,command,var1,var2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



%% Start-up Routine
datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss:SSS') %Sets resolution to ms in the data table
instrreset %deletes all instrument objects



%% Message Write

if strcmp(command,'ADDRESS')==1
    command_write='WRITE_ADDRESS';
    command_read_request='READ_ADDRESS';
else
    command_write=horzcat('SET_',command);
    command_read_request=horzcat('READ_',command);
end


[write_message]=procom_write(command_write,message_id,var1,var2);
[read_request_message]=procom_write(command_read_request,message_id+1,var1);

status=0;
counter=0;
parameter_read='N.A.';
while status==0 && counter <10
    
    s = serial(port);
    set(s,'BaudRate',9600);
    s.InputBufferSize=10^5;
    s.Timeout=2;
    t_initial=datestr(now,'dd-mmm-yyyy HH:MM:SS:FFF');
    
    fopen(s);
    fwrite(s,write_message);
    fwrite(s,read_request_message);
    data_read=fread(s);
    
    if strcmp(command,'ADDRESS')==1
        [parameter_read]=read_address(data_read);
    else
        [parameter_read]=read_parameter(command,data_read);
    end
    
    counter=counter+1;
    
    if strcmp(command,'ADDRESS')==1
        if parameter_read==var2
            status=1;
            fprintf(horzcat('Writing operation completed with success!! \n SET: ',command,'; Writen with value = ',num2str(var2),' ; After ',num2str(counter),' trials.'));
            
        else
            status=0;
            
        end
    else
        if strcmp(parameter_read,var1)==1   | parameter_read==var1
            status=1;
            fprintf(horzcat('Writing operation completed with success!! \n SET: ',command,'; Writen with value = ',num2str(var1),' ; After ',num2str(counter),' trials.'));
            
        else
            status=0;
        end

        if counter==10
                        fprintf(2,horzcat('Writing operation not completed! \n SET: ',command,' = ',num2str(var1),' ; \n Couldn''t be completed after 1o trials.'));
            
        end
        
    end
    
    %% Output
    parameter=parameter_read;
    
    fclose(s);
end

