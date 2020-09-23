X_SO2=100/10^6; % Assumption
per_SO3_base=[1 3 5]./100'; % Assumption

%References
%http://en.citizendium.org/wiki/Acid_dew_point

P_atm=101325./10^5;

X_SO3=per_SO3_base(2)*X_SO2;
p_SO3=X_SO3.*P_atm;

X_H2O=([0:0.1:15]./100)';
p_H2O=X_H2O.*P_atm;

for i=1:size(p_H2O,1)
Tsat_H2O(i)=XSteam('Tsat_P',p_H2O(i));
end

f=1.7842-0.0269.*log10(p_H2O)-0.1029.*log10(p_SO3)+0.0329.*log10(p_H2O).*log10(p_SO3);
Tsat_H2SO4=(1000./f)-273.15;

figure
plot(X_H2O.*100,Tsat_H2O,'b')
ylim([0 max(Tsat_H2SO4)+10])
title('Comparison between Dew-Point temperature of H_2O and H_2SO_4')
hold on
plot(X_H2O.*100,Tsat_H2SO4,'r')
xlabel('H_2O volumetric fraction - [%]')
ylabel('Saturation Temperature - [ºC]')
legend('H_2O',strcat('H_2SO_4 - Assuming X_{SO_3}= ',num2str(X_SO3.*100),' [%]'));