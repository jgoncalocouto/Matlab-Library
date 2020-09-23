
Qn=[21.725];
CO2_duct=[7.8];
CO2_spill=[0.25];
T_ntc_0=60;

%  Qn=[21.725
% 21.08
% 20.025
% 19.334
% 18.202
% 17.01
% 16.9
% 15.54
% 14.269
% 13.136];
% 
% CO2_duct=[7.8
% 7.5
% 7.1
% 6.7
% 6.5
% 5.8
% 6
% 5.3
% 4.5
% 4.2];
% 
% CO2_spill=[0.25
% 0.27
% 0.24
% 0.27
% 0.2
% 0.18
% 0.13
% 0.09
% 0.05
% 0.07];

T_ntc_t=ones(length(Qn),1);

for i=1:length(Qn)
%1.External Convection from Exhaust Gases
%1.1 Inputs
A_tair_window=(3*10^-2)*10^-2;
D_ntc=1*10^-3;
T_exg=150;
h=0;
gastype='G20';
g=9.80655;

L_ntc=7*10^-2;
A_ntc_surface=(2*pi*(D_ntc./2).^2)+(2*pi*(D_ntc./2)*L_ntc);
%2.1 Inputs
f_tair=0.2;
T_amb=20;
P_amb=P_altitude(0);

%3.1 Inputs
A_ntc_cs=pi*(D_ntc^2)*0.25;
rho_ntc=7850;
V_ntc=A_ntc_cs.*L_ntc.*10;
C_ntc=0.502;
k_ntc=54;

%1.2 Calculation of exhaust gas flow rate, density, prandlt, viscosity and
%thermal condutivity
Hi=heatingvalues(gastype,'Hi');
AFR=afr(1,1,gastype,'vol');
V_dot_gas=Qn(i).*1000./(Hi.*10.^6);
lambda=lambda_calc(gastype,CO2_duct(i)./100,1,1);
P_exg=P_altitude(h);
[X_CO2,X_H2O,X_N2,X_O2]=exgases_fraction(lambda,1,1,gastype,'wet');

rho_CO2=densityz('CO2',T_exg,P_exg);
rho_N2=densityz('N2',T_exg,P_exg);
rho_O2=densityz('O2',T_exg,P_exg);
rho_H2O=XSteam('rho_pT',P_exg./1000,T_exg);
rho_exg=X_CO2.*rho_CO2+X_O2.*rho_O2+X_N2.*rho_N2+X_H2O.*rho_H2O;

rho_CO2_15=densityz('CO2',15,P_exg);
rho_N2_15=densityz('N2',15,P_exg);
rho_O2_15=densityz('O2',15,P_exg);
rho_H2O_15=XSteam('rho_pT',P_exg./1000,T_exg);
rho_exg_15=X_CO2.*rho_CO2_15+X_O2.*rho_O2_15+X_N2.*rho_N2_15+X_H2O.*rho_H2O_15;

mu_CO2=viscosityd('CO2',T_exg);
mu_N2=viscosityd('N2',T_exg);
mu_O2=viscosityd('O2',T_exg);
mu_H2O=XSteam('my_pT',P_exg./1000,T_exg);
mu_exg=X_CO2.*mu_CO2+X_O2.*mu_O2+X_N2.*mu_N2+X_H2O.*mu_H2O;

Pr_CO2_exg=prandlt('CO2',T_exg);
Pr_N2_exg=prandlt('N2',T_exg);
Pr_O2_exg=prandlt('O2',T_exg);
Pr_H2O_exg=prandlt('O2',T_exg);
Pr_exg=X_CO2.*Pr_CO2_exg+X_O2.*Pr_O2_exg+X_N2.*Pr_N2_exg+X_H2O.*Pr_H2O_exg;

V_dot_exg=(V_dot_gas.*(1+lambda.*AFR)).*rho_exg_15./rho_exg;
V_dot_spillage=((CO2_spill(i))./(CO2_duct(i))).*V_dot_exg;
v_spillage=V_dot_spillage./A_tair_window;

v1=v_spillage;
D1=D_ntc;

rho_air_15=densityz('Air',15,P_amb);
rho_air_amb=densityz('Air',T_amb,P_amb);

V_dot_air=(V_dot_gas.*(lambda.*AFR)).*rho_air_15./rho_air_amb;
V_dot_tair=V_dot_air.*f_tair;

v_tair=V_dot_tair./A_tair_window;
D2=D_ntc;


mu_air_amb=viscosityd('Air',T_amb);

a=50;
T_ntc_iter=T_amb;

T_f1_0=(T_exg+T_ntc_0)./2;
T_f2_0=(T_amb+T_ntc_0)./2;



while abs(a)>=1^-5
T_f1=(T_exg+T_ntc_iter)./2;
T_f2=(T_amb+T_ntc_iter)./2;


rho_CO2_f1=densityz('CO2',T_f1,P_exg);
rho_N2_f1=densityz('N2',T_f1,P_exg);
rho_O2_f1=densityz('O2',T_f1,P_exg);
rho_H2O_f1=XSteam('rho_pT',P_exg./1000,T_f1);
rho_exg_f1=X_CO2.*rho_CO2_f1+X_O2.*rho_O2_f1+X_N2.*rho_N2_f1+X_H2O.*rho_H2O_f1;

mu_CO2_f1=viscosityd('CO2',T_f1);
mu_N2_f1=viscosityd('N2',T_f1);
mu_O2_f1=viscosityd('O2',T_f1);
mu_H2O_f1=XSteam('my_pT',P_exg./1000,T_f1);
mu_exg_f1=X_CO2.*mu_CO2_f1+X_O2.*mu_O2_f1+X_N2.*mu_N2_f1+X_H2O.*mu_H2O_f1;

Pr_CO2_f1=prandlt('CO2',T_f1);
Pr_N2_f1=prandlt('N2',T_f1);
Pr_O2_f1=prandlt('O2',T_f1);
Pr_H2O_f1=prandlt('O2',T_f1);
Pr_exg_f1=X_CO2.*Pr_CO2_f1+X_O2.*Pr_O2_f1+X_N2.*Pr_N2_f1+X_H2O.*Pr_H2O_f1;

k_CO2_f1=thermal_condutivity('CO2',T_f1);
k_N2_f1=thermal_condutivity('N2',T_f1);
k_O2_f1=thermal_condutivity('O2',T_f1);
k_H2O_f1=thermal_condutivity('O2',T_f1);
k_exg_f1=X_CO2.*k_CO2_f1+X_O2.*k_O2_f1+X_N2.*k_N2_f1+X_H2O.*k_H2O_f1;

%1.4 Calculation of convection coefficients

Re_1=(rho_exg_f1.*v1.*D1)/(mu_exg_f1);

beta1=1./(273.15+T_f1);
Gr_1=(g.*beta1*(T_exg-60).*D1.^3)./(mu_exg_f1./rho_exg_f1);
Pr_1=Pr_exg_f1;

Nu_f1=Nusselt_ext_fconv_cylinder_transverse_flow(Re_1,Pr_1);
Nu_n1=Nusselt_ext_nconv_cylinder_transverse_flow(Gr_1,Pr_1);

if (Gr_1./(Re_1.^2))>=1.5
Nu_1=Nu_n1;
elseif (Gr_1./(Re_1.^2))>0.5 && (Gr_1./(Re_1.^2))<1.5
    Nu_1=Nu_n1+Nu_f1;
elseif (Gr_1./(Re_1.^2))<=0.5
    Nu_1=Nu_f1;
end

h_1=(Nu_1.*k_exg_f1)./D1;
Q_1=h_1.*A_ntc_surface.*(T_exg-T_ntc_iter);

%2 External Convection from Terciary Air

rho_air_f2=densityz('Air',T_f2,P_amb);
mu_air_f2=viscosityd('Air',T_f2);
Pr_air_f2=prandlt('Air',T_f2);
k_air_f2=thermal_condutivity('Air',T_f2);


Re_2=(rho_air_f2.*v_tair.*D2)./(mu_air_f2);
beta2=1./(273.15+T_f2);
Gr_2=(g.*beta2*(60-T_amb).*D2.^3)./(mu_air_f2./rho_air_f2);
Pr_2=Pr_air_f2;

Nu_f2=Nusselt_ext_fconv_cylinder_transverse_flow(Re_2,Pr_2);
Nu_n2=Nusselt_ext_nconv_cylinder_transverse_flow(Gr_2,Pr_2);

if (Gr_2./(Re_2.^2))>=1.5
Nu_2=Nu_n2;
elseif (Gr_2./(Re_2.^2))>0.5 && (Gr_2./(Re_2.^2))<1.5
    Nu_2=Nu_n2+Nu_f2;
elseif (Gr_2./(Re_2.^2))<=0.5
    Nu_2=Nu_f2;
end

h_2=(Nu_2.*k_air_f2)./D2;
Q_2=h_2.*A_ntc_surface.*(T_amb-T_ntc_iter);

%3. Conduction from exhaust gas collector

efficiency_percentage=0.05;
Q_3=efficiency_percentage.*Qn(i);
q_3=Q_3/A_ntc_surface;

T_ntc_iter=((Q_3./A_ntc_surface)+h_1.*T_exg+h_2.*T_amb)/(h_1+h_2);

a=Q_3+Q_1+Q_2;

h(i)=h_1+h_2;
T_inf(i)=(h_1.*T_exg+h_2.*T_amb)./(h_1+h_2);
a_l(i)=(h(i).*A_ntc_surface)./(rho_ntc.*V_ntc.*C_ntc);
b_l(i)=Q_3./(rho_ntc.*V_ntc.*C_ntc);
Bi(i)=((V_ntc./(A_ntc_surface)).*h(i))./k_ntc;

T_ntc=T_ntc_iter;

end
T_ntc_result(i)=T_ntc;
end
plot(Qn,T_ntc_result,'*')


fileID = fopen('ntc_sim.txt','w');
fprintf(fileID,'%6s %12s\n','x','exp(x)');
fprintf(fileID,'%6.2f %12.8f\n',A);
fclose(fileID);

