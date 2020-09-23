
CO2=[2.5:0.25:10]
T_air=22;
T_gas=22;
Qn=11;
h=0;

T_exg=zeros(length(CO2));

for i=1:length(CO2)
T_exg_86(i)=exhaust_gases_temperature('G20',Qn,CO2(i),0.86,T_air,T_gas,h);
T_exg_90(i)=exhaust_gases_temperature('G20',Qn,CO2(i),0.9,T_air,T_gas,h);
T_exg_95(i)=exhaust_gases_temperature('G20',Qn,CO2(i),0.95,T_air,T_gas,h);

end

figure
plot(CO2,T_exg_86,'-*',CO2,T_exg_90,'-o',CO2,T_exg_95,'-x')