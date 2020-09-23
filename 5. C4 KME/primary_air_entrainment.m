
%Definition of gas types
gt_1='G20'; %High-momentum gas
gt_2='Air'; %Gas subsjected to entrainment

%Combustible gas properties
Qn=22;
N_inj=15;
hi_gas=heatingvalues(gt_1,'Hi');
AFR_gas=afr(1,1,gt_1,'vol');
V_gas=((Qn*1000)./(hi_gas.*10^6))./N_inj; %Only one injector considered


%Pressure
P_0=P_altitude(0).*100; %Ambient Pressure at Injection Section
P_4=P_0; %Ambient Pressure at Burner Surface
P_gas=P_0; %Discharged combustible gas is at ambient pressure
P_airp=P_0; %Primary air is at ambient pressure

% Temperature
T_gas=15; %Gas Temperature
T_airp=15; %Primary Air Temperature

%Density
rho_gas=densityz(gt_1,T_gas,P_gas./100);
rho_airp=densityz(gt_2,T_airp,P_airp./100);

%Gas Mass Flow Rate
m_gas=V_gas.*rho_gas;


%Local pressure loss coefficients
K_1a=1200; %Primary Air entrance region
K_2t3=1200; % Constant-section region
K_3t4=1200; %Divergent section

%Geometry
D_inj=1*10^-3; %Injector diameter
A_inj=pi*0.25*(D_inj)^2; %Injector discharge area
A_2=pi*0.25*(10*10^-3)^2; % Constant-section area
A_1=2.*A_2; %Primary Air entrance section
A_3=1.5.*A_2; %Divergent Section 
x=[0,1,2,3,4]; %Section definition




%Initial Solver parameters
E_rel=1;
lambda_pr=0.1;
i=0;

while E_rel>1*10^-3
V_airp=AFR_gas.*V_gas.*lambda_pr;
m_airp=V_airp.*rho_airp;
P_1=P_0-((rho_airp./2).*(((m_airp)/(rho_airp.*A_1)).^2).*(1+K_1a));
m_mixp=m_gas+m_airp;
v_1a=((m_airp)/(rho_airp.*A_1));
v_1g=((m_gas)/(rho_gas.*A_inj));

X_gas=(m_gas./(rho_gas))/(((m_gas./(rho_gas)))+((m_airp./(rho_airp))));
X_airp=(m_airp./(rho_airp))/(((m_gas./(rho_gas)))+((m_airp./(rho_airp))));
rho_mixp=X_gas.*rho_gas+X_airp.*rho_airp;

v_2=m_mixp./(rho_mixp.*A_2);

P_2=(P_1.*A_1+m_gas.*v_1g+m_airp.*v_1a-m_mixp.*v_2)./A_2;
P_3=P_2-((rho_mixp./2).*(((m_mixp)./(rho_mixp.*A_2)).^2).*(1+K_2t3));
P_4iter=P_3-((rho_mixp./2).*(((m_mixp)./(rho_mixp.*A_3)).^2).*(1+K_3t4));




E_rel=abs((P_4-P_4iter)./P_4)

if (P_4-P_4iter)./P_4>1*10^-3
    lambda_pr=lambda_pr-0.001;
else
   lambda_pr=lambda_pr+0.001 ;
end

i=i+1;
end
P(1)=P_0./100;
P(2)=P_1./100;
P(3)=P_2./100;
P(4)=P_3./100;
P(5)=P_4./100;

[X_CO2,X_H2O,X_N2,X_O2]=exgases_fraction(lambda_pr,1,1,gt_1,'dry');
figure
plot(x,P)


