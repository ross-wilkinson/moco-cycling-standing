% ------------------------------------------------------------------------
% Analyze Handlebar Forces
% ------------------------------------------------------------------------
% Copyright (c) 2020 Authors
%                                                                        
% Author(s): Ross Wilkinson
%                                                                        
% Licensed under the Apache License, Version 2.0 (the "License"); you may
% not use this file except in compliance with the License. You may obtain a
% copy of the License at http://www.apache.org/licenses/LICENSE-2.0
%                                                                        
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
% License for the specific language governing permissions and limitations
% under the License.
% ------------------------------------------------------------------------

% Introduction
% ============
% Although detailed and insightful, Soden & Adeyefa's analysis of forces
% acting on a bicycle during non-seated climbing ignored vertical inertia
% forces as CoM motion of the rider was not measured. In light of more
% recent evidence regarding the energetics of a rider's CoM during
% non-seated cycling, it is likely that ignoring vertical inertia forces
% may have had a significant effect on their estimate of the magnitude of
% forces applied by the arms at the handlebar.
% 
% Here we use our recently collected dataset which includes a measure CoM
% inertia to compare estimates of forces acting on the handlebar between
% Soden & Adeyefa's original analysis and one that accounts for vertical
% inertia. The case of climbing and speeding will be analysed. For clarity
% and convenience, we have replicated of Soden & Adeyefa's figure showing
% the diagram of the bicycle together with the major dimensions and the
% simplifed system of forces assumed to act.
% 
% The co-ordinates and motion of the riders' centre of mass (L1 and L5 in
% Figure) were calculated using the Analyze Tool in OpenSim 4.0,
% which uses a subject-specfic full-body musculoskeletal model scaled using
% a full-body markerset measured at 200 Hz to estimate CoM position using a
% least-squares optimization at each time point. For subject 1 in a
% non-seated posture with the cranks horizontal (see Figure of Model).

% Assumption/s
% ============
% 1. There were no forces on the saddle 2. There is no thrust on the
% bicycle or rider's CoM. (Note: Thrust decreases contact force on the rear
% wheel) 3. Aerodynamic forces and rolling resistance were negligible 4.
% Weight and inertia of the bicycle itself are neglected 5. All lateral
% forces are ignored 6. No attempt to achieve moment equilibrium of the
% handlebar, brakes, and front wheel assembly, which is free to rotate
% about the steering tube

% Notes
% =====
% B = point of rear wheel contact

% Initialize script
% =================
clear; clc; close all

% Variable      Description                                         Unit
% ========      ===========                                         ====
L1 = [];        % horz. distance from hands to B (rdr to B3)        m
L2 = [];        % horz. distance from CoM to B                      m
L3 = [];        % horz. distance from saddle to B (rgt to B3)       m
L4 = [];        % horz. distance from left pedal to B               m
L5 = [];        % horz. distance from right pedal to B              m
L6 = [];        % horz. distance from front center to B             m
L7 = [];        % vert. height of saddle above B                    m
L8 = [];        % vert. height of handlebar above B                 m
L9 = 1.054;     % vert. height of CoM above B                       m
L10 = 0.122;    % lateral distance from right pedal to B            m
L11 = 0.122;    % lateral distance from left pedal to B             m
L12 = 0.220;    % lateral distance from right hand to B             m
L13 = 0.220;    % lateral distance from left hand to B              m
g = -9.79124;   % acceleration due to gravity                       m/s^2
S1 = 0;         % horizontal saddle force                           N
S2 = 0;         % vertical saddle force                             N
T = 0;          % thrust at rear wheel                              N
a1 = 0;         % vertical acceleration of rider CoM                m/s^2
a2 = 0;         % horizontal acceleration of rider CoM              m/s^2
a3 = 0;         % lateral acceleration of rider CoM                 m/s^2
a4 = 0;         % lateral acceleration of rider CoM                 m/s^2
M = 67.5;       % mass of rider in kg                               kg
Mb = 9;         % mass of bike in kg                                kg
W1 = M*(g+a1);  % force due to rider mass along Y                   N
W2 = M*a2;      % force due to rider mass along X                   N
W3 = M*a3;      % force due to rider mass along Z                   N
W4 = Mb*a4;     % force due to bike mass along Y                    N
P1 = 1448;      % vertical force on right pedal                     N
P2 = 367;       % vertical force on left pedal                      N
P3 = 200;       % horizontal force on right pedal                   N
P4 = 50;        % horizontal force on left pedal                    N
H1 = [];        % vert. force on right handlebar                    N
H2 = [];        % vert. force on left handlebar                     N
H3 = [];        % horz. force on right handlebar                    N
H4 = [];        % horz. force on left handlebar                     N
R1 = [];        % vert. force on front wheel                        N
R2 = [];        % vert. force on rear wheel                         N
theta_b = [];   % lean angle of bicycle frame                       rad

% Equation/s                            Description
% ==========                            ===========
% R1 + R2 + W1 = 0                      Total vertical contact force = Force due to vertical acceleration of rider CoM.
% H1 + H2 + P1 + P2 + W1 = 0            Total vertical force at pedals and handlebar = Force due to vertical acceleration of rider CoM. 
% H3 + H4 + P3 + P4 + W2 = 0            Total horizontal force at pedals and handlebar = Force due to horizontal acceleration of rider CoM. 
% R1*L6 + a1*L9 - ((R1+R2)*L2) == 0     Moments about B in sagittal plane are in equilibrium. 
% H1*L12 + H2*L13 == P1*L10 + P2*L11    Moments about B in frontal plane are in equilibrium. 
% H3*L12 + H4*L13 == P3*L10 + P4*L11    Moments about B in transverse plane are in equilibrium. 

% set vars
% --------
subList = {'s01','s03','s05','s07','s08',...
    's09','s10','s11','s13'};
nSub = numel(subList);
conList = {'c01','c02','c03'};
nCon = numel(conList);

% set dirs
% --------
expDir = '/Users/rosswilkinson/Documents/PhD/e02';
codDir = [expDir '/code'];
datDir = [expDir '/data'];
resDir = [expDir '/results'];
figDir = [expDir '/figures'];

% load data table
load([resDir '/' 'DATA.mat'],'SWAY');

for iS = 1:nSub
    for iC = 1:nCon
        % hand y position
        cd(codDir)
        trialName = [subList{iS} conList{iC} '01'];
        load([trialName 'workspaceExternalLoads'],'markerData','markerLabels',...
            'theta_b')
        rHand = markerData(:,:,markerLabels == 'rdr')/1000;
        lHand = markerData(:,:,markerLabels == 'ldr')/1000;

        % calculate offset at handlebar based on theta_b
        Lhb = 0.775; % height of hoods from roller surface
        offset = sin(theta_b')*Lhb;

        L12 = (lHand(2,:) - rHand(2,:)) / 2;
        L12offset = L12 + offset;
        L13 = L12;
        L13offset = L13 - offset;

        % pedal y position
        load([trialName 'workspaceExternalLoads'],'pointXyzGlobalLeft','pointXyzGlobalRight')
        rPedal = pointXyzGlobalRight;
        lPedal = pointXyzGlobalLeft;

        % calculate offset at handlebar based on theta_b
        Lgr = 0.0926; % height of roller surface
        offsetLeft = sin(theta_b') .* (lPedal(2,:) - Lgr);
        offsetRight = sin(theta_b') .* (rPedal(2,:) - Lgr);

        L10 = (-lPedal(3,:) + rPedal(3,:)) / 2;
        L10offset = L10 + offsetRight;
        L11 = L10;
        L11offset = L11 - offsetLeft;

        % contact position
        Lbb = 0.350 - 0.061;
        offsetB = sin(theta_b') .* Lbb;
        Bb(1,:) = -mean([lPedal(1,:); rPedal(1,:)]);
        Bb(2,:) = -mean([lPedal(2,:); rPedal(2,:)]);
        Bb(3,:) = -mean([lPedal(3,:); rPedal(3,:)]);
        Bz = Bb(3,:) + offsetB;

        % CoM position
        cd(resDir)
        dataCOM = importdata([trialName '_BodyKinematics_pos_global.sto'],'\t');
        time = dataCOM.data(:,1);
        comX = dataCOM.data(:,2);
        comY = dataCOM.data(:,3);
        comZ = -dataCOM.data(:,4);

        By = Bb(1,:) - mean(Bb(1,:));
        L2 = comX' + By;
        L9 = comY' - Lgr;

        % front wheel x position
        L6 = 0.995;

        % mass, weight and acceleration of rider
        M = SWAY.subjectData.mass(1);

        comVel = lowpass(diff(comY)/(1/200),12,200);
        a1 = lowpass(diff(comVel)/(1/200),12,200);
        W1 = interp1(M*(-g+a1),1:length(a1)/(length(comY)+1):length(a1));

        % pedal force
        cd(codDir)
        load([trialName 'workspaceExternalLoads.mat'],'angleGlobalRightRadians','forceXyzOSLeft','forceXyzOSRight')
        P1 = forceXyzOSRight(2,:);

        [~,locs] = findpeaks(P1,'minPeakDistance',150);
        k = diff(locs);
        shift = round(mean(k)/2);

        %P2 = [P1(shift:end) P1(1:shift-1)];
        P2 = forceXyzOSLeft(2,:);
        P3 = forceXyzOSRight(1,:);
        P4 = forceXyzOSLeft(1,:);
        %P4 = [P3(shift:end) P3(1:shift-1)];

        % angleY - bike
        thetaYbike = lowpass(theta_b,1,200);
        % velocityY - bike
        omegaYbike = lowpass(diff(thetaYbike) / (1/200),1,200);
        % accelerationY - bike
        alphaYbike = diff(omegaYbike) / (1/200);
        aYbike = alphaYbike * 0.350;
        
        % Bicycle Mechanical Energy
        m = 11; % mass of bike
        r = 0.4; % vertical height of bike's CoM
        h = r*(cos(thetaYbike));
        PEbike = m*g*h;
        KEbike = 0.5 * (m*r^2) * (omegaYbike.^2);
        TEbike = lowpass(PEbike(2:end) + KEbike,1,200);
        TPbike = lowpass(diff(TEbike) / (1/200),1,200);
        
        % Create figure of lean angle, lean velocity, energy and power
        t = seconds(1/200:1/200:10);
        
        figure('color','w')
        % lean angle
        subplot(411)
        plot(t,rad2deg(thetaYbike))
        box off
        ylabel('Lean Angle (deg)')
        xlim([seconds(0) seconds(10)])
        % lean velocity
        subplot(412)
        plot(t(2:end),rad2deg(omegaYbike))
        box off
        ylabel('Lean Velocity (deg/s)')
        xlim([seconds(0) seconds(10)])
        % total energy
        subplot(413)
        plot(t(41:end-40),TEbike(40:end-40))
        box off
        ylabel({'Total','Mechanical Energy (J)'})
        xlim([seconds(0) seconds(10)])
        % total power
        subplot(414)
        plot(t(41:end-40),TPbike(39:end-40))
        box off
        ylabel('Mechanical Power (W)')
        xlim([seconds(0) seconds(10)])

        % Create structure to save handlebar Forces
        S.colheaders = {'time','crank_angle','right_hbar_force_y','left_hbar_force_y'};
        S.data(:,1) = time;
        S.datawAcc(:,1) = time;
        S.datawAccLean(:,1) = time;

        % Solve for unknowns (R1, R2, H1, H2)
        % ===========================================
        % Rider CoM acceleration NOT included
        syms R1 R2 H1 H2
        for i = 1:length(W1)
        %     eqnsR = [R1*L6 + a2*L9(i) + M*g*L2(i) == 0, R1 + R2 == -M*g];
        %     R = solve(eqnsR,[R1 R2]);
        %     S.R1(i) = double(R.R1);
        %     S.R2(i) = double(R.R2);
        %     S.WDF(i) = S.R1(i) / W1(i) * 100;

            eqnsHv = [H1 + H2 + -P1(i) + -P2(i) == -M*g, -H1*L12(i) + H2*L13(i) == -P1(i)*L10(i) + P2(i)*L11(i)];
            H = solve(eqnsHv,[H1 H2]);
            S.data(i,2) = double(H.H1);
            S.data(i,3) = double(H.H2);
        end

        % Rider CoM acceleration included

        syms R1 R2 H1 H2
        for i = 1:length(W1)
        %     eqnsR = [R1*L6 + a2*L9(i) + W1(i)*L2(i) == 0, R1 + R2 == -W1(i)];
        %     R = solve(eqnsR,[R1 R2]);
        %     S.R1wAcc(i) = double(R.R1);
        %     S.R2wAcc(i) = double(R.R2);
        %     S.WDFwAcc(i) = S.R1wAcc(i) / W1(i) * 100;

            eqnsHv = [H1 + H2 + -P1(i) + -P2(i) == W1(i), -H1*L12(i) + H2*L13(i) == -P1(i)*L10(i) + P2(i)*L11(i)];
            H = solve(eqnsHv,[H1 H2]);
            S.datawAcc(i,2) = double(H.H1);
            S.datawAcc(i,3) = double(H.H2);
        end

        % Rider CoM acceleration included AND lateral movement
        syms R1 R2 H1 H2
        for i = 1:length(W1)
        %     eqnsR = [R1*L6 + a2*L9(i) + (R1+R2)*L2(i) == 0, R1 + R2 == -W1(i)];
        %     R = solve(eqnsR,[R1 R2]);
        %     S.R1wAccLat(i) = double(R.R1);
        %     S.R2wAccLat(i) = double(R.R2);
        %     S.WDFwAccLat(i) = S.R1wAccLat(i) / W1(i) * 100;

            eqnsHv = [H1 + H2 + -P1(i) + -P2(i) == W1(i), -H1*L12offset(i) + H2*L13offset(i) == -P1(i)*L10offset(i) + P2(i)*L11offset(i)];
            H = solve(eqnsHv,[H1 H2]);
            S.datawAccLean(i,2) = double(H.H1);
            S.datawAccLean(i,3) = double(H.H2);
        end
        
        %% Save structure
        cd(resDir)
        filename = [trialName 'handlebarForces.mat'];
        save(filename,'S')
        clear S Bb
        disp([trialName ' complete.'])
    end
end
