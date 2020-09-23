function [Nu] = Nusselt_ext_nconv_cylinder_transverse_flow(Gr,Pr)
%Script for determining the nusselt number for natural external convection
%in a cylinder exposed to transverse flow

Ra=Gr.*Pr;

if Ra>=10^-10 && Ra<10^2
C=0.675;
n=0.058;
elseif Ra>=10^-2 && Ra<10^2
C=1.02;
n=0.148;
elseif Ra>=10^2 && Ra<10^4
C=0.85;
n=0.188;
elseif Ra>=10^4 && Ra<10^7
C=0.480;
n=0.250;
elseif Ra>=10^7 && Ra<10^12
C=0.125;
n=0.330;
end

Nu=C.*Ra.^n;
end

