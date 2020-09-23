%Post Process PROCOM+MANOMETER

TableData.Pburner_movmean=movmean(TableData.Pburner,20);


Final_Table=synchronize(TableData,data);

filepath='C:\Users\BTJ1AV\Desktop\Deadband_Test\';
filename='DeadBand_Valve_Current_70mA_test2';
writetable(timetable2table(Final_Table),[filepath,filename,'.xls'])