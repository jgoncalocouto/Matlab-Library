function DeltaP = ploss_inline(l,Di,epsilon,gastype,Pi,Ti,vdoti)
%% Inputs:
% l - length - [m]
% Di - Internal Diameter - [mm]
% epsilon - relative roughness - [-]
% gastype - Gas Type - [-]
% Pi - Atmospheric Pressure - [mbar]
% Ti - Fluid Temperature - [ºC]
% vdoti - Volumetric Flow Rate - [l/min]

%% Outputs:
% DeltaP - Pressure loss - [mbar]

%% Code:

vdot=vdoti/60000;
rho=densityz(gastype,Ti,Pi);
mu=viscosityd(gastype,Ti);
D=Di/1000;
v=vdot/(pi*0.25*D^2);
Re=(rho*v*D)/mu;
f=darcyfactor(Re,epsilon,Di);
DeltaP=(f*(l/D)*rho*0.5*v^2)/100;
end