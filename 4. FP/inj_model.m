function [DeltaP,CD] =inj_model(appliance_type,capacity,gastype,D,V_gas,T_gas,P_atm)


inj_database={'Happy' 26 2 0.990803931 -1.3858093 0.253330644	1	0 17
    'Happy'	26	1.55	0.985866975	-1.78704823	0.294359117	1	0 17
    'FP Europe'	12	1.3	0.810615626	-2.11511838	0.507381783	0.588297175	0.006622837 9
    'FP Europe'	12	1.7	1.634179615	-1.148824076	0.043028383	0.588297175	0.006622837 9
    'FP Europe'	12	1.8	1.497534739	-0.943116546	0.039906968	0.588297175	0.006622837 9};

for i=1:size(inj_database,1)
    if strcmp(cell2mat(inj_database(i,1)),appliance_type)==1
        if D==cell2mat(inj_database(i,3)) && capacity==cell2mat(inj_database(i,2))
            c=cell2mat(inj_database(i,4));
            m=cell2mat(inj_database(i,5));
            x=cell2mat(inj_database(i,6));
            mp=cell2mat(inj_database(i,7));
            cp=cell2mat(inj_database(i,8));
            N_inj=cell2mat(inj_database(i,9));
        end
        
        
        
    end
end
rho_gas0=densityz(gastype,T_gas,P_atm);
mu_gas0=viscosityd(gastype,T_gas);
A=N_inj*pi*0.25*(D/1000)^2;
v=(V_gas/60000)/A;
DeltaP=ones(100000,1);
rho_gas=rho_gas0;
mu_gas=mu_gas0;
for j=2:100000
    
    Re=(rho_gas*v*(D/1000))/mu_gas;
    CD_iter=(m/(Re^x))+c;
    DeltaP_iter(j)=((rho_gas/(CD_iter^2))*((8*((V_gas/60000)^2))/((N_inj^2)*(pi^2)*((D/1000)^4))))/100; %[mbar]
    rho_gas=densityz(gastype,T_gas,P_atm+DeltaP(j));
    
    if ((DeltaP_iter(j)-DeltaP_iter(j-1))/(DeltaP_iter(j)))*100<=0.001
    DeltaP=DeltaP_iter(j);
    CD=CD_iter;
    break
    end
    

end

