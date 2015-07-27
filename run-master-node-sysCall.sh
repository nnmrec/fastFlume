#!/bin/sh

# should include a check which version of MPI (OpenMPI or Intel)
# could do this be looking at "which mpirun"

if [ $OMPI_COMM_WORLD_RANK -eq 0 ]
then
	echo 'We are on MASTER node, do master node things'
 	
 	

 	# reconstruct before sampling or converting
 	reconstructPar -latestTime

 	# compute any additional fields that would be sampled
 	vorticity -latestTime
	enstrophy -latestTime
	foamCalc components vorticity -latestTime
	foamCalc components U -latestTime
	foamCalc components UMean -latestTime
	Lambda2 -latestTime
	pPrime2 -latestTime
	uprime -latestTime

	## convert OpenFOAM format to VTK files
	foamToVTK -latestTime

	## sample the fields
	sample -latestTime

fi

