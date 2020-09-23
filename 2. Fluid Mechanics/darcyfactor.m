function fsol = darcyfactor(Re,epsilon,D)

if Re<=0
fsol=0;
end

f(1)=0.02;
for i=2:10000
f(i)=(1/(-2*log10(((epsilon/D)/3.7)+(2.51/(Re*((f(i-1))^(0.5)))))))^2;
if abs(((f(i)-f(i-1))/(f(i)))*100)<=0.001
    fsol=f(i);
    reldif=abs(((f(i)-f(i-1))/(f(i)))*100);
    break
end
end

end