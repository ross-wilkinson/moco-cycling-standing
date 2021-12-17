% -------------------------------------------------------------------------- %
% OpenSim Moco: buildModel_cyclistFullBodyMuscleActuated.m                   %
% -------------------------------------------------------------------------- %
% Copyright (c) Ross Wilkinson                                               %
%                                                                            %
% Author(s): Ross Wilkinson                                                  %
% GitHub: https://github.com/ross-wilkinson/moco-cycling-standing            %
%                                                                            %
% Licensed under the Apache License, Version 2.0 (the "License"); you may    %
% not use this file except in compliance with the License. You may obtain a  %
% copy of the License at http://www.apache.org/licenses/LICENSE-2.0          %
%                                                                            %
% Unless required by applicable law or agreed to in writing, software        %
% distributed under the License is distributed on an "AS IS" BASIS,          %
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   %
% See the License for the specific language governing permissions and        %
% limitations under the License.                                             %
% -------------------------------------------------------------------------- %

%% Initialize script

clear; close all; clc;
%% Set Body Segment Inertial Parameters (BSIPs)

% thigh
thighLength = 0.5;
thighMass = 0.5;
% shank
shankLength = 0.5;
shankMass = 0.5;

%% OpenSim document version

Tree.ATTRIBUTE.Version = '40000';
%% Create model structure

Tree.Model.ATTRIBUTE.name = 'cyclist_fullBodyMuscleActuated';
% references
Tree.Model.credits = '';
Tree.Model.publications = '';
% constants and units
Tree.Model.gravity = [0 -9.80665 0];
Tree.Model.length_units = 'meters';
Tree.Model.force_units = 'N';
% ground body
Tree.Model.Ground.ATTRIBUTE.name = 'ground';
Tree.Model.Ground.FrameGeometry.ATTRIBUTE.name = 'frame_geometry';
Tree.Model.Ground.FrameGeometry.socket_frame = '...';
Tree.Model.Ground.FrameGeometry.scale_factors = [0.2 0.2 0.2];

%% Construct BodySet

Tree.Model.BodySet.ATTRIBUTE.name = 'bodyset';
% thigh
Tree.Model.BodySet.objects.Body(1).ATTRIBUTE.name = 'thigh';
Tree.Model.BodySet.objects.Body(1).FrameGeometry.socket_frame = '...';
Tree.Model.BodySet.objects.Body(1).FrameGeometry.scale_factors = [0.2 0.2 0.2];
Tree.Model.BodySet.objects.Body(1).mass = 0.5;
Tree.Model.BodySet.objects.Body(1).mass_center = [0 0 0];
Tree.Model.BodySet.objects.Body(1).inertia = [1 1 1 0 0 0];
Tree.Model.BodySet.objects.Body(1).attached_geometry.Mesh.mesh_file = 'femur_r.vtp';
% shank
Tree.Model.BodySet.objects.Body(2).ATTRIBUTE.name = 'shank';
Tree.Model.BodySet.objects.Body(2).FrameGeometry.socket_frame = '...';
Tree.Model.BodySet.objects.Body(2).FrameGeometry.scale_factors = [0.2 0.2 0.2];
Tree.Model.BodySet.objects.Body(2).mass = 0.5;
Tree.Model.BodySet.objects.Body(2).mass_center = [0 0 0];
Tree.Model.BodySet.objects.Body(2).inertia = [1 1 1 0 0 0];
Tree.Model.BodySet.objects.Body(2).attached_geometry.Mesh.mesh_file = 'tibia_r.vtp';
%% Construct JointSet
Tree.Model.JointSet.objects.PinJoint(1).ATTRIBUTE.name = 'hip';
Tree.Model.JointSet.objects.PinJoint(1).socket_parent_frame = 'ground_offset';
Tree.Model.JointSet.objects.PinJoint(1).socket_child_frame = 'thigh_offset';
Tree.Model.JointSet.objects.PinJoint(1).coordinates.Coordinate.ATTRIBUTE.name = 'rx';
Tree.Model.JointSet.objects.PinJoint(1).frames.PhysicalOffsetFrame

%% Write .xml file

modDir = '/Users/rosswilkinson/Google Drive/projects/moco-cycling-standing/model';
fileName = [modDir '/cyclist_fullBodyMuscleActuated.xml'];
rootName = 'OpenSimDocument';
Pref.StructItem = false;
% Write to xmlfile
xml_write(fileName,Tree,rootName,Pref);
% Save structure
save([modDir '/cyclist_fullBodyMuscleActuated.mat'],'Tree')
%% Bodies and Joints (BodySet, JointSet)

% Body: Thigh
% -----------
thigh = Body('thigh', thighMass, Vec3(0, -0.17, 0), Inertia(0.1339, 0.0351, 0.1412, 0, 0, 0));
% Add geometry for display
thighGeometry = Mesh('femur_r.vtp');
thigh.attachGeometry(thighGeometry);
% Add Body to the Model
model.addBody(thigh);

% Joint: Hip
% ----------
hip = PinJoint('hip', ... 
    ground, Vec3(0, 1.0, 0), Vec3(0), ... % parent, trans., orien.
    thigh, Vec3(0, thighLength/2, 0), Vec3(0)); % child, trans., orien. 
model.addJoint(hip);

% Body: Shank
% -----------
shank = Body('shank', shankMass, Vec3(0), Inertia(1));
% Add geometry for display
shankGeometry = Mesh('tibia_r.vtp');
shank.attachGeometry(shankGeometry);
% Add Body to the Model
model.addBody(shank);

% Joint: Knee
% -----------
knee = PinJoint('knee', ... 
    thigh, Vec3(0, -thighLength/2, 0), Vec3(0), ... 
    shank, Vec3(0, shankLength/2, 0), Vec3(0)); 
model.addJoint(knee);

%% Muscles (ForceSet)

% Muscle: Vastus
% --------------
vastus = Millard2012EquilibriumMuscle(); 
vastus.setName('vastus'); 
vastus.setMaxIsometricForce(500); 
vastus.setOptimalFiberLength(0.19); 
vastus.setTendonSlackLength(0.19);
% Construct muscle path
origin = Vec3(thighLength/10, 0, 0);
vastus.addNewPathPoint('origin', thigh, origin); 
insertion = Vec3(0.75 * shankLength/10, 0.7 * shankLength/2, 0); 
vastus.addNewPathPoint('insertion', shank, insertion);
% Add muscle to the model
model.addForce(vastus);
%% Wrap Objects (WrapObjects)

% Wrap: Patella
% -------------
patella = WrapCylinder(); 
patella.setName('patella'); 
patella.set_translation(Vec3(0, -thighLength/2, 0)); 
patella.set_radius(0.04); 
patella.set_length(0.1); 
patella.set_quadrant('x'); 
thigh.addWrapObject(patella);
% update muscle wrapping
vastus.updGeometryPath().addPathWrap(patella);
%% Initialize and save model

% Check model
model.initSystem();
% Save model file
cd('/Users/rosswilkinson/Google Drive/projects/moco-cycling-standing/model')
model.print('test.osim')
