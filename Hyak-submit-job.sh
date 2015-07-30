#!/bin/bash
#
# NOTE: to submit jobs to Hyak use
#       qsub <script.sh>
#
# #PBS is a directive requesting job scheduling resources
# and ALL PBS directives must be at the top of the script, standard
# bash commands can follow afterwards. 
#
## RENAME FOR YOUR JOB
#PBS -N dsale-Hyak_fasfFlume_medium1

## EDIT FOR YOUR JOB
## choose number of nodes and CPUs per node
## on nodes in group motley
# PBS -l nodes=1:ppn=16,mem=8gb,feature=8core

## on nodes in group stf
#PBS -l nodes=8:ppn=8,mem=40gb,feature=8core

## WALLTIME DEFAULTS TO ONE HOUR - ALWAYS SPECIFY FOR LONGER JOBS
## If the job doesn't finish in 10 minutes, cancel it
#PBS -l walltime=02:00:00

## EDIT FOR YOUR JOB
## Put the output from jobs into the below directory
# PBS -o /gscratch/GROUPNAME/USERNAME/JOB_DIR
# PBS -o /gscratch/motley/dsale/job_output
#PBS -o /gscratch/stf/dsale/job_output

## Put both the stderr and stdout into a single file
#PBS -j oe
## Send email when the job is aborted, begins, and terminates
# PBS -m abe -M dsale@uw.edu
#PBS -m abe -M sale.danny@gmail.com

## EDIT FOR YOUR JOB
## Specify the working directory for this job
# PBS -d /gscratch/GROUPNAME/USERNAME/JOB_DIR
# PBS -d /gscratch/motley/dsale/workspace/OpenFOAM/dsale-2.1.1/SOWFA/tutorials/fastDuct
#PBS -d /gscratch/stf/dsale/OpenFOAM/dsale-2.4.x/fastFlume-branches/medium1

## Some applications, particularly FORTRAN applications require
##  a larger than usual data stack size. Uncomment if your
##  application is exiting unexpectedly.
#ulimit -s unlimited

## Load the appropriate environment module.
# module load <latest module> # gcc_<version>-ompi_<version> 
# module load gcc_4.4.7-ompi_1.6.5
module load icc_15.0-ompi_1.8.3
source /gscratch/stf/dsale/OpenFOAM/OpenFOAM-2.4.x/etc/bashrc

### Debugging information
### Include your job logs which contain output from the below commands
###  in any job-related help requests.
# Total Number of processors (cores) to be used by the job
HYAK_NPE=$(wc -l < $PBS_NODEFILE)
# Number of nodes used
HYAK_NNODES=$(uniq $PBS_NODEFILE | wc -l )
echo "**** Job Debugging Information ****"
echo "This job will run on $HYAK_NPE total CPUs on $HYAK_NNODES different nodes"
echo ""
echo "Node:CPUs Used"
uniq -c $PBS_NODEFILE | awk '{print $2 ":" $1}'
echo "SHARED LIBRARY CHECK"
ldd ./Allrun 2>&1 | tee log.Hyak_fastFlume_Allrun
echo "ENVIRONMENT VARIABLES"
set
echo "**********************************************"
### End Debugging information

# Prevent tasks from exceeding the total RAM of the node
# Requires HYAK_NPE and HYAK_NNODE or HYAK_TPN to be set.
HYAK_TPN=$((HYAK_NPE/HYAK_NNODES))
NODEMEM=`grep MemTotal /proc/meminfo | awk '{print $2}'`
NODEFREE=$((NODEMEM-2097152))
MEMPERTASK=$((NODEFREE/HYAK_TPN))
ulimit -v $MEMPERTASK
 
### Specify the app to run here                           ###
###                                                       ###
# EDIT FOR YOUR JOB
#

./Allclean
./Allrun

#./Allclean
#./Allrun.pre-mesh
#./Allrun.post-mesh

#mpirun --bind-to-core ./Allrun 2>&1 | tee log.Hyak_fastFlume_Allrun

### include any post processing here                      ###
###                                                       ###
