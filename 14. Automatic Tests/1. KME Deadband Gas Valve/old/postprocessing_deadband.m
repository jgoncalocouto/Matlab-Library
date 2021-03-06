%% Post_processing script
tic
number_of_evodaqs=2;
number_of_matlabs=4;

test_blocks={'Valve_offset = 0';'Valve_offset = 5';'Valve_offset = 10';'Valve_offset = 15'};

for i=1:number_of_evodaqs
    [tt_evodaq_intermediate] = evodaq_importer('channel naming',{'P_burner_dpm','I_GV','P_in','P_burner_huba','A0','A00'});
    
    if exist('tt_evodaq')==0
        tt_evodaq=tt_evodaq_intermediate;
    else
        tt_evodaq=[tt_evodaq_intermediate;tt_evodaq];
    end
    
end
tt_evodaq.A0=[]; tt_evodaq.A00=[];

toc

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

clearvars -except tt
%% Separate Test Batches
d_gv=diff(tt.I_gv);
separators=find(d_gv<-50);
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

%% 1st Post Processing: Get only statiscal relevant data from baselines, ignore the rest

D_1=diff(tt_evodaq.I_GV);
patamar_1=zeros(size(D_1,1),1);
patamar_1(abs(D_1)<0.3)=1;
patamar_1(size(patamar_1,1)+1)=patamar_1(size(patamar_1,1));

D_2=diff(tt_evodaq.P_in);
patamar_2=zeros(size(D_2,1),1);
patamar_2(abs(D_2)<0.01)=1;
patamar_2(size(patamar_2,1)+1)=patamar_2(size(patamar_2,1));

patamar=patamar_1;
patamar(patamar_2==0)=0;

[T_err,T_avg,T_median,T_std,details]=patamar_statistics(patamar,tt_evodaq,'random_uncertainty','average','median','std','patamar_details');

min_number_of_elements=30;

T_err=T_err(details.number_of_elements>min_number_of_elements,:);
T_std=T_std(details.number_of_elements>min_number_of_elements,:);
T_avg=T_avg(details.number_of_elements>min_number_of_elements,:);
T_median=T_median(details.number_of_elements>min_number_of_elements,:);
details=details(details.number_of_elements>min_number_of_elements,:);
details.patamar_midpoint=(details.patamar_start+details.patamar_end)./2;
%% Figures; Eyeball Test
%Eyeball Test #1: Check for the correctness of baseline definition
figure
ax1=subplot(2,1,1)
plot(tt_evodaq.I_GV,'-k');
hold on
plot(details.patamar_start,T_median.I_GV,'r*')
plot(details.patamar_end,T_median.I_GV,'ro')
title('Eyeball Test #1: Check for the correctness of baseline definition')
ylabel('Intensity of current - [mA]')
legend('Untreated data','Median @ baseline start','Median @ baseline end')

%Eyeball Test #2: Check for excessive inlet pressure variation during each specific baseline
ax2=subplot(2,1,2)
errorbar(details.patamar_midpoint,T_median.P_in,T_err.P_in,'ko');
hold on
plot(tt_evodaq.P_in,'-r')
title('Eyeball Test #2: Check for excessive inlet pressure variation during each specific baseline')
ylabel('Inlet Pressure - [mbar]')
xlabel('Relative time - t - [s]')
legend('Error bar for Inlet Pressure for each baseline')

linkaxes([ax1 ax2],'x')



%% Figures: Check for Deadband

figure
x_1=subplot(2,1,1);
plot(T_median.I_GV,T_median.P_burner_huba,'ko')
title('Intensity of current vs Burner Pressure [mbar]')
xlabel('Intensity of current - [mA]')
ylabel('Burner pressure - [mbar]')

x_2=subplot(2,1,2);
errorbar(T_median.I_GV,T_median.P_in,T_err.P_in,'r*')
xlabel('Intensity of current - [mA]')
ylabel('Inlet Pressure - [mbar]')

linkaxes([x_1,x_2],'x')


%% Missing

%Post-process matlab_logs (has the procom data). From this log, \Delta I
%for each I_sp can be correctly extracted.
