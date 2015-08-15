#!/bin/sh
##
## This file reinitializes some variables in the FAST model, because
## if OpenFOAM restarts from a previous timestep FAST should also
## reinitialize using previous time values
##
## To-Do: this probably only works with a single turbine, if multiple
##        turbines are defined the format of FAST output files is different


## The file to modify
cd ..
fileFAST=$PWD/primary.fst
echo $fileFAST
cd -

## Find the name of last time directory where OpenFOAM and FAST stopped
## these are the most recently modified files
lastTimeFAST=$(ls -t ./../turbineOutput/ | head -n 1)
lastTimeFOAM=$(ls -t ./../processor0/ | head -n 1)

echo $lastTimeFAST
echo $lastTimeFOAM

## now find the lastTime directory of the FAST output files
## (note: the rotorSpeed and azimuth files share same format)
lastDirFAST=$(realpath ./../turbineOutput/$lastTimeFAST/)

echo $lastDirFAST

## now read the second column of the file
timesFAST=$(awk '{print $2}' $lastDirFAST/azimuth)
azimuth=$(awk '{print $4}' $lastDirFAST/azimuth)


## convert to list so we can refer to elements using index
timesFAST=($timesFAST)
azimuth=($azimuth)

echo $timesFAST
echo $azimuth


## find the index of matching element in list
for ((i=0; i < ${#timesFAST[@]}; ++i)); do
    if [ ${timesFAST[$i]} ==  $lastTimeFOAM ]; then
        index=$i
    fi
done

echo $index


## define the new intital conditions to restart with
init_azimuth=${azimuth[$index]}

echo $init_azimuth

## Read the last known blade azimuth, and overwite to FAST input file
# fileName=./turbineOutput/$lastDir/azimuth
# lastLine=$(tac $fileName | egrep -m 1 .)
# lastWord=$(echo $lastLine | awk '{ print $(NF) }')
lineNumb=72
./overwrite-line.sh $lineNumb "$init_azimuth    Azimuth     - Initial azimuth angle for blade 1 (degrees), using Azimuth from previous OpenFOAM timestep of t = asdf" $fileFAST > $fileFAST.replace
mv $fileFAST.replace $fileFAST



## also need to overwrite in the file constant/turbineArrayProperties
## need to search for the line (or multiple lines) containing the "Azimuth" keyword

replace line with

"Azimuth   $init_azimuth;   // using Azimuth from previous OpenFOAM timestep of t = asdf"
