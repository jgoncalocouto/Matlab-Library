function [Q] = thermostatic_ideal_power(T_sp,T_in,p_water,Vdot_water,capacity,gas_type)
%thermostatic_ideal_power: calculates the power required to reach a given setpoint temperature or the value closest to that objective if reaching the setpoint is not possible (C4 KME only)

%INPUTS:
% - T_sp : Set-point temperature - [�C]
% - T_in : Inlet Water temperature - [�C]
% - P_in : Inlet Water Pressure - [bar]
% - Vdot_water : Water flowrate - [l/min]
% - capacity : Appliance capacity - {'11','14'}
% - gas_type :  Appliance gas type - {'NG','LPG'}

%OUTPUTS:
% - Q - Power Input Request - [kW]


j=0;
for j=1:max(size(Vdot_water,1),size(Vdot_water,2))


T_out(j)=T_sp(j);
SW=KME_SW_calc(capacity);


cp(j)=XSteam('Cp_pT',p_water(j),mean(T_in(j),T_sp(j)));
rho(j)=XSteam('rho_pT',p_water(j),mean(T_in(j),T_sp(j)));
eta(j)=interp1_sat(SW.Efficiency.(gas_type)(:,1),SW.Efficiency.(gas_type)(:,2),mean(SW.Efficiency.(gas_type)(:,1)));
E_rel(j)=100;
N_count(j)=0;
while E_rel(j)>10^-3 && N_count(j)<1000
    
    Q(j)=(Vdot_water(j)*cp(j)*rho(j)*(1/60000)*(T_out(j)-T_in(j)))/(eta(j)*(1/100));
    
    if Q(j)>max(SW.Flowrate.(gas_type)(:,1))
        Q(j)=max(SW.Flowrate.(gas_type)(:,1));
    elseif Q(j)<min(SW.Flowrate.(gas_type)(:,1))
        Q(j)=min(SW.Flowrate.(gas_type)(:,1));
    end
    
    eta(j)=interp1_sat(SW.Efficiency.(gas_type)(:,1),SW.Efficiency.(gas_type)(:,2),Q(j));
    T_out_calc(j)=((Q(j)*eta(j)*(1/100))/(Vdot_water(j)*rho(j)*cp(j)*(1/60000)))+T_in(j);
    cp(j)=XSteam('Cp_pT',p_water(j),(T_in(j)+T_out_calc(j))*0.5);
    rho(j)=XSteam('rho_pT',p_water(j),(T_in(j)+T_out_calc(j))*0.5);
    
    Q_calc(j)=(Vdot_water(j)*cp(j)*rho(j)*(1/60000)*(T_out_calc(j)-T_in(j)))/(eta(j)*(1/100));
    
    E_rel(j)=abs((Q(j)-Q_calc(j))/(Q_calc(j)))*100;
    N_count(j)=N_count(j)+1;
    
end

T_out_expected(j)=T_out_calc(j);
sm_status(j) = solar_mode_status(T_in(j),T_out_expected(j),T_sp(j));

if sm_status(j)==1
    Q(j)=0;
end
end
end


