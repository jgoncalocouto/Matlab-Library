
%% Automatic test: Evaluate the deadband of KME Gas Valves

%% Definition of test points
instrreset
Valve_offset_sp=[0]';
Fanduty_delta=[0]';
Fanduty_sp=[250:50:600]';
N_repetitions=1;

w=0;
Fanduty_test=zeros(N_repetitions*2*size(Fanduty_sp,1)*size(Fanduty_delta,1)+size(Fanduty_sp,1),1);
for i=1:size(Fanduty_sp,1) %runs every current input
    for j=1:size(Fanduty_delta,1) %runs every offset
        w=w+1;
        Fanduty_test(w)=Fanduty_sp(i);
        for k=1:N_repetitions %runs repetitions with the two values before
            w=w+1;
            Fanduty_test(w)=Fanduty_sp(i)+Fanduty_delta(j); %current increase offset
            w=w+1;
            Fanduty_test(w)=Fanduty_test(w-1)-Fanduty_delta(j); %current decrease to original value
        end
    end
end

Fanduty_exit=[500:100:Fanduty_sp(size(Fanduty_sp,1),1)]';
Fanduty_exit=sort(Fanduty_exit,'descend');

clearvars -except Fanduty_test Fanduty_exit Valve_offset_sp

%% Procom DAQ



port='COM6';
GV_address='8E7';

for k=1:4
    my_field = strcat('v',num2str(k));
    variable.(my_field) = plot(nan);
end

for j=1:size(Valve_offset_sp,1)
    
    figure
    name=strcat('test_handle',num2str(j));
    plots.(name) = plot(nan,'k-o');
    set(plots.(name),'color',[0 0 0])
    hold on
    title(strcat('Test Overview: ','Valve Current Set-point Percentual Time Variation = ',num2str(Valve_offset_sp(j))));
    ylabel('Air flow [l/min]')
    ylim([Fanduty_test(1) Fanduty_test(size(Fanduty_test,1))])
    xlabel('Test Point')
    
    
    
    for i=1:size(Fanduty_test,1)
        
        
        s = serial(port);
        set(s,'BaudRate',9600);
        s.InputBufferSize=10^5;
        s.Timeout=2 ;
        [write_message]=procom_write('WRITE_ADDRESS',29,GV_address,Fanduty_test(i));
        fopen(s);
        fwrite(s,write_message);
        fclose(s);
        
        [data] = procom_daq(port,'acquisition_mode','timer',2,'figureOFF');
        
        if exist('log_data')==0
            log_data=data;
        else
            [log_data]=[log_data;data];
        end
        
        set(plots.(name)  ,'YData', Fanduty_test(1:i) );
        
    end
    disp(strcat('Test Overview: ','Valve Current Set-point Percentual Time Variation = ',num2str(Valve_offset_sp(j))))
    disp('Completed!')
    disp(strcat('Test Status :',num2str(j),'/',num2str(size(Valve_offset_sp,1)),' Done!'))
    for w=1:size(Fanduty_exit,1)
        s = serial(port);
        set(s,'BaudRate',9600);
        s.InputBufferSize=10^5;
        s.Timeout=2 ;
        [write_message]=procom_write('WRITE_ADDRESS',29,GV_address,Fanduty_exit(w));
        fopen(s);
        fwrite(s,write_message);
        fclose(s);
        pause(10);
    end
    
    
    
end


%% Export Procom log
[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',['Procom_analysis' '.xls']);
if FileNameBodeWrite ~=0
    if exist([PathNameBodeWrite FileNameBodeWrite],'file')
        delete([PathNameLachWrite FileNameBodeWrite ]);
    end
    writetable(timetable2table(log_data),[PathNameBodeWrite FileNameBodeWrite ])  %table
end

