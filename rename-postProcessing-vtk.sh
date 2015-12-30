#!/bin/bash

#
# The gameplan:
# rename all the OpenFOAM vtk files in sane manner
# run VisIt to convert all the vtk files into format more easily readable by Matlab
# use my readOkm.m function to read the Oxml files
# now can run Ben's FTLE code
# PITFALLS: avoid situation where duplicating files, somehow link the time-index with the time-values (think backfill)
#

dir_main=$(pwd)
dir_post=postProcessing/surfaces

# improvement: read these variable names from the sampleDict file
vars=(Ux Uy Uz)

# the OpenFOAM time directories (careful to sort these numerically)
#IN_DIRS=($(ls -d */))

for ((i=0;i<=${#vars[*]}-1;i++)); do

    # careful to sort these files numerically 
#    IN_FILES=`find $dir_post -maxdepth 2 -name "${vars[i]}*.vtk" | sort`
    IN_FILES=`find $dir_post -maxdepth 2 -name "${vars[i]}*.vtk" | ls -l -d */`

    k=1
    for file in $IN_FILES
      do
      name=${file#*${vars[i]}_}
      name=${name%*.vtk}
      echo "converting sampled data for variable: ${vars[i]} on surface: $name"

      j=$( printf "%06d" "$k" )

      mkdir -p $dir_post/$name
      cp "$file" "$dir_post/$name/${vars[i]}_$j.vtk"
      (( k++ ))

    done

done

