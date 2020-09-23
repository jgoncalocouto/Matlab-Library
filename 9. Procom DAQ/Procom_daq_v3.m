instrreset % garantees that all sessions are terminated
clear;clc;close all;

%% Inputs

t_daq=0.25;
port='COM5';   
axis_time=60; % Set time for plot window
script_input='Flamelift_AirFlow_Huba';
count_id=2;


%% Variables initialization
xlim_end=0;
xlim_start=0;
buffer_size=round(7200*(1/t_daq),0);
i=1;k=0;record=0;msg_ready=0;buffer=zeros(1,60);B=zeros(buffer_size,60);w=1;start_supervision=0;a=1;repeat_supervision=0;a=0;b=0;R=zeros(buffer_size,60); k_R=0;
t_absolute = NaT(buffer_size,1);
t_relative=zeros(buffer_size,1);
T_win=zeros(buffer_size,1); %Inlet Water Temperature
T_wout=zeros(buffer_size,1); %Outlet Water Temperature -HEx
T_wsp=zeros(buffer_size,1); %Set-point Water Temperature
T_box=zeros(buffer_size,1); %Box Temperature
Vdot_w=zeros(buffer_size,1); %Water Flow Rate
burner_power=zeros(buffer_size,1); %Burner Power
safety_data=zeros(buffer_size,1); %Safety DATA
error=zeros(buffer_size,1); %Active Failure
N_fan=zeros(buffer_size,1); %Fan Speed [rpm]
I_fan=zeros(buffer_size,1); %Fan Current [A]
V_fan=zeros(buffer_size,1); %Fan Voltage [V] 40% - Max Voltage; 80% - Min Voltage
Vdot_air_actual=zeros(buffer_size,1); %Actual Air Flow [l/min]
Vdot_air_desired=zeros(buffer_size,1); %Desired Air Flow [l/min]
I_gv=zeros(buffer_size,1); %Valve Current [mA]
P_box=zeros(buffer_size,1); %Desired Gas Flow [l/min]
component_status=zeros(buffer_size,1);
T_flue=zeros(buffer_size,1); %Flue Temperature [ºC]
I_ion=zeros(buffer_size,1); %Ionisation Current [\muA]
P_atm=zeros(buffer_size,1); %Atmospheric Pressure [mbar]
T_wmix=zeros(buffer_size,1); %Mix Temperature
I_bp=zeros(buffer_size,1); %Bypass current
operation_mode=zeros(buffer_size,1); %Operation Mode
T_wsp_limit=zeros(buffer_size,1); %Limit Set-point



%% Procom Live Figure Initialization
ProcomFigHandle = figure('units','normalized','outerposition',[0.0 0.0 0.4 0.8]);
set(ProcomFigHandle,'Name','Procom Live','NumberTitle','off','DoubleBuffer', 'on','CurrentCharacter','a');

% Sub-plot 1: Water
sp_1=subplot(3,1,1);

T_wsp_Handle = plot(nan,'k');
set(T_wsp_Handle,'color',[0 0 0])
hold on
T_win_Handle = plot(nan,'b');
T_wout_Handle = plot(nan,'r');
T_wmix_Handle = plot(nan,'c');

ylabel('Temperature - T - [ºC]')
ylim([0 85])
yyaxis right

Vdot_w_Handle = plot(nan,'g');
ylabel('Water Flow Rate - [l/min]')
ylim([0 10])

xlabel('Elapsed Time - t - [s]')
l_s1=[
    string('Set-point')
    string('Inlet Water Temperature')
    string('Outlet Water Temperature')
    string('Mix Water Temperature')
    string('Water Flowrate')
    ];
legend_s1=legend(l_s1,'Location','eastoutside');
title('Water Temperature')
title(legend_s1,'Legend');


hold off

% Sub-plot 2: Fan Control

sp_2=subplot(3,1,2);
N_fan_Handle=plot(nan,'b');
hold on
V_fan_Handle=plot(nan,'c');
Vdot_air_actual_Handle=plot(nan,'k');
Vdot_air_desired_Handle=plot(nan,'g');

xlabel('Elapsed Time - t - [s]')
l_s2=[
    string('Fan Speed - [RPM]')
    string('Fan Duty - [%]*10')
    string('Actual Flow Rate - [slpm]')
    string('Desired Flow Rate - [slpm]')
    ];
legend_s2=legend(l_s2,'Location','eastoutside');
title('Fan Control')
ylim([0 2500])
title(legend_s2,'Legend');


% Sub-plot 3: Burner Control
sp_3=subplot(3,1,3);
I_gv_Handle=plot(nan,'k');
hold on
I_ion_Handle=plot(nan,'r');
burner_power_Handle=plot(nan,'g');

xlabel('Elapsed Time - t - [s]')
l_s3=[
    string('Valve Current - [mA]')
    string('Ionisation Current - [\mu A]')
    string('Burner Power - [%]')
    ];
legend_s3=legend(l_s3,'Location','eastoutside');
title('Burner Control')
ylim([0 250])
title(legend_s3,'Legend');
hold off

% linkaxes([sp_1,sp_2,sp_3],'x');

%% Start COM Aquisition
pause(2);
s = serial(port);
set(s,'BaudRate',9600);
s.Timeout=10*60;
s.InputBufferSize=10^5;
fopen(s);


%% Inital Configurations


% Set Acquisition time
if t_daq==0.25
    t_daq_command=255;
elseif t_daq>=1
    t_daq_command=round(t_daq,0);
end
[set_t_daq]=procom_write('SET_ACQUISITION_TIME',1,t_daq_command,1);
fwrite(s,set_t_daq)

% Set message type

[set_mtype]=procom_write('SET_MESSAGE_TYPE',2,1,1);
fwrite(s,set_mtype)


% Get initial Date
t_absolute_initial=datetime(now,'ConvertFrom','datenum');
t_ref=t_absolute_initial;

tic
%% Aquisition Routine
while ishandle(ProcomFigHandle)==1
    
    carry=fscanf(s,'%c',1); %get a single character
    
    if record==0
        if start_supervision==0 && carry==123  %Detect a '{' and raise a flag
            buffer(i)=123;
            i=i+1;
            start_supervision=1; %flag
        elseif start_supervision==1 && carry==123 %if a '{' has been detected before and there is another, start recording
            buffer(i)=123;
            i=i+1;
            start_supervision=0;
            record=1;
        elseif start_supervision==1 && carry~=123 %if not, delete previously stored '{' '-->Em alguma situação isto pode acontecer?
            buffer(i)=0;
            start_supervision=0;
        end
        
    elseif record==1
        if carry==125 && buffer(i-1)==125 && false_finish==0
            buffer(i)=carry;
            i=i+1;
            record=0;
            k=k+1;
            
            if buffer(6)==hex2dec('A0') % Checks if message of the type: broadcast
                %% Treat Message Values and store them
                t_absolute(k,1)=datetime(now,'ConvertFrom','datenum');
                t_relative(k,1)=seconds(t_absolute(k,1)-t_absolute_initial);
                T_win(k,1)=buffer(8)+buffer(9)./100; %Inlet Water Temperature
                T_wout(k,1)=buffer(35)+buffer(36)./100; %Outlet Water Temperature (Mix Temperature)
                T_wsp(k,1)=buffer(12); %Set-point Water Temperature
                T_box(k,1)=buffer(13)+buffer(14)./100; %Box Temperature
                Vdot_w(k,1)=buffer(15)./10; %Water Flow Rate
                burner_power(k,1)=buffer(16); %Burner Power
                safety_data(k,1)=buffer(17); %Safety DATA
                error(k,1)=buffer(18); %Active Failure
                N_fan(k,1)=buffer(20).*60; %Fan Speed [rpm]
                I_fan(k,1)=buffer(21)./100; %Fan Current [A] - Lixo
                V_fan(k,1)=100-buffer(22); %Fan Voltage [V] 40% - Max Voltage; 80% - Min Voltage
                Vdot_air_actual(k,1)=(buffer(23)+buffer(24)./100).*10; %Actual Air Flow [l/min]
                Vdot_air_desired(k,1)=(buffer(25)+buffer(26)./100).*10; %Desired Air Flow [l/min]
                I_gv(k,1)=buffer(28); %Valve Current [mA]
                P_box(k,1)=(buffer(29)+buffer(30)./100)./10; %Desired Gas Flow [l/min]
                component_status(k,1)=buffer(31);
                T_flue(k,1)=buffer(32); %Flue Temperature [ºC]
                I_ion(k,1)=buffer(33); %Ionisation Current [\muA]
                P_atm(k,1)=buffer(34).*10; %Atmospheric Pressure [mbar]
                T_wmix(k,1)=buffer(10)+buffer(11)./100; %Mix Temperature (HEX Outlet)
                I_bp(k,1)=buffer(37)+buffer(38)./10; %Bypass current
                operation_mode(k,1)=buffer(39); %Operation Mode
                T_wsp_limit(k,1)=buffer(41); %Limit Set-point
                
                
                B(k,1:length(buffer))=buffer(:); %Stores complete broadcast message in vector B
                
                
                %% Update plots
                
                if k-axis_time*(1/t_daq)<1
                    a=1;
                    xlim_start=0;
                    xlim_end=axis_time+10;
                else
                    a=round(k-axis_time*(1/t_daq),0);
                    xlim_start=t_relative(a,1);
                    xlim_end=t_relative(k,1)+10;
                end
                
                
                set(T_wsp_Handle  ,'XData', t_relative(a:k) );
                set(T_wsp_Handle  ,'YData', T_wsp(a:k) );
                set(T_win_Handle  ,'XData', t_relative(a:k) );
                set(T_win_Handle  ,'YData', T_win(a:k) );
                set(T_wout_Handle  ,'XData', t_relative(a:k) );
                set(T_wout_Handle  ,'YData', T_wout(a:k) );
                set(T_wmix_Handle  ,'XData', t_relative(a:k) );
                set(T_wmix_Handle  ,'YData', T_wout(a:k) );
                
                set(Vdot_w_Handle  ,'XData', t_relative(a:k) );
                set(Vdot_w_Handle  ,'YData', Vdot_w(a:k) );
                
                set(N_fan_Handle  ,'XData', t_relative(a:k) );
                set(N_fan_Handle  ,'YData', N_fan(a:k) );
                set(V_fan_Handle  ,'XData', t_relative(a:k) );
                set(V_fan_Handle  ,'YData', V_fan(a:k).*10 );
                set(Vdot_air_actual_Handle  ,'XData', t_relative(a:k) );
                set(Vdot_air_actual_Handle  ,'YData', Vdot_air_actual(a:k));
                set(Vdot_air_desired_Handle  ,'XData', t_relative(a:k) );
                set(Vdot_air_desired_Handle  ,'YData', Vdot_air_desired(a:k));
                
                
                set(I_gv_Handle, 'XData',t_relative(a:k) );
                set(I_gv_Handle, 'YData',I_gv(a:k) );
                
                set(I_ion_Handle, 'XData',t_relative(a:k) );
                set(I_ion_Handle, 'YData',I_ion(a:k) );
                
                set(burner_power_Handle, 'XData',t_relative(a:k) );
                set(burner_power_Handle, 'YData',burner_power(a:k) );
                
                
                
                
                xlim(sp_1,[xlim_start xlim_end])
                xlim(sp_2,[xlim_start xlim_end])
                xlim(sp_3,[xlim_start xlim_end])
                
                
                drawnow
                
                
            %% Appliance Supervision
            
            % Insert conditions and commands here
            

            run(horzcat(script_input,'.m'))
                
                
            else
                k_R=k_R+1;
                R(k_R,1:length(buffer))=buffer(:);
                buffer=zeros(1,60);
                i=1;
                k=k-1;
            end
            
            
            %% Clean buffer
            buffer=zeros(1,44);
            i=1;
            

            
        elseif carry==0 && buffer(i-1)==123 && i>3
            
        elseif carry==0 && buffer(i-1)==125
            false_finish=1;
        else
            buffer(i)=carry;
            i=i+1;
            false_finish=0;
        end
    end
    
    
end
toc

data=timetable(t_absolute,t_relative,T_win,T_wout,T_wsp,T_box,Vdot_w,burner_power,safety_data,error,N_fan,I_fan,V_fan,Vdot_air_actual,Vdot_air_desired,I_gv,P_box,component_status,T_flue,I_ion,P_atm,T_wmix,I_bp,operation_mode,T_wsp_limit);
data=data(1:k);
fclose(s);

