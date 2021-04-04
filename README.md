# Using OpenSim Moco to predict the metabolic cost of standing cycling

This repository contains the necessary data, model, and processing files to predict the metabolic cost of standing cycling.

The dataset (motion capture, crank forces, EMG) was collected during my PhD at The University of Queensland.

An intermediary step in this pipeline is the use of force and torque equilibrium equations to predict forces generated on the handlebar.

The full-body muscle-actuated model used for this pipeline was created by combining three previously created models:
* Muscle-actuated lower limbs by Lai, Arnold, and Wakeling (2017)
* Muscle-actuated trunk by Allaire, Burkhart, and Anderson (2020)
* Muscle-actuated upper limbs by Saul et al. (2015) updated by McFarland et al. (2019)
