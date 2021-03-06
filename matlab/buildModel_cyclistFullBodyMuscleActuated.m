%% OpenSim Moco: buildModel_cyclistFullBodyMuscleActuated.m

% Copyright (c) Ross Wilkinson

% Author(s): Ross Wilkinson 
% GitHub: https://github.com/ross-wilkinson/moco-cycling-standing

% Licensed under the Apache License, Version 2.0 (the "License"); you may
% not use this file except in compliance with the License. You may obtain a
% copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
% License for the specific language governing permissions and limitations
% under the License.

%% Initialize script

clear; close all; clc;
%% Import OpenSim Libraries into Matlab

import org.opensim.modeling.*
%% Initialize an (empty) OpenSim Model

model = Model();
model.setName('cyclistFullBodyMuscleActuated');
%% Get a reference to the ground object

ground = model.getGround();
%% Set Body Segment Inertial Parameters (BSIPs)

mass = 80; % kg

headMass = 0.1 * mass; 
thoracicMass = 0.016 * mass;
lumbarMass = 0.012 * mass;
pelvisMass = 0.08 * mass;
ribMass = 1e-4 * mass;
abdomenMass = 1e-4 * mass;
sternumMass = 1e-4 * mass;
clavicleMass = 1e-4 * mass;
scapulaMass = 1e-4 * mass;
upperArmMass = 0.05 * mass;
forearmMass = 0.03 * mass;
handMass = 0.01 * mass;
thighMass = 0.1 * mass;
shankMass = 0.1 * mass;
patellaMass = 1e-4 * mass;
talusMass = 0.01 * mass;
calcaneusMass = 0.02 * mass;
toesMass = 0.01 * mass;

%% BODIES AND JOINTS (BodySet, JointSet)

% Body: Head and Neck
head = Body('head', headMass, Vec3(0), Inertia(1));
head.attachGeometry(Mesh('skull.vtp'));
head.attachGeometry(Mesh('jaw.vtp'));
head.attachGeometry(Mesh('cerv1.vtp'));
head.attachGeometry(Mesh('cerv2.vtp'));
head.attachGeometry(Mesh('cerv3.vtp'));
head.attachGeometry(Mesh('cerv4.vtp'));
head.attachGeometry(Mesh('cerv5.vtp'));
head.attachGeometry(Mesh('cerv6.vtp'));
head.attachGeometry(Mesh('cerv7.vtp'));
model.addBody(head);

% Joint: Ground To Head
groundToHead = FreeJoint('groundToHead', ... 
    ground, Vec3(0), Vec3(0), ... % parent, trans., orien.
    head, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(groundToHead);

% Body: T1
T1 = Body('T1', thoracicMass, Vec3(0), Inertia(1));
T1.attachGeometry(Mesh('thoracic1.vtp'));
model.addBody(T1);

% Joint: C7 To T1
C7T1 = WeldJoint('C7T1', ... 
    head, Vec3(-0.0216, -0.1179, 0), Vec3(0), ... % parent, trans., orien.
    T1, Vec3(-0.00684, 0.020271, 0), Vec3(0, 0, 0.5236)); % child, trans., orien. 
model.addJoint(C7T1);

% Body: T2
T2 = Body('T2', thoracicMass, Vec3(0), Inertia(1));
T2.attachGeometry(Mesh('thoracic2.vtp'));
model.addBody(T2);

% Joint: T1 To T2
T1T2 = BallJoint('T1T2', ... 
    T1, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T2, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T1T2); 

% Body: T3
T3 = Body('T3', thoracicMass, Vec3(0), Inertia(1));
T3.attachGeometry(Mesh('thoracic3.vtp'));
model.addBody(T3);

% Joint: T2 To T3
T2T3 = BallJoint('T2T3', ... 
    T2, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T3, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T2T3); 

% Body: T4
T4 = Body('T4', thoracicMass, Vec3(0), Inertia(1));
T4.attachGeometry(Mesh('thoracic4.vtp'));
model.addBody(T4);

% Joint: T3 To T4
T3T4 = BallJoint('T3T4', ... 
    T3, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T4, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T3T4);

% Body: T5
T5 = Body('T5', thoracicMass, Vec3(0), Inertia(1));
T5.attachGeometry(Mesh('thoracic5.vtp'));
model.addBody(T5);

% Joint: T4 To T5
T4T5 = BallJoint('T4T5', ... 
    T4, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T5, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T4T5);

% Body: T6
T6 = Body('T6', thoracicMass, Vec3(0), Inertia(1));
T6.attachGeometry(Mesh('thoracic6.vtp'));
model.addBody(T6);

% Joint: T5 To T6
T5T6 = BallJoint('T5T6', ... 
    T5, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T6, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T5T6);

% Body: T7
T7 = Body('T7', thoracicMass, Vec3(0), Inertia(1));
T7.attachGeometry(Mesh('thoracic7.vtp'));
model.addBody(T7);

% Joint: T6 To T7
T6T7 = BallJoint('T6T7', ... 
    T6, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T7, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T6T7);

% Body: T8
T8 = Body('T8', thoracicMass, Vec3(0), Inertia(1));
T8.attachGeometry(Mesh('thoracic8.vtp'));
model.addBody(T8);

% Joint: T7 To T8
T7T8 = BallJoint('T7T8', ... 
    T7, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T8, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T7T8);

% Body: T9
T9 = Body('T9', thoracicMass, Vec3(0), Inertia(1));
T9.attachGeometry(Mesh('thoracic9.vtp'));
model.addBody(T9);

% Joint: T8 To T9
T8T9 = BallJoint('T8T9', ... 
    T8, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T9, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T8T9);

% Body: T10
T10 = Body('T10', thoracicMass, Vec3(0), Inertia(1));
T10.attachGeometry(Mesh('thoracic10.vtp'));
model.addBody(T10);

% Joint: T9 To T10
T9T10 = BallJoint('T9T10', ... 
    T9, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T10, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T9T10);

% Body: T11
T11 = Body('T11', thoracicMass, Vec3(0), Inertia(1));
T11.attachGeometry(Mesh('thoracic11.vtp'));
model.addBody(T11);

% Joint: T10 To T11
T10T11 = BallJoint('T10T11', ... 
    T10, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T11, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T10T11);

% Body: T12
T12 = Body('T12', thoracicMass, Vec3(0), Inertia(1));
T12.attachGeometry(Mesh('thoracic12.vtp'));
model.addBody(T12);

% Joint: T11 To T12
T11T12 = BallJoint('T11T12', ... 
    T11, Vec3(0), Vec3(0), ... % parent, trans., orien.
    T12, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T11T12);

% Body: L1
L1 = Body('L1', lumbarMass, Vec3(0), Inertia(1));
L1.attachGeometry(Mesh('lumbar1.vtp'));
model.addBody(L1);

% Joint: T12 To L1
T12L1 = BallJoint('T12L1', ... 
    T12, Vec3(0), Vec3(0), ... % parent, trans., orien.
    L1, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T12L1);

% Body: L2
L2 = Body('L2', lumbarMass, Vec3(0), Inertia(1));
L2.attachGeometry(Mesh('lumbar2.vtp'));
model.addBody(L2);

% Joint: L1 To l2
L1L2 = BallJoint('L1L2', ... 
    L1, Vec3(0), Vec3(0), ... % parent, trans., orien.
    L2, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(L1L2);

% Body: L3
L3 = Body('L3', lumbarMass, Vec3(0), Inertia(1));
L3.attachGeometry(Mesh('lumbar3.vtp'));
model.addBody(L3);

% Joint: L2 To L3
L2L3 = BallJoint('L2L3', ... 
    L2, Vec3(0), Vec3(0), ... % parent, trans., orien.
    L3, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(L2L3);

% Body: L4
L4 = Body('L4', lumbarMass, Vec3(0), Inertia(1));
L4.attachGeometry(Mesh('lumbar4.vtp'));
model.addBody(L4);

% Joint: L3 To L4
L3L4 = BallJoint('L3L4', ... 
    L3, Vec3(0), Vec3(0), ... % parent, trans., orien.
    L4, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(L3L4);

% Body: L5
L5 = Body('L5', lumbarMass, Vec3(0), Inertia(1));
L5.attachGeometry(Mesh('lumbar5.vtp'));
model.addBody(L5);

% Joint: L4 To L5
L4L5 = BallJoint('L4L5', ... 
    L4, Vec3(0), Vec3(0), ... % parent, trans., orien.
    L5, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(L4L5);

% Body: Pelvis
pelvis = Body('pelvis', pelvisMass, Vec3(0), Inertia(1));
pelvis.attachGeometry(Mesh('r_pelvis.vtp'));
pelvis.attachGeometry(Mesh('l_pelvis.vtp'));
pelvis.attachGeometry(Mesh('sacrum.vtp'));
model.addBody(pelvis);

% Joint: L5 To S1
L5S1 = BallJoint('L5S1', ... 
    L5, Vec3(0), Vec3(0), ... % parent, trans., orien.
    pelvis, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(L5S1);

%% Ribs Right

% Body: R1R
R1R = Body('R1R', ribMass, Vec3(0), Inertia(1));
R1R.attachGeometry(Mesh('Rib1R.vtp'));
model.addBody(R1R);

% Joint: T1 To R1R
T1R1R = WeldJoint('T1R1R', ... 
    T1, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R1R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T1R1R);

% Body: R2R
R2R = Body('R2R', ribMass, Vec3(0), Inertia(1));
R2R.attachGeometry(Mesh('Rib2R.vtp'));
model.addBody(R2R);

% Joint: T2 To R2R
T2R2R = WeldJoint('T2R2R', ... 
    T2, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R2R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T2R2R);

% Body: R3R
R3R = Body('R3R', ribMass, Vec3(0), Inertia(1));
R3R.attachGeometry(Mesh('Rib3R.vtp'));
model.addBody(R3R);

% Joint: T3 To R3R
T3R3R = WeldJoint('T3R3R', ... 
    T3, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R3R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T3R3R);

% Body: R4R
R4R = Body('R4R', ribMass, Vec3(0), Inertia(1));
R4R.attachGeometry(Mesh('Rib4R.vtp'));
model.addBody(R4R);

% Joint: T4 To R4R
T4R4R = WeldJoint('T4R4R', ... 
    T4, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R4R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T4R4R);

% Body: R5R
R5R = Body('R5R', ribMass, Vec3(0), Inertia(1));
R5R.attachGeometry(Mesh('Rib5R.vtp'));
model.addBody(R5R);

% Joint: T5 To R5R
T5R5R = WeldJoint('T5R5R', ... 
    T5, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R5R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T5R5R);

% Body: R6R
R6R = Body('R6R', ribMass, Vec3(0), Inertia(1));
R6R.attachGeometry(Mesh('Rib6R.vtp'));
model.addBody(R6R);

% Joint: T6 To R6R
T6R6R = WeldJoint('T6R6R', ... 
    T6, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R6R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T6R6R);

% Body: R7R
R7R = Body('R7R', ribMass, Vec3(0), Inertia(1));
R7R.attachGeometry(Mesh('Rib7R.vtp'));
model.addBody(R7R);

% Joint: T7 To R7R
T7R7R = WeldJoint('T7R7R', ... 
    T7, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R7R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T7R7R);

% Body: R8R
R8R = Body('R8R', ribMass, Vec3(0), Inertia(1));
R8R.attachGeometry(Mesh('Rib8R.vtp'));
model.addBody(R8R);

% Joint: T8 To R8R
T8R8R = WeldJoint('T8R8R', ... 
    T8, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R8R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T8R8R);

% Body: R9R
R9R = Body('R9R', ribMass, Vec3(0), Inertia(1));
R9R.attachGeometry(Mesh('Rib9R.vtp'));
model.addBody(R9R);

% Joint: T9 To R9R
T9R9R = WeldJoint('T9R9R', ... 
    T9, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R9R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T9R9R);

% Body: R10R
R10R = Body('R10R', ribMass, Vec3(0), Inertia(1));
R10R.attachGeometry(Mesh('Rib10R.vtp'));
model.addBody(R10R);

% Joint: T10 To R10R
T10R10R = WeldJoint('T10R10R', ... 
    T10, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R10R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T10R10R);

% Body: R11R
R11R = Body('R11R', ribMass, Vec3(0), Inertia(1));
R11R.attachGeometry(Mesh('Rib11R.vtp'));
model.addBody(R11R);

% Joint: T11 To R11R
T11R11R = WeldJoint('T11R11R', ... 
    T11, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R11R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T11R11R);

% Body: R12R
R12R = Body('R12R', ribMass, Vec3(0), Inertia(1));
R12R.attachGeometry(Mesh('Rib12R.vtp'));
model.addBody(R12R);

% Joint: T12 To R12R
T12R12R = WeldJoint('T12R12R', ... 
    T12, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R12R, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T12R12R);

%% Ribs Left

% Body: R1L
R1L = Body('R1L', ribMass, Vec3(0), Inertia(1));
R1L.attachGeometry(Mesh('Rib1L.vtp'));
model.addBody(R1L);

% Joint: T1 To R1L
T1R1L = WeldJoint('T1R1L', ... 
    T1, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R1L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T1R1L);

% Body: R2L
R2L = Body('R2L', ribMass, Vec3(0), Inertia(1));
R2L.attachGeometry(Mesh('Rib2L.vtp'));
model.addBody(R2L);

% Joint: T2 To R2L
T2R2L = WeldJoint('T2R2L', ... 
    T2, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R2L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T2R2L);

% Body: R3L
R3L = Body('R3L', ribMass, Vec3(0), Inertia(1));
R3L.attachGeometry(Mesh('Rib3L.vtp'));
model.addBody(R3L);

% Joint: T3 To R3L
T3R3L = WeldJoint('T3R3L', ... 
    T3, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R3L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T3R3L);

% Body: R4L
R4L = Body('R4L', ribMass, Vec3(0), Inertia(1));
R4L.attachGeometry(Mesh('Rib4L.vtp'));
model.addBody(R4L);

% Joint: T4 To R4L
T4R4L = WeldJoint('T4R4L', ... 
    T4, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R4L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T4R4L);

% Body: R5L
R5L = Body('R5L', ribMass, Vec3(0), Inertia(1));
R5L.attachGeometry(Mesh('Rib5L.vtp'));
model.addBody(R5L);

% Joint: T5 To R5L
T5R5L = WeldJoint('T5R5L', ... 
    T5, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R5L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T5R5L);

% Body: R6L
R6L = Body('R6L', ribMass, Vec3(0), Inertia(1));
R6L.attachGeometry(Mesh('Rib6L.vtp'));
model.addBody(R6L);

% Joint: T6 To R6L
T6R6L = WeldJoint('T6R6L', ... 
    T6, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R6L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T6R6L);

% Body: R7L
R7L = Body('R7L', ribMass, Vec3(0), Inertia(1));
R7L.attachGeometry(Mesh('Rib7L.vtp'));
model.addBody(R7L);

% Joint: T7 To R7L
T7R7L = WeldJoint('T7R7L', ... 
    T7, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R7L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T7R7L);

% Body: R8L
R8L = Body('R8L', ribMass, Vec3(0), Inertia(1));
R8L.attachGeometry(Mesh('Rib8L.vtp'));
model.addBody(R8L);

% Joint: T8 To R8L
T8R8L = WeldJoint('T8R8L', ... 
    T8, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R8L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T8R8L);

% Body: R9L
R9L = Body('R9L', ribMass, Vec3(0), Inertia(1));
R9L.attachGeometry(Mesh('Rib9L.vtp'));
model.addBody(R9L);

% Joint: T9 To R9L
T9R9L = WeldJoint('T9R9L', ... 
    T9, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R9L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T9R9L);

% Body: R10L
R10L = Body('R10L', ribMass, Vec3(0), Inertia(1));
R10L.attachGeometry(Mesh('Rib10L.vtp'));
model.addBody(R10L);

% Joint: T10 To R10L
T10R10L = WeldJoint('T10R10L', ... 
    T10, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R10L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T10R10L);

% Body: R11L
R11L = Body('R11L', ribMass, Vec3(0), Inertia(1));
R11L.attachGeometry(Mesh('Rib11L.vtp'));
model.addBody(R11L);

% Joint: T11 To R11L
T11R11L = WeldJoint('T11R11L', ... 
    T11, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R11L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T11R11L);

% Body: R12L
R12L = Body('R12L', ribMass, Vec3(0), Inertia(1));
R12L.attachGeometry(Mesh('Rib12L.vtp'));
model.addBody(R12L);

% Joint: T12 To R12L
T12R12L = WeldJoint('T12R12L', ... 
    T12, Vec3(0), Vec3(0), ... % parent, trans., orien.
    R12L, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(T12R12L);

%% Abdomen, sternum

% Body: Abdomen
abdomen = Body('abdomen', abdomenMass, Vec3(0), Inertia(1));
model.addBody(abdomen);

% Joint: Abdomen to Pelvis
AbdomenToSacrum = BallJoint('AbdomenToSacrum', ... 
    pelvis, Vec3(0), Vec3(0), ... % parent, trans., orien.
    abdomen, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(AbdomenToSacrum);

% Body: Sternum
sternum = Body('sternum', sternumMass, Vec3(0), Inertia(1));
sternum.attachGeometry(Mesh('sternum.vtp'));
model.addBody(sternum);

% Joint: Sternum To R1R
SternumToR1R = WeldJoint('SternumToR1R', ... 
    R1R, Vec3(0), Vec3(0), ... % parent, trans., orien.
    sternum, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(SternumToR1R);

%% Right Upper Limb including shoulder girdle

% Body: Clavicle Right
clavicleRight = Body('clavicleRight', clavicleMass, Vec3(0), Inertia(1));
clavicleRight.attachGeometry(Mesh('r_clavicle.vtp'));
model.addBody(clavicleRight);

% Joint: Sternoclavicular Right
sternoclavicularRight = WeldJoint('sternoclavicularRight', ... 
    sternum, Vec3(0), Vec3(0), ... % parent, trans., orien.
    clavicleRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(sternoclavicularRight);

% Body: Scapula Right
scapulaRight = Body('scapulaRight', scapulaMass, Vec3(0), Inertia(1));
scapulaRight.attachGeometry(Mesh('r_scapula.vtp'));
model.addBody(scapulaRight);

% Joint: Acromioclavicular Right
acromioclavicularRight = WeldJoint('acromioclavicularRight', ... 
    clavicleRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    scapulaRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(acromioclavicularRight);

% Body: Upper Arm Right
upperArmRight = Body('upperArmRight', upperArmMass, Vec3(0), Inertia(1));
upperArmRight.attachGeometry(Mesh('r_humerus.vtp'));
model.addBody(upperArmRight);

% Joint: Shoulder Right
shoulderRight = BallJoint('shoulderRight', ... 
    scapulaRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    upperArmRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(shoulderRight);

% Body: Forearm Right
forearmRight = Body('forearmRight', forearmMass, Vec3(0), Inertia(1));
forearmRight.attachGeometry(Mesh('r_ulna.vtp'));
forearmRight.attachGeometry(Mesh('r_radius.vtp'));
model.addBody(forearmRight);

% Joint: Elbow Right
elbowRight = PinJoint('elbowRight', ... 
    upperArmRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    forearmRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(elbowRight);

% Body: Hand Right
handRight = Body('handRight', handMass, Vec3(0), Inertia(1));
handRight.attachGeometry(Mesh('r_hand.vtp'));
model.addBody(handRight);

% Joint: Wrist Right
wristRight = PinJoint('wristRight', ... 
    forearmRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    handRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(wristRight);

%% Left Upper Limb including shoulder girdle

% Body: Clavicle Left
clavicleLeft = Body('clavicleLeft', clavicleMass, Vec3(0), Inertia(1));
clavicleLeft.attachGeometry(Mesh('l_clavicle.vtp'));
model.addBody(clavicleLeft);

% Joint: Sternoclavicular Left
sternoclavicularLeft = WeldJoint('sternoclavicularLeft', ... 
    sternum, Vec3(0), Vec3(0), ... % parent, trans., orien.
    clavicleLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(sternoclavicularLeft);

% Body: Scapula Left
scapulaLeft = Body('scapulaLeft', scapulaMass, Vec3(0), Inertia(1));
scapulaLeft.attachGeometry(Mesh('l_scapula.vtp'));
model.addBody(scapulaLeft);

% Joint: Acromioclavicular Left
acromioclavicularLeft = WeldJoint('acromioclavicularLeft', ... 
    clavicleLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    scapulaLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(acromioclavicularLeft);

% Body: Upper Arm Left
upperArmLeft = Body('upperArmLeft', upperArmMass, Vec3(0), Inertia(1));
upperArmLeft.attachGeometry(Mesh('l_humerus.vtp'));
model.addBody(upperArmLeft);

% Joint: Shoulder Left
shoulderLeft = BallJoint('shoulderLeft', ... 
    scapulaLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    upperArmLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(shoulderLeft);

% Body: Forearm Left
forearmLeft = Body('forearmLeft', forearmMass, Vec3(0), Inertia(1));
forearmLeft.attachGeometry(Mesh('l_ulna.vtp'));
forearmLeft.attachGeometry(Mesh('l_radius.vtp'));
model.addBody(forearmLeft);

% Joint: Elbow Left
elbowLeft = PinJoint('elbowLeft', ... 
    upperArmLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    forearmLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(elbowLeft);

% Body: Hand Left
handLeft = Body('handLeft', handMass, Vec3(0), Inertia(1));
handLeft.attachGeometry(Mesh('l_hand.vtp'));
model.addBody(handLeft);

% Joint: Wrist Left
wristLeft = PinJoint('wristLeft', ... 
    forearmLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    handLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(wristLeft);

%% Right Lower Limb

% Body: Thigh Right
thighRight = Body('thighRight', thighMass, Vec3(0), Inertia(1));
thighRight.attachGeometry(Mesh('r_femur.vtp'));
model.addBody(thighRight);

% Joint: Hip Right
hipRight = BallJoint('hipRight', ... 
    pelvis, Vec3(0), Vec3(0), ... % parent, trans., orien.
    thighRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(hipRight);

% Body: Shank Right
shankRight = Body('shankRight', shankMass, Vec3(0), Inertia(1));
shankRight.attachGeometry(Mesh('r_tibia.vtp'));
shankRight.attachGeometry(Mesh('r_fibula.vtp'));
model.addBody(shankRight);

% Joint: Knee Right
kneeRight = BallJoint('kneeRight', ... 
    thighRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    shankRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(kneeRight);

% Body: Patella Right
patellaRight = Body('patellaRight', patellaMass, Vec3(0), Inertia(1));
patellaRight.attachGeometry(Mesh('r_patella.vtp'));
model.addBody(patellaRight);

% Joint: Patellofemoral Right
patellofemoralRight = WeldJoint('patellofemoralRight', ... 
    thighRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    patellaRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(patellofemoralRight);

% Body: Talus Right
talusRight = Body('talusRight', talusMass, Vec3(0), Inertia(1));
talusRight.attachGeometry(Mesh('r_talus.vtp'));
model.addBody(talusRight);

% Joint: Ankle Right
ankleRight = PinJoint('ankleRight', ... 
    shankRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    talusRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(ankleRight);

% Body: Calcaneus Right
calcaneusRight = Body('calcaneusRight', calcaneusMass, Vec3(0), Inertia(1));
calcaneusRight.attachGeometry(Mesh('r_foot.vtp'));
model.addBody(calcaneusRight);

% Joint: Subtalar Right
subtalarRight = PinJoint('subtalarRight', ... 
    talusRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    calcaneusRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(subtalarRight);

% Body: Toes Right
toesRight = Body('toesRight', toesMass, Vec3(0), Inertia(1));
toesRight.attachGeometry(Mesh('r_toes.vtp'));
model.addBody(toesRight);

% Joint: MTP Right
mtpRight = PinJoint('mtpRight', ... 
    calcaneusRight, Vec3(0), Vec3(0), ... % parent, trans., orien.
    toesRight, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(mtpRight);

%% Left Lower Limb

% Body: Thigh Left
thighLeft = Body('thighLeft', thighMass, Vec3(0), Inertia(1));
thighLeft.attachGeometry(Mesh('l_femur.vtp'));
model.addBody(thighLeft);

% Joint: Hip Left
hipLeft = BallJoint('hipLeft', ... 
    pelvis, Vec3(0), Vec3(0), ... % parent, trans., orien.
    thighLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(hipLeft);

% Body: Shank Left
shankLeft = Body('shankLeft', shankMass, Vec3(0), Inertia(1));
shankLeft.attachGeometry(Mesh('l_tibia.vtp'));
shankLeft.attachGeometry(Mesh('l_fibula.vtp'));
model.addBody(shankLeft);

% Joint: Knee Left
kneeLeft = BallJoint('kneeLeft', ... 
    thighLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    shankLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(kneeLeft);

% Body: Patella Left
patellaLeft = Body('patellaLeft', patellaMass, Vec3(0), Inertia(1));
patellaLeft.attachGeometry(Mesh('l_patella.vtp'));
model.addBody(patellaLeft);

% Joint: Patellofemoral Left
patellofemoralLeft = WeldJoint('patellofemoralLeft', ... 
    thighLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    patellaLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(patellofemoralLeft);

% Body: Talus Left
talusLeft = Body('talusLeft', talusMass, Vec3(0), Inertia(1));
talusLeft.attachGeometry(Mesh('l_talus.vtp'));
model.addBody(talusLeft);

% Joint: Ankle Left
ankleLeft = PinJoint('ankleLeft', ... 
    shankLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    talusLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(ankleLeft);

% Body: Calcaneus Left
calcaneusLeft = Body('calcaneusLeft', calcaneusMass, Vec3(0), Inertia(1));
calcaneusLeft.attachGeometry(Mesh('l_foot.vtp'));
model.addBody(calcaneusLeft);

% Joint: Subtalar Left
subtalarLeft = PinJoint('subtalarLeft', ... 
    talusLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    calcaneusLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(subtalarLeft);

% Body: Toes Left
toesLeft = Body('toesLeft', toesMass, Vec3(0), Inertia(1));
toesLeft.attachGeometry(Mesh('l_toes.vtp'));
model.addBody(toesLeft);

% Joint: MTP Left
mtpLeft = PinJoint('mtpLeft', ... 
    calcaneusLeft, Vec3(0), Vec3(0), ... % parent, trans., orien.
    toesLeft, Vec3(0), Vec3(0)); % child, trans., orien. 
model.addJoint(mtpLeft);

%% Muscles (ForceSet)
% 
% % Muscle: Vastus
% % --------------
% vastus = Millard2012EquilibriumMuscle(); 
% vastus.setName('vastus'); 
% vastus.setMaxIsometricForce(500); 
% vastus.setOptimalFiberLength(0.19); 
% vastus.setTendonSlackLength(0.19);
% % Construct muscle path
% origin = Vec3(thighLength/10, 0, 0);
% vastus.addNewPathPoint('origin', thighRight, origin); 
% insertion = Vec3(0.75 * shankLength/10, 0.7 * shankLength/2, 0); 
% vastus.addNewPathPoint('insertion', shankRight, insertion);
% % Add muscle to the model
% model.addForce(vastus);

%% Wrap Objects (WrapObjects)
% 
% % Wrap: Patella
% % -------------
% patella = WrapCylinder(); 
% patella.setName('patella'); 
% patella.set_translation(Vec3(0, -thighLength/2, 0)); 
% patella.set_radius(0.04); 
% patella.set_length(0.1); 
% patella.set_quadrant('x'); 
% thighRight.addWrapObject(patella);
% % update muscle wrapping
% vastus.updGeometryPath().addPathWrap(patella);
%% Initialize and save model

model.finalizeConnections();

% Check model
model.initSystem();
% Save model file
cd('/Users/rosswilkinson/Google Drive/projects/moco-cycling-standing/model')
model.print('test.osim')
