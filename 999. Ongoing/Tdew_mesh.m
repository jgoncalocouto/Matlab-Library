gastype='G30';
h=0;

X_CO2=X_CO2./100;

i=0;
j=0;
for i=1:size(X_CO2,1)
    for j=1:size(X_CO2,2)
        lambda(i,j)=lambda_calc(gastype,X_CO2(i,j),1,1);
        T_dew(i,j)=dew_point_T_exg(lambda(i,j),1,1,gastype,h);
    end
end