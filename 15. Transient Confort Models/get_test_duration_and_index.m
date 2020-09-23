function [t_end,sel1] = get_test_duration_and_index(data_v,selection)
%get_test_duration: Finds the test profile with start flowrate == selection and estimates the time duration assuming each transition needs 60s to stabilize


i=0;
for i=1:size(data_v,2)
    if data_v{i}(1)==selection
        sel1=i;
    end
end

t_end=size(data_v{sel1},2)*60;

end

