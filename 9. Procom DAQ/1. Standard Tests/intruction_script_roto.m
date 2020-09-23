%% Appliance Supervision

% Insert conditions and commands here

t_counter=second(datetime(now,'ConvertFrom','datenum')-datenum(t_ref));


if t_relative(k,1)>=70 && t_relative(k,1)<72
    close(ProcomFigHandle) 
end


