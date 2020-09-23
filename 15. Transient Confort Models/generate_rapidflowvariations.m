function [data_v] = generate_rapidflowvariations(V_start,V_end)

% V_start=[5:0.1:11];
% V_end=2.2;

for i=1:length(V_start)
V=[V_end:0.1:V_start(i)];
a=zeros(1,0);
Z=0;
j=2;
while Z<V_start(i)
    a(j-1)=V_start(i);
    Z=V_end+((j-2)/2).*0.1;
    a(j)=Z;
    j=j+2;
end
data_v{i}=a;
a=[];
end


end

