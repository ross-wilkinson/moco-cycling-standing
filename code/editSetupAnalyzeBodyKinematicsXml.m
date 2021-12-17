function editSetupAnalyzeBodyKinematicsXml(modDir,resDir,setDir,name,filename,startTime,endTime)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

% Load structure of generic Analyze file
load([modDir '/structureAnalyze.mat'],'Tree')

% model file
Tree.AnalyzeTool.model_file = [resDir '/' name 'modelScaled.osim'];

% results directory
Tree.AnalyzeTool.results_directory = resDir;

% turn on Body Kinematics
Tree.AnalyzeTool.AnalysisSet.objects.BodyKinematics.on = 'true';

% Set coordinates to report
Tree.AnalyzeTool.AnalysisSet.objects.BodyKinematics.bodies = 'center_of_mass';

% external loads file (.xml)
Tree.AnalyzeTool.external_loads_file = [];

% states file
Tree.AnalyzeTool.states_file = [];

% speeds file
Tree.AnalyzeTool.speeds_file = [];

% filter
Tree.AnalyzeTool.lowpass_cutoff_frequency_for_coordinates = '-1';

% intial time
Tree.AnalyzeTool.initial_time = startTime; 

% end time
Tree.AnalyzeTool.final_time = endTime;   

% name
Tree.AnalyzeTool.ATTRIBUTE.name = filename;  

% start time
Tree.AnalyzeTool.AnalysisSet.objects.BodyKinematics.start_time = startTime; 

% end time
Tree.AnalyzeTool.AnalysisSet.objects.BodyKinematics.end_time = endTime;  

% set coordinate file
Tree.AnalyzeTool.coordinates_file = [resDir '/' filename 'inverseKinematics.mot']; 

% Set inputs for xml_write
rootName = 'OpenSimDocument';
Pref.StructItem = false;

% Write .xml file
cd(setDir)
xml_write([filename 'setupAnalyzeBodyKinematics.xml'],Tree,rootName,Pref);

% Save structure
save([filename 'structureAnalyzeBodyKinematics.mat'],'Tree');

end

