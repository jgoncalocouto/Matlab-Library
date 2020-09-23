function [Appliance_state,P_venturi1_actual,P_venturi2_actual,P_venturi1_measured,P_venturi2_measured,DeltaP_fan,DeltaP_venturi,N_fan,FLOWRATE_ACTUAL_SP]=KME_FLOWRATE_CONTROL_PRESSURE_TAPS(FLOWRATE_SP_ECU,P_venturi1_state,P_venturi2_state,T_amb,h,L_duct,D_duct,N_elbows)


A_duct=pi*0.25*D_duct.^2;
    rho_air=densityz('Air',T_amb,P_altitude(0));


    if P_venturi1_state==1 && P_venturi2_state==1
        FLOWRATE_SP=FLOWRATE_SP_ECU;
        Appliance_state='Normal Operation'
    elseif P_venturi1_state==1 && P_venturi2_state==0
        DeltaP_1=((FLOWRATE_SP_ECU.^2)./(11809.^2)).*(273.15+T_amb);
        P_venturi1=DeltaP_1;


        E_rel=100;
        FLOWRATE_ITER=FLOWRATE_SP_ECU;
        N2=0;
        while E_rel>1
            [V_dot_fan, DeltaP_fan, DeltaP_venturi,P_venturi1_calc,P_venturi2_calc,N_fan] = KME_FAN_FLOWRATE_CONTROL(T_amb,h,L_duct,D_duct,N_elbows,FLOWRATE_ITER);
            FLOWRATE_ITER=(((P_venturi1-P_venturi1_calc)/P_venturi1)*0.5+1)*FLOWRATE_ITER;
            E_rel=abs(((P_venturi1-P_venturi1_calc)./(P_venturi1_calc)).*100)
            N2=N2+1;
        end
        FLOWRATE_SP=FLOWRATE_ITER;

        if FLOWRATE_SP==FLOWRATE_SP_ECU
            Appliance_state='Normal Operation'
        elseif FLOWRATE_SP>FLOWRATE_SP_ECU
            Appliance_state='Operation point is leaner than specified: Limit Condition - Flame Lift'
        elseif FLOWRATE_SP<FLOWRATE_SP_ECU
            Appliance_state='Operation point is richer than specified: Limit Condition - Spillage or High Emissions'
        end

    elseif P_venturi1_state==0 && P_venturi2_state==1
        b=3;
        DeltaP_2=(((FLOWRATE_SP_ECU.^2)./(11809.^2)).*(273.15+T_amb));
        P_venturi2=-DeltaP_2;

        Appliance_state='Error Code C4: Sensor signal is smaller or equal to the minimum value and the Fan is turned On'

    elseif P_venturi1_state==0 && P_venturi2_state==0
        b=4;
        FLOWRATE_SP=0;
        Appliance_state='Error Code C4: Sensor signal is smaller or equal to the minimum value and the Fan is turned On'
    end

    P_venturi1_measured=P_venturi1_state*P_venturi1_calc;
    P_venturi2_measured=P_venturi2_state*P_venturi2_calc;

    P_venturi1_actual=P_venturi1_calc;
    P_venturi2_actual=P_venturi2_calc;
    
    FLOWRATE_ACTUAL_SP=FLOWRATE_SP;





end
