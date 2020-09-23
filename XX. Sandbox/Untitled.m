%Simulation with various inlet pressures but the same geometry

%List of Cases A
%Case A.1
i_gv=[5:5:200];
P_in=29;
gas_type='G30'
Injector_marking=65
N_inj=18;
D_inj=0.65;
T_gas=20;
Patm=1013.25;

for i=1:length(i_gv) 
[Pburner_actual_up(i),Vgas_actual_up(i),Qn_gas_actual_up(i),Pburner_actual_nom(i),Vgas_actual_nom(i),Qn_gas_actual_nom(i),Pburner_actual_low(i),Vgas_actual_low(i),Qn_gas_actual_low(i)] = Gv_kme(i_gv(i),P_in,gas_type,Injector_marking,N_inj,D_inj,T_gas,Patm);
if isnan(Vgas_actual_up(i))==1
    Vgas_actual_up(i)=0;
elseif isnan(Qn_gas_actual_up(i))==1
Qn_gas_actual_up(i)=0;
elseif isnan(Vgas_actual_nom(i))==1
    Vgas_actual_nom(i)=0;
elseif isnan(Qn_gas_actual_nom(i))==1
Qn_gas_actual_nom(i)=0;
elseif isnan(Vgas_actual_low(i))==1
    Vgas_actual_low(i)=0;
elseif isnan(Qn_gas_actual_low(i))==1
Qn_gas_actual_low(i)=0;
end
end

figure
subplot(2,3,1)
plot(i_gv,Pburner_actual_up,'*',i_gv,Pburner_actual_nom,'+',i_gv,Pburner_actual_low,'o')
title({strcat('Gas Valve performance curve at P_{in}= ',string(P_in),' [mbar]'),strcat(string(gas_type),' ; ','Injector marking =',string(Injector_marking))})
xlabel('Intensity of current - I_{GV} - [mbar]')
ylabel('Burner Pressure - P_{burner} - [mbar]')
legend('Upper Limit','Nominal','Lower Limit')


subplot(2,3,4)
plot(i_gv,Qn_gas_actual_up,'*',i_gv,Qn_gas_actual_nom,'+',i_gv,Qn_gas_actual_low,'o')
title({strcat('Gas Valve performance curve at P_{in}= ',string(P_in),' [mbar]'),strcat(string(gas_type),' ; ','Injector marking =',string(Injector_marking))})
xlabel('Intensity of current - I_{GV} - [mbar]')
ylabel('Power Input - Q_{n} - [kW]')
legend('Upper Limit','Nominal','Lower Limit')



%Case A.2
P_in=20;


for i=1:length(i_gv) 
[Pburner_actual_up(i),Vgas_actual_up(i),Qn_gas_actual_up(i),Pburner_actual_nom(i),Vgas_actual_nom(i),Qn_gas_actual_nom(i),Pburner_actual_low(i),Vgas_actual_low(i),Qn_gas_actual_low(i)] = Gv_kme(i_gv(i),P_in,gas_type,Injector_marking,N_inj,D_inj,T_gas,Patm);
if isnan(Vgas_actual_up(i))==1
    Vgas_actual_up(i)=0;
elseif isnan(Qn_gas_actual_up(i))==1
Qn_gas_actual_up(i)=0;
elseif isnan(Vgas_actual_nom(i))==1
    Vgas_actual_nom(i)=0;
elseif isnan(Qn_gas_actual_nom(i))==1
Qn_gas_actual_nom(i)=0;
elseif isnan(Vgas_actual_low(i))==1
    Vgas_actual_low(i)=0;
elseif isnan(Qn_gas_actual_low(i))==1
Qn_gas_actual_low(i)=0;
end
end


subplot(2,3,2)
plot(i_gv,Pburner_actual_up,'*',i_gv,Pburner_actual_nom,'+',i_gv,Pburner_actual_low,'o')
title({strcat('Gas Valve performance curve at P_{in}= ',string(P_in),' [mbar]'),strcat(string(gas_type),' ; ','Injector marking =',string(Injector_marking))})
xlabel('Intensity of current - I_{GV} - [mbar]')
ylabel('Burner Pressure - P_{burner} - [mbar]')
legend('Upper Limit','Nominal','Lower Limit')


subplot(2,3,5)
plot(i_gv,Qn_gas_actual_up,'*',i_gv,Qn_gas_actual_nom,'+',i_gv,Qn_gas_actual_low,'o')
title({strcat('Gas Valve performance curve at P_{in}= ',string(P_in),' [mbar]'),strcat(string(gas_type),' ; ','Injector marking =',string(Injector_marking))})
xlabel('Intensity of current - I_{GV} - [mbar]')
ylabel('Power Input - Q_{n} - [kW]')
legend('Upper Limit','Nominal','Lower Limit')



%Case A.3
P_in=45;


for i=1:length(i_gv) 
[Pburner_actual_up(i),Vgas_actual_up(i),Qn_gas_actual_up(i),Pburner_actual_nom(i),Vgas_actual_nom(i),Qn_gas_actual_nom(i),Pburner_actual_low(i),Vgas_actual_low(i),Qn_gas_actual_low(i)] = Gv_kme(i_gv(i),P_in,gas_type,Injector_marking,N_inj,D_inj,T_gas,Patm);
if isnan(Vgas_actual_up(i))==1
    Vgas_actual_up(i)=0;
elseif isnan(Qn_gas_actual_up(i))==1
Qn_gas_actual_up(i)=0;
elseif isnan(Vgas_actual_nom(i))==1
    Vgas_actual_nom(i)=0;
elseif isnan(Qn_gas_actual_nom(i))==1
Qn_gas_actual_nom(i)=0;
elseif isnan(Vgas_actual_low(i))==1
    Vgas_actual_low(i)=0;
elseif isnan(Qn_gas_actual_low(i))==1
Qn_gas_actual_low(i)=0;
end
end


subplot(2,3,3)
plot(i_gv,Pburner_actual_up,'*',i_gv,Pburner_actual_nom,'+',i_gv,Pburner_actual_low,'o')
title({strcat('Gas Valve performance curve at P_{in}= ',string(P_in),' [mbar]'),strcat(string(gas_type),' ; ','Injector marking =',string(Injector_marking))})
xlabel('Intensity of current - I_{GV} - [mbar]')
ylabel('Burner Pressure - P_{burner} - [mbar]')
legend('Upper Limit','Nominal','Lower Limit')


subplot(2,3,6)
plot(i_gv,Qn_gas_actual_up,'*',i_gv,Qn_gas_actual_nom,'+',i_gv,Qn_gas_actual_low,'o')
title({strcat('Gas Valve performance curve at P_{in}= ',string(P_in),' [mbar]'),strcat(string(gas_type),' ; ','Injector marking =',string(Injector_marking))})
xlabel('Intensity of current - I_{GV} - [mbar]')
ylabel('Power Input - Q_{n} - [kW]')
legend('Upper Limit','Nominal','Lower Limit')


