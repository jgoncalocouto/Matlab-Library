function [CD] =cd_model(appliance_type,marking,rho,mu,N,DeltaP)
%Calculates CD for a given deltaP and injector configuration
%Outputs:
%'CD' - Discharge Coefficient - [-]

%Inputs:
%'appliance_type' - Appliance Type - [-] - Eg. 'C4 KME'
%'marking' - Marking - [-] - Injector marking - Eg. 100
%'rho' - Gas Density - [kg/m^3]
%'mu' - Gas Dynamic Viscosity - [Pa.s]
%'N' - Number of injectors - [-]
%'DeltaP' - Pressure Difference across the injectors - [mbar]

DeltaP=DeltaP.*100; %Convert to [Pa]

%Inj Database: List of injectors included in the model
inj_database={
    'C4 KME' 100 1 +0.15 0 1022 3868	1.197769 -2.06096	0.220131
    'C4 KME' 105 1.05 0.15 0 1006.738295 3813.960152 1.312419255 -1.466848928 0.138476982
    'C4 KME' 65 0.65 0.15 0 2220 8468 0.938014847 -3.721057298 0.453962136
    'C4 KME' 62 0.62 0.15 0 2040 9531 1.014648465 -4.951057309 0.401996214
    'C4 KME' 67 0.67 0.15 0 1975 10237 1.396 -0.857035345 0.063924851
    'C4 KME' 64 0.64 0.015 0 2220 8468 0.938014847 -3.721057298 0.453962136
    };
%Col.1 - Appliance Type
%Col.2 - Injector marking
%Col.3 - Injector Diameter - Nominal Value
%Col.4 - Injector Diameter - Tol+
%Col.5 - Injector Diameter - Tol-
%Col.6 - Test Limits:Reynolds Number Range - Min
%Col.7 - Test Limits:Reynolds Number Range - Max
%Col.8 - CD vs Re Curve - c
%Col.9 - CD vs Re Curve - m
%Col.10 - CD vs Re Curve - x


%Get c,m,x,D
for i=1:size(inj_database,1)
    if strcmp(cellstr(inj_database(i,1)),appliance_type)==1
        if marking==cell2mat(inj_database(i,2))
            c=cell2mat(inj_database(i,8));
            m=cell2mat(inj_database(i,9));
            x=cell2mat(inj_database(i,10));
            D=cell2mat(inj_database(i,3))./1000;
        end

    end
end

A=N.*0.25.*pi().*(D.^2); %Calculate Discharge Area

CD_iter=0.5; %First Guess
E_rel=100; %Initial estimative for relative Error

%While loop to determine CD iteratively
while E_rel>=0.1 
V_gas=CD_iter.*A.*sqrt((2.*DeltaP)./rho);
v=V_gas./A;
Re=(rho.*v.*D)./mu;
CD=(m./(Re.^x))+c;
E_rel=abs(((CD_iter-CD)./CD).*100);
CD_iter=CD;
end

end