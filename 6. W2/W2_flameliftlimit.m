function [CO2] = W2_flameliftlimit(gastype,Pi)

%Function that computes the flame lift limit based on experimental
%characterizations for G30 and G31. Function defined from 6 kW to 14 kW
% Pi [kW]
% CO2 [%]


FLL_G31=[6	2.11
    7.902	2.59
    10.168	3.15
    12.068 3.51
    14.116 4.24];


FLL_G30=[6.15	2.2 %6.143 is the minimum power measured
    8.2	2.81
    10.405	3.33
    12.334 3.67
    13.953 4.28];

if strcmp(gastype,'G31')==1
    CO2=interp1(FLL_G31(:,1),FLL_G31(:,2),Pi);
elseif strcmp(gastype,'G30')==1
    CO2=interp1(FLL_G30(:,1),FLL_G30(:,2),Pi);
else
    warning('Gas type not known')
end

end