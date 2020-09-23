function saveandplot(src,event,hObject,eventdata)
handles = guidata(hObject);
aux=zeros(handles.dat_avai,size(handles.daq_setup,1));
for i=1:size(handles.daq_setup,1)
    if string(handles.daq_setup{i,7})=='Linear'
        aux(:,i)=(event.Data(:,i)*handles.daq_setup{i,10}+handles.daq_setup{i,11})*handles.daq_setup{i,8}+handles.daq_setup{i,9};
    elseif string(handles.daq_setup{i,7})=='Table'
        aux(:,i)= interp1(handles.daq_setup{i,8},handles.daq_setup{i,9},event.Data(:,i),'linear','extrap');
    end
end
handles.Time(handles.counter:handles.counter+handles.dat_avai-1) = event.TimeStamps;
handles.Data(handles.counter:handles.counter+handles.dat_avai-1,:) = aux;
refreshdata(handles.axes1,'caller')
handles.counter=handles.counter+handles.dat_avai;
guidata(hObject, handles);