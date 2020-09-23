function [ Log ] = FT_logger(A, appType)
% This File imports data from PROCOM log to a struct. 
% MsgType argument defines position in columns

if strcmp(appType,'10')
    power = 20;
elseif strcmp(appType,'11')
    power = 22;
else
    power=22;
end

    % Reading XLS file msg 1
    Log.t_relative = A(:,1);
    Log.t_absolute=A(:,1).*0;
    Log.T_win = A(:,7);%inlet temperature
    Log.T_wout = A(:,8);
    Log.T_wsp = A(:,9);
    Log.Vdot_w = A(:,11);%L per min
    Log.burner_power = (A(:,12));%kW
    Log.SafetyData = A(:,13);
    Bitmask = 7 * ones(size(Log.SafetyData,1),1); 
    Log.Nsegments = bitand(Log.SafetyData,Bitmask);
    Log.Nsegments(find(Log.Nsegments == 7)) = 6;
    Log.Error = A(:,14);
    Log.N_fan = A(:,16).*60;
    Log.I_fan = A(:,17);
    Log.V_fan = A(:,18);
    Log.Vdot_air_actual = A(:,19).*10;
    Log.Vdot_air_desired = A(:,20).*10;
    Log.I_gv = A(:,22);
    Log.P_box = A(:,23)./10;
    Log.T_flue = A(:,25);
    Log.I_ion = A(:,26);
   
end

