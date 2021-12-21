#SortMeRNA - very intensive pipeline.

#This program is tricky to use, so follow my directions closely. 
#This takes a lot of computational power. 
#I recommend using the following slurm script and running only a 
#few samples at a time (like 10 maximum): 

1) conda create --name sortmerna
2) conda activate sortmerna
3) conda install -c bioconda sortmerna

#This will give you the newest version. As of 1/18/21, it is 4.2.0. 
#Any 'indexdb_rna' commands will not work. 
#There is only one command now, 'sortmerna'. 
#Everything, including indexing your databases will be done with this. 

#Download the GitHub repo and its contents:

git clone https://github.com/biocore/sortmerna.git

#Now you will have a directory called "sortmerna" in your conda path. 

cd /vortexfs1/home/selkassas/.conda/envs/sortmerna
cd sortmerna

#the sortmerna directory is a subdirectory of the main sortmerna path created by conda

#Move two additional databases into the 'rRNA_databases' directory

mv silva-bac-16s-database-id85.fasta rRNA_databases
mv silva-arc-16s-database-id95.fasta rRNA_databases

#How to index your databases: 

https://github.com/biocore/sortmerna/blob/master/scripts/test.jinja.yaml

#L347 --> look at test17 in this file. It will give you an example of how to index. However, just look at my code below and it will work for you too! Please note that sortmerna indexes your databases as it runs. You will have to index your databases each time you run a new sample. Because of this, you will have to delete the ‘run’ directory within the workdir it creates before running each new sample. See below examples with two samples — the first example is with merged, paired reads, and the second is with unmerged, paired reads (as promised!):

#SortmeRNA code - merged, paired reads 

	#general format: 

sortmerna --ref <insert path to reference database 1> --ref <insert path to reference database 2> --ref <insert path to reference database 3> --reads <insert merged reads file from Flash (will end in .extendedFrags.fastq> --aligned <insert file name_rRNA> --fastx --other <insert file name_mRNA> --otu_map -v

#some notes: you can list as many reference databases as you want, just make sure you indicate it using the --ref flag. The --aligned flag indicates reads mapped to the specified reference databases (i.e. your rRNA). 
#The --fastx flag gives your outputs as fastq files. 
#The --other flag indicates reads that did not map to the specified reference databases (i.e. your mRNA). The --otu_map flag is a potentially useful output for taxonomic classification. I haven’t found it useful, though it is a very small file. So no harm in generating it anyways! 
#The -v flag indicates you want a verbose output i.e. a nice log to check out what percent of reads mapped and some other info that may be useful. 

	#example using samples I’ve run. 
#I also includes my slurm script as an example of the type of memory you’re looking to allot.
#This will work for about 10 samples (in my experience) and will take about 2 hours per sample (This depends on how big your samples are, of course!)

#!/bin/bash
#SBATCH --partition=compute                          # Queue selection
#SBATCH --job-name=parallel_sortmerna                # Job name
#SBATCH --mail-type=ALL                              # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=selkassas@whoi.edu               # Where to send mail
#SBATCH --ntasks=1                                   # Run a single task
#SBATCH --cpus-per-task=36                           # Number of CPU cores per task
#SBATCH --mem=180gb                                  # Job memory request
#SBATCH --time=24:00:00                              # Time limit hrs:min:sec
#SBATCH --output=parallel_sortmerna%j.log            # Standard output/error

export OMP_NUM_THREADS=16

module load anaconda/5.1
source activate sortmerna

cd /vortexfs1/scratch/selkassas/qc-trim/raw_data/merged_files_flash/extendedFrags_for_sortmerna

rm -r /vortexfs1/home/selkassas/sortmerna/run

sortmerna --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-i
d90.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-i
d95.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5.8s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-database-id85.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-database-id95.fasta --reads FS908_80_13H7_GGATGT_L001_trim_paired_merged.extendedFrags.fastq --aligned FS908_80_13H7_GGATGT_L001_trim_paired_merged_rRNA --fastx --other FS908_80_13H7_GGATGT_L001_trim_paired_merged_mRNA --otu_map -v

rm -r /vortexfs1/home/selkassas/sortmerna/run

sortmerna --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-id90.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-id95.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5.8s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-database-id85.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-database-id95.fasta --reads FS907_80_13H8_TTCAGC_L001_trim_paired_merged.extendedFrags.fastq --aligned FS907_80_13H8_TTCAGC_L001_trim_paired_merged_rRNA --fastx --other FS907_80_13H8_TTCAGC_L001_trim_paired_merged_mRNA --otu_map -v

#SortmeRNA code - unmerged, paired reads

	#general format: 

sortmerna --ref <insert path to reference database 1> --ref <insert path to reference 
database 2> --ref <insert path to reference database 3> --reads <insert forward reads> 
  --reads <insert reverse reads> --aligned <insert file name_rRNA> --fastx --other <insert 
file name_mRNA> --otu_map -v --out2 --paired_out

#some notes: you can list as many reference databases as you want, just make sure you indicate it using the --ref flag. The --aligned flag indicates reads mapped to the specified reference databases (i.e. your rRNA). The --fastx flag gives your outputs as fastq files. 
#The --other flag indicates reads that did not map to the specified reference databases (i.e. your mRNA). 
#The --otu_map flag is a potentially useful output for taxonomic classification. I haven’t found it useful, though it is a very small file. So no harm in generating it anyways! 
#The -v flag indicates you want a verbose output i.e. a nice log to check out what percent of reads mapped and some other info that may be useful.
#The -—out2 flag outputs paired reads into two separate files. You can choose one of the following outputs to combine your files too.
#I used the --paired_out in the example above. 

 --paired_in       BOOL        Optional  If one of the paired-end reads is Aligned,              False
                                            put both reads into Aligned FASTA/Q file
                                            Must be used with 'fastx'.
                                            Mutually exclusive with 'paired_out'.

 --paired_out      BOOL        Optional  If one of the paired-end reads is Non-aligned,          False
                                            put both reads into Non-Aligned FASTA/Q file
                                            Must be used with 'fastx'.
                                            Mutually exclusive with 'paired_in'.

	#example using samples I’ve worked with. I’ve never run this before, but this is the format that should work for you if you decide to use unmerged, paired reads. I also includes my slurm script as an example of the type of memory you’re looking to allot. This will work for about 10 samples (in my experience).
                                            
#!/bin/bash
#SBATCH --partition=compute                          # Queue selection
#SBATCH --job-name=parallel_sortmerna                # Job name
#SBATCH --mail-type=ALL                              # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=selkassas@whoi.edu               # Where to send mail
#SBATCH --ntasks=1                                   # Run a single task
#SBATCH --cpus-per-task=36                           # Number of CPU cores per task
#SBATCH --mem=180gb                                  # Job memory request
#SBATCH --time=24:00:00                              # Time limit hrs:min:sec
#SBATCH --output=parallel_sortmerna%j.log            # Standard output/error

export OMP_NUM_THREADS=16

module load anaconda/5.1
source activate sortmerna

cd /vortexfs1/scratch/selkassas/qc-trim/raw_data/merged_files_flash/extendedFrags_for_sortmer
na

rm -r /vortexfs1/home/selkassas/sortmerna/run

sortmerna --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-id90.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-id95.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5.8s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-database-id85.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-database-id95.fasta --reads FS908_80_13H7_GGATGT_L001_trim_paired_merged_cat_forward_reads.fastq --reads FS908_80_13H7_GGATGT_L001_trim_paired_merged_cat_reverse_reads.fastq --aligned FS908_80_13H7_GGATGT_L001_trim_paired_merged_rRNA --fastx --other FS908_80_13H7_GGATGT_L001_trim_paired_mRNA --otu_map -v --out2 —-paired out

rm -r /vortexfs1/home/selkassas/sortmerna/run

sortmerna --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-id90.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-23s-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-id95.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/rfam-5.8s-database-id98.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-bac-16s-database-id85.fasta --ref /vortexfs1/home/selkassas/.conda/envs/sortmerna/sortmerna/data/rRNA_databases/silva-arc-16s-database-id95.fasta --reads FS907_80_13H8_TTCAGC_L001_trim_paired_merged.cat_forward_reads.fastq --reads FS907_80_13H8_TTCAGC_L001_trim_paired_mergedcat_reverse_reads.fastq--aligned FS907_80_13H8_TTCAGC_L001_trim_paired_merged_rRNA --fastx --other FS907_80_13H8_TTCAGC_L001_trim_paired_merged_mRNA --otu_map -v —-out2 —-paired out


