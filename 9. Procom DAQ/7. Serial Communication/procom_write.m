function[A]=procom_write(designation,message_id,var1,var2)

sender_id=77; %default sender id, can be altered
receiver_id=0;

A(1)=123;A(2)=123;A(3)=sender_id;A(4)=receiver_id;A(5)=message_id;

if strcmp(designation,'SET_ACQUISITION_TIME')==1
    A(6)=hex2dec('A1');
    A(7)=0;
    A(8)=var1;
elseif strcmp(designation,'SET_MESSAGE_TYPE')==1
    A(6)=hex2dec('A1');
    A(7)=1;
    A(8)=var1;
elseif strcmp(designation,'READ_SWVERSION_MAIN')==1
    A(6)=hex2dec('D8');
    A(7)=1;
elseif strcmp(designation,'READ_SWVERSION_SAFE')==1
    A(6)=hex2dec('D8');
    A(7)=2;
elseif strcmp(designation,'READ_EEPROM_VERSION')==1
    A(6)=hex2dec('D8');
    A(7)=3;
elseif strcmp(designation,'READ_SMART_ENERGY_PROTOCOL')==1
    A(6)=hex2dec('D8');
    A(7)=4;
elseif strcmp(designation,'READ_HW_VERSION')==1
    A(6)=hex2dec('D8');
    A(7)=5;
elseif strcmp(designation,'SET_SETPOINT')==1
    A(6)=hex2dec('D3');
    A(7)=02; %Operation_ID Mode
    A(8)=85; %Operation_ID for SETPOINT
    A(9)=0;  % First part of the setpoint value
    A(10)=var1; % Second part of the setpoint value
elseif strcmp(designation,'SET_TEMPERATURE_UNIT')==1
    A(6)=hex2dec('D3');
    A(7)=6;
    A(8)=1;
    A(9)=0;
    if strcmp(var1,'ºC')==1
        A(10)=0;
    elseif  strcmp(var1,'ºF')==1
        A(11)=1;
    else
        return
    end
elseif strcmp(designation,'SET_GAS_TYPE')==1
    A(6)=hex2dec('D3');
    A(7)=6;
    A(8)=5;
    A(9)=0;
    if strcmp(var1,'G20')==1
        A(10)=0;
    elseif  strcmp(var1,'G30')==1
        A(10)=1;
    elseif  strcmp(var1,'G31')==1
        A(10)=2;
    elseif  strcmp(var1,'G25')==1
        A(10)=3;
    elseif  strcmp(var1,'G28')==1
        A(10)=4;
    elseif  strcmp(var1,'G33')==1
        A(10)=5;
    else
        return
    end
elseif strcmp(designation,'SET_APPLIANCE_CAPACITY')==1
    A(6)=hex2dec('D3');
    A(7)=6;
    A(8)=3;
    A(9)=0;
    if var1==10 || var1==12
        A(10)=0;
    elseif var1==11 || var1==15
        A(10)=1;
    elseif var1==17 || var1==18
        A(10)=2;
    else
        return
    end
elseif strcmp(designation,'SET_P0')==1
    A(6)=hex2dec('D3');
    A(7)=6;
    A(8)=12;
    A(9)=0;
    A(10)=var1;
elseif strcmp(designation,'SET_FREQUENCY_MEASUREMENT_CIRCUIT_CALIBRATION')==1
    A(6)=hex2dec('D3');
    A(7)=4;
    A(8)=1;
    var1_hex=dec2hex(var1);
    
    if length(var1_hex)==1
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==2
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==3
        A(9)=hex2dec(var1_hex(1));
        A(10)=hex2dec(var1_hex(2:3));
    elseif length(var1_hex)==4
        A(9)=hex2dec(var1_hex(1:2));
        A(10)=hex2dec(var1_hex(3:4));
    end
    
elseif strcmp(designation,'SET_DESIRED_FANSPEED')==1
    A(6)=hex2dec('D3');
    A(7)=2;
    A(8)=30;
    var1_hex=dec2hex(var1);
    
    if length(var1_hex)==1
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==2
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==3
        A(9)=hex2dec(var1_hex(1));
        A(10)=hex2dec(var1_hex(2:3));
    elseif length(var1_hex)==4
        A(9)=hex2dec(var1_hex(1:2));
        A(10)=hex2dec(var1_hex(3:4));
    end
    
    
elseif strcmp(designation,'SET_DESIRED_AIRFLOW')==1
    A(6)=hex2dec('D3');
    A(7)=2;
    A(8)=39;
    var1_hex=dec2hex(var1);
    
    if length(var1_hex)==1
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==2
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==3
        A(9)=hex2dec(var1_hex(1));
        A(10)=hex2dec(var1_hex(2:3));
    elseif length(var1_hex)==4
        A(9)=hex2dec(var1_hex(1:2));
        A(10)=hex2dec(var1_hex(3:4));
    end
elseif strcmp(designation,'SET_DESIRED_VALVECURRENT')==1
    A(6)=hex2dec('D3');
    A(7)=2;
    A(8)=31;
    var1_hex=dec2hex(var1);
    
    if length(var1_hex)==1
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==2
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==3
        A(9)=hex2dec(var1_hex(1));
        A(10)=hex2dec(var1_hex(2:3));
    elseif length(var1_hex)==4
        A(9)=hex2dec(var1_hex(1:2));
        A(10)=hex2dec(var1_hex(3:4));
    end
    
    
elseif strcmp(designation,'SET_DESIRED_BURNERPOWER')==1
    A(6)=hex2dec('D3');
    A(7)=2;
    A(8)=8;
    var1_hex=dec2hex(var1);
    
    if length(var1_hex)==1
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==2
        A(9)=0;
        A(10)=var1;
    elseif length(var1_hex)==3
        A(9)=hex2dec(var1_hex(1));
        A(10)=hex2dec(var1_hex(2:3));
    elseif length(var1_hex)==4
        A(9)=hex2dec(var1_hex(1:2));
        A(10)=hex2dec(var1_hex(3:4));
    end
    
    
elseif strcmp(designation,'SET_MODE')==1
    A(6)=hex2dec('D3');
    A(7)=2;
    A(8)=6;
    A(9)=0;
    
    if strcmp(var1,'THERMOSTATIC')==1
        A(10)=0;
    elseif  strcmp(var1,'OFF')==1
        A(10)=1;
    elseif  strcmp(var1,'P0')==1
        A(10)=2;
    elseif  strcmp(var1,'P1')==1
        A(10)=3;
    elseif  strcmp(var1,'P2')==1
        A(10)=4;
    elseif  strcmp(var1,'P9')==1
        A(10)=5;
    else
        return
    end
    
elseif strcmp(designation,'WRITE_ADDRESS')==1
    A(6)=hex2dec('DC');
    address_hex=horzcat('0',num2str(var1));
    A(7)=hex2dec(address_hex(1:2));
    A(8)=hex2dec(address_hex(3:4));
    
    var2_hex=dec2hex(var2);
    
    
    
    
    if length(var2_hex)==1
        A(9)=var2;
        A(10)=0;
    elseif length(var2_hex)==2
        A(9)=var2;
        A(10)=0;
    elseif length(var2_hex)==3
        A(9)=hex2dec(var2_hex(2:3));
        A(10)=hex2dec(var2_hex(1));
    elseif length(var2_hex)==4
        A(9)=hex2dec(var2_hex(3:4));
        A(10)=hex2dec(var2_hex(1:2));
        
    end
    
elseif strcmp(designation,'READ_ADDRESS')==1
    A(6)=hex2dec('DB');
    address_hex=horzcat('0',num2str(var1));
    A(7)=hex2dec(address_hex(1:2));
    A(8)=hex2dec(address_hex(3:4));
    A(9)=2; %Number of bytes to read
    
    
elseif strcmp(designation,'READ_SETPOINT')==1
    A(6)=hex2dec('D2');
    A(7)=02; %Operation_ID Mode
    A(8)=85; %Operation_ID for SETPOINT
    
elseif strcmp(designation,'READ_TEMPERATURE_UNIT')==1
    A(6)=hex2dec('D2');
    A(7)=6; %Configuration Mode
    A(8)=1; %DATA_ID for Temperature Unit
    
    
elseif strcmp(designation,'READ_GAS_TYPE')==1
    A(6)=hex2dec('D2');
    A(7)=6;
    A(8)=5;
    
elseif strcmp(designation,'READ_APPLIANCE_CAPACITY')==1
    A(6)=hex2dec('D2');
    A(7)=6;
    A(8)=3;
    
elseif strcmp(designation,'READ_P0')==1
    A(6)=hex2dec('D2');
    A(7)=6;
    A(8)=12;
    
elseif strcmp(designation,'READ_FREQUENCY_MEASUREMENT_CIRCUIT_CALIBRATION')==1
    A(6)=hex2dec('D2');
    A(7)=4;
    A(8)=1;
    
elseif strcmp(designation,'READ_DESIRED_FANSPEED')==1
    A(6)=hex2dec('D2');
    A(7)=2;
    A(8)=30;
    
elseif strcmp(designation,'READ_DESIRED_AIRFLOW')==1
    A(6)=hex2dec('D2');
    A(7)=2;
    A(8)=39;
    
elseif strcmp(designation,'READ_DESIRED_VALVECURRENT')==1
    A(6)=hex2dec('D2');
    A(7)=2;
    A(8)=31;
    
elseif strcmp(designation,'READ_DESIRED_BURNERPOWER')==1
    A(6)=hex2dec('D2');
    A(7)=2;
    A(8)=8;
    
elseif strcmp(designation,'READ_MODE')==1
    A(6)=hex2dec('D2');
    A(7)=2;
    A(8)=6;
    
elseif strcmp(designation,'READ_ACTIVEFAILURE')==1
    A(6)=hex2dec('D2');
    A(7)=2;
    A(8)=52;
    
else
    return
    
end
csum=0;
csum=sum(A(3:length(A)));
checksum=bitand(csum,255);
A(length(A)+1)=checksum;
A(length(A)+1)=125;A(length(A)+1)=125;


end