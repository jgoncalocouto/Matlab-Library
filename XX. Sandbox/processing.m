[tt_procom] = procom_importer('14');

tt_daq=table_importer();
tt_daq2=table_importer();
tt_daq=[tt_daq;tt_daq2];
tt=synchronize(table2timetable(tt_daq),tt_procom);
tt=fillmissing(tt,'nearest');

	