function writeSetupScaleXml(expDir,modelOsim,mass,height)
%WRITESETUPSCALEXML Create generic scale setup structure and write to xml file
%   Detailed explanation goes here

%% Setup generic path and files
modDir = [expDir '/model'];
markerSetXml = 'markerSet.xml';
measurementSetXml = 'measurementSet.xml';
tasksScaleXml = 'tasksScale.xml';
timeRange = [0 2];

%% Create structure for ScaleTool objects
Tree.ATTRIBUTE.Version = '40000';

%% ScaleTool
Tree.ScaleTool.ATTRIBUTE.name = 'generic';
Tree.ScaleTool.mass = mass;
Tree.ScaleTool.height = height;

%% ScaleTool -> GenericModelMaker
Tree.ScaleTool.GenericModelMaker.ATTRIBUTE.name = 'generic';
Tree.ScaleTool.GenericModelMaker.model_file = [modDir '/' modelOsim];
Tree.ScaleTool.GenericModelMaker.marker_set_file = ...
    [modDir '/' markerSetXml];

%% ScaleTool -> ModelScaler
Tree.ScaleTool.ModelScaler.ATTRIBUTE.name = 'generic';
Tree.ScaleTool.ModelScaler.scaling_order = 'measurements';
Tree.ScaleTool.ModelScaler.MeasurementSet.ATTRIBUTE.file = ...
    [modDir '/' measurementSetXml];
Tree.ScaleTool.ModelScaler.marker_file = '';
Tree.ScaleTool.ModelScaler.time_range = timeRange;

Tree.ScaleTool.ModelScaler.preserve_mass_distribution = 'true';
Tree.ScaleTool.ModelScaler.output_scale_file = '';

%% ScaleTool -> MarkerPlacer
Tree.ScaleTool.MarkerPlacer.ATTRIBUTE.name = 'generic';
Tree.ScaleTool.MarkerPlacer.IKTaskSet.ATTRIBUTE.file = ...
    [modDir '/' tasksScaleXml];
Tree.ScaleTool.MarkerPlacer.marker_file = '';
Tree.ScaleTool.MarkerPlacer.coordinate_file = '';
Tree.ScaleTool.MarkerPlacer.time_range = timeRange;
Tree.ScaleTool.MarkerPlacer.output_model_file = '';
Tree.ScaleTool.MarkerPlacer.output_motion_file = '';
Tree.ScaleTool.MarkerPlacer.output_marker_file = '';
Tree.ScaleTool.MarkerPlacer.max_marker_movement = -1;

%% Set inputs for xml_write
fileName = [modDir '/setupScale.xml'];
rootName = 'OpenSimDocument';
Pref.StructItem = false;

xml_write(fileName,Tree,rootName,Pref);

save([modDir '/structureScale.mat'],'Tree');

end
