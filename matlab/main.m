% MocoInverse pipeline for solving control and actuator states during
% standing cycling

% Author(s): Ross Wilkinson
% Affiliation(s): Ross Wilkinson

% GitHub Repo: https://github.com/ross-wilkinson/moco-cycling-standing

% Planning: 
% - Use Lai et al. model first to see if it works with torque actuated
% upper body. Add reserve actuator to pelvis for rotation and translation. 
% - Then try full-body muscle actuated model (check model marker locations!). 
% - Use sprint data from grip-no-grip project


%% Load experimental kinematics and external pedal forces
% Inputs:
% - kinematic results from OpenSim 4.1
% - external loads setup file for OpenSim 4.1

%% Solve handlebar forces in x- and y-axis
% Input:
% - bicycle measurements
% - rider CoM location
% - pedal forces
% Output:
% - array handlebar forces
% - external loads file including handlebar forces

%% Invoke MocoStudy 
% Input:
% - model file
% - kinematics file
% - external load file
% Output:
% - controls
% - actuator states