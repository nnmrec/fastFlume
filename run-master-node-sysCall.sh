#!/bin/sh

# should include a check which version of MPI (OpenMPI or Intel)
# could do this be looking at "which mpirun"

#if [ $OMPI_COMM_WORLD_RANK -eq 0 ]
if [ $PMI_RANK -eq 0 ]
then

echo '======================================================================='	
echo '___  ___  ___   _____ _____ ___________        _   _ ___________ _____ '
echo '|  \/  | / _ \ /  ___|_   _|  ___| ___ \      | \ | |  _  |  _  \  ___|'
echo '| .  . |/ /_\ \\ `--.  | | | |__ | |_/ /      |  \| | | | | | | | |__  '
echo '| |\/| ||  _  | `--. \ | | |  __||    /       | . ` | | | | | | |  __| '
echo '| |  | || | | |/\__/ / | | | |___| |\ \       | |\  \ \_/ / |/ /| |___ '
echo '\_|  |_/\_| |_/\____/  \_/ \____/\_| \_|      \_| \_/\___/|___/ \____/ '
echo 'We are on MASTER node, do master node things'                                                                   
echo '======================================================================='                                                                       
 	
 	# reconstruct before sampling or converting
 	# reconstructPar -latestTime 2>&1 | tee log.reconstructPar

 	# compute any additional fields that would be sampled
  	# vorticity -latestTime
	# enstrophy -latestTime
	# foamCalc components vorticity -latestTime
	# foamCalc components U -latestTime 2>&1 | tee log.components-U
	# foamCalc components UMean -latestTime 2>&1 | tee log.components-Umean
	# Lambda2 -latestTime
	# pPrime2 -latestTime
	# uprime -latestTime 2>&1 | tee log.uprime
	# foamCalc components uprime -latestTime 2>&1 | tee log.components-uprime

	## convert OpenFOAM format to VTK files
	# foamToVTK -latestTime 2>&1 | tee log.foamToVTK

	## sample the fields (this hangs using planes ... change to point cloud method requiring )
	# sample -latestTime 2>&1 | tee log.sample

fi

