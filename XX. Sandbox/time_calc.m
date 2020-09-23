%% Import Procom log

capacity='14';
[tt_procom]=procom_importer(capacity,'path','C:\Users\coo1av\Desktop\Time for ignition - KMAF0010\14L\14L_after_improvement\record_2019129_1126.csv');

%% Identify events

% Identify Water Tapping Starts
tt_procom.Diff_Vdot_w=[0;diff(tt_procom.Vdot_w)];
tt_procom.Water_On=zeros(size(tt_procom,1),1);
tt_procom.Water_On(tt_procom.Diff_Vdot_w>3)=1;


% Identify Sparking Starts
tt_procom.Diff_safetydata=[0;diff(tt_procom.SafetyData)];
tt_procom.Spark_On=zeros(size(tt_procom,1),1);
tt_procom.Spark_On(tt_procom.Diff_safetydata<=-1)=1;


% Identify Burner Starts
tt_procom.Diff_I_ion=[0;diff(tt_procom.I_ion)];
tt_procom.Burner_On=zeros(size(tt_procom,1),1);
tt_procom.Burner_On(tt_procom.Diff_I_ion>10)=1;



%% Get times till sparking and times till ignition
count=0;
water_flag=0;spark_flag=0;burner_flag=0;
for i=2:size(tt_procom,1)
    
    if tt_procom.Water_On(i)==1
        if water_flag==0
            count=count+1;
            t(count,1)=tt_procom.t_relative(i);
            water_flag=1;
        elseif tt_procom.Water_On(i-1)==1
            water_flag=1;
        else
            t(count,1)=tt_procom.t_relative(i);
        end
        
    elseif tt_procom.Spark_On(i)==1
        t(count,2)=tt_procom.t_relative(i);
    elseif tt_procom.Burner_On(i)==1
        t(count,3)=tt_procom.t_relative(i);
        water_flag=0;
    end
    
    
    
end

i=0;
for i=1:size(t,1)
    
    
    t_spark(i,1)=t(i,2)-t(i,1);
    t_burnerOn(i,1)=t(i,3)-t(i,1);
    
    if t(i,2)==0 || t(i,3)==0
        t_spark(i,1)=NaN;
        t_burnerOn(i,1)=NaN;
        
    end
    
end


%% Plots

%Plot1: Start-ups
figure
s1=subplot(2,1,1);
plot(tt_procom.t_relative,tt_procom.Vdot_w)
ylabel('Water Flow rate - [slpm]')
xlabel('Relative Time - [s]')
hold on
yyaxis right
ylabel('Ionisation Current - [\muA]')
plot(tt_procom.t_relative,tt_procom.I_ion)
i=0;
for i=1:size(t_burnerOn,1)
% xline(t(i,2),'b-',{'Sparking time',num2str(t_spark(i))})
xline(t(i,3),'r-',{'Ignition time',num2str(t_burnerOn(i))})
end


s2=subplot(2,1,2);
plot(tt_procom.t_relative,tt_procom.Water_On)
hold on
ylabel('State [1/0]')
xlabel('Relative Time - [s]')
plot(tt_procom.t_relative,tt_procom.Spark_On)
plot(tt_procom.t_relative,tt_procom.Burner_On)
legend('Water Flow Start?','Sparking Start?','Burner Started?')


linkaxes([s1 s2],'x')


