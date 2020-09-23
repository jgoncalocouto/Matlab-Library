%% Burner Pressure Calculation with Qn, T and Altitude

% Inputs: Appliance capacity [-], Gas Type [-], Injector Marking [-], Temperature [ºC], Altitude [m] and Power Input [kW]
% Outputs: Burner Pressure - [mbar], Discharge Coefficient [-]


%% Inputs
capacity=14; %[-]
gas_type='G20'; %[-]
marking=105; %[-]
T_gas=15; %[ºC]
h=0; %[m]
Qn=10; %[kW]


%% Calculations

C4_KME_capacity_injectors=[
    11 15
    14 18
    17 24
    ];

N=C4_KME_capacity_injectors((C4_KME_capacity_injectors(:,1)==capacity),2);
mu=viscosityd(gas_type,T_gas);
P_atm=P_altitude(h);
D_inj=(marking/100)/1000;
appliance_type='C4 KME';
rho=densityz(gas_type,T_gas,P_atm);
A_inj=pi()*0.25*N*(D_inj)^2;
Hi=heatingvalues(gas_type,'Hi');

for i=1:size(Qn,1)
    V_gas(i)=Qn(i,1)./(Hi.*1000);
    CD(i,1) =cd_model_Vgas(appliance_type,marking,rho,mu,N,V_gas(i))
    P_burner(i)=(((V_gas(i).^2)./((CD(i)^2).*A_inj^2))*(rho/2))/100;
end

%Outputs
P_burner
CD