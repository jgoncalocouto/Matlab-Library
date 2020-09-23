function [B] = message_extract(bout)

i=0;
k=0;
j=3;
record=0;
out=zeros(1,40);
B=zeros(1,40);

for i=2:length(bout)-1
    if bout(i)==123 && bout(i-1)==123 && strcmp(dec2hex(bout(i+4)),'A0')==1  %cmd_id='broadcast'
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
end
