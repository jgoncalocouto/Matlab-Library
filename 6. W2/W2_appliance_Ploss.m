
D=80*10^-3;
A=pi*0.25*D^2;
g=9.81;
z_1=0;
z_2=0.7;

lambda=[1.271239037
1.357035334
1.433128771
1.625395126
1.883904511
2.286987255];

V_air=[0.020065416
0.018862668
0.018052241
0.016416031
0.014831742
0.012741664];

T_2=[49
48
44.8
48.8
41.6
28.7];

P_2=[-43
-38.5
-35.5
-33
-25.5
-18.5];


T_1=20;
P_1=1013.25;
rho_1=densityz('Air',T_1,P_1);


for i=1:length(lambda)
[X_CO2(i,1) X_H2O(i,1) X_N2(i,1) X_O2(i,1)]=exgases_fraction(lambda(i),1,1,'G30','dry');
T_12(i)=(T_2(i)+T_1)/2;
rho_2(i)=X_CO2(i,1)*densityz('CO2',T_12(i),P_1)+X_O2(i,1)*densityz('O2',T_12(i),P_1)+X_N2(i,1)*densityz('N2',T_12(i),P_1);
v_1(i)=V_air(i)/A;
v_2(i)=V_air(i)/A;
DeltaP_line(i)=(ploss_inline(1.74,80,0.03,'CO2',P_1,T_12(i),V_air(i)*60000)*X_CO2(i,1)+ploss_inline(1.74,80,0.03,'N2',P_1,T_12(i),V_air(i)*60000)*X_N2(i,1)+ploss_inline(1.74,80,0.03,'O2',P_1,T_12(i),V_air(i)*60000)*X_O2(i,1))*100;
k_ductwork=2*ploss_local_elbow(D*10^3,45)+2*ploss_local_elbow(D*10^3,90);
DeltaP_duct(i)=k_ductwork*0.5*((rho_1+rho_2(i))/2)*((v_2(i))^2);
DeltaP_appliance(i)=(-P_2(i))-((0.5*rho_2(i)*v_2(i)^2)-0.5*rho_1*v_1(i)^2)-(rho_2(i)*g*z_2-rho_1*g*z_1)-DeltaP_duct(i);
k_appliance(i)=DeltaP_appliance(i)/(0.5*((rho_1+rho_2(i))/2)*(v_2(i)^2));
end

