#!/bin/sh
##
## This file reinitializes some variables in the FAST model, because
## if OpenFOAM restarts from a previous timestep FAST should also
## reinitialize using previous time values
##
## To-Do: this probably only works with a single turbine, if multiple
##        turbines are defined the format of FAST output files is different


## The file to modify
fileFAST=$(realpath ./../primary.fst)


## Find the name of last time directory where OpenFOAM and FAST stopped
## these are the most recently modified files
lastTimeFAST=$(ls -t ./../turbineOutput/ | head -n 1)
lastTimeFOAM=$(ls -t ./../processor0/ | head -n 1)


## now find the lastTime directory of the FAST output files
## (note: the rotorSpeed and azimuth files share same format)
lastDirFAST=$(realpath ./../turbineOutput/$lastTimeFAST/)


## now read the second column of the file
timesFAST=$(awk '{print $2}' $lastDirFAST/azimuth)
azimuth=$(awk '{print $4}' $lastDirFAST/azimuth)
rotSpeed=$(awk '{print $4}' $lastDirFAST/rotSpeed)

## convert to list so we can refer to elements using index
timesFAST=($timesFAST)
azimuth=($azimuth)
rotSpeed=($rotSpeed)

## find the index of matching element in list
for ((i=0; i < ${#timesFAST[@]}; ++i)); do
    if [ ${timesFAST[$i]} ==  $lastTimeFOAM ]; then
        index=$i
    fi
done


## define the new intital conditions to restart with
init_azimuth=${azimuth[$index]}
init_rotSpeed=${rotSpeed[$index]}


## Read the last known blade azimuth, and overwite to FAST input file
# fileName=./turbineOutput/$lastDir/azimuth
# lastLine=$(tac $fileName | egrep -m 1 .)
# lastWord=$(echo $lastLine | awk '{ print $(NF) }')
lineNumb=72
./overwrite-line.sh $lineNumb "$init_azimuth    Azimuth     - Initial azimuth angle for blade 1 (degrees)" $fileFAST > $fileFAST.replace
mv $fileFAST.replace $fileFAST


## Read the last known rotor speed, and overwite to FAST input file
# fileName=./turbineOutput/$lastDir/rotSpeed
# lastLine=$(tac $fileName | egrep -m 1 .)
# lastWord=$(echo $lastLine | awk '{ print $(NF) }')
lineNumb=73
./overwrite-line.sh $lineNumb "$init_rotSpeed   RotSpeed    - Initial or fixed rotor speed (rpm)" $fileFAST > $fileFAST.replace
mv $fileFAST.replace $fileFAST


## REMOVE last N lines from a file (note the format has empty lines every other line)
## this is so FAST output files do not contain duplicate values if restarting
#nLines=$(($index * 2 + 1))
#head -n $nLines $lastDirFAST/azimuth > $lastDirFAST/azimuth.new
#head -n $nLines $lastDirFAST/rotSpeed > $lastDirFAST/rotSpeed.new

