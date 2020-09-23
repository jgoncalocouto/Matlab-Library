function [P_burner] = Gv_kme(I_gv,Mechanical_tuning,P_in,limit_sample_position,Manifold,Ambient_conditions)
% Inputs:
% I_gv - Valve Current [mA]

% Mechanical_tuning
    % - Min_tuning - Pressure value at which the minimum adjustment screw has truncated the gas valve: inferior limit - [mbar]
    % - Max_Tuning - Pressure value at which the maximum adjustment screw has truncated the gas valve: superior limit - [mbar]
% P_in - Inlet Pressure - [mbar]
% limit_sample_position - Position of the gas valve sample in the population {Nominal,Upper,Lower} - [-]
% Manifold: 
    % - appliance_type; 
    % - marking;
    % - N;
% Ambient_conditions
    % - T
    % - P
    % - Gas_type

% Outputs
% P_burner - Burner Pressure - [mbar]

%%Gas Valve Performance Curves
%Nominal Curve
gvcharacteristic.nom=[45	1.22
50	1.65
56.64851819	2.385877109
62.82813225	3.115205704
63.04258997	3.141449607
69.30749446	3.9388235
70.50225622	4.098101138
75.94317704	4.856305645
78.13182834	5.177838239
82.59872422	5.867294002
85.72992922	6.380080372
89.14969178	6.971481178
93.11893824	7.704338126
95.48839313	8.168599463
100.1538816	9.150191411
101.5281083	9.458412886
106.7298305	10.71727436
107.2065009	10.84071135
112.4879721	12.31530617
112.7871274	12.40526445
117.3646672	13.88202665
118.3137186	14.21387455
121.8558292	15.54071734
123.3438198	16.14284675
126.0051795	17.29123592
127.9520936	18.19194775
129.875986	19.13345136
132.2424642	20.36096506
133.5434616	21.06724257
136.3306445	22.64970414
137.084119	23.09249712
140.3193953	25.05798592
140.5616862	25.20911029
144.0091739	27.41698421
144.2654898	27.58564484
148.1372961	30.23252724
151.7618475	32.99848998
154.7602096	35.88339926];

%Upper Limit Curve
gvcharacteristic.upper=[28.18892696	0.952327612
    39.78838994	1.96132178
    48.17637466	2.843541001
    55.31538892	3.66250453
    64.06154252	4.858827793
    70.6665239	5.928771456
    77.45072975	7.187164366
    84.41388001	8.571212071
    93.69938721	10.70964979
    101.2004909	12.72183969
    106.9160709	14.35660396
    112.2748822	15.99123645
    117.4561493	17.81418641
    124.070652	21.01914144
    128.1838533	23.34405166
    130.5090106	24.72638619
    134.6247323	27.61644648
    136.7720654	29.12430402
    138.9196785	30.69495602
    142.1420782	33.27071459
    145.0085494	36.03472474];

%Lower Limit Curve
gvcharacteristic.lower=[57.97938531	1.024517568
    65.47572174	1.967721085
    75.11350909	3.099802142
    82.9668938	4.105833263
    92.78362469	5.363372165
    100.9948965	6.620318973
    109.2081255	8.316137977
    117.0662634	10.38800157
    122.0677354	11.89454831
    129.2134543	14.21693286
    136.5403536	17.16634348
    139.9374849	18.92308224
    144.7658849	21.62078771
    147.9863095	23.75363685
    151.3851184	25.88655177
    154.2484947	27.9565733
    157.4700376	30.34020654
    160.8705241	32.84929763
    165.1648896	35.79758985];



%% GV Characteristic Curve

%Calculation of Pburner with intensity of current applied for nominal,
%upper and lower limit gas valves assuming GV is truncated in min to 0 and
%in max to 35.8 mbar

% Select Gas Valve Characteristic curve in function of Limit Sample Position

if strcmp(limit_sample_position,'Nominal')==1
    gv_curve=gvcharacteristic.nom;
elseif strcmp(limit_sample_position,'Lower')==1
    gv_curve=gvcharacteristic.lower;
elseif strcmp(limit_sample_position,'Upper')==1
    gv_curve=gvcharacteristic.upper;
else
    error('Limit Sample Position must be: Nominal, Upper or Lower')
    return
end

P_burner=interp1_sat(gv_curve(:,1),gv_curve(:,2),I_gv);

%% Mechanical Tuning Function

if P_burner<= Mechanical_tuning.Min_tuning
    P_burner=Mechanical_tuning.Min_tuning;
elseif P_burner>=Mechanical_tuning.Max_tuning
    P_burner=Mechanical_tuning.Max_tuning;
end

%% Pressure Regulation Function
% Truncates Pburner to the maximum possible according to GV pressure loss

Re=[3709.26 8008.54 11790.94];
K_GV=[121.54 103.61 77.40];

A=Manifold.N.*pi*0.25*((Manifold.marking/100000)^2);
D_GVinlet=19/1000;
A_GVinlet=pi*0.25*D_GVinlet^2;
rho=densityz(Ambient_conditions.Gas_type,Ambient_conditions.T,Ambient_conditions.P);
mu=viscosityd(Ambient_conditions.Gas_type,Ambient_conditions.T);
[CD] =cd_model(Manifold.appliance_type,Manifold.marking,rho,mu,Manifold.N,P_burner);
Vdot_gas=vgas_calc(CD,rho,P_burner,A);

Re_actual=(rho*(Vdot_gas/A_GVinlet)*(Manifold.marking/100))/mu;
K_GV_actual=interp1_sat(Re,K_GV,Re_actual);

DP_loss=(K_GV_actual*0.5*rho*((Vdot_gas/A_GVinlet)^2))/100;

if P_burner+DP_loss>P_in
    P_burner=P_in-DP_loss;
end


end

