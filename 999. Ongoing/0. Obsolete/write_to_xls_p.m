    %% Define Filename and Filepath
filepath='S:\TTM-Projects\9305 Compact4 KME\10_testing\A_laboratory\65 - SW testing - Pressure Sensor\7. Iteration 08\' %Make sure the folder exists, this will not create it
Z=datestr(now,'dd/mm/yyyy  HH:MM:SS:FFF') %Date will be, current date, not file date.
filename='record_13_03_2019_1622_daq' %Custom name

%Include unique file date in the filename
Z=char(Z);
file_date=strcat(Z(1:2),'.',Z(4:5),'.',Z(7:11),'.',Z(13:14),'.',Z(16:17),'.',Z(19:20),'.',Z(22:24));

%Filename has the following format: "dd.mmm.yyyy.HH.MM.SS.FFF.filename.xls"
%% Write columns' names

titles=cell(ones(1,n3));
j=0;
for j=1:n3
    titles{j}=Aux_Aggregate{j};
end
xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),titles)

% Each collumn has the fieldname of the Aggregate struct
%% Write sensor measurement data

xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),C1{1,2},'Sheet1','B2') %write relative time vector
xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),C1{1,1},'Sheet1','A2') %write system time vector

%write sensor measurement data in each excel column, starting in column C
columns_excel=['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z']
n_excel=floor(n3./26)
i=0;
j=0;
k=0;
w=0;
x=0;
if n_excel==0
    for j=3:n3
        xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),C1{1,j},'Sheet1',strcat(columns_excel(j),'2'))
    end
else
    for k=3:26
        xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),C1{1,j},'Sheet1',strcat(columns_excel(j),'2'))
    end
    for k=27:52
        xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),C1{1,k},'Sheet1',strcat('A',columns_excel(k-1*26),'2'))
    end
    for w=52:78
        xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),C1{1,w},'Sheet1',strcat('B',columns_excel(w-2*26),'2'))
    end
    for x=79:104
        xlswrite(strcat(filepath,file_date,'_',filename,'.xls'),C1{1,x},'Sheet1',strcat('C',columns_excel(x-3*26),'2'))
    end
end

%Writing limited to 102 sensors by laziness
    






