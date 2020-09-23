Vdot.G31=(1782/3600)/1000;
Vdot.G30=(1782/3600)/1000;
Vdot.G20=(3176/3600)/1000;

DP_max.G31=3*100;
DP_max.G30=3*100;
DP_max.G20=4*100;

T=15;
P=1013.25;

D_GVinlet=19/1000;
A_GVinlet=pi*0.25*D_GVinlet^2;

rho.G31=densityz('G31',T,P);
rho.G30=densityz('G30',T,P);
rho.G20=densityz('G20',T,P);

mu.G31=viscosityd('G31',T);
mu.G30=viscosityd('G30',T);
mu.G20=viscosityd('G20',T);

K_GV.G31=DP_max.G31/(0.5*rho.G31*(Vdot.G31/(A_GVinlet))^2);
Re.G31=(rho.G31*(Vdot.G31/(A_GVinlet))*D_GVinlet)/mu.G31;

K_GV.G30=DP_max.G30/(0.5*rho.G30*(Vdot.G30/(A_GVinlet))^2);
Re.G30=(rho.G30*(Vdot.G30/(A_GVinlet))*D_GVinlet)/mu.G30;

K_GV.G20=DP_max.G20/(0.5*rho.G20*(Vdot.G20/(A_GVinlet))^2);
Re.G20=(rho.G20*(Vdot.G20/(A_GVinlet))*D_GVinlet)/mu.G20;



