function [tt_procom,states_list] = appliance_state_labeler(tt_procom)


tt_procom.Appliance_state_ID(tt_procom.SafetyData==111 & tt_procom.Vdot_w==0)=1;
tt_procom.Appliance_state_ID(tt_procom.SafetyData==111 & tt_procom.Vdot_w>0)=2;
tt_procom.Appliance_state_ID((tt_procom.SafetyData==110 & tt_procom.Vdot_w>0 & tt_procom.I_ion==0) | (tt_procom.SafetyData==0 & tt_procom.Vdot_w>0 & tt_procom.I_ion==0))=3;
tt_procom.Appliance_state_ID(tt_procom.SafetyData==110 & tt_procom.Vdot_w>0 & tt_procom.I_ion>0)=4;

states_list=zeros(size(tt_procom.t_relative,1),1);
states_list=string(states_list);

states_list(tt_procom.Appliance_state_ID==1)=string('Stand-by');
states_list(tt_procom.Appliance_state_ID==2)=string('C2 Check');
states_list(tt_procom.Appliance_state_ID==3)=string('Start-up Routine');
states_list(tt_procom.Appliance_state_ID==4)=string('Normal Operation');


end

