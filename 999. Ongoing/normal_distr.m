
%% Normal Distribution
Pburner_max=5.8;
Pburner_min=2.49;
Pburner_nom=4.02;
Pburner_limit=4.7;

T=Pburner_max-Pburner_min;
std=sqrt((T^2)/36);
mu=Pburner_nom;


p_nd=(normcdf(mu+T,mu,std)-normcdf(Pburner_limit,mu,std))*100

figure
x = [round(Pburner_min-1):.1:round(Pburner_max+1)];
y = normpdf(x,Pburner_nom,std);
plot(x,y)
hold on

plot([Pburner_limit Pburner_limit],[0 1])
ylim([0 1])
