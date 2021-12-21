##3. Combine all the forward and all the reverse read segments using cat command

#Preparing your samples
#Make sure you trim and quality control your reads before running through sortmerna! Use the “paired” output of trimmomatic as your input for sortmerna.
#Now, sortmerna can take merged, paired reads or unmerged, paired reads.
#However, if you have unmerged, paired reads, you will need to specify the names of your two outputs.
#I’ll show an example of running sortmerna with each one. See below.
#If you do want to merged, paired reads, you must prepare them by:
#concatenating all of the forward reads together,then concatenating all of the reverse reads together.
#Note: there may be a lot of forward and reverse reads if your sample was downloaded from the Short Read Archive (SRA), which splits your reads up into smaller segments. See example:

#My original sample had these forward reads (this sample was split into 7 forward read files):

FS903_30_12L_GGATGT_L001_R1_001_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_002_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_003_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_004_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_005_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_006_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_007_trim_paired.fastq

#and these reverse reads(this sample was split into 7 reverse read files):

FS903_30_12L_GGATGT_L001_R1_001_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_001_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_002_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_003_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_004_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_005_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_006_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_007_trim_paired.fastq

#Here is the concatenation code:
#####general concatenation code:

cat file1 file2 file3...file# > newfile

#####concatenation code for the forward and reverse reads above:

cat FS903_30_12L_GGATGT_L001_R1_001_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_002_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_003_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_004_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_005_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_006_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R1_007_trim_paired.fastq >
FS903_30_12L_GGATGT_L001_trim_paired_cat_forward_reads.fastq

cat FS903_30_12L_GGATGT_L001_R2_001_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_002_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_003_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_004_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_005_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_006_trim_paired.fastq
FS903_30_12L_GGATGT_L001_R2_007_trim_paired.fastq >
FS903_30_12L_GGATGT_L001_trim_paired_cat_reverse_reads.fastq
