function [value] = read_address(bout)
% Reads the value of the last address request by function READ_ADDRESS


i=0;
k=0;
j=3;
record=0;
out=zeros(1,40);
B=zeros(1,40);

for i=2:length(bout)-1
    if bout(i)==123 && bout(i-1)==123 && strcmp(dec2hex(bout(i+4)),'DB')==1  %cmd_id='READ VERSION'
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

if numel(num2str(B(7)))==1
    byte_1=horzcat('0',num2str(B(7)));
else
    byte_1=num2str(B(7));
end

if numel(num2str(B(8)))==1
    byte_0=horzcat('0',num2str(B(8)));
else
    byte_0=num2str(B(8));
end


ans1=horzcat(dec2hex(str2num(byte_0)),dec2hex(str2num(byte_1)));

value=hex2dec(ans1);

    
end
