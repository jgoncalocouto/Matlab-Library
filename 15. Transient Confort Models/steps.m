%% 0-D Transient Model: HEx response to variable loads

%% Inputs
tic
capacity='14'; %Appliance Capacity
gas_type='NG'; %Appliance Gas Type
selection=11;


% Test Profile
% V_start=[V11(1):0.1:11];
V_start=[1.9:0.1:11];
% V_start=11;
V_end=1.8;

data_v=generate_rapidflowvariations(V_start,V_end);
[t_end,sel1]=get_test_duration_and_index(data_v,selection);


%Time inputs
t_delay_vector=[0]';
t_step=0.1;
t_start=0;
t=[t_start:t_step:t_end]';
t_size=size(t,1);


% Set-point temperature
T_sp=constant_profile(60,t_size);

% Water flowrate
baselines=data_v{sel1};
time=t;
transition_method='abrupt';
transition_times=linspace(t_start+15,t_end,size(baselines,2)-1);
transition_duration=zeros(1,size(baselines,2));

Vdot_water=variable_profile(baselines,time,transition_method,transition_times,transition_duration);

% Inlet Water Temperature
T_win=constant_profile(10,t_size);


% Inlet Water Pressure
p_win=constant_profile(2.5,t_size);

% Power Input
Q_delay_ramp=10;

V=0.3*10^-3; %HEx water volume
KME_SW %Getting SW parameters



%% Model calculation

for j=1:size(t_delay_vector,1)
t_delay=t_delay_vector(j);
    model_calc
    data{j}.t=t;
    data{j}.Q=Q.value;
    data{j}.T=T.value;
    data{j}.T_win=T_win.value;
    data{j}.Vdot_water=Vdot_water.value;
    data{j}.p_win=p_win.value;
    data{j}.T_sp=T_sp.value;
end

%% Plots

% model_plots
try
    V=(data{1}.Vdot_water(data{1}.T>=85));
    abc=V(length(V))+0.1
catch
    abc=NaN
end

% msgbox(string(V(length(V))+0.1))

%% End

clearvars -except data data_v abc V11 V22 w
toc