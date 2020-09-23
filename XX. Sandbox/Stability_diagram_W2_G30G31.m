stabilitydiagram={'G31'	5160	48	7.86	75	'5 m of equivalent ductwork - 80 mm'
'G31'	5040	48	8.01	95	'5 m of equivalent ductwork - 80 mm'
'G31'	4920	48	8.19	124	'5 m of equivalent ductwork - 80 mm'
'G31'	4800	48	8.35	160	'5 m of equivalent ductwork - 80 mm'
'G31'	4680	48	8.52	205	'5 m of equivalent ductwork - 80 mm'
'G31'	4560	48	8.73	281	'5 m of equivalent ductwork - 80 mm'
'G31'	4440	48	8.94	386	'5 m of equivalent ductwork - 80 mm'
'G30'	4920	48	8.35	110	'5 m of equivalent ductwork - 80 mm'
'G30'	4800	48	8.49	147	'5 m of equivalent ductwork - 80 mm'
'G30'	4680	48	8.67	200	'5 m of equivalent ductwork - 80 mm'
'G30'	4560	48	8.87	268	'5 m of equivalent ductwork - 80 mm'
'G30'	4440	48	9.01	346	'5 m of equivalent ductwork - 80 mm'
'G30'	4320	48	9.25	504	'5 m of equivalent ductwork - 80 mm'
'G31'	5040	45.6	7.55	47	'5 m of equivalent ductwork - 80 mm'
'G31'	4920	45.6	7.67	66	'5 m of equivalent ductwork - 80 mm'
'G31'	4800	45.6	7.88	91	'5 m of equivalent ductwork - 80 mm'
'G31'	4680	45.6	8.02	116	'5 m of equivalent ductwork - 80 mm'
'G31'	4560	45.6	8.25	159	'5 m of equivalent ductwork - 80 mm'
'G31'	4440	45.6	8.45	210	'5 m of equivalent ductwork - 80 mm'
'G31'	4320	45.6	8.62	287	'5 m of equivalent ductwork - 80 mm'
'G31'	4200	45.6	8.79	390	'5 m of equivalent ductwork - 80 mm'
'G30'	4680	45.6	8.23	115	'5 m of equivalent ductwork - 80 mm'
'G30'	4560	45.6	8.37	150	'5 m of equivalent ductwork - 80 mm'
'G30'	4440	45.6	8.57	199	'5 m of equivalent ductwork - 80 mm'
'G30'	4320	45.6	8.78	278	'5 m of equivalent ductwork - 80 mm'
'G30'	4200	45.6	8.99	404	'5 m of equivalent ductwork - 80 mm'
'G31'	5400	50.4	7.94	75	'5 m of equivalent ductwork - 80 mm'
'G31'	5280	50.4	8.12	97	'5 m of equivalent ductwork - 80 mm'
'G31'	5160	50.4	8.27	124	'5 m of equivalent ductwork - 80 mm'
'G31'	5040	50.4	8.42	156	'5 m of equivalent ductwork - 80 mm'
'G31'	4920	50.4	8.62	206	'5 m of equivalent ductwork - 80 mm'
'G31'	4800	50.4	8.82	279	'5 m of equivalent ductwork - 80 mm'
'G31'	4680	50.4	8.98	364	'5 m of equivalent ductwork - 80 mm'
'G30'	5040	50.4	8.71	157	'5 m of equivalent ductwork - 80 mm'
'G30'	4920	50.4	8.86	198	'5 m of equivalent ductwork - 80 mm'
'G30'	4800	50.4	8.97	263	'5 m of equivalent ductwork - 80 mm'
'G30'	4680	50.4	9.15	345	'5 m of equivalent ductwork - 80 mm'
'G30'	4560	50.4	9.39	498	'5 m of equivalent ductwork - 80 mm'
'G31'	5760	55	8.19	95	'5 m of equivalent ductwork - 80 mm'
'G31'	5640	55	8.46	127	'5 m of equivalent ductwork - 80 mm'
'G31'	5520	55	8.59	155	'5 m of equivalent ductwork - 80 mm'
'G31'	5400	55	8.74	191	'5 m of equivalent ductwork - 80 mm'
'G31'	5280	55	8.93	245	'5 m of equivalent ductwork - 80 mm'
'G31'	5160	55	9.1	319	'5 m of equivalent ductwork - 80 mm'
'G31'	5040	55	9.31	434	'5 m of equivalent ductwork - 80 mm'
'G30'	5400	55	9.03	194	'5 m of equivalent ductwork - 80 mm'
'G30'	5280	55	9.19	240	'5 m of equivalent ductwork - 80 mm'
'G30'	5160	55	9.35	307	'5 m of equivalent ductwork - 80 mm'
'G30'	5040	55	9.57	415	'5 m of equivalent ductwork - 80 mm'
'G30'	4920	55	9.69	566	'5 m of equivalent ductwork - 80 mm'};

%CO2 Stoichiometric calculation for G30 and G31
[CO2_stoich_G31,X_H2O,X_N2,X_O2]=exgases_fraction(1,1,1,'G31','dry');
[CO2_stoich_G30,X_H2O,X_N2,X_O2]=exgases_fraction(1,1,1,'G30','dry');


%Lambda and COdaf Calculation
for i=1:length(stabilitydiagram)
stabilitydiagram(i,7)={lambda(cell2mat(stabilitydiagram(i,1)),(cell2mat(stabilitydiagram(i,4))/100),1,1)};
if strcmp(cell2mat(stabilitydiagram(i,1)),'G31')==1
    stabilitydiagram(i,8)={cell2mat(stabilitydiagram(i,5))*(CO2_stoich_G31/(cell2mat(stabilitydiagram(i,4))/100))};
elseif strcmp(cell2mat(stabilitydiagram(i,1)),'G30')==1
stabilitydiagram(i,8)={cell2mat(stabilitydiagram(i,5))*(CO2_stoich_G30/(cell2mat(stabilitydiagram(i,4))/100))};
end
end



%Stability curves plot for G31
hold on
a=0;
b=0;
c=0;
d=0;
for i=1:length(stabilitydiagram)
if strcmp(cell2mat(stabilitydiagram(i,1)),'G31')==1
        if cell2mat(stabilitydiagram(i,3))==48
        a=a+1;
        G31_p48(a,1)=cell2mat(stabilitydiagram(i,4));
        G31_p48(a,2)=cell2mat(stabilitydiagram(i,8));
    elseif cell2mat(stabilitydiagram(i,3))==45.6
        
                b=b+1;
        G31_p45(b,1)=cell2mat(stabilitydiagram(i,4));
        G31_p45(b,2)=cell2mat(stabilitydiagram(i,8));
    elseif cell2mat(stabilitydiagram(i,3))==50.4

                        c=c+1;
        G31_p50(c,1)=cell2mat(stabilitydiagram(i,4));
        G31_p50(c,2)=cell2mat(stabilitydiagram(i,8));
    elseif cell2mat(stabilitydiagram(i,3))==55

                                d=d+1;
        G31_p55(d,1)=cell2mat(stabilitydiagram(i,4));
        G31_p55(d,2)=cell2mat(stabilitydiagram(i,8));
    end

end
end
plot(G31_p48(:,1),G31_p48(:,2),'r-*')
plot(G31_p45(:,1),G31_p45(:,2),'b-+')
plot(G31_p50(:,1),G31_p50(:,2),'g-x')
plot(G31_p55(:,1),G31_p55(:,2),'m-o')
legend('Power Input=48kW','Power Input=45.6kW','Power Input=50.6kW','Power Input=55kW')
title('Stability Diagram - W2 Mx G31')
xlabel('\lambda')
ylabel('CO_{daf} [ppm]')

hold off

%Stability curves plot for G30
figure
hold on
a=0;
b=0;
c=0;
d=0;
for i=1:length(stabilitydiagram)
if strcmp(cell2mat(stabilitydiagram(i,1)),'G30')==1
        if cell2mat(stabilitydiagram(i,3))==48
        a=a+1;
        G30_p48(a,1)=cell2mat(stabilitydiagram(i,4));
        G30_p48(a,2)=cell2mat(stabilitydiagram(i,8));
    elseif cell2mat(stabilitydiagram(i,3))==45.6
        
                b=b+1;
        G30_p45(b,1)=cell2mat(stabilitydiagram(i,4));
        G30_p45(b,2)=cell2mat(stabilitydiagram(i,8));
    elseif cell2mat(stabilitydiagram(i,3))==50.4

                        c=c+1;
        G30_p50(c,1)=cell2mat(stabilitydiagram(i,4));
        G30_p50(c,2)=cell2mat(stabilitydiagram(i,8));
    elseif cell2mat(stabilitydiagram(i,3))==55

                                d=d+1;
        G30_p55(d,1)=cell2mat(stabilitydiagram(i,4));
        G30_p55(d,2)=cell2mat(stabilitydiagram(i,8));
    end

end
end
plot(G30_p48(:,1),G30_p48(:,2),'r-*')
plot(G30_p45(:,1),G30_p45(:,2),'b-+')
plot(G30_p50(:,1),G30_p50(:,2),'g-x')
plot(G30_p55(:,1),G30_p55(:,2),'m-o')
legend('Power Input=48kW','Power Input=45.6kW','Power Input=50.6kW','Power Input=55kW')
title('Stability Diagram - W2 Mx G30')
xlabel('\lambda')
ylabel('CO_{daf} [ppm]')

hold off


