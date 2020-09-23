function [P_atm]=P_altitude(h)
%Atmospheric pressure in [mbar] as a function of altitude [m] // Range: 0 till 6102m

P_atm=(101942.0313.*exp(-0.000126481.*h))/100;
end
