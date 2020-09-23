
%%Inputs
T_amb=22; %[ºC]
h=0;%[m]
L_duct=4; %[m]
N_elbows=0; %[-]
D_duct=80*10^-3; %[m]
N_fan=840./60; %[Hz]
D_fan=60*10^-3; %[m]
R_venturi=0.0424;
A_throat=pi*0.25*(7/1000)^2

P_amb=P_altitude(0); %[mbar]
rho_air=densityz('Air',T_amb,P_amb); %[kg/m^3]
V_iter=100./60000; %[m^3/s]
E_rel=100; %['%']
 
%%Ductwork Side
k_elbow=ploss_local_elbow(D_duct.*10^3,90); %[-]
A_duct=pi().*0.25.*(D_duct).^2; %[m^2]
k_appliance=10.6;
 
 
while E_rel>0.1
 
DeltaP_loss=ploss_inline(L_duct,D_duct.*1000,0,'Air',P_amb,T_amb,V_iter.*60000).*100+((k_elbow+k_appliance).*0.5.*rho_air.*(V_iter./A_duct).^2); %[Pa]
K_line=(ploss_inline(L_duct,D_duct.*1000,0,'Air',P_amb,T_amb,V_iter.*60000).*100)./((V_iter./A_duct).^2);
F_fan=V_iter./(N_fan.*D_fan.^3); %[-]
P_fan=kme_FAN_Characterization(F_fan,N_fan.*60); %[-]
DeltaP_fan=(P_fan.*rho_air.*N_fan.^3.*D_fan.^5)./V_iter; %[Pa]
 
E_rel=abs(((DeltaP_fan-DeltaP_loss)./(DeltaP_loss)).*100);
 
v_iter=sqrt(DeltaP_fan./((k_elbow+k_appliance).*0.5.*rho_air+K_line));
V_iter=v_iter.*A_duct;
end
 
V_dot_fan=V_iter.*60000
DeltaP_fan_mbar=DeltaP_fan./100;
DeltaP_venturi=(((V_dot_fan)^2)/(11809^2))*(273.15+T_amb);

P_venturi1=(DeltaP_fan+0.5*rho_air*((V_iter^2)/(A_duct^2)))/100;
P_venturi2=P_venturi1-DeltaP_venturi;




