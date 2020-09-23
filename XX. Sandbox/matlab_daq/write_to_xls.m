%% Define Filename and Filepath
filepath='C:\Users\coo1av\Documents\logs\' %Make sure the folder exists, this will not create it
filename='test6' %Custom name

%Include unique file date in the filename
Z=char(system_time(1));
file_date=strcat(Z(1:2),'.',Z(4:6),'.',Z(8:11),'.',Z(13:15));

%Filename has the following format: "dd.mmm.yyyy.HH.MM.SS.FFF.filename.xls"
%% Write columns' names

titles=cell(ones(1,daq_lines+2))
titles{1}='System Time - dd-mmm-yyyy HH:MM:SS:FFF'
titles{2}='Time - t - [s]'
for j=3:daq_lines+2
    titles{j}=daq_setup{j-2,5}
end
xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),titles)

%1st column = system time
%2nd column = relative time [s]
% i-th column (i=3:N) = measured variable name
%% Write sensor measurement data

xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),C{1,2},'Sheet1','B2') %write relative time vector
xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),cellstr(C{1,1}),'Sheet1','A2') %write system time vector

%write sensor measurement data in each excel column, starting in column C
columns_excel=['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z']
n_excel=floor(daq_lines./26)
i=0;
j=0;
k=0;
w=0;
x=0;
if n_excel==0
    for j=3:daqlines+2
        xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),C{1,j},'Sheet1',strcat(columns_excel(j),'2'))
    end
else
    for k=3:26
        xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),C{1,j},'Sheet1',strcat(columns_excel(j),'2'))
    end
    for k=27:52
        xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),C{1,k},'Sheet1',strcat('A',columns_excel(k-1*26),'2'))
    end
    for w=52:78
        xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),C{1,w},'Sheet1',strcat('B',columns_excel(w-2*26),'2'))
    end
    for x=79:104
        xlswrite(strcat(filepath,file_date,'.',filename,'.xls'),C{1,x},'Sheet1',strcat('C',columns_excel(x-3*26),'2'))
    end
end

%Writing limited to 102 sensors by laziness
    






