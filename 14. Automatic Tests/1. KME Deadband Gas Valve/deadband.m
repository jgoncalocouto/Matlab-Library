%% Automatic test: Evaluate the deadband of KME Gas Valves

%% Definition of test points
Valve_offset_sp=[0 5 10 15 20]';
DeltaI_sp=[1 2 3 5 8]';
I_sp=[45 55 65 75 85 100]';
N_repetitions=3;

w=0;
I_test=zeros(N_repetitions*2*size(I_sp,1)*size(DeltaI_sp,1)+size(I_sp,1),1);
for i=1:size(I_sp,1) %runs every current input
    for j=1:size(DeltaI_sp,1) %runs every offset
        w=w+1;
        I_test(w)=I_sp(i);
        for k=1:N_repetitions %runs repetitions with the two values before
            w=w+1;
            I_test(w)=I_sp(i)+DeltaI_sp(j); %current increase offset
            w=w+1;
            I_test(w)=I_test(w-1)-DeltaI_sp(j); %current decrease to original value
        end
    end
end

I_exit=[I_sp(1,1):10:I_sp(size(I_sp,1),1)]';
I_exit=sort(I_exit,'descend');

clearvars -except I_test I_exit Valve_offset_sp

%% Procom DAQ



port='COM26';
GV_address='93D';
Offset_address='947';

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
    ylabel('Valve Current Set-point [mA]')
    ylim([I_test(1) I_test(size(I_test,1))])
    xlabel('Test Point')
    
    
    
    s = serial(port);
    set(s,'BaudRate',9600);
    s.InputBufferSize=10^5;
    s.Timeout=2 ;
    [write_message]=procom_write('WRITE_ADDRESS',29,Offset_address,Valve_offset_sp(j));
    fopen(s);
    fwrite(s,write_message);
    fclose(s);
    
    for i=1:size(I_test,1)
        
        
        s = serial(port);
        set(s,'BaudRate',9600);
        s.InputBufferSize=10^5;
        s.Timeout=2 ;
        [write_message]=procom_write('WRITE_ADDRESS',29,GV_address,I_test(i));
        fopen(s);
        fwrite(s,write_message);
        fclose(s);
        
        [data] = procom_daq(port,'acquisition_mode','timer',4,'figureOFF');
        
        if exist('log_data')==0
            log_data=data;
        else
            [log_data]=[log_data;data];
        end
        
        set(plots.(name)  ,'YData', I_test(1:i) );
        
    end
    disp(strcat('Test Overview: ','Valve Current Set-point Percentual Time Variation = ',num2str(Valve_offset_sp(j))))
    disp('Completed!')
    disp(strcat('Test Status :',num2str(j),'/',num2str(size(Valve_offset_sp,1)),' Done!'))
    for w=1:size(I_exit,1)
        s = serial(port);
        set(s,'BaudRate',9600);
        s.InputBufferSize=10^5;
        s.Timeout=2 ;
        [write_message]=procom_write('WRITE_ADDRESS',29,GV_address,I_exit(w));
        fopen(s);
        fwrite(s,write_message);
        fclose(s);
        pause(10);
    end
    
%     check_pin=input('Please confirm that the inlet pressure is adjusted by responding ''OK'' \n','s');
%     
%     if strcmp(check_pin,'OK')~=1
%         return
%     end
    
    
end


%% Export Procom log
[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',['Procom_analysis' '.xls']);
if FileNameBodeWrite ~=0
    if exist([PathNameBodeWrite FileNameBodeWrite],'file')
        delete([PathNameLachWrite FileNameBodeWrite ]);
    end
    writetable(timetable2table(log_data),[PathNameBodeWrite FileNameBodeWrite ])  %table
end

