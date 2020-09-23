function [V_gas] =W2_venturimixer(gastype,P_offset,P_atm,T_air,T_gas,V_air,k_restriction)

%Air Geometry 
A_entrancetube=pi.*(62.4./1000).*(62.4./1000).*0.25;
A_throat=pi.*(26./1000).*(26./1000).*0.25;
k_tube=7.*0.71+2;
k_appliance=2.8;


%Gas Geometry
A_gv_outlet=pi.*0.25.*(14./1000).^2;
A_orifices=(3.*0.25.*pi.*(4./1000).^2)+(3.*0.25.*pi.*(3.2./1000).^2);
k_orifices=1./(0.9.^2);
k_gv=20;
% k_restriction=185;

K_air=-((1./(A_entrancetube.^2))-(1./(A_throat.^2))-((k_tube)./(A_entrancetube.^2))-((k_appliance)./(A_entrancetube.^2)));
K_gas=-((1./(A_gv_outlet.^2))+(-1./(A_orifices.^2))+(-k_orifices./(A_orifices.^2))+(-k_restriction./(A_gv_outlet.^2))+(-k_gv./(A_gv_outlet.^2)));


rho_gas=densityz(gastype,T_gas,P_atm);
rho_air=densityz('Air',T_air,P_atm);
m_air=(V_air./60000).*rho_air;
m_gas=sqrt((2.*rho_gas.*((m_air.^2)./rho_air).*K_air+P_offset)./(K_gas));
V_gas=(m_gas./rho_gas).*60000;

end

