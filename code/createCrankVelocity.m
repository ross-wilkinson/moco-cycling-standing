function [t,v] = createCrankVelocity(cadence,freq,simTime)
%CREATECRANKVELOCITY Summary of this function goes here
%   Take desired cadence, sampling frequency, and desired total time for
%   simulation
%
% Inputs:
%       - cadence:  desired pedaling rate for simulation in rpm
%       - freq:     sampling rate in Hz
%       - simTime:  total time of desired simulation

% Outputs:
%       - t:        time vector in seconds
%       - v:        crank velocity vector in rad/s

% Convert cadence to radians per sec
vMean = cadence / 60 * 2 * pi;

% Calculate sinusoidal pattern (based on Wilkinson et al., 2020a)
f = cadence * 2 / 60;
A = 0.33; % constant fluctuation of 0.33 rad/s (larger % at low rpm)
phi = -f/2;
sampleTime = 1/freq;
t = 0:sampleTime:simTime;
v = A * sin(2*pi*f*t + phi) + vMean; % add mean vel to sine wave

plot(t,v)
ylim([0 15])
end

