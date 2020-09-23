function cp = cp(gastype,Ti)

if isnan(Ti)==1
cp=0;
return
end


R=8.3144621;
coefs={'O2'	3.28254E+01	1.48309E-03	-7.57967E-07	2.09471E-10	-2.16718E-14	-1.08846E+03	5.45323E+00	3.78246E+00	-2.99673E-03	9.84730E-06	-9.68130E-09	3.24373E-12	-1.06394E+03	3.65768E+00	2.00000E+02	3.50000E+03	3.20000E+01
'H2'	3.33728E+00	-4.94025E-05	4.99457E-07	-1.79566E-10	2.00255E-14	-9.50159E+02	-3.20502E+00	2.34433E+00	7.98052E-03	-1.94782E-05	2.01572E-08	-7.37612E-12	-9.17935E+02	6.83010E-01	2.00000E+02	3.50000E+03	2.01600E+00
'H2O'	3.03399E+00	2.17692E-03	-1.64073E-07	-9.70420E-11	1.68201E-14	-3.00043E+04	4.96677E+00	4.19864E+00	-2.03643E-03	6.52040E-06	-5.48797E-09	1.77198E-12	-3.02937E+04	-8.49032E-01	2.00000E+02	3.50000E+03	1.80200E+01
'CH4'	7.48515E-02	1.33909E-02	-5.73286E-06	1.22293E-09	-1.01815E-13	-9.46834E+03	1.84373E+01	5.14988E+00	-1.36710E-02	4.91801E-05	-4.84743E-08	1.66694E-11	-1.02466E+04	-4.64130E+00	2.00000E+02	3.50000E+03	1.60420E+01
'G20'	7.48515E-02	1.33909E-02	-5.73286E-06	1.22293E-09	-1.01815E-13	-9.46834E+03	1.84373E+01	5.14988E+00	-1.36710E-02	4.91801E-05	-4.84743E-08	1.66694E-11	-1.02466E+04	-4.64130E+00	2.00000E+02	3.50000E+03	1.60420E+01
'CO'	2.71519E+00	2.06253E-03	-9.98826E-07	2.30053E-10	-2.03648E-14	-1.41519E+04	7.81869E+00	3.57953E+00	-6.10354E-04	1.01681E-06	9.07006E-10	-9.04424E-13	-1.43441E+04	3.50841E+00	2.00000E+02	3.50000E+03	2.80100E+01
'CO2'	3.85746E+00	4.41437E-03	-2.21481E-06	5.23490E-10	-4.72084E-14	-4.87592E+04	2.27164E+00	2.35677E+00	8.98460E-03	-7.12356E-06	2.45919E-09	-1.43700E-13	-4.83720E+04	9.90105E+00	2.00000E+02	3.50000E+03	4.40100E+01
'N2'	2.92664E+00	1.48798E-03	-5.68476E-07	1.00970E-10	-6.75335E-15	-9.22798E+02	5.98053E+00	3.29868E+00	1.40824E-03	-3.96322E-06	5.64152E-09	-2.44485E-12	-1.02090E+03	3.95037E+00	2.00000E+02	5.00000E+03	2.80100E+01
'C3H8'	7.53414E+00	1.88722E-02	-6.27185E-06	9.14756E-10	-4.78381E-14	-1.64675E+04	-1.78923E+01	9.33554E-01	2.64246E-02	6.10597E-06	-2.19775E-08	9.51493E-12	-1.39585E+04	1.92017E+01	2.00000E+02	5.00000E+03	4.40900E+01
'G31'	7.53414E+00	1.88722E-02	-6.27185E-06	9.14756E-10	-4.78381E-14	-1.64675E+04	-1.78923E+01	9.33554E-01	2.64246E-02	6.10597E-06	-2.19775E-08	9.51493E-12	-1.39585E+04	1.92017E+01	2.00000E+02	5.00000E+03	4.40900E+01
'C4H10'	-3.17587E+05	6.17633E+03	-3.89156E+01	1.58465E-01	-1.86005E-04	-4.54036E+04	2.37949E+02	7.68232E+06	-3.25605E+04	5.73673E+01	-6.19792E-03	1.18019E-06	1.77453E+05	-3.58792E+02	2.00000E+02	6.00000E+03	5.81200E+01
'G30'	-3.17587E+05	6.17633E+03	-3.89156E+01	1.58465E-01	-1.86005E-04	-4.54036E+04	2.37949E+02	7.68232E+06	-3.25605E+04	5.73673E+01	-6.19792E-03	1.18019E-06	1.77453E+05	-3.58792E+02	2.00000E+02	6.00000E+03	5.81200E+01
};
Tk=Ti+273.15;
i=0;


[l c]=size(coefs);
for i=1:l
    if strcmp(gastype,cell2mat(coefs(i,1)))==1
        M=cell2mat(coefs(i,18));
        if Tk>=cell2mat(coefs(i,16)) && Tk<=cell2mat(coefs(i,17))
            if Tk<=1000
                a1=cell2mat(coefs(i,2));
                a2=cell2mat(coefs(i,3));
                a3=cell2mat(coefs(i,4));
                a4=cell2mat(coefs(i,5));
                a5=cell2mat(coefs(i,6));
                b1=cell2mat(coefs(i,7));
                b2=cell2mat(coefs(i,8));
            elseif Tk>=1000
                a1=cell2mat(coefs(i,9));
                a2=cell2mat(coefs(i,10));
                a3=cell2mat(coefs(i,11));
                a4=cell2mat(coefs(i,12));
                a5=cell2mat(coefs(i,13));
                b1=cell2mat(coefs(i,14));
                b2=cell2mat(coefs(i,15));
            end
        else
            warning('Temperature out of range')
            cp=0;
        end
        cp=(R/M)*(a1+a2*Tk+a3*Tk^2+a4*Tk^3+a5*Tk^4);
    end
    
end
i=0;



end