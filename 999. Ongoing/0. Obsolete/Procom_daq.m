%% Daq Load

[open_name3, open_path3] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
filename3 = strcat(open_path3,open_name3);

[C,C_txt] = xlsread(filename3);% Importing file

daq.t_absolute(:,1)=datenum(datestr(C_txt(2:length(C_txt),1),'HH:MM:SS:FFF'),'HH:MM:SS:FFF');
daq.t_relative(:,1)=C(:,2);

[~,columns]=size(C_txt)

for k=3:columns
    daq.(C_txt{1,k})=C(:,k-1);
end

t_initial_daq=datenum(datestr(C(1,1),'HH:MM:SS:FFF'),'HH:MM:SS:FFF');
time_inital_daq=datestr(t_initial_daq,'dd-mmm-yyyy HH:MM:SS:FFF');


%% PROCOM Load
%Inputs:
P_atm=101325; %[Pa]
Patm=P_atm./100;
T_air=15;
h=0;
L_duct=0.5;
D_duct=80*10^-3;
N_elbows=0;

Gastype='G30'
Hi_gas=heatingvalues(Gastype,'Hi');
Min_tuning=3;
Max_tuning=20;
Injector_marking=65;
N_inj=15;
D_inj=0.65;
A_inj=N_inj*pi*0.25*(D_inj/1000)^2;
T_gas=15;
P_in=20; %Inlet Gas Pressure -> Considered equal to Nominal as Default


rho_air=densityz('Air',15,Patm);
rho_gas=densityz(Gastype,15,Patm);
rho_exg=rho_air;

AFR=afr(1,1,Gastype,'vol');

[open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
filename1 = strcat(open_path1,open_name1);

[A,A_txt] = xlsread(filename1);% Importing file
[Log] = Procom_load_equivalence(A, '10');


%%Find the initial time of procom log
t_absinprocom=split(A_txt(23,2));
t_absinprocom_time=t_absinprocom(2,1);
t_absinprocom_aux=char(t_absinprocom(3,1));

aux=0;
for i=1:length(t_absinprocom_aux)
    if isempty(str2num(t_absinprocom_aux(i)))==0
        t_absinprocom_ms(i)=str2num(t_absinprocom_aux(i));
        aux=t_absinprocom_ms(i).*10.^(3-i)+aux;
    end
    
end
t_absinprocom_timedetail=char(strcat(t_absinprocom_time,':',num2str(aux))); %initial time of procom log start in format 'HH:MM:SS:FFF'
t_initial_procom=datenum(t_absinprocom_timedetail,'HH:MM:SS:FFF'); %initial time of procom log start in absolute time

time_inital_procom=datestr(t_initial_procom,'dd-mmm-yyyy HH:MM:SS:FFF');

i=0;
for i=1:length(Log.t_absolute)
    Log.t_absolute(i)=t_initial_procom+datenum(seconds(Log.t_relative(i)));
end


%% Agreggate Array

Aggregate.t_absolute=vertcat(Log.t_absolute,daq.t_absolute);
Aggregate.t_absolute=sort(Aggregate.t_absolute);
Aggregate.t_absolute=unique(Aggregate.t_absolute,'rows');

[Logical.daq , Index.daq]=ismember(Aggregate.t_absolute,daq.t_absolute);
[Logical.Procom,Index.Procom]=ismember(Aggregate.t_absolute,Log.t_absolute);

k=0;

Aggregate.t_relative(1,1)=0;

for k=2:length(Aggregate.t_absolute)
    
    Aggregate.t_relative(k,1)=Aggregate.t_relative(k-1,1)+str2num(datestr((Aggregate.t_absolute(k,1)-Aggregate.t_absolute(k-1,1)),'SS'))+str2num(datestr((Aggregate.t_absolute(k,1)-Aggregate.t_absolute(k-1,1)),'FFF'))./1000;
end
i=0;

Aux_procom=fieldnames(Log);
m=0;
i=0;
j=0;
for j=3:numel(fieldnames(Log))
    for i=1:length(Aggregate.t_absolute)
        if Logical.Procom(i)==true
            m=Index.Procom(i);
            Aggregate.(Aux_procom{j})(i,1)=Log.(Aux_procom{j})(m,1);
            m=0;
        else
            Aggregate.(Aux_procom{j})(i,1)=NaN;
        end
        
    end
    
end

Aux_daq=fieldnames(daq);
m=0;
i=0;
j=0;
n2=numel(fieldnames(Aggregate));

for j=n2+1:(n2+(numel(fieldnames(daq))-2))
    for i=1:length(Aggregate.t_absolute)
        if Logical.daq(i)==true
            m=Index.daq(i);
            Aggregate.(Aux_daq{j-n2+2})(i,1)=daq.(Aux_daq{j-n2+2})(m,1);
            m=0;
        else
            Aggregate.(Aux_daq{j-n2+2})(i,1)=NaN;
        end
        
    end
    
end

n3=numel(fieldnames(Aggregate));
Aux_Aggregate=fieldnames(Aggregate);
i=0;
for i=1:n3
    C1{1,i}=Aggregate.(Aux_Aggregate{i});
    C1{1,i}=num2cell(C1{1,i});
end

j=0;
i=0;

%     for j=1:n3
%         for i=1:length(Aggregate.t_absolute)
%             if isnan(C1{1,j}{i}(1))==true
%             C1{1,j}{i}=987654321;
%             end
%         end
%     end



%% Treat Aggregate Array
%Fill missing values with linear interpolation from the neighborhood
F=fieldnames(Aggregate);
i=0;
for i=1:length(F)
    Aggregate.(F{i})=fillmissing(Aggregate.(F{i}),'linear');
end

%% PROCOM data treatment - Including SW Related Variables
KME_SW

i=0;
for i=1:length(Aggregate.t_relative)
    
    if isempty(Aggregate.Qn(i,1))==1
        Aggregate.Qn(i,1)=0;
    elseif isnan(Aggregate.Qn(i,1))==1
        Aggregate.Qn(i,1)=0;
    end
    
    Aggregate.RPMNom(i,1)=Aggregate.N_fanhz(i,1).*60;
    Aggregate.RPMUp(i,1)=(Aggregate.N_fanhz(i,1)+0.49).*60;
    Aggregate.RPMLow(i,1)=(Aggregate.N_fanhz(i,1)-0.51).*60;
    rho_w=XSteam('rhoL_T',(Aggregate.T_waterin(i,1)+Aggregate.T_waterout(i,1))/2);
    cp_w=XSteam('CpL_T',(Aggregate.T_waterin(i,1)+Aggregate.T_waterout(i,1))/2);
    Aggregate.Pn(i,1)=(Aggregate.Vdot_water(i,1)./60000)*rho_w*cp_w*(Aggregate.T_waterout(i,1)-Aggregate.T_waterin(i,1));
    
%             if strcmp(Aggregate.Failure(i,1),'A4')==1
%             Aggregate.Error_A4(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'A5')==1
%             Aggregate.Error_A5(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'A6')==1
%             Aggregate.Error_A6(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'A7')==1
%             Aggregate.Error_A7(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'A9')==1
%             Aggregate.Error_A9(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'AC')==1
%             Aggregate.Error_AC(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'C2')==1
%             Aggregate.Error_C2(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'C7')==1
%             Aggregate.Error_C7(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'CC')==1
%             Aggregate.Error_CC(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'CF')==1
%             Aggregate.Error_CF(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'E7')==1
%             Aggregate.Error_E7(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'E0')==1
%             Aggregate.Error_E0(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'E1')==1
%             Aggregate.Error_E1(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'E4')==1
%             Aggregate.Error_E4(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'E8')==1
%             Aggregate.Error_E8(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'E9')==1
%             Aggregate.Error_E9(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'EA')==1
%             Aggregate.Error_EA(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'EC')==1
%             Aggregate.Error_EC(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'F7')==1
%             Aggregate.Error_F7(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'FA')==1
%             Aggregate.Error_FA(i,1)=1;
%         elseif strcmp(Aggregate.Failure(i,1),'F9')==1
%             Aggregate.Error_F9(i,1)=1;
%         end
        
    
    
    
    
    
    if Aggregate.I_ion(i,1)>0
        Aggregate.SW_FlowrateNom(i,1)=interp1(SW_Flowrate.(Gastype)(:,1),SW_Flowrate.(Gastype)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_FlowrateLow(i,1)=(SW_FlowrateLimitLow.(Gastype)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_FlowrateUp(i,1)=(SW_FlowrateLimitUp.(Gastype)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_ValveCurrent(i,1)=interp1(SW_ValveCurrent.(Gastype)(:,1),SW_ValveCurrent.(Gastype)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_Efficiency(i,1)=interp1(SW_Efficiency.(Gastype)(:,1),SW_Efficiency.(Gastype)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_TVenturi(i,1)=interp1(SW_Tventuri.(Gastype)(:,1),SW_Tventuri.(Gastype)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_RPMMin(i,1)=interp1(SW_RPMMin.(Gastype)(:,1),SW_RPMMin.(Gastype)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_RPMMax(i,1)=interp1(SW_RPMMax.(Gastype)(:,1),SW_RPMMax.(Gastype)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_Tfire(i,1)=interp1(SW_Tfire.(Gastype)(:,1),SW_Tfire.(Gastype)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_ExpectedPn(i,1)=(Aggregate.SW_Efficiency(i,1)/100)*Aggregate.Qn(i,1);
        
        
        [Pburner_actual_nom,Vgas_actual_nom,Qn_actual_nom] = Gv_kme(Aggregate.SW_ValveCurrent(i,1),Min_tuning,Max_tuning,P_in,Gastype,Injector_marking,N_inj,D_inj,T_gas,Patm,'Nominal');
        [Pburner_actual_up,Vgas_actual_up,Qn_actual_up] = Gv_kme(Aggregate.SW_ValveCurrent(i,1),Min_tuning,Max_tuning,P_in,Gastype,Injector_marking,N_inj,D_inj,T_gas,Patm,'Upper Limit');
        [Pburner_actual_low,Vgas_actual_low,Qn_actual_low] = Gv_kme(Aggregate.SW_ValveCurrent(i,1),Min_tuning,Max_tuning,P_in,Gastype,Injector_marking,N_inj,D_inj,T_gas,Patm,'Lower Limit');
        
        Aggregate.Expected_Vgas_nom(i,1)=Vgas_actual_nom;
        Aggregate.Expected_Vgas_up(i,1)=Vgas_actual_up;
        Aggregate.Expected_Vgas_low(i,1)=Vgas_actual_low;
        
        Aggregate.Expected_Qn_nom(i,1)=Qn_actual_nom;
        Aggregate.Expected_Qn_up(i,1)=Qn_actual_up;
        Aggregate.Expected_Qn_low(i,1)=Qn_actual_low;
        
        Aggregate.Expected_Pburner_nom(i,1)=Pburner_actual_nom;
        Aggregate.Expected_Pburner_up(i,1)=Pburner_actual_up;
        Aggregate.Expected_Pburner_low(i,1)=Pburner_actual_low;
        
        Aggregate.Expected_Vair_nom(i,1)=((Vgas_actual_nom*rho_gas)+(Aggregate.Vdot_exg_actual(i,1)*rho_exg))/rho_air;
        Aggregate.Expected_Vair_up(i,1)=((Vgas_actual_up*rho_gas)+(Aggregate.Vdot_exg_actual(i,1)*rho_exg))/rho_air;
        Aggregate.Expected_Vair_low(i,1)=((Vgas_actual_low*rho_gas)+(Aggregate.Vdot_exg_actual(i,1)*rho_exg))/rho_air;
        
        Aggregate.Expected_lambda_nom(i,1)=(Aggregate.Expected_Vair_nom(i,1)/Aggregate.Expected_Vgas_nom(i,1))/AFR;
        Aggregate.Expected_lambda_up(i,1)=(Aggregate.Expected_Vair_up(i,1)/Aggregate.Expected_Vgas_up(i,1))/AFR;
        Aggregate.Expected_lambda_low(i,1)=(Aggregate.Expected_Vair_low(i,1)/Aggregate.Expected_Vgas_low(i,1))/AFR;
        
        
        [Aggregate.Expected_CO2_nom(i,1),~,~,~]=exgases_fraction(Aggregate.Expected_lambda_nom(i,1),1,1,Gastype,'dry');
        [Aggregate.Expected_CO2_up(i,1),~,~,~]=exgases_fraction(Aggregate.Expected_lambda_up(i,1),1,1,Gastype,'dry');
        [Aggregate.Expected_CO2_low(i,1),~,~,~]=exgases_fraction(Aggregate.Expected_lambda_low(i,1),1,1,Gastype,'dry');
        
        Aggregate.Expected_CO2_nom(i,1)=Aggregate.Expected_CO2_nom(i,1).*100;
        Aggregate.Expected_CO2_up(i,1)=Aggregate.Expected_CO2_up(i,1).*100;
        Aggregate.Expected_CO2_low(i,1)=Aggregate.Expected_CO2_low(i,1).*100;
        
        
        
        Aggregate.Expected_Efficiency_nom(i,1) = appliance_efficiency(Gastype,Aggregate.Qn(i,1),Aggregate.Expected_CO2_nom(i,1),Aggregate.SW_TVenturi(i,1), T_gas, T_air,h).*100;
        Aggregate.Expected_Efficiency_up(i,1) = appliance_efficiency(Gastype,Aggregate.Qn(i,1),Aggregate.Expected_CO2_up(i,1),Aggregate.SW_TVenturi(i,1), T_gas, T_air,h).*100;
        Aggregate.Expected_Efficiency_low(i,1) = appliance_efficiency(Gastype,Aggregate.Qn(i,1),Aggregate.Expected_CO2_low(i,1),Aggregate.SW_TVenturi(i,1), T_gas, T_air,h).*100;
        
        [Aggregate.Expected_DeltaP_fan(i,1),Aggregate.Expected_DeltaP_venturi(i,1),Aggregate.Expected_P_venturi1(i,1),Aggregate.Expected_P_venturi2(i,1)] = KME_FAN_CALC(Aggregate.Vdot_exg_actual(i,1),Aggregate.RPMNom(i,1),densityz('Air',T_air,Patm),Aggregate.SW_TVenturi(i,1));
        
        Aggregate.SW_TVenturi_calc(i,1)=-273.15+(((11809.^2)*Aggregate.DeltaP_sensor(i,1))./(Aggregate.Vdot_exg_actual(i,1).^2));

        
     
    P_gas=Aggregate.P_burner(i,1)+Patm;
    rho_gas_measured=densityz(Gastype,T_gas,P_gas);
    mu_gas=viscosityd(Gastype,T_gas);
    cd_actual=cd_model('C4 KME',Injector_marking,rho_gas_measured,mu_gas,N_inj,Aggregate.P_burner(i,1));
    Aggregate.Vgas_calculatedbypburner(i,1)=vgas_calc(cd_actual,rho_gas_measured,Aggregate.P_burner(i,1),A_inj);
    Aggregate.Qn_calculatedbypburner(i,1)=(Aggregate.Vgas_calculatedbypburner(i,1).*Hi_gas.*10^6)./1000; %[kW]

        
    else
        Aggregate.SW_FlowrateNom(i,1)=0;
        Aggregate.SW_FlowrateUp(i,1)=0;
        Aggregate.SW_FlowrateLow(i,1)=0;
        Aggregate.SW_ValveCurrent(i,1)=0;
        Aggregate.SW_Efficiency(i,1)=0;
        Aggregate.SW_TVenturi(i,1)=Aggregate.T_flue(i,1);
        Aggregate.SW_RPMMin(i,1)=0;
        Aggregate.SW_RPMMax(i,1)=0;
        Aggregate.SW_Tfire(i,1)=0;
        Aggregate.SW_ExpectedPn(i,1)=0;
        Aggregate.SW_TVenturi_calc(i,1)=0;
        
        
        Aggregate.Expected_Vgas_nom(i,1)=0;
        Aggregate.Expected_Vgas_up(i,1)=0;
        Aggregate.Expected_Vgas_low(i,1)=0;
        
        Aggregate.Expected_Qn_nom(i,1)=0;
        Aggregate.Expected_Qn_up(i,1)=0;
        Aggregate.Expected_Qn_low(i,1)=0;
        
        Aggregate.Expected_Pburner_nom(i,1)=0;
        Aggregate.Expected_Pburner_up(i,1)=0;
        Aggregate.Expected_Pburner_low(i,1)=0;
        
        Aggregate.Expected_Vair_nom(i,1)=0;
        Aggregate.Expected_Vair_up(i,1)=0;
        Aggregate.Expected_Vair_low(i,1)=0;
        
        Aggregate.Expected_lambda_nom(i,1)=0;
        Aggregate.Expected_lambda_up(i,1)=0;
        Aggregate.Expected_lambda_low(i,1)=0;
        
        Aggregate.Expected_CO2_nom(i,1)=0;
        Aggregate.Expected_CO2_low(i,1)=0;
        Aggregate.Expected_CO2_up(i,1)=0;
        
        Aggregate.Expected_Efficiency_nom(i,1) = 0;
        Aggregate.Expected_Efficiency_up(i,1) = 0;
        Aggregate.Expected_Efficiency_low(i,1) = 0;
   
        
        Aggregate.Expected_DeltaP_fan(i,1)=0;
        Aggregate.Expected_DeltaP_venturi(i,1)=0;
        Aggregate.Expected_P_venturi1(i,1)=0;
        Aggregate.Expected_P_venturi2(i,1)=0;
        
        Aggregate.Vgas_calculatedbypburner(i,1)=0;
        Aggregate.Qn_calculatedbypburner(i,1)=0;
        
    
    end
    
end


%% Treat Aggregate Array
%Fill missing values with linear interpolation from the neighborhood
F_2=fieldnames(Aggregate);
i=0;
for i=1:length(F_2)
    Aggregate.(F_2{i})=fillmissing(Aggregate.(F_2{i}),'linear');
end


%% Graphs


%Plot1: Air Flow / Qn /I_{GV} /I_{ion}
%Flow Rate Control
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_FlowrateNom,'-g',Aggregate.t_relative,Aggregate.SW_FlowrateUp,'--g',Aggregate.t_relative,Aggregate.SW_FlowrateLow,':g',Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-k',Aggregate.t_relative,Aggregate.Vdot_exg_desired,'--k')
title('Flow Rate Control Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Flow Rate @15ºC, 1 at - [l/min]')
ylim([0 1000]);
legend('Flow Rate Set-point', 'Acceptance Criteria: Flow Rate Max','Acceptance Criteria: Flow Rate Min','SW: Actual Flow Rate','SW: Desired Flow Rate')



%Qn Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
title('Power Input Overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]')


%Plot2: Air Flow / RPM
%Flow Rate Control

figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_FlowrateNom,'-g',Aggregate.t_relative,Aggregate.SW_FlowrateUp,'--g',Aggregate.t_relative,Aggregate.SW_FlowrateLow,':g',Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-k',Aggregate.t_relative,Aggregate.Vdot_exg_desired,'--k')
title('Flow Rate Control Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Flow Rate @15ºC, 1 at - [l/min]')
ylim([0 1000]);
legend('Flow Rate Set-point', 'Acceptance Criteria: Flow Rate Max','Acceptance Criteria: Flow Rate Min','SW: Actual Flow Rate','SW: Desired Flow Rate')

subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.RPMNom,'-k',Aggregate.t_relative,Aggregate.RPMUp,'--k',Aggregate.t_relative,Aggregate.RPMLow,':k',Aggregate.t_relative,Aggregate.SW_RPMMax,'-b',Aggregate.t_relative,Aggregate.SW_RPMMin,'-r');
title('Fan RPM Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Fan Rotational Speed - [rpm]')
ylim([0 3000])
legend('SW: Actual RPM: Nominal', 'SW: Actual RPM: Upper Limit', 'SW: Actual RPM: Lower Limit','C6: Maximum RPM allowed during continuous operation','Minimum allowed RPM during continous operation')


%Plot3: T_fire / Qn /I_{GV} /I_{ion}
%Exhaust Gas Temperature
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.T_flue,'-k',Aggregate.t_relative,Aggregate.SW_Tfire,'-r')
title('A4: Exhaust Gas Temperature Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Exhaust Gas Temperature - [ºC]')
ylim([0 250])
legend('Maximum allowed temperature for exhaust gases', 'Exhaust Gases Temperature')


%Qn Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
title('Power Input Overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]')



%Plot4: Power Output & Expected / T water out & T water SP & Water Flow Rate

%Power Output
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.Pn,'-k',Aggregate.t_relative,Aggregate.SW_ExpectedPn,'-b')
title('Power Output Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Power Output - P_n - [kW]')
ylim([0 22]);
legend('Actual Power Output', 'Expected Power Output according to SW curves')


%Qn Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.T_watersp,'-k',Aggregate.t_relative,Aggregate.T_waterout,'-r',Aggregate.t_relative,Aggregate.Vdot_water,'-b');
title('Water Outlet Overview')
xlabel('Elapsed time - t - [s]')
legend('Water Outlet Temperature: Set-Point - [ºC]', 'Water Outlet Temperature: Actual - [ºC]', 'Water Flow Rate - [l/min]')


%Plot5: Combustion Overview
%CO2
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.Expected_CO2_nom,'-g',Aggregate.t_relative,Aggregate.Expected_CO2_up,'-r',Aggregate.t_relative,Aggregate.Expected_CO2_low,'-b')
title('Expected CO2 having GV variation into consideration')
xlabel('Elapsed time - t - [s]')
ylabel('CO2 concentration at dry basis - CO_2 - [%]')
ylim([0 10]);
legend('CO_2 [%] - Nominal', 'CO_2 [%] - Upper Limit', 'CO_2 [%] - Lower Limit')



%Combustion Actuators Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
ylim([0 200]);
yyaxis right
plot(Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-c')
title('Combustion Actuators overview')
xlabel('Elapsed time - t - [s]')
ylim([0 1000]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]', 'Actual Exhaust Gas Flow Rate - [l/min]')


%Plot6: Ionisation Overview

figure
subplot(2,1,1);
plot(Aggregate.I_ion,Aggregate.Expected_CO2_nom,'g*',Aggregate.I_ion,Aggregate.Expected_CO2_up,'r+',Aggregate.I_ion,Aggregate.Expected_CO2_low,'bo')
title('CO2 vs I_{ion}')
xlabel('Ionisation Current - I_{ion} - [\muA]')
ylabel('CO2 concentration at dry basis - CO_2 - [%]')
ylim([0 10]);
legend('CO2 [%] - Nominal', 'CO2 [%] - Upper Limit', 'CO2 [%] - Lower Limit')

%Combustion Actuators Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
ylim([0 200]);
yyaxis right
plot(Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-c')
title('Combustion Actuators overview')
xlabel('Elapsed time - t - [s]')
ylim([0 1000]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]', 'Actual Exhaust Gas Flow Rate - [l/min]')



%Plot7: Efficiency Overview

figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.Expected_Efficiency_nom,'-b',Aggregate.t_relative,Aggregate.Expected_Efficiency_up,'--b',Aggregate.t_relative,Aggregate.Expected_Efficiency_low,':b',Aggregate.t_relative,Aggregate.SW_Efficiency,'-k')
title('Efficiency Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Thermal Efficiency - \eta - [%]')
ylim([0 100]);
legend('Efficiency considering calculated CO2 - Nominal GV','Efficiency considering calculated CO2 - Upper Limit GV', 'Efficiency considering calculated CO2 - Lower Limit GV', 'SW: Efficiency')

%Combustion Actuators Overview
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
yyaxis right
plot(Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-c')
title('Combustion Actuators overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]', 'Actual Exhaust Gas Flow Rate - [l/min]')



%Plot8: Air Flow / RPM
%Flow Rate Control
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.DeltaP_sensor,'-k',Aggregate.t_relative,Aggregate.Expected_DeltaP_venturi,'--k',Aggregate.t_relative,Aggregate.Expected_DeltaP_fan,'-r',Aggregate.t_relative,Aggregate.Expected_P_venturi1,'-b',Aggregate.t_relative,Aggregate.Expected_P_venturi2,'-g');
title('Pressure Difference Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Pressure Difference - \DeltaP - [mbar]')
ylim([-5 5])
legend('Pressure difference in the venturi - measured', 'Pressure difference in the venturi - calculated from Actual Flow Rate', 'Pressure difference across the Fan','Pressure difference in the venturi - TAP 01','Pressure difference in the venturi - TAP 02')


subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.SW_FlowrateNom,'-g',Aggregate.t_relative,Aggregate.SW_FlowrateUp,'--g',Aggregate.t_relative,Aggregate.SW_FlowrateLow,':g',Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-k',Aggregate.t_relative,Aggregate.Vdot_exg_desired,'--k')
title('Flow Rate Control Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Flow Rate @15ºC, 1 at - [l/min]')
ylim([0 1000])
legend('Flow Rate Set-point', 'Acceptance Criteria: Flow Rate Max','Acceptance Criteria: Flow Rate Min','SW: Actual Flow Rate','SW: Desired Flow Rate')


%Plot9: Tventuri calc
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.SW_TVenturi,':k',Aggregate.t_relative,Aggregate.SW_TVenturi_calc,'-k',Aggregate.t_relative,Aggregate.T_flue,'-r');
title('Temperature in the Venturi Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Temperature - T - [ºC]')
legend('Temperature in the venturi - f(Qn) - [ºC]', 'Temperature in the venturi - Calculated from \Delta P and Flow Rate - [ºC]', 'Flue Temperature - measured by the sensor - [ºC]');

subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.I_ion,'-r',Aggregate.t_relative,Aggregate.I_gv,'-b');
yyaxis right
plot(Aggregate.t_relative,Aggregate.Vdot_exg_actual,'-c')
title('Combustion Actuators overview')
xlabel('Elapsed time - t - [s]')
ylim([0 200]);
legend('Power Input - [kW]', 'Ionisation Currrent - [\muA]', 'Gas Valve Current - [mA]', 'Actual Exhaust Gas Flow Rate - [l/min]')


%% Graphs DAQ

%Plot10: Tventuri calc
figure
subplot(2,1,1);
plot(Aggregate.t_relative,Aggregate.Qn,'-k',Aggregate.t_relative,Aggregate.Qn_calculatedbypburner,'-b');
title('Power Input Overview')
xlabel('Elapsed time - t - [s]')
ylabel('Power Input - Qn - [kW]')
ylim([0 22])
legend('Request', 'Actual: Calculated with Burner Pressure');

Aggregate.CO_daf=Aggregate.CO.*14./Aggregate.CO2;
subplot(2,1,2);
plot(Aggregate.t_relative,Aggregate.CO2,'-k');
yyaxis right
plot(Aggregate.t_relative,Aggregate.CO,':b',Aggregate.t_relative,Aggregate.CO_daf,'-b');
title('Combustion Overview')
ylim([0 2000])
xlabel('Elapsed time - t - [s]')
legend('CO2', 'CO', 'CO_{DAF}')




%% Produce cell for export

F_3=fieldnames(Aggregate);
C_xls=cell(1,1);
C_xls_titles=cell(1,length(F_3));
A=0;
A=zeros(length(Aggregate.(F_3{1})),length(F_3));
for i=1:length(F_3)
    C_xls_titles{1,i}=F_3{i};
    A(:,i)=Aggregate.(F_3{i});
end

C_xls{1}=A;



%Window that asks where you want to save the file
[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',['Procom_analysis' '.xls']);
    if FileNameBodeWrite ~=0
        if exist([PathNameBodeWrite FileNameBodeWrite],'file')
            delete([PathNameLachWrite FileNameBodeWrite ]);
        end
        xlswrite([PathNameBodeWrite FileNameBodeWrite ],C_xls_titles)  %header           
        xlswrite([PathNameBodeWrite FileNameBodeWrite ],C_xls{1},'Sheet1','A2') %data
    end

 