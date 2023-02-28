for dir in */; do
  # Change to the subdirectory
  cd "$dir"
  
  # Launch the slurm job with sbatch
  sbatch r.sh
  
  # Change back to the parent directory
  cd ..
done
