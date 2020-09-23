%% Inputs

number_of_evodaqs=3;
number_of_matlabs=1;
test_blocks={'Valve Oscillation = 0';'Valve Oscillation = 5';'Valve Oscillation = 10';'Valve Oscillation = 15';'Valve Oscillation = 20'};

%% Produce n timetables, one for each test block

[tt_data] = data_importer_evoleo_matlab(number_of_evodaqs,number_of_matlabs);

%% 1st Post Processing: Get only statistic data from baselines, ignore the rest

for w=1:size(test_blocks,1)
    tt=tt_data{1,w};
    name=test_blocks{w};
    [tt,T_err,T_avg,T_median,T_std,details] = post_processing_one(tt);
    
    
    
    statistics.T_err=T_err;
    statistics.T_std=T_std;
    statistics.T_avg=T_avg;
    statistics.T_median=T_median;
    statistics.details=details;
    tt_data{1,w}=tt;
    tt_data{2,w}=statistics;

    plots_deadband(tt_data{1,w},tt_data{2,w},test_blocks{w})
end

%% 2nd Post Processing

