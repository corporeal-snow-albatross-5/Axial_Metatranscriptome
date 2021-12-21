##  Combine concatenated forward and reverse reads using Flash
#Merge the concatenated forward reads file with the concatenated reverse reads file using a program called flash.

#Here is how to install it into your flash  environment and then run the program:
conda create --name flash
conda activate flash 
conda install -c bioconda flash (mine was v. 1.2.11) 

#Here is the flash code:
    #general format:
flash <insert concatenated forward reads file> <insert concatenated reverse reads file> -r <insert read length> -d
<insert output directory path> -o <insert output file prefix - this will generate a fastq file>

    #flash code for the example above:
flash FS903_30_12L_GGATGT_L001_trim_paired_cat_forward_reads.fastq FS903_30_12L_GGATGT_L001_trim_paired_cat_reverse_reads.fastq -r 110 -d /vortexfs1/scratch/selkassas/qc-trim/raw_data/merged_files_flash -o FS903_30_12L_GGATGT_L001_trim_paired_merged

#THE OUTPUT FROM FLASH THAT YOU WILL USE FOR SORTMERNA IS THE .extendedFrags.fastq FILE!!!
