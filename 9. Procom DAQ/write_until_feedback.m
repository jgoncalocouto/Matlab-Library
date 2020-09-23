
[message1]=procom_write(designation,message_id,var1,var2);

i_fb=1;
feedback=0;
record_fb=0;
start_supervision_fb=0;
readings=0;
buffer_fb=zeros(1,44);
write_counter=0;
%% Cycle
while feedback==0 && write_counter<5
    fwrite(s,message1);
    while readings<5
        carry_fb=fscanf(s,'%c',1); %get a single character
        if record_fb==0
            if start_supervision_fb==0 && carry_fb==123  %Detect a '{' and raise a flag
                buffer_fb(i_fb)=123;
                i_fb=i_fb+1;
                start_supervision_fb=1; %flag
            elseif start_supervision_fb==1 && carry_fb==123 %if a '{' has been detected before and there is another, start recording
                buffer_fb(i_fb)=123;
                i_fb=i_fb+1;
                start_supervision_fb=0;
                record_fb=1;
            elseif start_supervision_fb==1 && carry_fb~=123 %if not, delete previously stored '{' '-->Em alguma situação isto pode acontecer?
                buffer_fb(i_fb)=0;
                start_supervision_fb=0;
            end
            
        elseif record_fb==1
            if carry_fb==125 && buffer_fb(i_fb-1)==125 && false_finish_fb==0
                buffer_fb(i_fb)=carry_fb;
                i_fb=i_fb+1;
                record_fb=0;
                readings=readings+1;
                if buffer_fb(6)==hex2dec('A0') % Checks if message of the type: broadcast
                else
                    if buffer_fb(5)==message_id && buffer_fb(8)==1
                        feedback=1;
                        readings=5;
                    end
                    i_fb=1;
                end
                %% Clean buffer
                buffer_fb=zeros(1,44);
                i_fb=1;
            elseif carry_fb==0 && buffer_fb(i_fb-1)==123 && i_fb>3
                
            elseif carry_fb==0 && buffer_fb(i_fb-1)==125
                false_finish_fb=1;
            else
                buffer_fb(i_fb)=carry_fb;
                i_fb=i_fb+1;
                false_finish_fb=0;
            end
        end
    end
    readings=0;
    write_counter=write_counter+1;
    pause(2)
end