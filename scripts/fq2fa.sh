# Use fq2fa from IDBA_UD to convert .fastq output of SortMeRNA to .fasta before inputting into Mothur
#Convert your sample_name_rRNA.fastq files from SortMeRNA to fasta using fq2fa 
#(already installed in my idba-ud_assembly_env) 

conda activate idba-ud_assembly_env

	#general format:

fq2fa sample_name_rRNA.fastq sample_name_rRNA.fasta

	#Example using one of my samples:

fq2fa FS903_30_12H_AAGACG_L001_trim_paired_merged_rRNA.fastq FS903_30_12H_AAGACG_L001_trim_paired_merged_rRNA.fasta
