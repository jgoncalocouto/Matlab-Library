%Inputs

T_amb=[20
40
60
80
100
120
];

h=0.*ones(length(T_amb),1);

L_duct=0.5.*ones(length(T_amb),1);

D_duct=(80./1000).*ones(length(T_amb),1);

N_elbows=0.*ones(length(T_amb),1);

N_fan=[1050
1081
1111
1142
1172
1203]./60;

for i=1:length(N_fan)
    [V_dot_fan(i), DeltaP_fan(i), DeltaP_venturi(i),P_venturi1(i),P_venturi2(i)] = KME_FAN_FANSPEED_CONTROL( T_amb(i),h(i),L_duct(i),D_duct(i),N_elbows(i),N_fan(i))
end


