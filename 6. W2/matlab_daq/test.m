a = CDaqData(10);

for i=1:50
    
    a.bufTime.append([i ;i;i]);
    a.bufData.append([i ;i;i]);
end
