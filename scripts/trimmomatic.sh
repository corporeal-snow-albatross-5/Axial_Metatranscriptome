#Step 1: Set up a conda environment as listed on Emilie's GitHub (pasted below):
#https://github.com/emilieskoog/Isolate_assembly_workflow/blob/master/Huber_Lab_Isolate_assembly_README.md

conda create --name trimmomatic
conda activate trimmomatic
conda install -c bioconda trimmomatic

#Step 2: Add adapter file with all adapters
#If you are uncertain of what adapters were used, here is a list of them that
#trimmomatic can go through and test each one.
#If you are unsure of whether or not adapters were already removed,
#performing this step would not hurt regardless.
#1. Find path for trimmomatic using:

conda info --envs

#2. Follow the outputted path that will lead you to the trimmomatic directory
#"cd" into this trimmomatic directory and create a folder named 'adapters'

mkdir adapters

#3. Create a file with list of all adapters: all_adapters.fa

nano all_adapters.fa

#4. Copy and past the following into this newly-created all_adapters.fa file

>PrefixNX/1
AGATGTGTATAAGAGACAG
>PrefixNX/2
AGATGTGTATAAGAGACAG
>Trans1
TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG
>Trans1_rc
CTGTCTCTTATACACATCTGACGCTGCCGACGA
>Trans2
GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG
>Trans2_rc
CTGTCTCTTATACACATCTCCGAGCCCACGAGAC>PrefixPE/1
AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PrefixPE/2
CAAGCAGAAGACGGCATACGAGATCGGTCTCGGCATTCCTGCTGAACCGCTCTTCCGATCT
>PCR_Primer1
AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PCR_Primer1_rc
AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT
>PCR_Primer2
CAAGCAGAAGACGGCATACGAGATCGGTCTCGGCATTCCTGCTGAACCGCTCTTCCGATCT
>PCR_Primer2_rc
AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG
>FlowCell1
TTTTTTTTTTAATGATACGGCGACCACCGAGATCTACAC
>FlowCell2
TTTTTTTTTTCAAGCAGAAGACGGCATACGA
>TruSeq2_SE
AGATCGGAAGAGCTCGTATGCCGTCTTCTGCTTG
>TruSeq2_PE_f
AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
>TruSeq2_PE_r
AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAG
>PrefixPE/1
TACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PrefixPE/2
GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT
>PE1
TACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PE1_rc
AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA
>PE2
GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT
>PE2_rc
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC>PrefixPE/1
TACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PrefixPE/2
GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT>TruSeq3_IndexedAdapter
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>TruSeq3_UniversalAdapter
AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA

#move all of your files to a raw_data folder.
#It will make it easier to run a bunch of things at once.
#However, this is by no means an automated process.
#It will be better to use Sarah's SnakeMake pipeline for scalability and reproducibility.
#However, in some cases (like if your file names do not match what Sarah has in her
#SnakeFile), you've got to do things the old fashion way as shown below.

#!/bin/bash
#SBATCH --partition=compute              # Queue selection
#SBATCH --job-name=trimmomatic           # Job name
#SBATCH --mail-type=ALL                  # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=selkassas@whoi.edu   # Where to send mail
#SBATCH --ntasks=1                       # Run a single task
#SBATCH --cpus-per-task=36               # Number of CPU cores per task
#SBATCH --mem=180gb                      # Job memory request
#SBATCH --time=24:00:00                  # Time limit hrs:min:sec
#SBATCH --output=trimmomatic%j.log       # Standard output/error
#export OMP_NUM_THREADS=36

export OMP_NUM_THREADS=8
module load anaconda/5.1
source activate trimmomatic
cd /vortexfs1/scratch/selkassas/qc-trim/raw_data

trimmomatic PE FS891_RNA_GGACCC_L001_R1_001.fastq.gz FS891_RNA_GGACCC_L001_R2_001.fastq.gz FS891_RNA_GGACCC_L001_R1_001_trim_paired.fastq.gz FS891_RNA_GGACCC_L001_R1_001_trim_unpaired.fastq.gz FS891_RNA_GGACCC_L001_R2_001_trim_paired.fastq.gz FS891_RNA_GGACCC_L001_R2_001_trim_unpaired.fastq.gz ILLUMINACLIP:/vortexfs1/home/selkassas/.conda/envs/trimmomatic/all_adapters.fa:2:40:15 CROP:140 LEADING:10 TRAILING:10 SLIDINGWINDOW:25:10 MINLEN:50


