%% Appliance Supervision

% Insert conditions and commands here

[set_mode]=procom_write('SET_MODE',3,'P9',1);
fwrite(s,set_mode)

valve_current_steps=[40:1:80];

if t_absolute(i)>=(t_absolute_initial+valve_current_point_id*seconds(10)) && t_absolute(i) <= (t_absolute_initial+(valve_current_point_id+1)*seconds(12))
count_id=count_id+1;
valve_current_steps=[5:1:165];
designation='WRITE_ADDRESS';
message_id=count_id;
var1='93D';%Change Valve Current
var2=valve_current_steps(valve_current_point_id);
valve_current_point_id=valve_current_point_id+1;
[message]=procom_write(designation,message_id,var1,var2);
fwrite(s,message);
end