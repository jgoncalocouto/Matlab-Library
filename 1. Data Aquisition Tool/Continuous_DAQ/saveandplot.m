function saveandplot(src,event,hObject,eventdata)
handles = guidata(hObject);
aux=zeros(handles.dat_avai,size(handles.daq_setup,1));
for i=1:size(handles.daq_setup,1)
    aux(:,i)=(event.Data(:,i)*handles.daq_setup{i,9}+handles.daq_setup{i,10})*handles.daq_setup{i,7}+handles.daq_setup{i,8};
end

% Input here "for cycle" for virtual channels and add it to the end of the
% data vector

handles.Time(handles.counter:handles.counter+handles.dat_avai-1) = event.TimeStamps;
handles.Data(handles.counter:handles.counter+handles.dat_avai-1,:) = aux;
refreshdata(handles.axes1,'caller')
handles.counter=handles.counter+handles.dat_avai;
guidata(hObject, handles);