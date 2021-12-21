#Set up Conda environment like Emilie lists in her GitHub:
#https://github.com/emilieskoog/Isolate_assembly_workflow/blob/master/Huber_Lab_Isolate_assembly_README.md
#Instructions copied below:
# Step 1: Create a FastQC environment

conda create --name fastqc
conda activate fastqc

conda install -c bioconda fastqc

#Step 2: Run FastQC!
#Go into folder with files for fastqc-action to be done to them and create a shell file.
#Again:

nano fastqc.sh

#Here is an example of the code:

#!/bin/bash
#SBATCH --partition=compute              # Queue selection
#SBATCH --job-name=fastqc                # Job name
#SBATCH --mail-type=ALL                  # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=selkassas@whoi.edu   # Where to send mail
#SBATCH --ntasks=1                       # Run a single task
#SBATCH --cpus-per-task=36               # Number of CPU cores per task
#SBATCH --mem=80gb                       # Job memory request
#SBATCH --time=24:00:00                  # Time limit hrs:min:sec
#SBATCH --output=fastqc%j.log            # Standard output/error
#export OMP_NUM_THREADS=36

module load anaconda/5.1
source activate fastqc

cd /vortexfs1/scratch/selkassas/qc-trim/raw_data/trimmed

fastqc FS903_30_12L_GGATGT_L001_R1_006_trim_paired.fastq.gz
FS903_30_12L_GGATGT_L001_R2_006_trim_paired.fastq.gz
FS903_30_12L_GGATGT_L001_R1_006_trim_unpaired.fastq.gz
FS903_30_12L_GGATGT_L001_R2_006_trim_unpaired.fastq.gz

