%% Appliance Supervision

% Insert conditions and commands here

t_counter=second(datetime(now,'ConvertFrom','datenum')-datenum(t_ref));


if t_relative(k,1)>=5 && t_relative(k,1)<7
    
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1='8EE';%Change Valve Current
    var2=60;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1='8E0';%Change Airflow
    var2=600;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    t_ref=datetime(now,'ConvertFrom','datenum');
    
end


if I_ion(k,1)<1
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1='8EE';%Change Valve Current
    var2=I_gv(abs(k-60*4),1)+10;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1='8E0';%Change Airflow
    var2=abs(Vdot_air_desired(abs(k-60*4),1)-100);
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    t_ref=datetime(now,'ConvertFrom','datenum');
    
end

if t_counter>15
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1='8E0';%Change Airflow
    var2=Vdot_air_desired(k,1)+50;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    t_ref=datetime(now,'ConvertFrom','datenum');

end