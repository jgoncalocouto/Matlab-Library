%% Inputs

port='COM6';
var1='93D';%Valve Current Setpoint
test_mode='automatic';
direction='both';

valve_pitch=1; % fan duty interval for the fan characterization
test_points=[50:valve_pitch:165]';
test_points=vertcat(5,test_points);
% test_points=vertcat(test_points,165);
% Variables to record
variable_name={
    'I_gv' 'Intensity of current - PROCOM' 'mbar'
    'T_flue' 'Flue Gas Temperature' 'ºC'
    };



%% Variable initialization
if strcmp(direction,'both')==1
test_points=vertcat(test_points,fliplr(test_points')');
elseif strcmp(direction,'down')==1
    test_points=fliplr(test_points')';
end

instrreset;

if exist('i')==1
    
else
    i=0;
    count_id=0;
    data_test=0;
end



if size(data_test,2)<size(variable_name,1)
    A=zeros(1,size(variable_name,1));
    data_test=array2table(A);
    
    for j=1:size(variable_name,1)
        data_test.Properties.VariableUnits{horzcat('A',num2str(j))} = variable_name{j,3};
        data_test.Properties.VariableDescriptions{horzcat('A',num2str(j))} = variable_name{j,2};
        data_test.Properties.VariableNames{horzcat('A',num2str(j))} = variable_name{j,1};
        
    end
else
    
    for j=1:size(variable_name,1)
        data_test.Properties.VariableDescriptions{variable_name(j,1)} = variable_name{j,2};
        data_test.Properties.VariableUnits{variable_name(j,1)} = variable_name{j,3};
    end
end


%% Data aquisition module

if strcmp(test_mode,'manual')==1
    
    t_daq=0.25;
    
    s = serial(port);
    set(s,'BaudRate',9600);
    s.Timeout=10*60;
    s.InputBufferSize=10^5;
    fopen(s);
    
    [set_mode]=procom_write('SET_MODE',3,'P9',1);
    fwrite(s,set_mode)
    
    
    prompt = {'Enter variable value'};
    dlgtitle = 'Valve Current Set-point';
    dims = [1 50];
    definput = {'5'};
    var2=str2num(cell2mat(inputdlg(prompt,dlgtitle,dims,definput)));
    
    count_id=count_id+1;
    designation='WRITE_ADDRESS';
    message_id=count_id;
    [message]=procom_write(designation,message_id,var1,var2);
    fwrite(s,message);
    fclose(s);
    
    % Procom Daq
    
    t_daq=0.25;
    Procom_daq_v3_GC_notvisible %run procom daq
    
    if data_test.I_gv(1)==0
        i=1;
        data_test=timetable(data.t_absolute,data.I_gv,data.T_flue);
        data_test.Properties.VariableNames{'Var1'} = 'I_gv';
        data_test.Properties.VariableNames{'Var2'} = 'T_flue';
    else
        i=i+1;
    end
    
    data_test_i=timetable(data.t_absolute,data.I_gv,data.T_flue);
    data_test_i.Properties.VariableNames{'Var1'} = 'I_gv';
    data_test_i.Properties.VariableNames{'Var2'} = 'T_flue';
    data_test=[data_test;data_test_i];
    save data_test
    
elseif strcmp(test_mode,'automatic')==1
    
    for w=1:size(test_points,1)
        
        t_daq=0.25;
        
        s = serial(port);
        set(s,'BaudRate',9600);
        s.Timeout=10*60;
        s.InputBufferSize=10^5;
        fopen(s);
        
        [set_mode]=procom_write('SET_MODE',3,'P9',1);
        fwrite(s,set_mode)
        
        var2=test_points(w);
        
        count_id=count_id+1;
        designation='WRITE_ADDRESS';
        message_id=count_id;
        [message]=procom_write(designation,message_id,var1,var2);
        fwrite(s,message);
        fclose(s);
        
        
        
        % Procom Daq
        
        t_daq=0.25;
        Procom_daq_v3_GC_notvisible %run procom daq
        
        if data_test.I_gv(1)==0
            i=1;
            data_test=timetable(data.t_absolute,data.I_gv,data.T_flue);
            data_test.Properties.VariableNames{'Var1'} = 'I_gv';
            data_test.Properties.VariableNames{'Var2'} = 'T_flue';
        else
            i=i+1;
        end
        
        data_test_i=timetable(data.t_absolute,data.I_gv,data.T_flue);
        data_test_i.Properties.VariableNames{'Var1'} = 'I_gv';
        data_test_i.Properties.VariableNames{'Var2'} = 'T_flue';
        data_test=[data_test;data_test_i];
        save data_test
        pause(5)
        
        
        
    end
    
end
