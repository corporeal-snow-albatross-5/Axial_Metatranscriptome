#Running files through multiqc:
#In whatever conda environment you want (I just did it in my fastqc environment,
#though you could also create a new one), install multiqc:

conda install -c bioconda -c conda-forge multiqc #And here is an example of the$

#!/bin/bash
#SBATCH --partition=compute              # Queue selection
#SBATCH --job-name=multiqc               # Job name
#SBATCH --mail-type=ALL                  # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=selkassas@whoi.edu   # Where to send mail
#SBATCH --ntasks=1                       # Run a single task
#SBATCH --cpus-per-task=12               # Number of CPU cores per task
#SBATCH --mem=10gb                      # Job memory request
#SBATCH --time=24:00:00                  # Time limit hrs:min:sec
#SBATCH --output=multiqc%j.log           # Standard output/error
#export OMP_NUM_THREADS=12

source activate fastqc
cd /vortexfs1/scratch/selkassas/qc-trim/raw_data/fastqc

multiqc .
