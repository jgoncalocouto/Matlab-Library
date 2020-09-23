%% Appliance Supervision

% Insert conditions and commands here

t_counter=seconds(datetime(now,'ConvertFrom','datenum')-t_ref);
valvecurrent=70;

%Initial Settings
if t_relative(k,1)>10 && t_relative(k,1)<12
    %Valve Current
    count_id=count_id+1;
    var1='8EE';%Change Valve Current
    var2=valvecurrent%Value
    [message]=procom_write('WRITE_ADDRESS',count_id,var1,var2);
    fwrite(s,message);
    pause(1)
    
    %Air Flow
    count_id=count_id+1;
    var1='8E0';%Change Fan Airflow
    var2=350%Value
    [message]=procom_write('WRITE_ADDRESS',count_id,var1,var2);
    fwrite(s,message);
    pause(1)
    
    step=[1 2 3 4 5 6 10];
    t_ref=datetime(now,'ConvertFrom','datenum');
    t_counter=seconds(datetime(now,'ConvertFrom','datenum')-t_ref);
    UP=false;
    step_id=1;
    step_counter=0;
end


if t_counter>6 && t_relative(k,1)>12
    if step_counter>3
        if step_id<size(step,2)
            step_counter=0;
            step_id=step_id+1;
        else
            finish=true;
        end
    else
        if UP==false
            %Valve Current
            count_id=count_id+1;
            var1='8EE';%Change Valve Current
            var2=valvecurrent+step(step_id)%Value
            [message]=procom_write('WRITE_ADDRESS',count_id,var1,var2);
            fwrite(s,message);
            pause(1)
            %Valve Current
            count_id=count_id+1;
            var1='8EE';%Change Valve Current
            var2=valvecurrent+step(step_id)%Value
            [message]=procom_write('WRITE_ADDRESS',count_id,var1,var2);
            fwrite(s,message);
            pause(1)
            UP=true;
        else
            %Valve Current
            count_id=count_id+1;
            var1='8EE';%Change Valve Current
            var2=valvecurrent%Value
            [message]=procom_write('WRITE_ADDRESS',count_id,var1,var2);
            fwrite(s,message);
            pause(1)
            %Valve Current
            count_id=count_id+1;
            var1='8EE';%Change Valve Current
            var2=valvecurrent%Value
            [message]=procom_write('WRITE_ADDRESS',count_id,var1,var2);
            fwrite(s,message);
            pause(1)
            UP=false;
            step_counter=step_counter+1;
        end
        t_ref=datetime(now,'ConvertFrom','datenum');
    end
end
    
