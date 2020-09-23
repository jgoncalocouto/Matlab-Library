function [tt_data] = data_importer_evoleo_matlab(number_of_evodaqs,number_of_matlabs)

for i=1:number_of_evodaqs
    [tt_evodaq_intermediate] = evodaq_importer('channel naming',{'P_burner_dpm','I_GV','P_in','P_burner_huba','A0','A00'});
    
    if exist('tt_evodaq')==0
        tt_evodaq=tt_evodaq_intermediate;
    else
        tt_evodaq=[tt_evodaq_intermediate;tt_evodaq];
    end
end
tt_evodaq.A0=[]; tt_evodaq.A00=[];


for i=1:number_of_matlabs
    
    [open_name1, open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
        'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
    filename1 = strcat(open_path1,open_name1);
    
    [tt_procom_intermediate] = readtable(filename1);% Importing file
    tt_procom_intermediate=table2timetable(tt_procom_intermediate);
    
    if exist('tt_procom')==0
        tt_procom=tt_procom_intermediate;
    else
        tt_procom=[tt_procom_intermediate;tt_procom];
    end
    
    
end


tt=synchronize(tt_evodaq,tt_procom);
tt=fillmissing(tt,'nearest');

% Separate Test Batches
d_gv=diff(tt.I_gv);
separators=find(d_gv<-21);

if size(separators,1)==0
    tt_data{1}=tt;
else
    lim(1,1)=1;
    lim(size(separators,1)+1,1)=separators(size(separators,1),1);
    lim(size(separators,1)+1,2)=size(tt.t_absolute,1);
    
    for i=1:(size(separators,1))
        lim(i+1,1)=separators(i,1);
        lim(i,2)=separators(i,1);
    end
    
    for i=1:size(lim,1)
        tt_data{i}=tt(lim(i,1):lim(i,2),:);
    end
end



end

