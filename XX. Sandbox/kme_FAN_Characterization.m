function P_fan = kme_FAN_Characterization(F_fan,N_fan)
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
        P_fan1=8.7936.*1.65+1.4948;
        P_fan3=23.203.*2.5+1.6698;
        P_fan=(((P_fan3-P_fan1)./(1200-600)).*(N_fan-600))+P_fan1;
    else
        P_fan1=8.7936.*F_fan+1.4948;
        P_fan3=23.203.*F_fan+1.6698;
        P_fan=(((P_fan3-P_fan1)./(1200-600)).*(N_fan-600))+P_fan1;
    end
    
end






end

