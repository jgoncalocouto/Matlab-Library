Min_tuning=2.4;
Max_tuning=30.3;
limit_sample_position='Nominal';
Manifold.N=15;
Manifold.marking=65;
Manifold.appliance_type='C4 KME';
Manifold.A=Manifold.N.*pi*0.25*((Manifold.marking/100000)^2);

Ambient_conditions.T=15;
Ambient_conditions.P=1013.25;
Ambient_conditions.Gas_type='G31';
Hi=heatingvalues(Ambient_conditions.Gas_type,'Hi');

rho_gas=densityz(Ambient_conditions.Gas_type,Ambient_conditions.T,Ambient_conditions.P);
mu_gas=viscosityd(Ambient_conditions.Gas_type,Ambient_conditions.T);

P_in=[37]';

I_gv=[25:5:165]';

i=0;
j=0;

for j=1:size(P_in,1)
    
for i=1:size(I_gv,1)
P_burner(i,j) = Gv_kme(I_gv(i),Min_tuning,Max_tuning,P_in(j),limit_sample_position,Manifold,Ambient_conditions); %[mbar]
CD =cd_model(Manifold.appliance_type,Manifold.marking,rho_gas,mu_gas,Manifold.N,P_burner(i,j)); %[-]
V_gas(i,j)=vgas_calc(CD,rho_gas,P_burner(i,j),Manifold.A); %[m^3/s]
Qn(i,j)=V_gas(i,j).*Hi.*1000; %[kW]
end
plot(I_gv,Qn(:,j));
hold on
leg(j)=string(horzcat('P_{inlet}= ',num2str(P_in(j)),' [mbar]'));

end
legend(leg(:))
