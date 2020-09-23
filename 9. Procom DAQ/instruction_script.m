%% Appliance Supervision

% Insert conditions and commands here



if t_relative(k,1)>5 && t_relative(k,1)<6
    [message1]=procom_write('SET_SETPOINT',3,35,1);
    fwrite(s,message1);
    pause(1)
    
elseif t_relative(k,1)>125 && t_relative(k,1)<126
    [message2]=procom_write('SET_SETPOINT',4,45,1);
    fwrite(s,message2);
    pause(1)
    
elseif t_relative(k,1)>245 && t_relative(k,1)<246
    [message2]=procom_write('SET_SETPOINT',5,60,1);
    fwrite(s,message2);
    pause(1)
    
    
elseif t_relative(k,1)>365 && t_relative(k,1)<366
    [message2]=procom_write('SET_MODE',6,'OFF',1);
    fwrite(s,message2);
    pause(1)
    
elseif t_relative(k,1)>485 && t_relative(k,1)<486
    [message2]=procom_write('SET_MODE',7,'THERMOSTATIC',1);
    fwrite(s,message2);
    pause(1)
    
    
    
elseif t_relative(k,1)>500 && t_relative(k,1)<501
    [message1]=procom_write('SET_SETPOINT',3,35,1);
    fwrite(s,message1);
    pause(1)
    
elseif t_relative(k,1)>620 && t_relative(k,1)<621
    [message2]=procom_write('SET_SETPOINT',4,45,1);
    fwrite(s,message2);
    pause(1)
    
elseif t_relative(k,1)>740 && t_relative(k,1)<741
    [message2]=procom_write('SET_SETPOINT',5,60,1);
    fwrite(s,message2);
    pause(1)
    
    
elseif t_relative(k,1)>861 && t_relative(k,1)<862
    [message2]=procom_write('SET_MODE',6,'OFF',1);
    fwrite(s,message2);
    pause(1)
end