function [V_gas]=vgas_calc(CD,rho,DeltaP,A)
%Calculates V_gas for a given A,CD,DeltaP
%Outputs:
%'V_gas' - Gas Flow Rate referenced at T and P correspondent to input
%density - [m^3/s]

%Inputs:
%'CD' - Discharge Coefficient - [-]
%'rho' - Gas Density - [kg/m^3]
%'DeltaP' - Pressure Difference across the injectors - [mbar]
%'A' - Discharge Area - [m^2]


DeltaP=DeltaP.*100;
V_gas=CD.*A.*sqrt((2*DeltaP)./rho);

if isnan(V_gas)==1
V_gas=0;
end

end
