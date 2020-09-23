function [Nu] = Nusselt_ext_fconv_cylinder_transverse_flow(Re,Pr)
%Script for determining the nusselt number for forced external convection
%in a cylinder exposed to transverse flow


if Re>=0.4 && Re<4
C=0.989;
m=0.33;
elseif Re>=4 && Re<40
C=0.911;
m=0.385;
elseif Re>=40 && Re<4000
C=0.683;
m=0.466;
elseif Re>=4000 && Re<40000
C=0.193;
m=0.618;
elseif Re>=40000 && Re<400000
C=0.027;
m=0.805;
end

Nu=C.*(Pr.^(1/3)).*Re.^m;
end

