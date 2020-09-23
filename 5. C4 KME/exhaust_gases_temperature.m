function [T_exg] = exhaust_gases_temperature(gastype,Qn,CO2_input,eta, T_gas, T_air,h)
%Function that estimates the exhaust gases temperature of an appliance from the
%overall efficiency and CO2
%   Inputs: CO2_input dry [-], gastype [-], Power Input [kW], Overall Efficiency [-], Air Temperature [ºC], Gas Temperature [ºC], altitude
%   [m]
%Outputs: Exhaust Gas Temperature [ºC]

CO2_duct=CO2_input./100;
lambda=lambda_calc(gastype,CO2_duct,1,1); %Calculate lambda with CO2 and Gas Type
[X_CO2,X_H2O,X_N2,X_O2]=exgases_fraction(lambda,1,1,gastype,'wet'); %Calculate exhaust gas fractions
AFR=afr(1,1,gastype,'vol'); %Calculate AFR stoichiometric
P_exg=P_altitude(h); %Calculate ambient pressure with altitude

Hi=heatingvalues(gastype,'Hi'); %Calculate Heat Input
V_dot_gas=Qn.*1000./(Hi.*10.^6); %Calculate Gas Flow Rate



%Calculate exhaust gas densities at 15ºC
rho_CO2_15=densityz('CO2',15,P_exg);
rho_N2_15=densityz('N2',15,P_exg);
rho_O2_15=densityz('O2',15,P_exg);
rho_H2O_15=XSteam('rho_pT',P_exg./1000,100);
rho_exg_15=X_CO2.*rho_CO2_15+X_O2.*rho_O2_15+X_N2.*rho_N2_15+X_H2O.*rho_H2O_15;

%Calculate Air and Gas Specific Heat at constant pressure at T_average
cp_air=cp('N2',(15+T_air)./2).*0.79+cp('O2',(15+T_air)./2).*0.21;
cp_gas=cp(gastype,(15+T_gas)./2);

%Calculate density for air
rho_air_15=densityz('Air',15,P_exg);
rho_air=densityz('Air',(15+T_air)./2,P_exg);

%Calculate density for gas
rho_gas_15=densityz(gastype,15,P_exg);
rho_gas=densityz(gastype,(15+T_gas)./2,P_exg);

%Calculate volumetric flow rate for air
V_dot_air=(V_dot_gas.*(lambda.*AFR)).*rho_air_15./rho_air;

%Calculate massic flow rate for exhaust gases, air and combustible gas
m_dot_air=V_dot_air.*rho_air;
m_dot_gas=V_dot_gas.*rho_gas;
m_dot_exg=m_dot_air+m_dot_gas;

%Calculate heat fluxes for Air and combustible gas
Q_air=m_dot_air.*cp_air.*(15-T_air);
Q_gas=m_dot_gas.*cp_gas.*(15-T_gas);

%Calculate heat flux for exhaust gases
Q_exg=Qn.*(1-eta)-Q_air-Q_gas

T_exg=T_air;
cp_CO2=cp('CO2',((T_exg+15)./2));
cp_N2=cp('N2',((T_exg+15)./2));
cp_O2=cp('O2',((T_exg+15)./2));
cp_H2O=cp('H2O',((T_exg+15)./2));
cp_exg=X_CO2.*cp_CO2+X_O2.*cp_O2+X_N2.*cp_N2+X_H2O.*cp_H2O;


E_rel=1;
i=0;

while E_rel>1*10^-3
   
T_exg=15+(Q_exg./(m_dot_exg.*cp_exg));
cp_CO2=cp('CO2',((T_exg+15)./2));
cp_N2=cp('N2',((T_exg+15)./2));
cp_O2=cp('O2',((T_exg+15)./2));
cp_H2O=cp('H2O',((T_exg+15)./2));
cp_exg=X_CO2.*cp_CO2+X_O2.*cp_O2+X_N2.*cp_N2+X_H2O.*cp_H2O;


Q_exg_iter=m_dot_exg.*cp_exg.*(T_exg-15);

E_rel=(abs(Q_exg-Q_exg_iter)./Q_exg);
Q_exg=Q_exg_iter;
    
i=i+1
end


end

