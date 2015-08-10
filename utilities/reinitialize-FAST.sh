#!/bin/sh
cd ${0%/*} || exit 1 # run from this directory

## This file reinitializes some variables in the FAST model, because
## if OpenFOAM restarts from a previous timestep FAST should also
## reinitialize using previous time values


## The file to modify
fileFAST=../primary.fst


## Find the name of last time directory where OpenFOAM stopped

## sort the directory names and list the time directories

## or find the the most recently modified file
lastTime=$(ls -t ./../turbineOutput/ | head -n 1)
echo $lastTime

## now find the lastTime directory of the FAST output files
## (note: the rotorSpeed and azimuth files share same format)
lastDir="./../turbineOutput/$lastTime/"
echo $lastDir

## now search the second column for the line of previous time step

timesFAST=$(awk '{print $2}' $lastDir/azimuth)




## Read the last known rotor speed, and overwite to FAST input file
fileName=./turbineOutput/$lastDir/rotSpeed
lastLine=$(tac $fileName | egrep -m 1 .)
lastWord=$(echo $lastLine | awk '{ print $(NF) }')
lineNumb=73
./replace-line.sh $lineNumb "$lastWord    RotSpeed    - Initial or fixed rotor speed (rpm)" $fileFAST > replace.$fileFAST
mv replace.$fileFAST $fileFAST



## Read the last known blade azimuth, and overwite to FAST input file
fileName=./turbineOutput/$lastDir/azimuth
lastLine=$(tac $fileName | egrep -m 1 .)
lastWord=$(echo $lastLine | awk '{ print $(NF) }')
lineNumb=72
./replace-line.sh $lineNumb "$lastWord    Azimuth     - Initial azimuth angle for blade 1 (degrees)" $fileFAST > replace.$fileFAST
mv replace.$fileFAST $fileFAST

