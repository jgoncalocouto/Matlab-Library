function [z]=f_aux(x)
T_amb=x(1);
h=x(2);
L_duct=x(3);
D_duct=x(4);
N_elbows=x(5);
FLOWRATE_ITER=x(6);

[V_dot_fan, DeltaP_fan, DeltaP_venturi,P_venturi1_calc,P_venturi2_calc,N_fan] = KME_FAN_FLOWRATE_CONTROL(T_amb,h,L_duct,D_duct,N_elbows,FLOWRATE_ITER);

z(1)=V_dot_fan;
z(2)=DeltaP_fan;
z(3)=DeltaP_venturi;
z(4)=P_venturi1_calc;
z(5)=P_venturi2_calc;
z(6)=N_fan;

end
