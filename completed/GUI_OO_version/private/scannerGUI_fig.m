function handles = scannerGUI_fig
% Build a GUI for the scanner and return the handles to the plot and ui objects
%	
% function handles = scannerGUI_fig
%
% 


handles.hFig = figure;
set(handles.hFig, ...
	'ToolBar', 'none', ...
	'MenuBar', 'none', ...
	'Name', 'scannerGUI');
handles.hFig.Position(4)=150;

%Scan button
handles.startStopScan = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [60 40  120  55], ...
    'ForeGroundColor','g', ...
    'String', 'START SCAN');


%Bidi checkbox and phase delay
handles.bidiFrame = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [200 40  80   55], ...
    'Style','Frame', ...
    'String', 'Bidi');


handles.bidi = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [204 70  60   21], ...
    'Style','CheckBox', ...
    'String', 'Bidi');

%Phase delay for bidi 
handles.bidiPhase = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [204 44 68 20], ...
    'Style','Edit', ...
	'HorizontalAlignment', 'left', ...
    'BackgroundColor',[1,1,1]*0.75, ...
    'String', '');

%Save fname
handles.saveFrame = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [290 40  240   55], ...
    'Style','Frame', ...
    'String', 'Save');

handles.save = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [294 70  60   21], ...
    'Style','CheckBox', ...
    'String', 'Save');

%file name to save to
handles.saveFname = uicontrol(...
    'Parent', handles.hFig, ...
    'Units', 'pixels', ...
    'FontSize', 10, ...
    'FontWeight', 'Bold', ...
    'Position', [294 44 225 20], ...
    'Style','Edit', ...
	'HorizontalAlignment', 'left', ...
    'BackgroundColor',[1,1,1]*0.75, ...
    'String', '');
