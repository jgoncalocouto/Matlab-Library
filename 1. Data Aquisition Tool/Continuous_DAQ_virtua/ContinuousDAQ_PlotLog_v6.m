function varargout = ContinuousDAQ_PlotLog_v6(varargin)
% CONTINUOUSDAQ_PLOTLOG_V6 MATLAB code for ContinuousDAQ_PlotLog_v6.fig
%      CONTINUOUSDAQ_PLOTLOG_V6, by itself, creates a new CONTINUOUSDAQ_PLOTLOG_V6 or raises the existing
%      singleton*.
%
%      H = CONTINUOUSDAQ_PLOTLOG_V6 returns the handle to a new CONTINUOUSDAQ_PLOTLOG_V6 or the handle to
%      the existing singleton*.
%
%      CONTINUOUSDAQ_PLOTLOG_V6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTINUOUSDAQ_PLOTLOG_V6.M with the given input arguments.
%
%      CONTINUOUSDAQ_PLOTLOG_V6('Property','Value',...) creates a new CONTINUOUSDAQ_PLOTLOG_V6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ContinuousDAQ_PlotLog_v6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ContinuousDAQ_PlotLog_v6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ContinuousDAQ_PlotLog_v6

% Last Modified by GUIDE v2.5 15-May-2019 13:55:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ContinuousDAQ_PlotLog_v6_OpeningFcn, ...
                   'gui_OutputFcn',  @ContinuousDAQ_PlotLog_v6_OutputFcn, ...
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


% --- Executes just before ContinuousDAQ_PlotLog_v6 is made visible.
function ContinuousDAQ_PlotLog_v6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ContinuousDAQ_PlotLog_v6 (see VARARGIN)

% Choose default command line output for ContinuousDAQ_PlotLog_v6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Enable START button and disable STOP button, when opening GUI
set(handles.startbutton,'Enable','on')
set(handles.stopbutton,'Enable','off')
% UIWAIT makes ContinuousDAQ_PlotLog_v6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ContinuousDAQ_PlotLog_v6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Enable START button and disable STOP button
set(handles.startbutton,'Enable','off')
set(handles.stopbutton,'Enable','on')
start_daq()

% --- Executes on button press in stopbutton.
function stopbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stopbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.s);
release(handles.s);
set(handles.startbutton,'Enable','on')
set(handles.stopbutton,'Enable','off')
clear Time
clear Data
