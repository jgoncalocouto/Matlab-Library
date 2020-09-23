%% Automatic test: Evaluate the deadband of KME Gas Valves

%% Definition of test points
I_lim=[40 165]';
pitch=5;
valve_name='GV08';
t_point=5;

I_test=[I_lim(1,1):pitch:I_lim(size(I_lim,1),1)]';
I_test(I_test>120)=[];
I_test=vertcat(I_test,sort(I_test,'descend'));



I_test2=[130:pitch:I_lim(size(I_lim,1),1)]';
I_test2=vertcat(I_test2,sort(I_test2,'descend'));

I_test=[I_test;I_test2;40];

%% Procom DAQ

% Inputs
port='COM26';
GV_address='93D';
Offset_address='947';


% Initializing plots
figure
variable.v1 = plot(nan);
name=strcat('test_handle',num2str(1));
plots.(name) = plot(nan,'k-o');
set(plots.(name),'color',[0 0 0])
hold on
title(strcat('Test Overview: Valve Characterization - ',valve_name));
ylabel('Valve Current Set-point [mA]')
ylim([min(I_test)-pitch max(I_test)+pitch])
xlabel('Test Point')


% GV_Oscillation=0
s = serial(port);
set(s,'BaudRate',9600);
s.InputBufferSize=10^5;
s.Timeout=2 ;
[write_message]=procom_write('WRITE_ADDRESS',29,Offset_address,0);
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
    
    [data] = procom_daq(port,'acquisition_mode','timer',t_point,'figureOFF');
    
    if exist('log_data')==0
        log_data=data;
    else
        [log_data]=[log_data;data];
    end
    
    set(plots.(name)  ,'YData', I_test(1:i) );
    
end
disp('Test Completed!')

%% Export Procom log

table_exporter(log_data)

