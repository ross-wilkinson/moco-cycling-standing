# Using OpenSim Moco to predict the metabolic cost of standing cycling

This repository contains the necessary data, model, and processing files to predict the metabolic cost of standing cycling.

The dataset (motion capture, crank forces, EMG) was collected during my PhD at The University of Queensland.

An intermediary step in this pipeline is the use of force and torque equilibrium equations to predict forces generated on the handlebar. Once handlebar forces have been resolved then all external loads acting on the rider are used to estimate whole-body muscle activity.

The full-body muscle-actuated model used for this pipeline was created by combining two previously created models.
