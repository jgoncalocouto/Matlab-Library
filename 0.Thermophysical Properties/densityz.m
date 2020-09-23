function rho = densityz(gastype,Ti,Pi)
%Calculation of real gas density for several gastypes:
%'Air' 'CO' 'CO2' 'CH4' C3H8' 'C4H10' 'N2' 'O2'
%P is defined in mbar
%T is defined in ºC


prop={ 'Air' 0.078 132.6 3.77.*10.^6 28.966
    'CO' 0.051 132.8 3.49.*10.^6 28.011
    'CO2' 0.225 304.13 7.38.*10.^6 44.01
    'CH4' 0.011 190.56 4.60.*10.^6 16.043
    'G20' 0.011 190.56 4.60.*10.^6 16.043
    'C3H8' 0.1524 369.85 4.25.*10.^6 44.097
    'G31' 0.1524 369.85 4.25.*10.^6 44.097
    'C4H10' 0.2 425.13 3.80.*10.^6 58.124
    'G30' 0.2 425.13 3.80.*10.^6 58.124
    'N2' 0.038 126.19 3.40.*10.^6 28.0134
    'O2' 0.0222 154.58 5.04.*10.^6 31.9988};

for i=1:length(prop)
    if strcmp(gastype,cell2mat(prop(i,1)))==1
        omega=cell2mat(prop(i,2));
        Tc=cell2mat(prop(i,3));
        Pc=cell2mat(prop(i,4));
        M=cell2mat(prop(i,5));
        T=273.15+Ti;
        P=Pi.*100;
        Tr=T./Tc;
        Pr=P./Pc;
        beta1=0.083-(0.422./(Tr.^1.6))+(0.139-(0.172./(Tr.^4.2))).*omega;
        Z=1+(beta1.*Pr)./(Tr);
        Ru=8314.4621;
        R=Ru./M;
        rho=P./(Z.*R.*T);
    end
end

end


