
CO2=[2.5:0.25:10]
Qn=22;
eta=0.86;
T_air=22;
T_gas=22;
h=0;

T_exg=zeros(length(CO2));

for i=1:length(CO2)
T_exg(i)=exhaust_gases_temperature('G20',Qn,CO2(i),eta,T_air,T_gas,h);

end

figure
plot(CO2,T_exg)