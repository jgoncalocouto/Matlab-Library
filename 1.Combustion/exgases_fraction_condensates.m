function [X_H2O,X_CO2,X_N2,X_O2,m_H2O_liquid]=exgases_fraction_condensates(lambda,gastype,w_d,T_exg,h)

[N_CO2_nc,N_H2O_nc,N_N2_nc,N_O2_nc]=exgases_moles(lambda,gastype,w_d);
[X_CO2_nc,X_H2O_nc,X_N2_nc,X_O2_nc]=exgases_fraction(lambda,gastype,w_d);


N_total_nc=N_CO2_nc+N_H2O_nc+N_N2_nc+N_O2_nc;
P_atm=P_altitude(h);

P_partial_H2O_gas=(XSteam('psat_T',T_exg)*10^5)/100; %[mbar]

X_H2O_gas_sat=P_partial_H2O_gas/P_atm;

if X_H2O_nc>=X_H2O_gas_sat
    X_H2O_gas=X_H2O_gas_sat;
else
    X_H2O_gas=X_H2O_nc;
end

X_H2O_liquid=X_H2O_nc-X_H2O_gas;

N_total=N_total_nc-X_H2O_liquid*N_total_nc;

X_H2O=X_H2O_gas;
X_CO2=(N_CO2_nc)/(N_total);
X_N2=(N_N2_nc)/(N_total);
X_O2=(N_O2_nc)/(N_total);

M_H2O=1.008*2+16;
m_H2O_liquid=(X_H2O_liquid)*M_H2O;


end