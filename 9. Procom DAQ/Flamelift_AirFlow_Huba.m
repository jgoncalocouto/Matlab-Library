%% Appliance Supervision

% Insert conditions and commands here

t_counter=seconds(datetime(now,'ConvertFrom','datenum')-t_ref);


if I_ion(k,1)<1
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1=908;%Change Valve Current
    var2=I_gv(k-60,1)+10;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);

    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1='8FA';%Change Airflow
    var2=Vdot_air_desired(k-60,1)-100;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    t_ref=datetime(now,'ConvertFrom','datenum');

end

if t_counter>60
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    var1='8FA';%Change Airflow
    var2=Vdot_air_desired(k,1)+50;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    t_ref=datetime(now,'ConvertFrom','datenum');

%     designation='SET_SETPOINT';
%     message_id=3;
%     var1=var1+5;
%     var2=1;
%     write_until_feedback
%     t_ref=datetime(now,'ConvertFrom','datenum');
%     pause(2)
end