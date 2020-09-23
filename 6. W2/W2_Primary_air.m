function [V_air1] =W2_Primary_air(V_air)
%Computation of Air Flow Rate of primary air [lpm], knowing the quantity of
%total air flow rate [lpm]
%   Detailed explanation goes here
f=-0.00007.*(V_air.^2) + 0.1369.*V_air + 28.162;
if V_air>1100
f=94.05920776;
elseif V_air<285
    f=61.5;
else
f=-0.00007.*(V_air.^2) + 0.1369.*V_air + 28.162;
end

V_air1=(f./100).*V_air;
end


