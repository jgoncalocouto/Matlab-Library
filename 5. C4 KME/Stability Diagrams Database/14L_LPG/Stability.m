%% Stability Curves for C4 KME
%Inputs:
appliance_type='C4 KME';
marking=64;
T_gas=20;
h=0;
N=18;
P_atm=P_altitude(h); %[mbar]


%Calc
A=pi*0.25*(marking/100)^2;

rho_gas.G31=densityz('G31',T_gas,P_atm);
rho_gas.G30=densityz('G30',T_gas,P_atm);
mu.G31=viscosityd('G31',T_gas);
mu.G30=viscosityd('G30',T_gas);



load flnoise_g31_log.mat
Lean_noise.G31=avg_table(2:size(avg_table,1),:);

vars = {'avg_table','std_table'};
clear(vars{:});

load fl_g31_log.mat
Flame_lift.G31=avg_table(2:size(avg_table,1),:);

vars = {'avg_table','std_table'};
clear(vars{:});


load fl_g32_log.mat
Flame_lift.G32=avg_table(2:size(avg_table,1),:);

vars = {'avg_table','std_table'};
clear(vars{:});
clear vars;



i=0;
selected_gastype='G31';
for i=1:size(Lean_noise.(selected_gastype),1)
    rho=rho_gas.(selected_gastype);
    mu=mu.(selected_gastype);
    Hi=heatingvalues(selected_gastype,'Hi');
    CD=cd_model(appliance_type,marking,rho,mu,N,Lean_noise.(selected_gastype).P_burner(i));
    V_gas=vgas_calc(CD,rho,Lean_noise.(selected_gastype).P_burner(i),A);
    Lean_noise.(selected_gastype).Qn(i)=(V_gas*rho/densityz(selected_gastype,15,1013.25))*Hi;

end
