
v=5;         %Mean velocity (m/s)
D=14*10^-2; %Pipe Diameter (m)
T=15; %Fluid Temperature [ºC]
P=1013.15; %Fluid Absolute Pressure [mbar]
gastype='Air'; %Fluid Name [-]
mu=viscosityd(gastype,T);
rho=densityz(gastype,T,P);
vu=viscosityd(gastype,T)/densityz(gastype,T,P); %Kynematic Viscosity
R=D/2;

r=linspace(0,R,100);
y=linspace(0,2*R,200);

u=v.*(1-((2.*r)./D).^2);
uy=horzcat(fliplr(u),u);

plot(uy,y)
title('Fully developed laminar velocity profile in pipe')
xlabel('Velocity [m/s]')
ylabel('Vertical coordinate [m]')