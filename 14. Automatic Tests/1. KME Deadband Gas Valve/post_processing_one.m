function [tt,T_err,T_avg,T_median,T_std,details] = post_processing_one(tt)
%% 1st Post Processing: Get only statistic data from baselines, ignore the rest

%Criteria 1: Identifying all the current steps
D_1=diff(tt.I_GV);
patamar_1=zeros(size(D_1,1),1);
patamar_1(abs(D_1)<0.3)=1;
patamar_1(size(patamar_1,1)+1)=patamar_1(size(patamar_1,1));
patamar=patamar_1;

%Criteria 2; Identifying different subtests (GVO=0 ~= GVO=5)
D3=diff(tt.I_gv);
sep=find(D3>=10);
lim(1,1)=1;
lim(size(sep,1)+1,1)=sep(size(sep,1),1);
lim(size(sep,1)+1,2)=size(tt.t_absolute,1);

for i=1:(size(sep,1))
    lim(i+1,1)=sep(i,1);
    lim(i,2)=sep(i,1);
end

for i=1:size(lim,1)
    tt.I_gv_patamar(lim(i,1):lim(i,2))=mode(tt.I_gv(lim(i,1):lim(i,2)));
    tt.I_GV_patamar(lim(i,1):lim(i,2))=mode(tt.I_GV(lim(i,1):lim(i,2)));
    tt.P_burner_huba_patamar(lim(i,1):lim(i,2))=mode(tt.P_burner_huba(lim(i,1):lim(i,2)));
    tt.P_burner_dpm_patamar(lim(i,1):lim(i,2))=mode(tt.P_burner_dpm(lim(i,1):lim(i,2)));
end

tt.DeltaI_gv=tt.I_gv-tt.I_gv_patamar;
tt.DeltaI_GV=tt.I_GV-tt.I_GV_patamar;

tt.DeltaP_burner_huba=tt.P_burner_huba-tt.P_burner_huba_patamar;
tt.DeltaP_burner_dpm=tt.P_burner_dpm-tt.P_burner_dpm_patamar;


[T_err,T_avg,T_median,T_std,details]=patamar_statistics(patamar,tt,'random_uncertainty','average','median','std','patamar_details');

min_number_of_elements=30;

T_err=T_err(details.number_of_elements>min_number_of_elements,:);
T_std=T_std(details.number_of_elements>min_number_of_elements,:);
T_avg=T_avg(details.number_of_elements>min_number_of_elements,:);
T_median=T_median(details.number_of_elements>min_number_of_elements,:);
details=details(details.number_of_elements>min_number_of_elements,:);
details.patamar_midpoint=(details.patamar_start+details.patamar_end)./2;

end

