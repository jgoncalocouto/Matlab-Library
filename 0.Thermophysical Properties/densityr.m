function rho = densityr(gastype,Ti,Pi)
%Calculation of perfect gas density for several gastypes:
%'G32'
%P is defined in mbar
%T is defined in ºC


prop={ 'G32' 42.08};

for i=1:length(prop)
    if strcmp(gastype,cell2mat(prop(i,1)))==1
        M=cell2mat(prop(i,2));
        T=273.15+Ti;
        P=Pi.*100;
        Ru=8314.4621;
        R=Ru./M;
        rho=P./(R.*T);
    end
end

end


