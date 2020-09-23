function [k]= thermal_condutivity(gastype,T)

k_H2O=[106.85	0.0246
126.85	0.0261
176.85	0.0299
226.85	0.0339
276.85	0.0379
326.85	0.0422
376.85	0.0464
426.85	0.0505
476.85	0.0549
526.85	0.0592
576.85	0.0637];

k_H2=[-173.15	0.067
-123.15	0.101
-73.15	0.131
-23.15	0.157
26.85	0.183
76.85	0.204
126.85	0.226
176.85	0.247
226.85	0.266
276.85	0.285
326.85	0.305
426.85	0.342
526.85	0.378
626.85	0.412
726.85	0.448
826.85	0.488
926.85	0.528
1026.85	0.568
1126.85	0.61
1226.85	0.655
1326.85	0.697
1426.85	0.742
1526.85	0.786
1626.85	0.835
1726.85	0.878];

k_N2=[-173.15	0.00958
-123.15	0.0139
-73.15	0.0183
-23.15	0.0222
26.85	0.0259
76.85	0.0293
126.85	0.0327
176.85	0.0358
226.85	0.0389
276.85	0.0417
326.85	0.0446
426.85	0.0499
526.85	0.0548
626.85	0.0597
726.85	0.0647
826.85	0.07
926.85	0.0758
1026.85	0.081];

k_O2=[-173.15	0.00925
-123.15	0.0138
-73.15	0.0183
-23.15	0.0226
26.85	0.0268
76.85	0.0296
126.85	0.033
176.85	0.0363
226.85	0.0412
276.85	0.0441
326.85	0.0473
426.85	0.0528
526.85	0.0589
626.85	0.0649
726.85	0.071
826.85	0.0758
926.85	0.0819
1026.85	0.0871];

k_CO2=[6.85	0.0152
26.85	0.01655
46.85	0.01805
66.85	0.0197
86.85	0.0212
106.85	0.02275
126.85	0.0243
176.85	0.0283
226.85	0.0325
276.85	0.0366
326.85	0.0407
376.85	0.0445
426.85	0.0481
476.85	0.0517
526.85	0.0551];

if strcmp(gastype,'O2')==1
    k=interp1(k_O2(:,1),k_O2(:,2),T);
elseif strcmp(gastype,'CO2')==1
    k=interp1(k_CO2(:,1),k_CO2(:,2),T);
elseif strcmp(gastype,'N2')==1
    k=interp1(k_N2(:,1),k_N2(:,2),T);
elseif strcmp(gastype,'H2')==1
    k=interp1(k_H2(:,1),k_H2(:,2),T);
elseif strcmp(gastype,'H2O')==1
    k=interp1(k_H2O(:,1),k_H2O(:,2),T);  
elseif strcmp(gastype,'Air')==1
    k=interp1(k_O2(:,1),k_O2(:,2),T)*0.2095+interp1(k_N2(:,1),k_N2(:,2),T)*0.7905;
end

    


end