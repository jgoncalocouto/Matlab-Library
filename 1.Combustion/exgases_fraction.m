function [X_CO2,X_H2O,X_N2,X_O2]=exgases_fraction(lambda,gastype,w_d)
%Function that estimates the exhaust gases' molar fractions of combustible using a simplified single-order combustion model

%Inputs: lambda [-] Gas Type [-], 'wet' or 'dry' fraction?  [-]
%Outputs: Number of moles of: CO2 [-] , O2 [-] , N2 [-] , H2O [-]

%Special notice:
%Output variable is a matrix


%Gas Type Database
gas_list={
    'G110'	0.26	1	4	0.00	0	0	0.24	0.50	21.76	24.75	13.95	15.87	0.411	0.411
    'G112'	0.17	1	4	0.00	0	0	0.24	0.59	19.48	22.36	11.81	13.56	0.367	0.367
    'G20'	1.00	1	4	0.00	0	0	0.00	0.00	45.67	50.72	34.02	37.78	0.555	0.554
    'G21'	0.87	1	4	0.13	3	8	0.00	0.00	49.6	54.76	41.01	45.28	0.684	0.680
    'G222'	0.77	1	4	0.00	0	0	0.00	0.23	42.87	47.87	28.53	31.86	0.443	0.442
    'G23'	0.93	1	4	0.00	0	0	0.08	0.00	41.11	45.66	31.46	34.95	0.586	0.585
    'G24'	0.68	1	4	0.12	3	8	0.00	0.20	47.01	52.09	35.7	39.55	0.577	0.573
    'G25'	0.86	1	4	0.00	0	0	0.14	0.00	37.38	41.52	29.25	32.49	0.612	0.612
    'G26'	0.80	1	4	0.07	3	8	0.13	0.00	40.52	44.83	33.36	36.91	0.678	0.675
    'G27'	0.87	1	4	0.00	0	0	0.18	0.00	35.17	39.06	27.89	30.98	0.629	0.656
    'G231'	0.85	1	4	0.00	0	0	0.15	0.00	36.82	40.9	28.91	32.11	0.617	0.616
    'G30'	1.00	4	10	0.00	0	0	0.00	0.00	80.58	87.33	116.09	125.81	2.075	2.007
    'G31'	1.00	3	8	0.00	0	0	0.00	0.00	70.69	76.84	88	95.65	1.55	1.522
    'G32'	1.00	3	6	0.00	0	0	0.00	0.00	68.14	72.86	82.78	88.52	1.476	1.453
    };

% col.1 - Gas Type
% col.2 - %( C_{x1} H_{y1} )
% col.3 - x1
% col.3 - y1
% col.4 %( C_{x2} H_{y2} )
% col.5 x2
% col.6 y2
% col.7 %(N_2)
% col.8 %(H_2)
% col.9 Inferior Wobbe Index - Wi - [MJ/m^3]
% col.10 	Superior Wobbe Index - Ws - [MJ/m^3]
% col.11 	Inferior Heating Value - Hi - [MJ/m^3]
% col.12 Superior Heating Value - Hs - [MJ/m^3]
% col.13 EN26 - Relative Density in relation to Air - d - [-]
% col.14 Relative Density in relation to Air (Calculated with Molecular Weight) - d - [-]

%Code to discover number of carbon and hydrogen atoms based on the gas type
for i=1:size(gas_list,1)
    if strcmp(gastype,cell2mat(gas_list(i,1)))==1
        fraction_ch1=cell2mat(gas_list(i,2));
        N_C1=cell2mat(gas_list(i,3));
        N_H1=cell2mat(gas_list(i,4));
        fraction_ch2=cell2mat(gas_list(i,5));
        N_C2=cell2mat(gas_list(i,6));
        N_H2=cell2mat(gas_list(i,7));
        fraction_n2=cell2mat(gas_list(i,8));
        fraction_h2=cell2mat(gas_list(i,9));
        
        x=fraction_ch1*N_C1+fraction_ch2*N_C2;
        y=fraction_ch1*N_H1+fraction_ch2*N_H2;
        fraction_ch=fraction_ch1+fraction_ch2;
    end
end

R1=fraction_ch;
R2=fraction_n2;
R3=fraction_h2;
R4=lambda*(x*fraction_ch+(fraction_ch*y+fraction_h2*2)/4);

P1=fraction_ch*x;
P2=(fraction_ch*y+2*fraction_h2)/2;
P3=(2*R4-2*P1-P2)/2;
P4=R4*3.76+fraction_n2;

%Code to calculate exhaust gases' molar fraction depending if it is wet or dry
if strcmp(w_d,'wet')==1
    X_CO2=P1/(P1+P2+P3+P4);
    X_O2=P3/(P1+P2+P3+P4);
    X_N2=P4/(P1+P2+P3+P4);
    X_H2O=P2/(P1+P2+P3+P4);
    
elseif strcmp(w_d,'dry')==1
    X_CO2=P1/(P1+P3+P4);
    X_O2=P3/(P1+P3+P4);
    X_N2=P4/(P1+P3+P4);
    X_H2O=0;
end


end