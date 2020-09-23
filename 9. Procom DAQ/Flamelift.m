%% Appliance Supervision

% Insert conditions and commands here

t_counter=seconds(datetime(now,'ConvertFrom','datenum')-t_ref);


if I_ion(k,1)<5
    count_id=count_id+1;
    designation='SET_DESIRED_VALVECURRENT';
    message_id=count_id;
%     valve_curr=valve_curr+10;
%     var1=valve_curr;
    var1=I_gv(k,1)+10;
    var2=1;
    write_until_feedback

    count_id=count_id+1;
    designation='SET_DESIRED_FANSPEED';
    message_id=count_id;
%     fan_speed=fan_speed-20;
%     var1=fan_speed;
    var1=N_fan(k,1)-20;
    var2=1;
    write_until_feedback
    t_ref=datetime(now,'ConvertFrom','datenum');

end

if t_counter>30
    count_id=count_id+1;
    designation='SET_DESIRED_FANSPEED';
    message_id=count_id;
%     fan_speed=fan_speed+10;
%     var1=fan_speed;
    var1=N_fan(k,1)+10;
    var2=1;
    write_until_feedback
    t_ref=datetime(now,'ConvertFrom','datenum');

%     designation='SET_SETPOINT';
%     message_id=3;
%     var1=var1+5;
%     var2=1;
%     write_until_feedback
%     t_ref=datetime(now,'ConvertFrom','datenum');
%     pause(2)
end