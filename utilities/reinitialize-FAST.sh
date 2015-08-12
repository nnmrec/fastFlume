#!/bin/sh
cd ${0%/*} || exit 1 # run from this directory

## This file reinitializes some variables in the FAST model, because
## if OpenFOAM restarts from a previous timestep FAST should also
## reinitialize using previous time values


## The file to modify
fileFAST=./../primary.fst


## Find the name of last time directory where OpenFOAM stopped

## sort the directory names and list the time directories

## or find the the most recently modified file
lastTimeFAST=$(ls -t ./../turbineOutput/ | head -n 1)
lastTimeFOAM=$(ls -t ./../processor0/ | head -n 1)
echo $lastTimeFAST
echo $lastTimeFOAM

## now find the lastTime directory of the FAST output files
## (note: the rotorSpeed and azimuth files share same format)
lastDir="./../turbineOutput/$lastTimeFAST/"
echo $lastDir

## now read the second column for the line of previous time step
timesFAST=$(awk '{print $2}' $lastDir/azimuth)
echo $timesFAST

## convert the string into an array
times=($timesFAST)
echo $times

## cut off the first element of the array (which is the variable name)
times="${times[@]:1}"
times=${times[@]:1}
echo $times
echo ${times[1]}
echo ${times[2]}

newTimes="$times"
echo $newTimes
echo ${newTimes[1]}

my_array=(red orange green)
value='green'

for i in "${!my_array[@]}"; do
   if [[ "${my_array[$i]}" = "${value}" ]]; then
       echo "${i}";
   fi
done

## now find the index of the time value where OpenFOAM will restart

# for i in "${times[@]}"
# 	do
#    	echo "$i"
#    	# or do whatever with individual element of the array
# done


## Read the last known blade azimuth, and overwite to FAST input file
# fileName=./turbineOutput/$lastDir/azimuth
# lastLine=$(tac $fileName | egrep -m 1 .)
# lastWord=$(echo $lastLine | awk '{ print $(NF) }')
# lineNumb=72
# ./replace-line.sh $lineNumb "$lastWord    Azimuth     - Initial azimuth angle for blade 1 (degrees)" $fileFAST > replace.$fileFAST
# mv replace.$fileFAST $fileFAST



## Read the last known rotor speed, and overwite to FAST input file
# fileName=./turbineOutput/$lastDir/rotSpeed
# lastLine=$(tac $fileName | egrep -m 1 .)
# lastWord=$(echo $lastLine | awk '{ print $(NF) }')
# lineNumb=73
# ./replace-line.sh $lineNumb "$lastWord    RotSpeed    - Initial or fixed rotor speed (rpm)" $fileFAST > replace.$fileFAST
# mv replace.$fileFAST $fileFAST





