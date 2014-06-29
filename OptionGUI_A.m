function varargout = OptionGUI_A(varargin)
% OPTIONGUI_A MATLAB code for OptionGUI_A.fig
%      OPTIONGUI_A, by itself, creates a new OPTIONGUI_A or raises the existing
%      singleton*.
%
%      H = OPTIONGUI_A returns the handle to a new OPTIONGUI_A or the handle to
%      the existing singleton*.
%
%      OPTIONGUI_A('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIONGUI_A.M with the given input arguments.
%
%      OPTIONGUI_A('Property','Value',...) creates a new OPTIONGUI_A or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OptionGUI_A_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OptionGUI_A_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OptionGUI_A

% Last Modified by GUIDE v2.5 17-Jun-2013 15:31:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OptionGUI_A_OpeningFcn, ...
                   'gui_OutputFcn',  @OptionGUI_A_OutputFcn, ...
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


% --- Executes just before OptionGUI_A is made visible.
function OptionGUI_A_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

% UIWAIT makes OptionGUI_A wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OptionGUI_A_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
global Option;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton3'
        Option.IgnoreFirstLastFrame = true;
    case 'radiobutton4'
        Option.IgnoreFirstLastFrame = false;
end