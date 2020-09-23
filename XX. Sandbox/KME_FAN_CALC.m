function [DeltaP_fan,DeltaP_venturi,P_venturi1,P_venturi2] = KME_FAN_CALC(Vdot_fan,N_fan,rho,T)

%Inputs
% N_fan - [rpm]
% Vdot_fan - [l/min]

%Outputs
%DeltaP_fan - [mbar]

D_fan=60*10^-3; %[m]
A_duct=pi().*0.25.*(80*10^-3).^2; %[m^2]

F_fan=((Vdot_fan)./60000)/((N_fan./60)*(D_fan^3));

if N_fan>=1200
    
    if F_fan>=2.5
        P_fan=23.203.*2.5+1.6698;
    else
        P_fan=23.203.*F_fan+1.6698;
    end
    
    
elseif N_fan<=600
    if F_fan>=1.65
        P_fan=8.7936.*1.65+1.4948;
    else
        P_fan=8.7936.*F_fan+1.4948;
    end
    
    
else
    
    if F_fan>=2.5
        P_fan1=8.7936.*2.5+1.4948;
        P_fan3=23.203.*2.5+1.6698;
        P_fan=(((P_fan3-P_fan1)./(1200-600)).*(N_fan-600))+P_fan1;
    else
        P_fan1=8.7936.*F_fan+1.4948;
        P_fan3=23.203.*F_fan+1.6698;
        P_fan=(((P_fan3-P_fan1)./(1200-600)).*(N_fan-600))+P_fan1;
    end
    
end

DeltaP_fan=(P_fan*rho*((N_fan/60)^3)*(D_fan^5))/(Vdot_fan/60000);
DeltaP_fan=DeltaP_fan./100;

DeltaP_venturi=(((Vdot_fan)^2)/(11809^2))*(273.15+T);

P_venturi1=((DeltaP_fan*100)+0.5.*rho.*(((Vdot_fan/60000).^2)/(A_duct.^2)))./100;
P_venturi2=P_venturi1-DeltaP_venturi;





end

