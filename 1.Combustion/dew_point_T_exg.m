function [T_dew]=dew_point_T_exg(lambda,gastype,h)
w_d='wet';
[N_CO2_nc,N_H2O_nc,N_N2_nc,N_O2_nc]=exgases_moles(lambda,gastype,w_d);
[X_CO2_nc,X_H2O_nc,X_N2_nc,X_O2_nc]=exgases_fraction(lambda,gastype,w_d);


N_total_nc=N_CO2_nc+N_H2O_nc+N_N2_nc+N_O2_nc;
P_atm=P_altitude(h);

P_partial_H2O_gas=X_H2O_nc*P_atm;

T_dew=XSteam('Tsat_p',(P_partial_H2O_gas*100)*(10^-5));

end