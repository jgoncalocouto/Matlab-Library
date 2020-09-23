%% Power Input Calculation with Pburner, T and Altitude

% Inputs: Appliance capacity [-], Gas Type [-], Injector Marking [-], Temperature [ºC], Altitude [m] and Burner Pressure [mbar]
% Outputs: Gas Flowrate @15ºC 1atm [lpm], Power Input [kW], Discharge Coefficient [-]


%% Inputs
capacity=14; %[-]
gas_type='G31'; %[-]
marking=65; %[-]
T_gas=22; %[ºC]
h=0; %[m]
P_burner=[
4.7
9.4
14.5
21.4
34.4
41.1
]; %[mbar]


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

for i=1:size(P_burner,1)
CD(i,1) =cd_model(appliance_type,marking,rho,mu,N,P_burner(i,1));
V_gas(i,1)=vgas_calc(CD(i,1),rho,P_burner(i,1),A_inj);
Hi=heatingvalues(gas_type,'Hi');
Qn(i,1)=V_gas(i)*Hi*1000;
end

%Outputs
Qn
V_gasslpm=V_gas.*60000
CD
