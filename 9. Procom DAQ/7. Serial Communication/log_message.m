function [data] = log_message(B,t) 

[l_B,~]=size(B);

%Variable initiation
sender=zeros(l_B,1);receiver=zeros(l_B,1);message_id=zeros(l_B,1);cmd_id=zeros(l_B,1);broadcast_id=zeros(l_B,1);T_win=zeros(l_B,1);T_wout=zeros(l_B,1);T_wsp=zeros(l_B,1);T_box=zeros(l_B,1);Vdot_w=zeros(l_B,1);
burner_power=zeros(l_B,1);safety_data=zeros(l_B,1);error=zeros(l_B,1);N_fan=zeros(l_B,1);I_fan=zeros(l_B,1);V_fan=zeros(l_B,1);Vdot_air_actual=zeros(l_B,1);
Vdot_air_desired=zeros(l_B,1);P_box=zeros(l_B,1);I_gv=zeros(l_B,1);component_status=zeros(l_B,1);T_flue=zeros(l_B,1);I_ion=zeros(l_B,1);P_atm=zeros(l_B,1);T_wmix=zeros(l_B,1);I_bp=zeros(l_B,1);operation_mode=zeros(l_B,1);
bathroom_controller_state=zeros(l_B,1);T_wsp_limit=zeros(l_B,1);check_sum=zeros(l_B,1);


i=0;
for i=1:l_B
sender(i,1)=B(i,3); %Sender DEC
receiver(i,1)=B(i,4); %Receiver DEC
message_id(i,1)=B(i,5); %MessageID DEC
cmd_id(i,1)=B(i,6); %Cmd_ID HEX
broadcast_id(i,1)=B(i,7); %Broadcast_message_ID DEC
T_win(i,1)=B(i,8)+B(i,9)./100; %Inlet Water Temperature
T_wout(i,1)=B(i,10)+B(i,11)./100; %Outlet Water Temperature -HEx
T_wsp(i,1)=B(i,12); %Set-point Water Temperature
T_box(i,1)=B(i,13)+B(i,14)./100; %Box Temperature
Vdot_w(i,1)=B(i,15)./10; %Water Flow Rate
burner_power(i,1)=B(i,16); %Burner Power
safety_data(i,1)=B(i,17); %Safety DATA
error(i,1)=B(i,18); %Active Failure
N_fan(i,1)=B(i,20).*60; %Fan Speed [rpm]
I_fan(i,1)=B(i,21)./100; %Fan Current [A] - Lixo
V_fan(i,1)=100-B(i,22); %Fan Voltage [V] 40% - Max Voltage; 80% - Min Voltage
Vdot_air_actual(i,1)=(B(i,23)+B(i,24)./100).*10; %Actual Air Flow [l/min]
Vdot_air_desired(i,1)=(B(i,25)+B(i,26)./100).*10; %Desired Air Flow [l/min]
I_gv(i,1)=B(i,28); %Valve Current [mA]
P_box(i,1)=(B(i,29)+B(i,30)./100)./10; %Desired Gas Flow [l/min]
component_status(i,1)=B(i,31);
T_flue(i,1)=B(i,32); %Flue Temperature [ºC]
I_ion(i,1)=B(i,33); %Ionisation Current [\muA]
P_atm(i,1)=B(i,34).*10; %Atmospheric Pressure [mbar]
T_wmix(i,1)=B(i,35)+B(i,36)./100; %Mix Temperature
I_bp(i,1)=B(i,37)+B(i,38)./10; %Bypass current
operation_mode(i,1)=B(i,39); %Operation Mode
bathroom_controller_state(i,1)=B(i,40); %Bathroom controller state
T_wsp_limit(i,1)=B(i,41); %Limit Set-point
check_sum(i,1)=B(i,42); %Check Sum 8 bits à direita
end

data=timetable(t,sender,receiver,message_id,cmd_id,broadcast_id,T_win,T_wout,T_wsp,T_box,Vdot_w,burner_power,safety_data,error,N_fan,I_fan,V_fan,Vdot_air_actual,Vdot_air_desired,P_box,I_gv,T_flue,I_ion,P_atm,T_wmix,I_bp,operation_mode,bathroom_controller_state,T_wsp_limit,check_sum);

end