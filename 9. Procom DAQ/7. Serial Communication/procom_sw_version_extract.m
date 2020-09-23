function [SW_INFO] = procom_sw_version_extract(bout)

i=0;
k=0;
j=3;
record=0;
out=zeros(1,40);
B=zeros(1,40);

for i=2:length(bout)-1
    if bout(i)==123 && bout(i-1)==123 && strcmp(dec2hex(bout(i+4)),'D8')==1  %cmd_id='READ VERSION'
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

SW_INFO.MAIN=0;SW_INFO.SAFE=0;SW_INFO.EEPROM=0;SW_INFO.SMART_ENERGY_PROTOCOL=0;SW_INFO.HW_VERSION=0;
i=0;
for i=1:l_b
    
    if B(i,7)==1 %MAIN
        SW_INFO.MAIN=horzcat(B(i,8),B(i,9),B(i,10));
    elseif B(i,7)==2 %SAFE
        SW_INFO.SAFE=horzcat(B(i,8),B(i,9),B(i,10));
    elseif B(i,7)==3 %EEPROM
        SW_INFO.EEPROM=horzcat(B(i,8),B(i,9),B(i,10));
    elseif B(i,7)==4 %SMART_ENERGY_PROTOCOL
        SW_INFO.SMART_ENERGY_PROTOCOL=horzcat(B(i,8),B(i,9),B(i,10));
    elseif B(i,7)==5 %HW_VERSION
        SW_INFO.HW_VERSION=horzcat(B(i,8),B(i,9),B(i,10),B(i,11),B(i,12),B(i,13),B(i,14));
    end
    
    
end


end
