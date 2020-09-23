%% Calculations


% Power Input Load Profile

baselines=thermostatic_ideal_power(T_sp.value(1:size(Vdot_water.baselines,2)),T_win.value(1:size(Vdot_water.baselines,2)),p_win.value(1:size(Vdot_water.baselines,2)),Vdot_water.baselines,capacity,gas_type);
time=t;
transition_method='linear';
transition_times=Vdot_water.transition_times+t_delay;
transition_duration=Q_delay_ramp;

Q=variable_profile(baselines,time,transition_method,transition_times,transition_duration);




if size(Q.value,1)>size(Q.time,1)
    Q.value(size(Q.time,1)+1:size(Q.value,1))=[];
end

solar=Q.value;
solar(Q.value~=0)=0;solar(Q.value==0)=1;

%Thermal Efficiency
baselines=interp1(SW_Efficiency.(gas_type)(:,1),SW_Efficiency.(gas_type)(:,2),Q.baselines)./100;
time=t;
transition_method='linear';
transition_times=Vdot_water.transition_times+t_delay;
transition_duration=Q_delay_ramp;
eta=variable_profile(baselines,time,transition_method,transition_times,transition_duration);
eta.value(isnan(eta.value)==1)=1;


%Thermal Properties Initialization
rho.value=ones(size(t,1),1)*XSteam('rho_pT',p_win.value(1),T_win.value(1));
cp.value=ones(size(t,1),1)*XSteam('Cp_pT',p_win.value(1),T_win.value(1));

% Outlet Water Temperature
[T_out_expected] = thermostatic_ideal_Tout_simplified(T_sp.value(1),T_win.value(1),p_win.value(1),Vdot_water.value(1),capacity,gas_type);
T.value=ones(size(t,1),1).*T_out_expected;

for i=2:size(t,1)
    
    rho.value(i)=XSteam('rho_pT',p_win.value(i),(T.value(i-1)+T_win.value(i-1))*0.5);
    cp.value(i)=XSteam('Cp_pT',p_win.value(i),(T.value(i-1)+T_win.value(i-1))*0.5);
    
    T.value(i)=(((t(i)-t(i-1))/(rho.value(i)*cp.value(i)*V))*(rho.value(i)*(Vdot_water.value(i-1)/60000)*cp.value(i)*(-T.value(i-1)+T_win.value(i-1))+eta.value(i-1)*Q.value(i-1)))+T.value(i-1);
end

