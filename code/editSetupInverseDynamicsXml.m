function editSetupInverseDynamicsXml(modDir,resDir,setDir,name,filename,startTime,endTime)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% Load structure of generic IK file
load([modDir '/structureInverseDynamics.mat'],'Tree')

% Edit -> name
Tree.InverseDynamicsTool.ATTRIBUTE.name = filename;

% Edit -> results directory
Tree.InverseDynamicsTool.results_directory = resDir;

% Edit -> model file
Tree.InverseDynamicsTool.model_file = [resDir '/' name 'modelScaled.osim'];

% Edit -> time range
Tree.InverseDynamicsTool.time_range = [startTime endTime];
 
% Edit -> external loads file
Tree.InverseDynamicsTool.external_loads_file = ...
            [setDir '/' filename 'setupExternalLoads.xml'];
 
% Edit -> motion file
Tree.InverseDynamicsTool.coordinates_file = ...
            [resDir '/' filename 'inverseKinematics.mot'];
 
% Edit -> output file
Tree.InverseDynamicsTool.output_gen_force_file = [filename 'inverseDynamics.sto'];

% Set inputs for xml_write
rootName = 'OpenSimDocument';
Pref.StructItem = false;
 
% Write .xml file.
cd(setDir)
xml_write([filename 'setupInverseDynamics.xml'],Tree,rootName,Pref);

% Save structure
save([filename 'structureInverseDynamics.mat'],'Tree')
     
end

