function [ Log ] = Procom_load_equivalence(A, appType)
% This File imports data from PROCOM log to a struct.
% MsgType argument defines position in columns

if strcmp(appType,'10')
    power = 20;
elseif strcmp(appType,'11')
    power = 22;
elseif strcmp(appType,'14')
    power=28;
else
    power=22;
end

% Reading XLS file msg 1
Log.t_relative = A(:,1);
Log.t_absolute=A(:,1).*0;
Log.T_win = A(:,3);%inlet temperature
Log.T_wout = A(:,4);
Log.Power_derrate = A(:,5);
Log.T_wsp = A(:,6);
Log.Vdot_w = A(:,7);%L per min
    Log.T_amb = A(:,8);
Log.burner_power = (A(:,9));
Log.Qn = round(((A(:,9)./100) * power),0);%kW
Log.SafetyData = A(:,10);
Bitmask = 7 * ones(size(Log.SafetyData,1),1);
Log.Nsegments = bitand(Log.SafetyData,Bitmask);
Log.Nsegments(find(Log.Nsegments == 7)) = 6;
Log.Error = A(:,11);
Log.N_fan = A(:,14)*60;
Log.I_fan = A(:,15);
Log.V_fan = A(:,16);
Log.Vdot_air_actual = A(:,17).*10;
Log.Vdot_air_desired = A(:,18).*10;
%     Log.DeltaP_sensor = A(:,19);
Log.I_gv = A(:,20);
Log.P_box = A(:,21)./10;
Log.T_flue = A(:,22);
Log.I_ion = A(:,23);

end

