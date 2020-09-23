%% Defaults

datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss:SSS')

%% Agreggate Array
if str2double(capacity)==11
    nominal_power=22;
elseif str2double(capacity)==14
    nominal_power=28;
end


Aggregate.Qn=(Aggregate.burner_power./100)*nominal_power;
Aggregate.N_fanhz=Aggregate.N_fan./60;

%% Treat Aggregate Array
%Fill missing values with linear interpolation from the neighborhood
% Aggregate=fillmissing(Aggregate,'nearest');

%% PROCOM data treatment - Including SW Related Variables
KME_SW

i=0;


%Initialization of variables
rho_w=zeros(length(Aggregate.t_relative),1);
cp_w=zeros(length(Aggregate.t_relative),1);

Aggregate.RPMNom=zeros(length(Aggregate.t_relative),1);
Aggregate.RPMUp=zeros(length(Aggregate.t_relative),1);
Aggregate.RPMLow=zeros(length(Aggregate.t_relative),1);
Aggregate.Pn=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_FlowrateNom=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_FlowrateLow=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_FlowrateUp=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_ValveCurrent=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_Efficiency=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_TVenturi=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_RPMMin=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_RPMMax=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_Tfire=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_ExpectedPn=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vgas_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vgas_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vgas_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Qn_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Qn_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Qn_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Pburner_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Pburner_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Pburner_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vair_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vair_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Vair_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_lambda_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_lambda_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_lambda_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_CO2_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_CO2_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_CO2_low=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Efficiency_nom=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Efficiency_up=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_Efficiency_low=zeros(length(Aggregate.t_relative),1);
Aggregate.SW_TVenturi_calc=zeros(length(Aggregate.t_relative),1);
Aggregate.Expected_T_wout=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A4=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A5=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A6=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_A9=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_AC=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_C2=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_C6=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_C7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_CC=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_CF=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_CE=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E0=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E1=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E4=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_EC=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E8=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_E9=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_EA=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_F7=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_FA=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_F9=zeros(length(Aggregate.t_relative),1);
Aggregate.Error_50=zeros(length(Aggregate.t_relative),1);

Aggregate.Appliance_state_ID=zeros(size(Aggregate.t_relative,1),1);


Aggregate.RPMNom(:,1)=Aggregate.N_fanhz(:,1).*60;
Aggregate.RPMUp(:,1)=(Aggregate.N_fanhz(:,1)+0.49).*60; %rounding error accountablity
Aggregate.RPMLow(:,1)=(Aggregate.N_fanhz(:,1)-0.51).*60; %rounding error accountablity

Aggregate.Qn(isempty(Aggregate.Qn(:,1))==1)=0;
Aggregate.Qn(isnan(Aggregate.Qn(:,1))==1)=0;



Aggregate.Error_A4(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('A4'))==1,1)=1;
Aggregate.Error_A5(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('A5'))==1,1)=1;
Aggregate.Error_A6(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('A6'))==1,1)=1;
Aggregate.Error_A7(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('A7'))==1,1)=1;
Aggregate.Error_A9(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('A9'))==1,1)=1;
Aggregate.Error_AC(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('AC'))==1,1)=1;
Aggregate.Error_C2(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('C2'))==1,1)=1;
Aggregate.Error_C6(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('C6'))==1,1)=1;
Aggregate.Error_C7(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('C7'))==1,1)=1;
Aggregate.Error_CC(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('CC'))==1,1)=1;
Aggregate.Error_CF(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('CF'))==1,1)=1;
Aggregate.Error_E7(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('E7'))==1,1)=1;
Aggregate.Error_E0(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('E0'))==1,1)=1;
Aggregate.Error_E1(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('E1'))==1,1)=1;
Aggregate.Error_E4(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('E4'))==1,1)=1;
Aggregate.Error_E8(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('E8'))==1,1)=1;
Aggregate.Error_E9(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('E9'))==1,1)=1;
Aggregate.Error_EA(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('EA'))==1,1)=1;
Aggregate.Error_EC(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('EC'))==1,1)=1;
Aggregate.Error_F7(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('F7'))==1,1)=1;
Aggregate.Error_F7(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('f7'))==1,1)=1;
Aggregate.Error_FA(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('FA'))==1,1)=1;
Aggregate.Error_F9(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('F9'))==1,1)=1;
Aggregate.Error_CE(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('CE'))==1,1)=1;
Aggregate.Error_50(strcmp(num2str(dec2hex(Aggregate.Error(:,:))),string('50'))==1,1)=1;

Aggregate.SW_FlowrateNom(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_FlowrateUp(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_FlowrateLow(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_ValveCurrent(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_Efficiency(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_TVenturi(Aggregate.I_ion(:,1)<0,1)=Aggregate.T_flue(Aggregate.I_ion(:,1)<0,1);
Aggregate.SW_RPMMin(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_RPMMax(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_Tfire(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_ExpectedPn(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.SW_TVenturi_calc(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.Expected_T_wout(Aggregate.I_ion(:,1)<0,1)=0;
Aggregate.Pn(Aggregate.I_ion(:,1)<0,1)=0;

[Aggregate,states_list] = appliance_state_labeler(Aggregate);

% Compute variables
for i=1:length(Aggregate.t_relative)
    
    
    rho_w(i,1)=XSteam('rhoL_T',(Aggregate.T_win(i,1)+Aggregate.T_wout(i,1))/2);
    cp_w(i,1)=XSteam('CpL_T',(Aggregate.T_win(i,1)+Aggregate.T_wout(i,1))/2);
    
    
    
    
    
    
    
    if Aggregate.Appliance_state_ID(i,1)==4
        Aggregate.SW_FlowrateNom(i,1)=interp1_sat(SW_Flowrate.(Gastype_parameter)(:,1),SW_Flowrate.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_FlowrateLow(i,1)=(SW_FlowrateLimitLow.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_FlowrateUp(i,1)=(SW_FlowrateLimitUp.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_ValveCurrent(i,1)=interp1_sat(SW_ValveCurrent.(Gastype_parameter)(:,1),SW_ValveCurrent.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_Efficiency(i,1)=interp1_sat(SW_Efficiency.(Gastype_parameter)(:,1),SW_Efficiency.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_TVenturi(i,1)=interp1_sat(SW_Tventuri.(Gastype_parameter)(:,1),SW_Tventuri.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_RPMMin(i,1)=interp1_sat(SW_RPMMin.(Gastype_parameter)(:,1),SW_RPMMin.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_RPMMax(i,1)=interp1_sat(SW_RPMMax.(Gastype_parameter)(:,1),SW_RPMMax.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_Tfire(i,1)=interp1_sat(SW_Tfire.(Gastype_parameter)(:,1),SW_Tfire.(Gastype_parameter)(:,2),Aggregate.Qn(i,1));
        Aggregate.SW_ExpectedPn(i,1)=(Aggregate.SW_Efficiency(i,1)/100)*Aggregate.Qn(i,1);
        Aggregate.SW_TVenturi_calc(i,1)=-273.15+(((11809.^2)*Aggregate.P_box(i,1))./(Aggregate.Vdot_air_actual(i,1).^2));
        Aggregate.Expected_T_wout(i,1)=((Aggregate.Qn(i,1).*Aggregate.SW_Efficiency(i,1).*0.01)./(Aggregate.Vdot_w(i,1).*(1/60000).*rho_w(i).*cp_w(i)))+Aggregate.T_win(i,1);
    elseif Aggregate.Appliance_state_ID(i,1)==2
        Aggregate.SW_FlowrateNom(i,1)=SW_I_Flowrate.(Gastype_parameter);
        Aggregate.SW_FlowrateLow(i,1)=(SW_I_FlowrateLimitLow.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_FlowrateUp(i,1)=(SW_I_FlowrateLimitUp.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_RPMMax(i,1)=interp1_sat(SW_I_RPMMax.(Gastype_parameter)(:,1),SW_I_RPMMax.(Gastype_parameter)(:,2),Aggregate.T_flue(i,1));
        
    elseif Aggregate.Appliance_state_ID(i,1)==3
        Aggregate.SW_FlowrateNom(i,1)=SW_I_Flowrate.(Gastype_parameter);
        Aggregate.SW_FlowrateLow(i,1)=(SW_I_FlowrateLimitLow.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_FlowrateUp(i,1)=(SW_I_FlowrateLimitUp.(Gastype_parameter)+1)*Aggregate.SW_FlowrateNom(i,1);
        Aggregate.SW_RPMMax(i,1)=interp1_sat(SW_I_RPMMax.(Gastype_parameter)(:,1),SW_I_RPMMax.(Gastype_parameter)(:,2),Aggregate.T_flue(i,1));
        
        
        
    end
    
end

Aggregate.Pn(Aggregate.I_ion(i,1)>0,1)=(Aggregate.Vdot_w(Aggregate.I_ion(i,1)>0,1)./60000).*rho_w(Aggregate.I_ion(i,1)>0,1).*cp_w(Aggregate.I_ion(i,1)>0,1).*(Aggregate.T_wout(Aggregate.I_ion(i,1)>0,1)-Aggregate.T_win(Aggregate.I_ion(i,1)>0,1));



%% Treat Aggregate Array
%Fill missing values with linear interpolation from the neighborhood

% Aggregate=fillmissing(Aggregate,'nearest');
