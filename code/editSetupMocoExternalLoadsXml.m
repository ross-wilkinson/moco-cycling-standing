function editSetupMocoExternalLoadsXml(datDir,setDir,filename,RFxyz_r,RFxyz_l,HBRFxyz_r,HBRFxyz_l,Pxyz_r,Pxyz_l,HBPxyz_r,HBPxyz_l,startTime,endTime)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Load data file
data = load([datDir '/' filename '.mat']);

% Create time vector based on number of frames and frame rate.
nFrames = data.(filename).Frames;
frameRate = data.(filename).FrameRate;
timeVector = startTime:1/frameRate:endTime;

%% Write external loads file (.mot).
% Concatenate time, force, and position data to be used in external loads file.
dataMot = vertcat(timeVector, RFxyz_r, Pxyz_r, RFxyz_l, Pxyz_l, HBRFxyz_r, HBPxyz_r, HBRFxyz_l, HBPxyz_l);  
k = find(isnan(dataMot));
dataMot(k) = 0;

% Change directory to subject setup folder and open file.
cd(setDir)
fileId = fopen(['BLR_' filename 'externalLoads.mot'],'w');

% Set header names.
headers = {'time ' 'forceCrankRightX ' 'forceCrankRightY ' 'forceCrankRightZ '...
'pointCrankRightX ' 'pointCrankRightY ' 'pointCrankRightZ '...
'forceCrankLeftX ' 'forceCrankLeftY ' 'forceCrankLeftZ '...
'pointCrankLeftX ' 'pointCrankLeftY ' 'pointCrankLeftZ '...
'forceHandlebarRightX ' 'forceHandlebarRightY ' 'forceHandlebarRightZ '...
'pointHandlebarRightX ' 'pointHandlebarRightY ' 'pointHandlebarRightZ '...
'forceHandlebarLeftX ' 'forceHandlebarLeftY ' 'forceHandlebarLeftZ '...
'pointHandlebarLeftX ' 'pointHandlebarLeftY ' 'pointHandlebarLeftZ '};

% Write header information into .mot file.
fprintf(fileId,'External Loads File\n');
fprintf(fileId,'version=1\n');
fprintf(fileId,'nRows=%d\n',size(timeVector,2));
fprintf(fileId,'nColumns=%d\n',length(headers));
fprintf(fileId,'Range=%d-%d seconds\n',timeVector([1 end]));
fprintf(fileId,'endheader\n');
str = sprintf('%s\t', headers{:});
fprintf(fileId,'%s\t\n',str);      

% Write data into file under headers.
fprintf(fileId,...
    '%.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f\n',...
    dataMot);        

% Close .mot file.
fclose(fileId);

%% Edit External Loads setup structure "Tree"
% Load structure of generic IK file
% load([modDir '/structureExternalLoads.mat'],'Tree')

% Set subject specific values in place of generic values within structure.     

% Edit -> name
% Tree.ExternalLoads.ATTRIBUTE.name = filename;        

% Edit -> data file
% Tree.ExternalLoads.datafile = [setDir '/' filename 'externalLoads.mot'];

% Edit -> kinematics file
% Tree.ExternalLoads.external_loads_model_kinematics_file = [resDir '/' filename 'inverseKinematics.mot'] ;

% Edit -> filter
% Tree.ExternalLoads.lowpass_cutoff_frequency_for_load_kinematics = 12;

%% Create and write .xml file
% Set inputs for xml_write 
% fileName = [setDir '/' filename 'setupExternalLoads.xml'];
% rootName = 'OpenSimDocument';
% Pref.StructItem = false;

% Write .xml file.
% xml_write(fileName,Tree,rootName,Pref); 

% Save structure
% save([setDir '/' filename 'structureExternalLoads.mat'],'Tree')

end

