%% 0-D Transient Model: HEx response to variable loads

%% Inputs
tic
capacity='14'; %Appliance Capacity
gas_type='NG'; %Appliance Gas Type
t_prediction=60;


% Test Profile
V_start=7.1;
V_end=2.4;



%Time inputs
t_transition=1;
t_end=t_transition+t_prediction;
t_delay_vector=[0]';
t_step=0.25;
t_start=0;
t=[t_start:t_step:t_end]';
t_size=size(t,1);


% Set-point temperature
T_sp=constant_profile(60,t_size);

% Water flowrate
baselines=[V_start V_end];
time=t;
transition_method='abrupt';
transition_times=t_transition;
transition_duration=zeros(1,size(baselines,2)-1);

Vdot_water=variable_profile(baselines,time,transition_method,transition_times,transition_duration);

% Inlet Water Temperature
T_win=constant_profile(10.1,t_size);


% Inlet Water Pressure
p_win=constant_profile(2.5,t_size);

% Power Input
Q_delay_ramp=10;

V=0.3*10^-3; %HEx water volume
KME_SW %Getting SW parameters



%% Model calculation

for j=1:size(t_delay_vector,1)
t_delay=t_delay_vector(j);
    model_calc_2
    data{j}.t=t;
    data{j}.Q=Q.value;
    data{j}.T=T.value;
    data{j}.T_win=T_win.value;
    data{j}.Vdot_water=Vdot_water.value;
    data{j}.p_win=p_win.value;
    data{j}.T_sp=T_sp.value;
end

[M,I]=max(data{1}.T);


%% Plots

model_plots2


%% End

clearvars -except data data_v t_transition
toc