# This tutorial for SOWFA is for model of hydrokinetic turbines.

* full-scale horizontal-axis tidal turbine, rated power of 550kW, diameter of 20-m
* created by US DOE to standardize experimental and numerical studies
* foils are NACA 4 and 6 series chosen for cavitation prevention and well known performance characteristics at low and high Reynolds numbers
* laboratory turbine 45:1 scaling -- diameter of 45-cm
* attempt to match power extraction and wake characteristics at lab-scale
* lab-scale rotor was re-designed to minimize Reynolds scaling effects

Two turbine models are included in this tutorial, the full-scale and laboratory-scale re-design.  This repository uses seperate branches for different OpenFOAM cases (like when changing meshes, turbine configurations and layouts).


## Some additional scripts have also been added:

* recontruct fields in parallel
* session files for visualization using VisIt
* spreadsheet to estimate values for actuator-line settings, timestepping, mesh size, etc...


## here be dragons ...
the simulations are still coarse, but run stable and give qualitative comparison
with experiments and literature ... improvements would be local mesh
refinement, improve distribution of body forces (like
elliptical wing or disk/sector method), add background turbulence,
change wall boundary conditions ...


