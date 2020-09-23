%Calculation at AvP Tuning Conditions
h=0;
gastype_0='G31';
V_air=linspace(300,1600,100);

for i=1:length(V_air)
V_air1(i)=W2_Primary_air(V_air(i));
end

T_gas=15;
T_air=15;
P_atm_0=P_altitude(h);
P_offset=25;
V_gas_0=W2_venturimixer(gastype_0,P_offset,P_atm_0,T_air,T_gas,V_air1);
Hi_0=heatingvalues(gastype_0,'Hi');
Pi_0=((V_gas_0./60000).*Hi_0).*1000;
lambda_0=(V_air./V_gas_0)./(afr(1,1,gastype_0,'vol'));

for i=1:length(lambda_0)
[X_CO2(i),X_H2O(i),X_N2(i),X_O2(i)]=exgases_fraction(lambda_0(i),1,1,gastype_0,'dry');
X_CO2_0(i)=X_CO2(i).*100;
end

hold on
plot(Pi_0,X_CO2_0,'*');

%Gas Mix Limits for W2
Pi_2=linspace(6,14,100);
Pi_1=linspace(45.6,55,100);

%Gas Type:
X_C4H10=0;
X_C3H8=1;

FLL_MX=W2_flameliftlimit('G31',Pi_2).*X_C3H8+W2_flameliftlimit('G30',Pi_2).*X_C4H10;


plot(Pi_2,FLL_MX,'r')

hold off


% %Calculation at Mx installations assuming the same ductwork
% h=0;
% gastype_0='G31';  
% V_air=linspace(300,1600,100);
% 
% for i=1:length(V_air)
% V_air1(i)=W2_Primary_air(V_air(i));
% end
% T_gas=15;
% T_air=15;
% P_atm=P_altitude(h);
% P_offset=0;
% V_gas=W2_venturimixer(gastype_0,P_offset,P_atm,T_air,T_gas,V_air1);
% Hi=heatingvalues(gastype_0,'Hi');
% Pi=((V_gas./60000).*Hi).*1000;
% lambda=(V_air./V_gas)./(afr(1,1,gastype_0,'vol'));
% 
% for i=1:length(lambda)
% [X_CO2(i),X_H2O(i),X_N2(i),X_O2(i)]=exgases_fraction(lambda(i),1,1,gastype_0,'dry');
% X_CO2(i)=X_CO2(i).*100;
% end
% 
% Pi_0=Pi;
% X_CO2_0=X_C02;
% V_gas_0=V_gas;
% lambda_0=lambda;