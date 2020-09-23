function rho = densityz_exg(lambda,gastype,Texg,h)
%Calculation of real gas density for exhaust gas stream:
%P is defined in mbar
%T is defined in ºC

w_d='wet';
P_atm=P_altitude(h);
T_exg=Texg;

[X_H2O,X_CO2,X_N2,X_O2,m_H2O_liquid]=exgases_fraction_condensates(lambda,gastype,w_d,T_exg,h);
P_CO2=X_CO2.*P_atm;
P_O2=X_O2.*P_atm;
P_N2=X_N2.*P_atm;
P_H2O=(X_H2O.*P_atm)*(100/(10^5));

rho_CO2=densityz('CO2',T_exg,P_CO2);
rho_O2=densityz('CO2',T_exg,P_O2);
rho_N2=densityz('N2',T_exg,P_N2);
rho_H2O=XSteam('rhoV_T',T_exg);

rho=rho_CO2+rho_O2+rho_N2+rho_H2O*X_H2O;  


end


