function writeSetupInverseKinematicsXml(modDir)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Create structure for InverseKinematicsTool objects
Tree.ATTRIBUTE.Version = '40000';

% InverseKinematicsTool
Tree.InverseKinematicsTool.ATTRIBUTE.name = 'generic';

% Directories
Tree.InverseKinematicsTool.results_directory = '';
Tree.InverseKinematicsTool.input_directory = '';

% Model file
Tree.InverseKinematicsTool.model_file = '';

% Solver parameters
Tree.InverseKinematicsTool.constraint_weight = 'infinity';
Tree.InverseKinematicsTool.accuracy = 0.00001;

% IKTaskSet file
Tree.InverseKinematicsTool.IKTaskSet.ATTRIBUTE.file = ...
    [modDir '/tasksInverseKinematics.xml'];

% Marker File
Tree.InverseKinematicsTool.marker_file = '';

% Coordinate file
Tree.InverseKinematicsTool.coordinate_file = '';

% Time range
Tree.InverseKinematicsTool.time_range = [0 0];

% Error reporting
Tree.InverseKinematicsTool.report_errors = 'true';

% Output file
Tree.InverseKinematicsTool.output_motion_file = '';

% Report marker locations
Tree.InverseKinematicsTool.report_marker_locations = 'true';

% Set inputs for xml_write
fileName = [modDir '/setupInverseKinematics.xml'];
rootName = 'OpenSimDocument';
Pref.StructItem = false;

xml_write(fileName,Tree,rootName,Pref);

save([modDir '/structureInverseKinematics.mat'],'Tree')

end

