

v=5;         %Mean velocity (m/s)
D=14*10^-2; %Pipe Diameter (m)
k=0.41;      %K constant of logaritmic overlap layer model [-]
B=5;     %B constant of logaritmic overlap layer model [-]
T=15; %Fluid Temperature [ºC]
P=1013.15; %Fluid Absolute Pressure [mbar]
gastype='Air'; %Fluid Name [-]
vu=viscosityd(gastype,T)/densityz(gastype,T,P); %Kynematic Viscosity


R=D/2;
guess=v/100;
u_str=fsolve(@(x)log_law(x,v,k,B,vu,R),guess);

tau_w=densityz(gastype,T,P)*u_str^2
r=linspace(0,R,100);
y=linspace(0,2*R,200);

u=u_str*((1/k)*log(((R-r)*u_str)/vu)+B);
uy=horzcat(fliplr(u),u);

plot(uy,y);
title('Fully developed turbulent velocity profile in pipe - Log Law approximation')
xlabel('Velocity [m/s]')
ylabel('Vertical coordinate [m]')


