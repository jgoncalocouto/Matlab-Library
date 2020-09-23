%Calculation at AvP Tuning Conditions
gastype_0='G31';
Hi_0=heatingvalues(gastype_0,'Hi');
afr_0=afr(1,1,gastype_0,'vol');
h_0=0;
Patm_0=P_altitude(h_0);
Tair_0=15;
Tgas_0=15;
rho_0=densityz(gastype_0,Tgas_0,Patm_0);

%P1
Pi_0_p1=53.39;
CO2_0_p1=9.9;
lambda_0_p1=lambda_calc(gastype_0,CO2_0_p1/100,1,1);
Vgas_0_p1=(Pi_0_p1*1000)/(Hi_0*10^6);
Vair_0_p1=Vgas_0_p1*lambda_0_p1*afr_0;
Vair1_0_p1=W2_Primary_air(Vair_0_p1*60000)/60000;
k_restriction_0=76;

%P2
Pi_0_p2=8.8;
CO2_0_p2=2.8;
lambda_0_p2=lambda_calc(gastype_0,CO2_0_p2/100,1,1);
Vgas_0_p2=(Pi_0_p2*1000)/(Hi_0*10^6);
Vair_0_p2=Vgas_0_p2*lambda_0_p2*afr_0;
Vair1_0_p2=W2_Primary_air(Vair_0_p2*60000)/60000;
Poffset_0=-50;


Vair1_0=linspace(Vair1_0_p2*60000,Vair1_0_p1*60000,25);
Vgas_0=W2_venturimixer(gastype_0,Poffset_0,Patm_0,Tair_0,Tgas_0,Vair1_0,k_restriction_0);
Pi_0=(Vgas_0./60000).*Hi_0.*10^6./1000;
lambda_0=(Vair1_0./Vgas_0)./afr_0;

[CO2_0,H2O_0,N2_0,O2_0]=exgases_fraction(lambda_0,1,1,gastype_0,'dry');
CO2_0=CO2_0.*100;
H2O_0=H2O_0.*100;
N2_0=N2_0.*100;
O2_0=O2_0.*100;

hold on
plot(Pi_0,CO2_0,'*');
title('Sea Level');
xlabel('Power Input [kW]')
ylabel('CO2 concentration [%]')



% %Calculation at Mx Conditions
% 
% gastype_a='G30'
% gastype_b='G31'
% x_a=0.4;
% x_b=0.6;
% 
% h_1=2500;
% Patm_1=P_altitude(h_1);
% Tair_1=Tair_0;
% Tgas_1=Tgas_0;
% 
% Hi_1=heatingvalues(gastype_a,'Hi')*x_a+heatingvalues(gastype_b,'Hi')*x_b;
% afr_1=x_a*afr(1,1,gastype_a,'vol')+x_b*afr(1,1,gastype_b,'vol');
% rho_1=densityz(gastype_a,Tgas_1,Patm_1)*x_a+densityz(gastype_b,Tgas_1,Patm_1)*x_b;
% rho_ref_1=densityz(gastype_a,Tgas_0,Patm_0)*x_a+densityz(gastype_b,Tgas_0,Patm_0)*x_b;
% 
% 
% 
% Vair1_1=Vair1_0;
% k_restriction_1=k_restriction_0;
% Poffset_1=Poffset_0;
% 
% Vgas_1=W2_venturimixer(gastype_a,Poffset_1,Patm_1,Tair_1,Tgas_1,Vair1_0,k_restriction_1)*x_a+W2_venturimixer(gastype_b,Poffset_1,Patm_1,Tair_1,Tgas_1,Vair1_0,k_restriction_1)*x_b;
% Pi_1=(Vgas_1./60000).*(rho_1/rho_ref_1).*Hi_1.*10^6./1000;
% lambda_1=(Vair1_1./Vgas_1)./afr_1;
% 
% [CO2_a,H2O_a,N2_a,O2_a]=exgases_fraction(lambda_1,1,1,gastype_a,'dry');
% [CO2_b,H2O_b,N2_b,O2_b]=exgases_fraction(lambda_1,1,1,gastype_b,'dry');
% 
% CO2_1=(CO2_a.*x_a+CO2_b.*x_b).*100;
% H2O_1=(H2O_a.*x_a+H2O_b.*x_b).*100;
% N2_1=(N2_a.*x_a+N2_b.*x_b).*100;
% O2_1=(O2_a.*x_a+O2_b.*x_b).*100;
% 
% plot(Pi_1,CO2_1,'+');


