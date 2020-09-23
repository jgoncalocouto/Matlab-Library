    % Inputs:
gastype='G30';
T_ref=15; % For deltaP venturi calc
% lambda_1=1.15;
% CO2_sec=10.89;
% Q_actual=11;
% CO2_duct=6;

% input=[
%     8	1.53	7.21	5.09
%     14.1	1.12	10.18	8.17
%     19.5	1.16	10.36	6.9
%     22	1.15	10.89	5.78
%     ];


input=[
    7.2	1.75	3.90	3.03
    9.05	1.70	4.96	3.84
    13.8	1.34	5.81	4.41
    20.9	1.22	7.39	5.3
    ];

Input_table=array2table(input);
Input_table.Properties.VariableNames={'Q','Lambda_1','CO2_finblock','CO2_duct'};

i=0;
for i=1:size(input)
    
    lambda_1=input(i,2);
    CO2_sec=input(i,3);
    Q_actual=input(i,1);
    CO2_duct=input(i,4);
    
    
    % Assumptions:
    h=0;
    P_atm=P_altitude(h);
    Hi=heatingvalues(gastype,'Hi');
    
    % Gas
    Vdot_gas=Q_actual/(Hi*1000);
    rho_gas_std=densityz(gastype,15,P_atm);
    mdot_gas=Vdot_gas*rho_gas_std;
    
    
    % Primary Air
    AFR_stoich=afr(gastype,'vol');
    Vdot_air_1=AFR_stoich*lambda_1*Vdot_gas;
    rho_air_std=densityz('Air',15,P_atm);
    mdot_air_1=Vdot_air_1.*rho_air_std;
    
    % Primary Exhaust Gases
    rho_exg_std=densityz_exg(lambda_1,gastype,15,0);
    Vdot_exg_1=(mdot_air_1+mdot_gas)/(rho_exg_std);
    mdot_exg_1=Vdot_exg_1*rho_exg_std;
    
    [X_CO2_w1,X_H2O_w1,X_N2_w1,X_O2_w1]=exgases_fraction(lambda_1,gastype,'wet');
    [X_CO2_d1,X_H2O_d1,X_N2_d1,X_O2_d1]=exgases_fraction(lambda_1,gastype,'dry');
    
    M_CO2=12.01+16*2;
    M_H2O=2*1.008+16;
    M_N2=28.02;
    M_O2=16*2;
    
    M_exg_1=X_CO2_w1*M_CO2+X_H2O_w1*M_H2O+X_N2_w1*M_N2+X_O2_w1*M_O2;
    Ndot_exg_1_dry=(mdot_exg_1/M_exg_1)-((mdot_exg_1/M_exg_1)*X_H2O_w1);
    Ndot_CO2_1_dry=Ndot_exg_1_dry*X_CO2_d1;
    
    % Secondary Air
    Ndot_air_2=(Ndot_CO2_1_dry/(CO2_sec/100))-Ndot_exg_1_dry;
    M_air= 28.9647;
    mdot_air_2=Ndot_air_2*M_air;
    Vdot_air_2=mdot_air_2/(rho_air_std);
    
    % Tertiary Air
    Ndot_air_3=(Ndot_CO2_1_dry/(CO2_duct/100))-Ndot_exg_1_dry-Ndot_air_2;
    mdot_air_3=Ndot_air_3*M_air;
    Vdot_air_3=mdot_air_3/(rho_air_std);
    
    % Air fractions
    y_air_3=mdot_air_3/(mdot_air_2+mdot_air_1+mdot_air_3);
    y_air_2=mdot_air_2/(mdot_air_2+mdot_air_1+mdot_air_3);
    y_air_1=mdot_air_1/(mdot_air_2+mdot_air_1+mdot_air_3);
    
    DeltaP_venturi_pr=(((Vdot_air_1*60000)/11809)^2)/(1/(273.15+T_ref));
    DeltaP_venturi_pr_sec=(((((Vdot_air_2+Vdot_air_1))*60000)/11809)^2)/(1/(273.15+T_ref));
    DeltaP_venturi_total=((((Vdot_air_3+Vdot_air_2+Vdot_air_1)*60000)/11809)^2)/(1/(273.15+T_ref));    
    
    output(i,1)=y_air_1*100;
    output(i,2)=y_air_2*100;
    output(i,3)=y_air_3*100;
    output(i,4)=Vdot_air_1*60000;
    output(i,5)=Vdot_air_2*60000;
    output(i,6)=Vdot_air_3*60000;
    output(i,7)=DeltaP_venturi_pr;
    output(i,8)=DeltaP_venturi_pr_sec;
    output(i,9)=DeltaP_venturi_total;    
    
    Output_table=array2table(output);
    Output_table.Properties.VariableNames={'y_air_1','y_air_2','y_air_3','Vdot_air_1','Vdot_air_2','Vdot_air_3','DeltaP_venturi_pr','DeltaP_venturi_pr_sec','DeltaP_venturi_total'};
    
end

figure
hold on
title('Mass fractions of primary, secondary and tertiary air')
plot(Input_table.Q,Output_table.y_air_1);
plot(Input_table.Q,Output_table.y_air_2);
plot(Input_table.Q,Output_table.y_air_3);
xlabel('Power Input - Q - [kW]')
ylabel('Mass fraction - y - [%]')
legend('Primary air', 'Secondary Air', 'Tertiary Air')

figure
hold on
title('Pressure difference in the venturi for different cases')
plot(Input_table.Q,Output_table.DeltaP_venturi_pr);
plot(Input_table.Q,Output_table.DeltaP_venturi_pr_sec);
plot(Input_table.Q,Output_table.DeltaP_venturi_total);
xlabel('Power Input - Q - [kW]')
ylabel('Pressure Difference in the venturi - \DeltaP_{venturi} - [mbar]')
legend('Only Primary air', 'Primary Air + Secondary Air', 'Primary Air + Secondary Air+Tertiary Air')


