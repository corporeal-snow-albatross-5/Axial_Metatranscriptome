##**7. Classify taxonomy of rRNA using Mothur classify.seqs**

#Running rRNA samples through mothur to classify rRNA takes a bit of preparation. 

#useful links: 
#https://mothur.org/wiki/classify.seqs/
#https://mothur.org/wiki/degap.seqs/

#First, get your mothur environment set up on conda: 

conda create —-name mothur
conda activate mothur 
conda install -c bioconda mothur

#Download the GitHub repo and its contents:

git clone https://github.com/mothur/mothur.git

#Download the taxonomy and template files to Poseidon:

https://mothur.org/wiki/silva_reference_files/ —> scroll down to the version you want, and copy the URL of the ‘Full-length sequences and taxonomy references’ by right clicking, then clicking “copy link”

#then 

wget -N <insert URL> username@poseidon.whoi.edu:path/to/where/you/want/these/databases/to/go

	#As of 2/8/21 the Silva-132 taxonomy and align files are in the following 
#folder in the huber lab directory:

		#taxonomy 
		/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax 

		#align 
		/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.align 

		#nogap align file (also known as the ‘reference’ or ‘template’ in the classify.seqs code
		/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta

	#If you need a newer version though, you will have to re-download the files to Poseidon. 

#Create a nogap version of your .align file, 
#so you are able to align your rRNA without issues. Mothur has a build in command for this:

	#enter mothur 
	
mothur  

	#use degap.seqs command 

degap.seqs(fasta=mothur.silva.nr_v132.align)

	#The align file is a fasta file, so no need to convert it to have the .fasta extension. 
  #It will do it for you. 
	#Also, you do need to enter mothur first before this command can be run! 
  #If you try to run it without first entering 	mothur, it will give you the error: 
	
bash: syntax error near unexpected token `('

#I have already created the nogap file for Silva v132. 
#You will only need to do this step if you downloaded a newer version of the 
#silva .tax and .align files. 

#Run mothur classify.seqs command to get your rRNA taxonomy! Remember to enter mothur first!

#enter mothur 

mothur

	#general format:

classify.seqs(fasta=rRNA_file.fasta, template=nogap_file.align, taxonomy=silva_taxonomy_file.tax)

	#example with one of my samples:

classify.seqs(fasta=FS891_RNA_merged_rRNA.fasta, template=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta ,taxonomy=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax)

#Slurm script — for running a lot of samples at once: 

#1.) make sure you paste all of your commands in a .txt file first: 

nano mothur.txt 

#paste your commands (Here are some of mine as an example). It is best to only do five at a time. It will take almost 24 hours to run 5 samples. 

classify.seqs(fasta=FS891_RNA_merged_rRNA.fasta, template=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta, taxonomy=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax)

classify.seqs(fasta=FS903_30_12H_AAGACG_L001_trim_paired_merged_rRNA.fasta, template=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta, taxonomy=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax)

classify.seqs(fasta=FS903_30_12L_GGATGT_L001_trim_paired_merged_rRNA.fasta, template=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta, taxonomy=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax)

classify.seqs(fasta=FS903_30_13H_CCTCGG_L001_trim_paired_merged_rRNA.fasta, template=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta, taxonomy=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax)

classify.seqs(fasta=FS903_30_13L_TTCGCT_L001_trim_paired_merged_rRNA.fasta, template=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta, taxonomy=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax)

classify.seqs(fasta=FS903_55_12H_AAGGGA_L002_trim_paired_merged_rRNA.fasta, template=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.ng.fasta, taxonomy=/vortexfs1/omics/huber/db/silva-db/mothur.silva.nr_v132.tax)

#2.) Write your submit script: 

nano mothur.sh

#!/bin/bash
#SBATCH --partition=compute                          # Queue selection
#SBATCH --job-name=parallel_mothur                   # Job name
#SBATCH --mail-type=ALL                              # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=selkassas@whoi.edu               # Where to send mail
#SBATCH --ntasks=2                                   # Run a single task
#SBATCH --cpus-per-task=36                           # Number of CPU cores per task
#SBATCH --mem=100gb                                  # Job memory request
#SBATCH --time=24:00:00                              # Time limit hrs:min:sec
#SBATCH --output=parallel_mothur%j.log               # Standard output/error

export OMP_NUM_THREADS=12

module load anaconda/5.1
source activate mothur

cd /vortexfs1/scratch/selkassas/qc-trim/raw_data/merged_files_flash/extendedFrags_for_sortmer
na/rRNA_files/rRNA_fasta_files

mothur mothur.txt

#3.) Submit to slurm: 

sbatch mothur.sh

#You will get these three outputs per rRNA file: 
filename_rRNA.nr_v132.wang.flip.accnos
filename_rRNA.nr_v132.wang.taxonomy
filename_rRNA.nr_v132.wang.tax.summary

#The file you want for post-processing is the "filename_rRNA.nr_v132.wang.taxonomy"
