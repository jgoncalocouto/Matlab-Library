S=[0.06 0.006]';
L=[1 2]';
R(1,1)=1; %closed wall
R(size(S,1),1)=-1; %open-ended

gamma=1.4;
M=28.96;
Ru=8314;
Rm=Ru/M;
Ti=26.85;
Tk=Ti+273.15;
C0=sqrt(gamma*Rm*Tk);
C0=830;

syms k A

j=0;
for j=2:size(S,1)
    Th(j-1)=S(j-1)/S(j);
    T{j-1}=(1/2).*[exp(1i*k*L(j-1))*(1+Th(j-1)) exp(-1i*k*L(j-1))*(1-Th(j-1)); exp(i*k*L(j-1))*(1-Th(j-1)) exp(-i*k*L(j-1))*(1+Th(j-1))];
end

G=T{1};
for j=2:size(S,1)-1
    G=mtimes(G,T{j});
end
A = sym('A',[2 size(S,1)]);


% lol = mtimes(G,A(:,1)) == A(:,size(S,1));
% eqns(1,:)=lol(1,:);
% eqns(2,:)=lol(2,:);
% eqns(3,:)= A(1,1)/A(2,1)==R(1);
% eqns(4,:)= (A(1,size(S,1))/A(2,size(S,1)))*exp(2*1i*k*L(size(S,1)))==R(size(S,1));
% eqns(5,:)= R(size(S,1))==((G(1,1)*R(1)+G(1,2))/(G(2,1)*R(1)+G(2,2)))*(exp(2*1i*k*L(size(S,1))))
% vars = [k A(1,1) A(2,1) A(1,size(S,1)) A(2,size(S,1))];
% sol=solve(eqns, vars, 'ReturnConditions', true);

eqns(1,:)= R(size(S,1))==((G(1,1)*R(1)+G(1,2))/(G(2,1)*R(1)+G(2,2)))*(exp(2*1i*k*L(size(S,1))));
vars = [k];
sol=solve(eqns, vars, 'ReturnConditions', true);



% eqns(1,:)= 0==cos(k*L(1))*cos(k*L(2))-Th(1)*sin(k*L(1))*sin(k*L(2))
% vars = [k];
% sol=solve(eqns, vars, 'ReturnConditions', true);


syms l z

n=[0:1:19];
n1=n+1;

j=0;
figure
hold on
xlabel('Mode number')
ylabel('Natural Frequencies - f - [Hz]')
title('Longitudinal Modes')

    
    for j=1:size(sol.k,1)
        
        
        f(j,:)=(subs(sol.k(j),l,n).*C0)./(2*pi);
        f(j,:)=real(subs(f(j,:),z,1));
    end

f=f(:);

f=round(f(f>0));
f=sort(f,'ascend');
scatter(n1(1:20),f(1:20));







