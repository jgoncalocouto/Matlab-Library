T=[0:10:250];

for i=1:length(T)
p_sat(i)=(XSteam('psat_T',T(i)).*10^5)./100;
end

T=transpose(T);
p_sat=transpose(p_sat);