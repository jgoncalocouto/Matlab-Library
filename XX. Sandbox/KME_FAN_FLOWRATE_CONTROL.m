function [F_fan,P_fan,V_dot_fan, DeltaP_fan, DeltaP_venturi,P_venturi1,P_venturi2,N_fan] = KME_FAN_FLOWRATE_CONTROL(T_amb,h,L_duct,D_duct,N_elbows,V_dot_fan_sp)
%Returns the aeraulic working point of C4 KME fan based on the fluid properties and flow rate set-point

%%Inputs:
%T_amb - Ambient Temperature - [°C]
%h - Altitude - [m]
%L_duct - Exhaust Gas Duct Length - [m]
%D_duct - Duct Diameter - [m]
%N_elbows - Number of elbows in the exhaust gas ductwork
%V_dot_fan_sp - Flow Rate Set-point - [l/min]

%%Outputs:
%V_dot_fan - Volumetric Flow Rate across the fan at T_amb and P_atm@h -[l/min}
%DeltaP_fan - Pressure Difference across the fan - [mbar]
%DeltaP_venturi - Pressure difference in the venturi pressure taps - [mbar]
%P_venturi1 - Relative Pressure in the venturi's pressure tap (stagnation point) - [mbar]
%P_venturi2 - Relative Pressure in the venturi's pressure tap (venturi's throat) - [mbar]
%N_fan - Fan Rotational Speed - [Hz]



for i=1:length(V_dot_fan_sp)

    E_rel=100;
    N_iter=600./60;
    N=0;
 while E_rel>0.1
    [F_fan(i),P_fan(i),V_dot_fan(i), DeltaP_fan(i), DeltaP_venturi(i),P_venturi1(i),P_venturi2(i)] = KME_FAN_FANSPEED_CONTROL( T_amb(i),h(i),L_duct(i),D_duct(i),N_elbows(i),N_iter);
     E_rel=abs(((V_dot_fan(i)-V_dot_fan_sp(i))./(V_dot_fan_sp(i))).*100);
     
     N_fan(i)=N_iter;
     N_iter=N_iter+1./60;
     N=N+1;
     
     if N>10000
     return
     end
     
 end
        
end


