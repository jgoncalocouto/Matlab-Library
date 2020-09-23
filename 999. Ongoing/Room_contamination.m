%% Inputs

% Time Evolution of Worst-case

CO_wcs=[
    0	6.840983607
    0.033333333	21.57540984
    0.066666667	32.62622951
    0.1	39.99344262
    0.133333333	46.30819672
    0.166666667	52.62295082
    0.25	65.25245902
    0.333333333	75.77704918
    0.416666667	79.46065574
    0.5	85.24918033
    0.666666667	94.72131148
    0.833333333	106.2983607
    1	129.9786885
    1.166666667	183.6540984
    1.333333333	235.7508197
    1.5	281.0065574
    1.65	321
    ];

CO_wcs2=[
    0	20
    0.033333333	32
    0.066666667	62
    0.1	91
    0.133333333	115
    0.166666667	141
    0.25	195
    0.333333333	236
    0.366666667	250
    0.416666667	269
    0.5	297
    0.666666667	338
    0.833333333	362
    1	379
    1.166666667	389
    1.283333333	390
    ];


CO_initial=321;
CO_initial2=390;
RPH=0.64;
% RPH=1;

Profile_selection='M';




%% Effects of CO concentration
R1=[
    3	200
    2	250
    1	750
    ];
t_r1=[0:0.1:3];t_r1=t_r1';
R1_curve=703.74.*t_r1(:).^(-1.244);

R2=[
    8	250
    2	1000
    1	2000
    ];
t_r2=[0:0.1:8];t_r2=t_r2';
R2_curve=2000.*t_r2(:).^(-1);

I1=[
    5	500
    3	1000
    1.5	2000
    ];

t_i1=[0:0.1:5];t_i1=t_i1';
I1_curve=3273.8.*t_i1(:).^(-1.143);

I2=[
    6.5	1000
    3.5	2000
    ];

t_i2=[0:0.1:6.5];t_i2=t_i2';
I2_curve=8132.6.*t_i2(:).^(-1.12);


%% Erp profile
t=[0:0.01:24];t=t';

Erp_profile.M=[
    0	0
    0.0000000000000001	10.4650000000000
    0.0100000000000000	10.4650000000000
    0.0100000000000001	0
    0.0800000000000000	0
    0.0800000000000001	20.9300000000000
    0.150000000000000	20.9300000000000
    0.150000000000001	0
    0.500000000000000	0
    0.500000000000001	10.4650000000000
    0.510000000000000	10.4650000000000
    0.510000000000001	0
    1.02000000000000	0
    1.02000000000001	10.4650000000000
    1.03000000000000	10.4650000000000
    1.03000000000001	0
    1.25000000000000	0
    1.25000000000001	10.4650000000000
    1.26000000000000	10.4650000000000
    1.26000000000001	0
    1.50000000000000	0
    1.50000000000001	10.4650000000000
    1.51000000000000	10.4650000000000
    1.51000000000001	0
    1.75000000000000	0
    1.75000000000001	10.4650000000000
    1.76000000000000	10.4650000000000
    1.76000000000001	0
    2	0
    2.00000000000001	10.4650000000000
    2.01000000000000	10.4650000000000
    2.01000000000001	0
    2.50000000000000	0
    2.50000000000001	10.4650000000000
    2.51000000000000	10.4650000000000
    2.51000000000001	0
    3.50000000000000	0
    3.50000000000001	10.4650000000000
    3.51000000000000	10.4650000000000
    3.51000000000001	0
    4.50000000000000	0
    4.50000000000001	10.4650000000000
    4.51000000000000	10.4650000000000
    4.51000000000001	0
    4.75000000000000	0
    4.75000000000001	10.4650000000000
    4.76000000000000	10.4650000000000
    4.76000000000001	0
    5.75000000000000	0
    5.75000000000001	13.9533333300000
    5.77000000000000	13.9533333300000
    5.77000000000001	0
    7.50000000000000	0
    7.50000000000001	10.4650000000000
    7.51000000000000	10.4650000000000
    7.51000000000001	0
    8.50000000000000	0
    8.50000000100001	10.4650000000000
    8.51000000000000	10.4650000000000
    8.51000000100001	0
    9.50000000000000	0
    9.50000000100001	10.4650000000000
    9.51000000000000	10.4650000000000
    9.51000000100001	0
    11	0
    11.0000000010001	10.4650000000000
    11.0100000000000	10.4650000000000
    11.0100000010000	0
    11.2500000000000	0
    11.2500000010000	10.4650000000000
    11.2600000000000	10.4650000000000
    11.2600000010000	0
    11.5000000000000	0
    11.5000000010000	10.4650000000000
    11.5100000000000	10.4650000000000
    11.5100000010000	0
    12	0
    12.0000000010000	10.4650000000000
    12.0100000000000	10.4650000000000
    12.0100000010000	0
    13.5000000000000	0
    13.5000000010000	13.9533333300000
    13.5500000000000	13.9533333300000
    13.5500000010000	0
    14.2500000000000	0
    14.2500000010000	10.4650000000000
    14.2600000000000	10.4650000000000
    14.2600000010000	0
    14.5000000000000	0
    14.5000000010000	20.9300000000000
    14.5700000000000	20.9300000000000
    14.5700000010000	0
    24	0
    ];


Erp_profile.L=[
    0.0000000000	0
    0.0000000001	10.465
    0.0100000000	10.465
    0.0100000001	0
    0.0833333330	0
    0.0833333331	20.93
    0.1502777780	20.93
    0.1502777781	0
    0.5000000000	0
    0.5000000001	10.465
    0.5100000000	10.465
    0.5100000001	0
    0.7500000000	0
    0.7500000001	10.465
    0.7600000000	10.465
    0.7600000001	0
    1.0833333330	0
    1.0833333331	34.88333333
    1.1866666670	34.88333333
    1.1866666671	0
    1.4166666670	0
    1.4166666671	10.465
    1.4266666670	10.465
    1.4266666671	0
    1.5000000000	0
    1.5000000001	10.465
    1.5100000000	10.465
    1.5100000001	0
    1.7500000000	0
    1.7500000001	10.465
    1.7600000000	10.465
    1.7600000001	0
    2.0000000000	0
    2.0000000001	10.465
    2.0100000000	10.465
    2.0100000001	0
    2.5000000000	0
    2.5000000001	10.465
    2.5100000000	10.465
    2.5100000001	0
    3.5000000000	0
    3.5000000001	10.465
    3.5100000000	10.465
    3.5100000001	0
    4.5000000000	0
    4.5000000001	10.465
    4.5100000000	10.465
    4.5100000001	0
    4.7500000000	0
    4.7500000001	10.465
    4.7600000000	10.465
    4.7600000001	0
    5.7500000000	0
    5.7500000001	13.95333333
    5.7725000000	13.95333333
    5.7725000001	0
    7.5000000000	0
    7.5000000001	10.465
    7.5100000000	10.465
    7.5100000001	0
    8.5000000000	0
    8.5000000001	10.465
    8.5100000000	10.465
    8.5100000001	0
    9.5000000000	0
    9.5000000001	10.465
    9.5100000000	10.465
    9.5100000001	0
    11.0000000000	0
    11.0000000001	10.465
    11.0100000000	10.465
    11.0100000001	0
    11.2500000000	0
    11.2500000001	10.465
    11.2600000000	10.465
    11.2600000001	0
    11.5000000000	0
    11.5000000001	10.465
    11.5100000000	10.465
    11.5100000001	0
    12.0000000000	0
    12.0000000001	10.465
    12.0100000000	10.465
    12.0100000001	0
    13.5000000000	0
    13.5000000001	13.95333333
    13.5527777800	13.95333333
    13.5527777801	0
    14.0000000000	0
    14.0000000001	34.88333333
    14.1033333300	34.88333333
    14.1033333301	0
    14.5000000000	0
    14.5000000001	10.465
    14.5100000000	10.465
    14.5100000001	0
    24 0
    ];


Erp_profile.XL=[
    0.0000000000	0
    0.0000000001	10.465
    0.0100000000	10.465
    0.0100000001	0
    0.2500000000	0
    0.2500000001	20.93
    0.3369444440	20.93
    0.3369444441	0
    0.4333333330	0
    0.4333333331	10.465
    0.4433333330	10.465
    0.4433333331	0
    0.7500000000	0
    0.7500000001	34.88333333
    0.8766666670	34.88333333
    0.8766666671	0
    1.0166666670	0
    1.0166666671	10.465
    1.0266666670	10.465
    1.0266666671	0
    1.2500000000	0
    1.2500000001	10.465
    1.2600000000	10.465
    1.2600000001	0
    1.5000000000	0
    1.5000000001	10.465
    1.5100000000	10.465
    1.5100000001	0
    1.7500000000	0
    1.7500000001	10.465
    1.7600000000	10.465
    1.7600000001	0
    2.0000000000	0
    2.0000000001	10.465
    2.0100000000	10.465
    2.0100000001	0
    2.5000000000	0
    2.5000000001	10.465
    2.5100000000	10.465
    2.5100000001	0
    3.0000000000	0
    3.0000000001	10.465
    3.0100000000	10.465
    3.0100000001	0
    3.5000000000	0
    3.5000000001	10.465
    3.5100000000	10.465
    3.5100000001	0
    4.0000000000	0
    4.0000000001	10.465
    4.0100000000	10.465
    4.0100000001	0
    4.5000000000	0
    4.5000000001	10.465
    4.5100000000	10.465
    4.5100000001	0
    4.7500000000	0
    4.7500000001	10.465
    4.7600000000	10.465
    4.7600000001	0
    5.7500000000	0
    5.7500000001	13.95333333
    5.8027777780	13.95333333
    5.8027777781	0
    7.5000000000	0
    7.5000000001	10.465
    7.5100000000	10.465
    7.5100000001	0
    8.0000000000	0
    8.0000000001	10.465
    8.0100000000	10.465
    8.0100000001	0
    8.5000000000	0
    8.5000000001	10.465
    8.5100000000	10.465
    8.5100000001	0
    9.0000000000	0
    9.0000000001	10.465
    9.0100000000	10.465
    9.0100000001	0
    9.5000000000	0
    9.5000000001	10.465
    9.5100000000	10.465
    9.5100000001	0
    10.0000000000	0
    10.0000000001	10.465
    10.0100000000	10.465
    10.0100000001	0
    11.0000000000	0
    11.0000000001	10.465
    11.0100000000	10.465
    11.0100000001	0
    11.2500000000	0
    11.2500000001	10.465
    11.2600000000	10.465
    11.2600000001	0
    11.5000000000	0
    11.5000000001	10.465
    11.5100000000	10.465
    11.5100000001	0
    12.0000000000	0
    12.0000000001	10.465
    12.0100000000	10.465
    12.0100000001	0
    13.5000000000	0
    13.5000000001	13.95333333
    13.5527777800	13.95333333
    13.5527777801	0
    13.7666666700	0
    13.7666666701	34.88333333
    13.8933333300	34.88333333
    13.8933333301	0
    14.2500000000	0
    14.2500000001	10.465
    14.2600000000	10.465
    14.2600000001	0
    24 0
    ];

uni.M=table2array(unique(table(Erp_profile.M)));
uni.L=table2array(unique(table(Erp_profile.L)));
uni.XL=table2array(unique(table(Erp_profile.XL)));



%% Approach 1 - Worst-case scenario: If burner on, CO=CO_steadystate
i=0;
for i=1:size(t,1)
    if interp1_sat(uni.(Profile_selection)(:,1),uni.(Profile_selection)(:,2),t(i))==0
        Ap_1(i,1)=0;
        Ap_1_2(i,1)=0;
    else
        Ap_1(i,1)=CO_initial;
        Ap_1_2(i,1)=CO_initial2;
    end
end

i=0;
for i=3:size(t,1)
    if Ap_1(i,1)==0
        Ap_1(i,1)=Ap_1(i-1,1)*exp(-RPH*(t(i,1)-t(i-1,1)));
        Ap_1_2(i,1)=Ap_1_2(i-1,1)*exp(-RPH*(t(i,1)-t(i-1,1)));
    end
    
end


figure
plot(t(:,1),Ap_1(:,1),'-k')
hold on
plot(t(:,1),Ap_1_2(:,1),'--k')
plot(t_r1,R1_curve,'-b')
plot(t_r2,R2_curve,'--b')
plot(t_i1,I1_curve,'-r')
plot(t_i2,I2_curve,'--r')


ylim([0 2500])
xlabel('Elapsed time - [h]')
ylabel('CO Concentration - [ppm]')
title(horzcat('Oxystop Chamber with Erp Profile:',Profile_selection,' and Worst-case condition for CO contamination'))
yyaxis right
plot(Erp_profile.(Profile_selection)(:,1),Erp_profile.(Profile_selection)(:,2),'-c')
ylabel('Power Output - [kW]')
leg=[
    horzcat('Room Concentration considering Room Ventilation with a RPH= ',num2str(RPH),' with a an appliance with 100k cycles')
    horzcat('Room Concentration considering Room Ventilation with a RPH= ',num2str(RPH),' with a an appliance with 185k cycles')
    string('Reversible effects: Headache, dizziness, nausea')
    string('Reversible effects: Tiredness, confusion')
    string('Irreversible consequences: Unconsciousness, hypotension')
    string('Rapid death by hypoxia')
    
    ];
legend(leg)


%% Approach 2 - Realist Scenario: If burner On CO(t) follows measured behavior in Oxystop Chamber

patamar=zeros(size(Erp_profile.(Profile_selection),1),1);

for i=1:size(Erp_profile.(Profile_selection),1)
    if Erp_profile.(Profile_selection)(i,2)==0
        patamar(i)=0;
    else
        patamar(i)=1;
    end
end

t_start=zeros(size(Erp_profile.(Profile_selection),1),1);
for i=2:size(Erp_profile.(Profile_selection),1)
    if patamar(i-1)==0 && patamar(i)==1
        t_start(i)=Erp_profile.(Profile_selection)(i,1);
        hold_flag=1;
        hold_value=t_start(i);
    elseif patamar(i-1)==1 && patamar(i)==0
        hold_flag=0;
    elseif hold_flag==1
        t_start(i)=hold_value;
    end
end





Ap_2=zeros(size(Erp_profile.(Profile_selection),1),1);
Ap_2_2=zeros(size(Erp_profile.(Profile_selection),1),1);

i=0;
for i=2:size(Erp_profile.(Profile_selection)(:,1),1)
    if patamar(i)==1
        t0_oxystop=interp1_sat(CO_wcs(:,2),CO_wcs(:,1),Ap_2(i-1,1)); % time correspondent to the intial CO
        Ap_2(i,1)=interp1_sat(CO_wcs(:,1),CO_wcs(:,2),(t0_oxystop+(Erp_profile.(Profile_selection)(i,1)-t_start(i))));
        
        t0_oxystop2=interp1_sat(CO_wcs2(:,2),CO_wcs2(:,1),Ap_2_2(i-1,1)); % time correspondent to the intial CO
        Ap_2_2(i,1)=interp1_sat(CO_wcs2(:,1),CO_wcs2(:,2),(t0_oxystop2+(Erp_profile.(Profile_selection)(i,1)-t_start(i))));
    else
        Ap_2(i,1)=Ap_2(i-1,1)*exp(-RPH*(Erp_profile.(Profile_selection)(i,1)-Erp_profile.(Profile_selection)(i-1,1)));
        Ap_2_2(i,1)=Ap_2_2(i-1,1)*exp(-RPH*(Erp_profile.(Profile_selection)(i,1)-Erp_profile.(Profile_selection)(i-1,1)));
    end
    
    
end



figure
plot(Erp_profile.(Profile_selection)(:,1),Ap_2(:,1),'-k')
hold on
plot(Erp_profile.(Profile_selection)(:,1),Ap_2_2(:,1),'--k')
plot(t_r1,R1_curve,'-b')
plot(t_r2,R2_curve,'--b')
plot(t_i1,I1_curve,'-r')
plot(t_i2,I2_curve,'--r')

ylim([0 2500])
xlabel('Elapsed time - [h]')
ylabel('CO Concentration - [ppm]')
title(horzcat('Oxystop Chamber with Erp Profile:',Profile_selection))
yyaxis right
plot(Erp_profile.(Profile_selection)(:,1),Erp_profile.(Profile_selection)(:,2),'-c')
ylabel('Power Output - [kW]')
leg=[
    horzcat('Room Concentration considering Room Ventilation with a RPH= ',num2str(RPH),' with a an appliance with 100k cycles')
    horzcat('Room Concentration considering Room Ventilation with a RPH= ',num2str(RPH),' with a an appliance with 185k cycles')
    string('Reversible effects: Headache, dizziness, nausea')
    string('Reversible effects: Tiredness, confusion')
    string('Irreversible consequences: Unconsciousness, hypotension')
    string('Rapid death by hypoxia')
    ];
legend(leg)



%% Approach 3 - Appliance operation continuously


Ap_3=ones(size(Erp_profile.(Profile_selection),1),1).*CO_initial;
Ap_3_2=ones(size(Erp_profile.(Profile_selection),1),1).*CO_initial2;
Pn=20.*ones(size(Erp_profile.(Profile_selection),1),1);



figure
plot(Erp_profile.(Profile_selection)(:,1),Ap_3(:,1),'-k')
hold on
plot(Erp_profile.(Profile_selection)(:,1),Ap_3_2(:,1),'--k')
plot(t_r1,R1_curve,'-b')
plot(t_r2,R2_curve,'--b')
plot(t_i1,I1_curve,'-r')
plot(t_i2,I2_curve,'--r')

ylim([0 2500])
xlabel('Elapsed time - [h]')
ylabel('CO Concentration - [ppm]')
title('Oxystop Chamber with appliance operating continuously')
yyaxis right
plot(Erp_profile.(Profile_selection)(:,1),Pn,'-c')
ylabel('Power Output - [kW]')
leg=[
    horzcat('Room Concentration considering Room Ventilation with a RPH= ',num2str(RPH),' with a an appliance with 100k cycles')
    horzcat('Room Concentration considering Room Ventilation with a RPH= ',num2str(RPH),' with a an appliance with 185k cycles')
    string('Reversible effects: Headache, dizziness, nausea')
    string('Reversible effects: Tiredness, confusion')
    string('Irreversible consequences: Unconsciousness, hypotension')
    string('Rapid death by hypoxia')
    ];
legend(leg)


