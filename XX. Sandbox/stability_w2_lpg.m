% function [CO_daf,status]=stability_w2_lpg(x_p,x_b,Pi,lambdai)
lambdai=1.5

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

[X_CO2_G31,X_H2O_G31,X_N2_G31,X_O2_G31]=exgases_fraction(lambdai,1,1,'G31','dry');
[X_CO2_G30,X_H2O_G30,X_N2_G30,X_O2_G30]=exgases_fraction(lambdai,1,1,'G30','dry');

Pi=44;


%Find Upper and Lower limits for G31 and G30 for each Power Input
limits(:,1)=unique(cell2mat(stabilitydiagram(:,3)));
for j=1:size(limits,1)
    k=1;
    for i=1:length(stabilitydiagram)
        
        if strcmp(cell2mat(stabilitydiagram(i,1)),'G31')==1 && cell2mat(stabilitydiagram(i,3))==limits(j,1)
            A(k,j)=cell2mat(stabilitydiagram(i,4));
            k=k+1;
        end
    end
    B=A(:,j);
    limits(j,2)=min(B(B>0))
    limits(j,3)=max(A(:,j));
    
    
    for i=1:length(stabilitydiagram)
        
        if strcmp(cell2mat(stabilitydiagram(i,1)),'G30')==1 && cell2mat(stabilitydiagram(i,3))==limits(j,1)
            C(k,j)=cell2mat(stabilitydiagram(i,4));
            k=k+1;
        end
    end
    D=C(:,j);
    E=C(:,j);
    limits(j,4)=min(D(D>0))
    limits(j,5)=max(E(E>0));
end





%
%
%
% end
