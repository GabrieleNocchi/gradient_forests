#!/bin/bash
#SBATCH --time=0-6:00
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --account=def-yeaman

module load r/4.2.1

Rscript GF.R
