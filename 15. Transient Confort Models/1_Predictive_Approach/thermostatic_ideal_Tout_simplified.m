function [T_out_expected] = thermostatic_ideal_Tout_simplified(T_sp,T_in,p_water,Vdot_water,capacity,gas_type)
%thermostatic_ideal_power_simplified: calculates the power required to reach a given setpoint temperature or the value closest to that objective if reaching the setpoint is not possible (C4 KME only)

%INPUTS:
% - T_sp : Set-point temperature - [ºC]
% - T_in : Inlet Water temperature - [ºC]
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
    
    
    cp(j)=4.178;
    rho(j)=993;
    N=SW.Efficiency.(gas_type)(:,1).*SW.Efficiency.(gas_type)(:,2).*(1/100);
    
    
    P(j)=(Vdot_water(j)*cp(j)*rho(j)*(1/60000)*(T_out(j)-T_in(j)));
    
    Q(j)=interp1_sat(N,SW.Efficiency.(gas_type)(:,1),P(j));
    
    if Q(j)>max(SW.Flowrate.(gas_type)(:,1))
        Q(j)=max(SW.Flowrate.(gas_type)(:,1));
    elseif Q(j)<min(SW.Flowrate.(gas_type)(:,1))
        Q(j)=min(SW.Flowrate.(gas_type)(:,1));
    end
    
    eta(j)=interp1_sat(SW.Efficiency.(gas_type)(:,1),SW.Efficiency.(gas_type)(:,2),Q(j));
    T_out_calc(j)=((Q(j)*eta(j)*(1/100))/(Vdot_water(j)*rho(j)*cp(j)*(1/60000)))+T_in(j);
    
    T_out_expected(j)=T_out_calc(j);
    sm_status(j) = solar_mode_status(T_in(j),T_out_expected(j),T_sp(j));
    
    if sm_status(j)==1
        Q(j)=0;
    end
    
end


