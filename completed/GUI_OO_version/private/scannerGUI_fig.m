function handles = scannerGUI_fig
% Build a GUI for the scanner and return the handles to the plot and ui objects
%	
% function handles = scannerGUI_fig
%
%
% Inputs
%  None
%
% Outputs
%  handles - a structure of handles associated with the UI elements in the GUI
%
% Rob Campbell - Basel 2016
%
%
% Also see:
% scannerGUI, scanAndAcquire_OO


handles.hFig = figure;
set(handles.hFig, ...
	'ToolBar', 'none', ...
	'MenuBar', 'none', ...
	'Name', 'scannerGUI',...
    'Resize', 'Off');
handles.hFig.Position(3)=500;
handles.hFig.Position(4)=100;



% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%Scan button
handles.startStopScan = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [16 30  120  55], ...
    'ForeGroundColor','g', ...
    'String', 'START SCAN',...
    'HandleVisibility','Off');


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%Status bar
handles.statusBar = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Style','Text', ...
    'Position', [1 1  500  18], ...
    'BackgroundColor',[1,1,1]*0.75, ...
    'HorizontalAlignment', 'left', ...
    'String', '',...
    'HandleVisibility','Off');


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%Bidi checkbox and phase delay
handles.bidiFrame = uipanel(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [142 30  110  64], ...
    'Title', 'Bidi scan',...
    'HandleVisibility','Off');

handles.bidi = uicontrol(...
    'Parent', handles.bidiFrame, ... %Note: nested within the bidiFrame
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [4 24  100   20], ...
    'Style','CheckBox', ...
    'String', 'Enable Bidi');

%Phase delay for bidi 
handles.bidiPhase = uicontrol(...
    'Parent', handles.bidiFrame, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [4 4 59 20], ...
    'Style','Edit', ...
    'HorizontalAlignment', 'left', ...
    'BackgroundColor',[1,1,1]*0.75, ...
    'String', '',...
    'HandleVisibility','Off');



% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%Save fname
handles.saveFrame = uipanel(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [258 30  240 64], ...
    'Title', 'Save to TIFF',...
    'HandleVisibility','Off');

handles.save = uicontrol(...
    'Parent', handles.saveFrame, ... %Note: nested within the saveFrame
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [4 24  120   20], ...
    'Style','CheckBox', ...
    'String', 'Save',...
    'HandleVisibility','Off');

%file name to save to
handles.saveFname = uicontrol(...
    'Parent', handles.saveFrame, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [4 4, 225 20], ...
    'Style','Edit', ...
	'HorizontalAlignment', 'left', ...
    'BackgroundColor',[1,1,1]*0.75, ...
    'String', '',...
    'HandleVisibility','Off');