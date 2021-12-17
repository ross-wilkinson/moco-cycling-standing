function editSetupInverseKinematicsXml(datDir,modDir,resDir,setDir,name,filename,startTime,endTime)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Load structure of generic IK file
load([modDir '/structureInverseKinematics.mat'],'Tree')
    
% Edit -> name
Tree.InverseKinematicsTool.ATTRIBUTE.name = filename;        

% Edit -> results directory
Tree.InverseKinematicsTool.results_directory = resDir;  

% Edit -> model file
Tree.InverseKinematicsTool.model_file = [resDir '/' name 'modelScaled.osim'];      

% Edit -> marker file
Tree.InverseKinematicsTool.marker_file = [datDir '/' filename '.trc'];

% Edit -> output file
Tree.InverseKinematicsTool.output_motion_file = ...
    [resDir '/' filename 'inverseKinematics.mot'];

% Edit -> time range
Tree.InverseKinematicsTool.time_range = [startTime endTime];

% Set inputs for xml_write 
rootName = 'OpenSimDocument';
Pref.StructItem = false;     

% Write .xml file.
cd(setDir)
xml_write([filename 'setupInverseKinematics.xml'],Tree,rootName,Pref);      

% Save structure
save([filename 'structureInverseKinematics.mat'],'Tree')

end

