function [parameter] = read_parameter(designation,bout)

i=0;
k=0;
j=3;
record=0;
out=zeros(1,40);
B=zeros(1,40);

for i=2:length(bout)-1
    if bout(i)==123 && bout(i-1)==123 && strcmp(dec2hex(bout(i+4)),'D2')==1  %cmd_id='READ VERSION'
        out(1)=123;out(2)=123;
        record=1;
    elseif bout(i)==125 && bout(i+1)==125 && record==1
        out(j)=125;out(j+1)=125;
        record=0;
        k=k+1;
        B(k,1:length(out))=out(1,:);
        clearvars out
        j=3;
    elseif bout(i-1)==125 && bout(i)==0 && record==1
        return
    elseif record==1
        out(j)=bout(i);
        j=j+1;
    end
end
[l_b,c_b]=size(B);

parameter=0;
i=0;
for i=1:l_b
    
    if strcmp(designation,'SETPOINT')==1 && B(i,7)==85 %SETPOINT
        parameter=B(i,9);
        
    elseif strcmp(designation,'TEMPERATURE_UNIT')==1 && B(i,7)==1 %TEMPERATURE_UNIT
        parameter=B(i,9);
        
        if parameter==0
            parameter='ºC';
        elseif parameter==1
            parameter='ºF';
        else
            return
        end
        
    elseif strcmp(designation,'GAS_TYPE')==1 && B(i,7)==5 %GAS_TYPE
        parameter=B(i,9);
        
        if parameter==0
            parameter='G20/NG';
        elseif parameter==1
            parameter='G30/LPG';
        elseif parameter==2
            parameter='G31';
        elseif parameter==3
            parameter='G25';
        elseif parameter==4
            parameter='G28';
        elseif parameter==5
            parameter='G33';
        else
            parameter='Unknown';
            return
        end
        
    elseif strcmp(designation,'APPLIANCE_CAPACITY')==1 && B(i,7)==3 %APPLIANCE_CAPACITY
        parameter=B(i,9);
        
        if parameter==0
            parameter='11';
        elseif parameter==1
            parameter='14';
        elseif parameter==2
            parameter='17';
            
        else
            return
        end
        
    elseif strcmp(designation,'P0')==1 && B(i,7)==12 %P0_VALUE
        parameter=B(i,9);
        
    elseif strcmp(designation,'FREQUENCY_MEASUREMENT_CIRCUIT_CALIBRATION')==1 && B(i,7)==1 %FREQUENCY_MEASUREMENT_CIRCUIT_CALIBRATION
        parameter=B(i,9);
        
        
    elseif strcmp(designation,'MODE')==1 && B(i,7)==6 %MODE
        parameter=B(i,9);
        
        if parameter==0
            parameter='THERMOSTATIC';
        elseif parameter==1
            parameter='OFF';
        elseif parameter==2
            parameter='P0';
        elseif parameter==3
            parameter='P1';
        elseif parameter==4
            parameter='P2';
        elseif parameter==5
            parameter='P9';
        else
            return
        end
        
    elseif strcmp(designation,'DESIRED_FANSPEED')==1 && B(i,7)==30 %DESIRED_FANSPEED
        
        
        if numel(num2str(B(i,9)))==1
            byte_1=horzcat('0',num2str(B(9)));
        else
            byte_1=num2str(B(i,9));
        end
        
        if numel(num2str(B(i,8)))==1
            byte_0=horzcat('0',num2str(B(8)));
        else
            byte_0=num2str(B(i,8));
        end
        
        
        ans1=horzcat(dec2hex(str2num(byte_0)),dec2hex(str2num(byte_1)));
        
        parameter=hex2dec(ans1).*6; %RPM
        
    elseif strcmp(designation,'DESIRED_AIRFLOW')==1 && B(i,7)==39 %DESIRED_AIRFLOW
        
        
        if numel(num2str(B(i,9)))==1
            byte_1=horzcat('0',num2str(B(9)));
        else
            byte_1=num2str(B(i,9));
        end
        
        if numel(num2str(B(i,8)))==1
            byte_0=horzcat('0',num2str(B(8)));
        else
            byte_0=num2str(B(i,8));
        end
        
        
        ans1=horzcat(dec2hex(str2num(byte_0)),dec2hex(str2num(byte_1)));
        
        parameter=hex2dec(ans1);
        
    elseif strcmp(designation,'DESIRED_VALVECURRENT')==1 && B(i,7)==31 %DESIRED_AIRFLOW
        
        
        if numel(num2str(B(i,9)))==1
            byte_1=horzcat('0',num2str(B(9)));
        else
            byte_1=num2str(B(i,9));
        end
        
        if numel(num2str(B(i,8)))==1
            byte_0=horzcat('0',num2str(B(8)));
        else
            byte_0=num2str(B(i,8));
        end
        
        
        ans1=horzcat(dec2hex(str2num(byte_0)),dec2hex(str2num(byte_1)));
        
        parameter=hex2dec(ans1);
        
        
        
        
    elseif strcmp(designation,'DESIRED_BURNERPOWER')==1 && B(i,7)==8 %DESIRED_AIRFLOW
        
        
        if numel(num2str(B(i,9)))==1
            byte_1=horzcat('0',num2str(B(9)));
        else
            byte_1=num2str(B(i,9));
        end
        
        if numel(num2str(B(i,8)))==1
            byte_0=horzcat('0',num2str(B(8)));
        else
            byte_0=num2str(B(i,8));
        end
        
        
        ans1=horzcat(dec2hex(str2num(byte_0)),dec2hex(str2num(byte_1)));
        
        parameter=hex2dec(ans1);
        
        
    elseif strcmp(designation,'ACTIVEFAILURE')==1 && B(i,7)==52 %DESIRED_AIRFLOW
        
        
        if numel(num2str(B(i,9)))==1
            byte_1=horzcat('0',num2str(B(9)));
        else
            byte_1=num2str(B(i,9));
        end
        
        if numel(num2str(B(i,8)))==1
            byte_0=horzcat('0',num2str(B(8)));
        else
            byte_0=num2str(B(i,8));
        end
        
        
        ans1=horzcat(dec2hex(str2num(byte_1)));
        
        parameter=ans1;
        
        
    end
    
end



end
