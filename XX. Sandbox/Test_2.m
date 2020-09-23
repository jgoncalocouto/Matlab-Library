P_venturi1_state=1;
P_venturi2_state=1;
T_amb=22; %[°C]
h=0;
L_duct=4;
D_duct=80*10^-3;
N_elbows=1;

Input=[
105	300
112.6666667	315
128	315
169.4285714	550
186	650
201	775
216	775
    ];

Exhausthood=[720	291.1343883
860	343.1051671
1230	518.077441
1760	953.3138632
2010	1174.602888
2040	1212.089115
];



i=0;
P_fan=zeros(length(Input(:,1)),1);
F_fan=zeros(length(Input(:,1)),1);
V_dot_fan=zeros(length(Input(:,1)),1);
DeltaP_fan=zeros(length(Input(:,1)),1);
DeltaP_venturi=zeros(length(Input(:,1)),1);
P_venturi1=zeros(length(Input(:,1)),1);
P_venturi2=zeros(length(Input(:,1)),1);
N_fan=zeros(length(Input(:,1)),1);
for i=1:length(Input(:,1))

    [F_fan(i),P_fan(i),V_dot_fan(i), DeltaP_fan(i), DeltaP_venturi(i),P_venturi1(i),P_venturi2(i),N_fan(i)] = KME_FAN_FLOWRATE_CONTROL(T_amb,h,L_duct,D_duct,N_elbows,Input(i,2));
end
N_fan=N_fan.*60;

hold on
plot(N_fan,V_dot_fan,'-b')
hold on

