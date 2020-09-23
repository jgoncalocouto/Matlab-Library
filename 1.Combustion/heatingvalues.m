function [HV] = heatingvalues(gastype,parameter)
%Function that computes the Hi,Hs,Wi and Ws in [MJ/m^3] for all the gas types defined in EN 437.
%gas_database:
    %col.1 - Gas Type
    %col.2 - %CH4
    %col.3 - %H2
    %col.4 - %N2
    %col.5 - %C3H8
    %col.6 - %n-C4H10
    %col.7 - %C4H10
    %col.8 - %C3H6
    %col.9 - Wi
    %col.10 - Hi
    %col.11 - Ws
    %col.12 - Hs
    %col.13 - d


gas_database={'G110'	26	50	24	0	0	0	0	21.76	13.95	24.75	15.87	0.411
    'G112'	17	59	24	0	0	0	0	19.48	11.81	22.36	13.56	0.367
    'G20'	100	0	0	0	0	0	0	45.67	34.02	50.72	37.78	0.555
    'G21'	87	0	0	13	0	0	0	49.6	41.01	54.76	45.28	0.684
    'G222'	77	23	0	0	0	0	0	42.87	28.53	47.87	31.86	0.443
    'G23'	92.5	0	7.5	0	0	0	0	41.11	31.46	45.66	34.95	0.586
    'G24'	68	20	0	12	0	0	0	47.01	35.7	52.09	39.55	0.577
    'G25'	86	0	14	0	0	0	0	37.38	29.25	41.52	32.49	0.612
    'G26'	80	0	13	7	0	0	0	40.52	33.36	44.83	36.91	0.678
    'G27'	82	0	18	0	0	0	0	35.17	27.89	39.06	30.98	0.629
    'G231'	85	0	15	0	0	0	0	36.82	28.91	40.9	32.11	0.617
    'G30'	0	0	0	0	50	50	0	80.58	116.09	87.33	125.81	2.075
    'G31'	0	0	0	100	0	0	0	70.69	88	76.84	95.65	1.55
    'G32'	0	0	0	0	0	0	100	68.14	82.78	72.86	88.52	1.476};

for i=1:length(gas_database)
    if strcmp(gastype,cell2mat(gas_database(i,1)))==1
        if strcmp(parameter,'Hi')==1
            HV=cell2mat(gas_database(i,10));
        elseif strcmp(parameter,'Hs')==1
            HV=cell2mat(gas_database(i,12));
        elseif strcmp(parameter,'Wi')==1
            HV=cell2mat(gas_database(i,9));
        elseif strcmp(parameter,'Ws')==1
            HV=cell2mat(gas_database(i,11));
        elseif strcmp(parameter,'d')==1
            HV=cell2mat(gas_database(i,13));
        end
    end
end




end