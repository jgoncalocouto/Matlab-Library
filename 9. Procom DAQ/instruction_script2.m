%% Appliance Supervision

% Insert conditions and commands here



if t_relative(k,1)>4 && t_relative(k,1)<6
    designation='SET_SETPOINT';
    message_id=3;
    var1=35;
    var2=1;
    write_until_feedback
    pause(2)
    
elseif t_relative(k,1)>20 && t_relative(k,1)<22
    designation='SET_SETPOINT';
    message_id=4;
    var1=60;
    var2=1;
    write_until_feedback
    pause(2)
    
    
elseif t_relative(k,1)>24 && t_relative(k,1)<26
    value=70;
    [message3]=procom_write('SET_DESIRED_VALVECURRENT',5,value,1);
    fwrite(s,message3);
    pause(2)
    
    [message3_2]=procom_write('SET_DESIRED_FANSPEED',6,140,1);
    fwrite(s,message3_2); %
    
elseif t_relative(k,1)>27 && t_relative(k,1)<29
    value=90;
    [message3]=procom_write('SET_DESIRED_VALVECURRENT',7,value,1);
    fwrite(s,message3);
    pause(2)
    [message3_2]=procom_write('SET_DESIRED_FANSPEED',8,180,1);
    fwrite(s,message3_2);
    
elseif t_relative(k,1)>30 && t_relative(k,1)<32
    value=105;
    [message3]=procom_write('SET_DESIRED_VALVECURRENT',9,value,1); %
    fwrite(s,message3);
    pause(2)
    
    [message3_2]=procom_write('SET_DESIRED_FANSPEED',10,300,1);
    fwrite(s,message3_2);
end