function [burner_off,M] = burner_off_predictor_simplified(criteria,appliance,V_start,V_end,T_win,T_sp,T_wout)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

capacity=appliance.capacity;
gas_type=appliance.gas_type;
t_prediction=10;

%Time inputs
t_transition=0;
t_end=t_transition+t_prediction;
t_delay_vector=[0]';
t_step=0.25;
t_start=0;
t=[t_start:t_step:t_end]';
t_size=size(t,1);

% Set-point temperature
T_sp=constant_profile(T_sp,t_size);

% Water flowrate
baselines=[V_start V_end];
time=t;
transition_method='abrupt';
transition_times=t_transition;
transition_duration=zeros(1,size(baselines,2)-1);

Vdot_water=variable_profile(baselines,time,transition_method,transition_times,transition_duration);

% Inlet Water Temperature
T_win=constant_profile(T_win,t_size);


% Inlet Water Pressure
p_win=constant_profile(2.5,t_size);

% Power Input
Q_delay_ramp=10;

V=0.5*10^-3; %HEx water volume
KME_SW %Getting SW parameters


%% Model calculation

for j=1:size(t_delay_vector,1)
    t_delay=t_delay_vector(j);
    
    
    % Power Input Load Profile
    
    baselines=thermostatic_ideal_power_simplified(T_sp.value(1:size(Vdot_water.baselines,2)),T_win.value(1:size(Vdot_water.baselines,2)),p_win.value(1:size(Vdot_water.baselines,2)),Vdot_water.baselines,capacity,gas_type);
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
    rho.value=ones(size(t,1),1)*993;
    cp.value=ones(size(t,1),1)*4.178;
    
    % Outlet Water Temperature

    T.value=ones(size(t,1),1).*T_wout;
    
    for i=2:size(t,1)
        T.value(i)=(((t(i)-t(i-1))/(rho.value(i)*cp.value(i)*V))*(rho.value(i)*(Vdot_water.value(i-1)/60000)*cp.value(i)*(-T.value(i-1)+T_win.value(i-1))+eta.value(i-1)*Q.value(i-1)))+T.value(i-1);
    end
    
    
    data{j}.t=t;
    data{j}.Q=Q.value;
    data{j}.T=T.value;
    data{j}.T_win=T_win.value;
    data{j}.Vdot_water=Vdot_water.value;
    data{j}.p_win=p_win.value;
    data{j}.T_sp=T_sp.value;
end

[M,I]=max(data{1}.T);

if M>=criteria
    burner_off=1;
else
    burner_off=0;
end



end

