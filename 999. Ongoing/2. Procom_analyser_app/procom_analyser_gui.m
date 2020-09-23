function varargout = procom_analyser_gui(varargin)
% PROCOM_ANALYSER_GUI MATLAB code for procom_analyser_gui.fig
%      PROCOM_ANALYSER_GUI, by itself, creates a new PROCOM_ANALYSER_GUI or raises the existing
%      singleton*.
%
%      H = PROCOM_ANALYSER_GUI returns the handle to a new PROCOM_ANALYSER_GUI or the handle to
%      the existing singleton*.
%
%      PROCOM_ANALYSER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROCOM_ANALYSER_GUI.M with the given input arguments.
%
%      PROCOM_ANALYSER_GUI('Property','Value',...) creates a new PROCOM_ANALYSER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before procom_analyser_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to procom_analyser_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help procom_analyser_gui

% Last Modified by GUIDE v2.5 11-Jun-2019 10:49:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @procom_analyser_gui_OpeningFcn, ...
    'gui_OutputFcn',  @procom_analyser_gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before procom_analyser_gui is made visible.
function procom_analyser_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to procom_analyser_gui (see VARARGIN)

% Choose default command line output for procom_analyser_gui
handles.output = hObject;

% Define lists for pop-up menus
handles.List_gastype=[
    string('NG')
    string('LPG')
    ];

handles.List_testgas=[
    string('G20')
    string('G30')
    string('G31')
    ];

handles.List_capacity=[
    string('11')
    string('14')
    string('17')
    ];

handles.List_injectormarking=[
    string('62')
    string('65')
    string('100')
    string('105')
    ];

set(handles.pum_gastype,'String',handles.List_gastype);
set(handles.pum_capacity,'String',handles.List_capacity);
set(handles.pum_testgas,'String',handles.List_testgas);
set(handles.pum_injector_marking,'String',handles.List_injectormarking);


% Define default values for inputs
handles.Gastype_parameter=string('NG');
handles.Appliance_capacity_parameter=string('11');


handles.test_gas=string('G20');
handles.injector_marking=string('100');

handles.idx_gastype = find(strcmp(handles.Gastype_parameter, handles.List_gastype));
handles.idx_capacity = find(strcmp(handles.Appliance_capacity_parameter, handles.List_capacity));
handles.idx_testgas = find(strcmp(handles.test_gas, handles.List_testgas));
handles.idx_injectormarking=find(strcmp(handles.injector_marking, handles.List_injectormarking));

handles.h=0;
handles.duct_length=0.5;
handles.N_elbows=0;
handles.P_burner_P1=15;
handles.P_burner_P2=2.5;
handles.T_air=15;
handles.T_gas=15;
handles.P_inlet=20;



% Set values in input boxes

set(handles.pum_gastype,'Value',handles.idx_gastype);
set(handles.pum_capacity,'Value',handles.idx_capacity);
set(handles.pum_testgas,'Value',handles.idx_testgas);
set(handles.pum_injector_marking,'Value',handles.idx_injectormarking);

set(handles.e_altitude,'String',string(handles.h));
set(handles.e_ductlength,'String',string(handles.duct_length));
set(handles.e_nelbows,'String',string(handles.N_elbows));
set(handles.e_p1,'String',string(handles.P_burner_P1));
set(handles.e_p2,'String',string(handles.P_burner_P2));
set(handles.e_tair,'String',string(handles.T_air));
set(handles.e_tgas,'String',string(handles.T_gas));
set(handles.e_pinlet,'String',string(handles.P_inlet));



set(handles.display_export_path,'String','<path>')
set(handles.pb_imp,'Enable','on')
set(handles.pb_export,'Enable','off')
set(handles.pb_graphs,'Enable','off')
set(handles.pb_run,'Enable','off')
set(handles.pb_savetoworkspace,'Enable','off')
set(handles.pb_plotselection,'Enable','off')
set(handles.label_analysis_status,'String','Analysis Status: ...')
% Update handles structure
guidata(hObject, handles);







% UIWAIT makes procom_analyser_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = procom_analyser_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_imp.
function pb_imp_Callback(hObject, eventdata, handles)
% hObject    handle to pb_imp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_imp,'Enable','on')
set(handles.pb_export,'Enable','off')
set(handles.pb_graphs,'Enable','off')
set(handles.pb_run,'Enable','off')
set(handles.pb_savetoworkspace,'Enable','off')
set(handles.pb_plotselection,'Enable','off')
set(handles.label_analysis_status,'String','Analysis Status: ...')
set(handles.display_export_path,'String','<path>')
% Update handles structure
guidata(hObject, handles);




[handles.open_name1, handles.open_path1] = uigetfile({'*.xls;*.xlsx;*.xlsm;*.csv',...
    'Excel files (*.xls, *.xlsx, *.xlsm, *.csv)'});
handles.filename1 = strcat(handles.open_path1,handles.open_name1);
set(handles.tb_filepath,'String',handles.filename1)

set(handles.pb_run,'Enable','on')
guidata(hObject, handles);







% --- Executes on selection change in pum_gastype.
function pum_gastype_Callback(hObject, eventdata, handles)
% hObject    handle to pum_gastype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx_gt = get(handles.pum_gastype,'Value');
items_gt = get(handles.pum_gastype,'String');
selectedItem_gt = items_gt{idx_gt};
handles.Gastype_parameter=selectedItem_gt;



if strcmp(handles.Gastype_parameter,'NG')
    
    handles.P_burner_P1=15;
    handles.P_burner_P2=2.5;
    handles.P_inlet=20;
    
    set(handles.e_p1,'String',string(handles.P_burner_P1));
    set(handles.e_p2,'String',string(handles.P_burner_P2));
    set(handles.e_pinlet,'String',string(handles.P_inlet));
    
    
    handles.test_gas=string('G20');
    handles.injector_marking=string('100');
    
    handles.idx_testgas = find(strcmp(handles.test_gas, handles.List_testgas));
    handles.idx_injectormarking=find(strcmp(handles.injector_marking, handles.List_injectormarking));
    
    
    set(handles.pum_testgas,'Value',handles.idx_testgas);
    set(handles.pum_injector_marking,'Value',handles.idx_injectormarking);
    
elseif strcmp(handles.Gastype_parameter,'LPG')
    
    handles.P_burner_P1=28;
    handles.P_burner_P2=4.5;
    handles.P_inlet=37;
    
    set(handles.e_p1,'String',string(handles.P_burner_P1));
    set(handles.e_p2,'String',string(handles.P_burner_P2));
    set(handles.e_pinlet,'String',string(handles.P_inlet));
    
    
    handles.test_gas=string('G31');
    handles.injector_marking=string('62');
    
    handles.idx_testgas = find(strcmp(handles.test_gas, handles.List_testgas));
    handles.idx_injectormarking=find(strcmp(handles.injector_marking, handles.List_injectormarking));
    
    
    set(handles.pum_testgas,'Value',handles.idx_testgas);
    set(handles.pum_injector_marking,'Value',handles.idx_injectormarking);
    
    
end


guidata(hObject, handles);






% Hints: contents = cellstr(get(hObject,'String')) returns pum_gastype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pum_gastype


% --- Executes during object creation, after setting all properties.
function pum_gastype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pum_gastype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pum_capacity.
function pum_capacity_Callback(hObject, eventdata, handles)
% hObject    handle to pum_capacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx = get(handles.pum_capacity,'Value');
items = get(handles.pum_capacity,'String');
selectedItem = items{idx};

handles.Appliance_capacity_parameter=selectedItem;

guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns pum_capacity contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pum_capacity


% --- Executes during object creation, after setting all properties.
function pum_capacity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pum_capacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_savetoworkspace.
function pb_savetoworkspace_Callback(hObject, eventdata, handles)
% hObject    handle to pb_savetoworkspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Aggregate=handles.Aggregate;
assignin('base', 'Aggregate', Aggregate);
guidata(hObject, handles);



% --- Executes on button press in pb_graphs.
function pb_graphs_Callback(hObject, eventdata, handles)
% hObject    handle to pb_graphs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%% Graphs


%Plot1: Air Flow / Qn /I_{GV} /I_{ion}
%Flow Rate Control

Aggregate=handles.Aggregate;

procom_analyser_plot1
procom_analyser_plot2
procom_analyser_plot3
procom_analyser_plot4
procom_analyser_plot5
procom_analyser_plot6





% --- Executes on button press in pb_run.
function pb_run_Callback(hObject, eventdata, handles)
% hObject    handle to pb_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Inputs:

set(handles.label_analysis_status,'String','Analysis Status: Running...')
guidata(hObject, handles);


Gastype_parameter=handles.Gastype_parameter;
capacity=handles.Appliance_capacity_parameter;
filename1=handles.filename1;
open_path1=handles.open_path1;
open_name1=handles.open_name1;

Gastype=handles.test_gas;
T_air=str2double(handles.T_air);
T_gas=str2double(handles.T_gas);
h=str2double(handles.h);
L_duct=str2double(handles.duct_length);
N_elbows=str2double(handles.N_elbows);
Injector_marking=str2double(handles.injector_marking);
Max_tuning=str2double(handles.P_burner_P1);
Min_tuning=str2double(handles.P_burner_P2);
P_in=str2double(handles.P_inlet);


procom_analyser_run_script;


handles.Aggregate=Aggregate;
set(handles.pb_graphs,'Enable','on')
set(handles.pb_plotselection,'Enable','on')
set(handles.pb_savetoworkspace,'Enable','on')
set(handles.pb_export,'Enable','on')

set(handles.label_analysis_status,'String','Analysis Status: Completed!')
guidata(hObject, handles);




% --- Executes on button press in pb_export.
function pb_export_Callback(hObject, eventdata, handles)
% hObject    handle to pb_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileNameBodeWrite, PathNameBodeWrite] = uiputfile({'*.xls';'*.csv'},'Save As...',['Procom_analysis' '.xls']);
if FileNameBodeWrite ~=0
    if exist([PathNameBodeWrite FileNameBodeWrite],'file')
        delete([PathNameLachWrite FileNameBodeWrite ]);
    end
    writetable(timetable2table(handles.Aggregate),[PathNameBodeWrite FileNameBodeWrite ])  %table
    
    set(handles.display_export_path,'String',horzcat(PathNameBodeWrite,FileNameBodeWrite))
    
    
    guidata(hObject, handles);
    
    
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over display_GT.
function display_GT_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to display_GT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rb_p1.
function rb_p1_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% Hint: get(hObject,'Value') returns toggle state of rb_p1


% --- Executes on button press in rb_p2.
function rb_p2_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p2


% --- Executes on button press in rb_p3.
function rb_p3_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p3


% --- Executes on button press in rb_p4.
function rb_p4_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p4


% --- Executes on button press in rb_p5.
function rb_p5_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p5


% --- Executes on button press in rb_p6.
function rb_p6_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p6


% --- Executes on button press in rb_p6.
function rb_p7_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p6


% --- Executes on button press in rb_p8.
function rb_p8_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p8


% --- Executes on button press in rb_p9.
function rb_p9_Callback(hObject, eventdata, handles)
% hObject    handle to rb_p9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_p9


% --- Executes on button press in pb_plotselection.
function pb_plotselection_Callback(hObject, eventdata, handles)
% hObject    handle to pb_plotselection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Aggregate=handles.Aggregate;

if handles.rb_p1.Value==1
    procom_analyser_plot1
end

if handles.rb_p2.Value==1
    procom_analyser_plot2
end

if handles.rb_p3.Value==1
    procom_analyser_plot3
end

if handles.rb_p4.Value==1
    procom_analyser_plot4
end

if handles.rb_p5.Value==1
    procom_analyser_plot5
end

if handles.rb_p6.Value==1
    procom_analyser_plot6
end

guidata(hObject, handles);




% Hint: get(hObject,'Value') returns toggle state of pb_plotselection



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_altitude_Callback(hObject, eventdata, handles)
% hObject    handle to e_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.h=str2double(get(handles.e_altitude,'String'));
guidata(hObject, handles);





% Hints: get(hObject,'String') returns contents of e_altitude as text
%        str2double(get(hObject,'String')) returns contents of e_altitude as a double


% --- Executes during object creation, after setting all properties.
function e_altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_ductlength_Callback(hObject, eventdata, handles)
% hObject    handle to e_ductlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.duct_length=str2double(get(handles.e_ductlength,'String'));
guidata(hObject, handles);





% Hints: get(hObject,'String') returns contents of e_ductlength as text
%        str2double(get(hObject,'String')) returns contents of e_ductlength as a double


% --- Executes during object creation, after setting all properties.
function e_ductlength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_ductlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_nelbows_Callback(hObject, eventdata, handles)
% hObject    handle to e_nelbows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.N_elbows=str2double(get(handles.e_nelbows,'String'));
guidata(hObject, handles);




% Hints: get(hObject,'String') returns contents of e_nelbows as text
%        str2double(get(hObject,'String')) returns contents of e_nelbows as a double


% --- Executes during object creation, after setting all properties.
function e_nelbows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_nelbows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_p2_Callback(hObject, eventdata, handles)
% hObject    handle to e_p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.P_burner_P2=str2double(get(handles.e_p2,'String'));
guidata(hObject, handles);



% Hints: get(hObject,'String') returns contents of e_p2 as text
%        str2double(get(hObject,'String')) returns contents of e_p2 as a double


% --- Executes during object creation, after setting all properties.
function e_p2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_p1_Callback(hObject, eventdata, handles)
% hObject    handle to e_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.P_burner_P1=str2double(get(handles.e_p1,'String'));
guidata(hObject, handles);


% Hints: get(hObject,'String') returns contents of e_p1 as text
%        str2double(get(hObject,'String')) returns contents of e_p1 as a double


% --- Executes during object creation, after setting all properties.
function e_p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_tair_Callback(hObject, eventdata, handles)
% hObject    handle to e_tair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.T_air=str2double(get(handles.e_tair,'String'));
guidata(hObject, handles);



% Hints: get(hObject,'String') returns contents of e_tair as text
%        str2double(get(hObject,'String')) returns contents of e_tair as a double


% --- Executes during object creation, after setting all properties.
function e_tair_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_tair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_tgas_Callback(hObject, eventdata, handles)
% hObject    handle to e_tgas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.T_gas=str2double(get(handles.e_tgas,'String'));
guidata(hObject, handles);



% Hints: get(hObject,'String') returns contents of e_tgas as text
%        str2double(get(hObject,'String')) returns contents of e_tgas as a double


% --- Executes during object creation, after setting all properties.
function e_tgas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_tgas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_pinlet_Callback(hObject, eventdata, handles)
% hObject    handle to e_pinlet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.P_inlet=str2double(get(handles.e_pinlet,'String'));
guidata(hObject, handles);


% Hints: get(hObject,'String') returns contents of e_pinlet as text
%        str2double(get(hObject,'String')) returns contents of e_pinlet as a double


% --- Executes during object creation, after setting all properties.
function e_pinlet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_pinlet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pum_testgas.
function pum_testgas_Callback(hObject, eventdata, handles)
% hObject    handle to pum_testgas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx_testgas = get(handles.pum_testgas,'Value');
items_testgas = get(handles.pum_testgas,'String');
selectedItem_testgas = items_testgas{idx_testgas};
handles.test_gas=selectedItem_gt;

guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns pum_testgas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pum_testgas


% --- Executes during object creation, after setting all properties.
function pum_testgas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pum_testgas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pum_injector_marking.
function pum_injector_marking_Callback(hObject, eventdata, handles)
% hObject    handle to pum_injector_marking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx_injector = get(handles.pum_injector_marking,'Value');
items_injector = get(handles.pum_injector_marking,'String');
selectedItem_injector = items_injector{idx_injector};
handles.injector_marking=selectedItem_injector;

guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns pum_injector_marking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pum_injector_marking


% --- Executes during object creation, after setting all properties.
function pum_injector_marking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pum_injector_marking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
